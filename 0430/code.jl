import Pkg
 
# このスクリプトがあるディレクトリを Julia の作業環境として有効化し、
# 必要なパッケージが無ければ自動で導入してから読み込みます。
Pkg.activate(@__DIR__)
try
    using MLJ, DataFrames, Dates, Random, Statistics, MLJXGBoostInterface
catch
    Pkg.add(["MLJ", "DataFrames", "XGBoost", "MLJXGBoostInterface"])
    using MLJ, DataFrames, Dates, Random, Statistics, MLJXGBoostInterface
end
 
# MLJ 経由で XGBoost の回帰モデルを読み込み、乱数シードを固定して
# サンプルデータや学習結果が毎回ほぼ同じになるようにします。
XGB = @load XGBoostRegressor pkg=XGBoost verbosity=0
Random.seed!(42)
 
# サンプルの時系列データを作成します。
# 1時間刻みの日時を並べ、気温は「基準値 + 日内変動 + 長期変動 + ノイズ」で
# 構成した疑似データにしています。
n = 800; t0 = DateTime(2024,1,1)
dt  = [t0 + Hour(i) for i in 0:n-1]
temp = [15 .+ 10*sin(2π*(i/24)) .+ 5*sin(2π*(i/(24*90))) .+ randn()*0.8 for i in 1:n]
df = DataFrame(datetime=dt, temp=temp)
 
# 特徴量を作成します。
# 時刻由来の特徴量と、過去の気温から作るラグ特徴量・移動平均を使って
# 将来の気温を予測できる表形式データに変換します。
"""
    lag(v, k)
 
ベクトル `v` を `k` 期だけ遅らせたベクトルを返します。
先頭の `k` 要素は `missing` で埋められ、残りには元の `v` の先頭から
`end-k` までの値が入ります。
"""
function lag(v, k); [fill(missing,k); v[1:end-k]] end
# `hour` と `month` は日時から取り出した説明変数です。
df.hour  = hour.(df.datetime); df.month = month.(df.datetime)
# 1, 3, 6時間前の気温を特徴量として追加します。
df.temp_l1 = lag(df.temp, 1); df.temp_l3 = lag(df.temp, 3); df.temp_l6 = lag(df.temp, 6)
# 直近6時点の平均気温を移動平均特徴量として追加します。
df.ma6 = [i<6 ? missing : mean(df.temp[i-5:i]) for i in 1:n]
# 6時間先の気温を目的変数にし、先頭や末尾に生じた欠損行を削除します。
df.temp_tplus6 = [i>n-6 ? missing : df.temp[i+6] for i in 1:n]
dropmissing!(df)
 
# 時系列の順序を保ったまま、前半80%を学習用、後半20%を評価用に分割します。
cut = floor(Int, 0.8*nrow(df))
train = df[1:cut, :]; test = df[cut+1:end, :]
# `datetime` はそのままでは学習に使わず、目的変数列も除外して説明変数行列を作ります。
ytr = train.temp_tplus6; Xtr = select(train, Not([:datetime, :temp_tplus6]))
yte = test.temp_tplus6;  Xte = select(test,  Not([:datetime, :temp_tplus6]))
 
# XGBoost 回帰モデルを作成して学習します。
# ここでは木の数、学習率、木の深さ、サンプリング率を指定しています。
model = XGB(num_round=400, eta=0.05, max_depth=6, subsample=0.8, colsample_bytree=0.8)
mach = machine(model, Xtr, ytr) |> fit!
 
# テストデータに対して6時間先の気温を予測し、RMSE で精度を評価します。
ŷ = predict(mach, Xte) |> MLJ.unwrap
rmse = sqrt(mean((ŷ .- yte).^2))
@info "Test RMSE (6h-ahead temp)" rmse