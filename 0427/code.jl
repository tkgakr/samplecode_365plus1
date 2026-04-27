import Pkg

# このスクリプトがあるディレクトリを Julia の作業環境として有効化し、
# 必要なパッケージが無ければ自動で導入してから読み込みます。
Pkg.activate(@__DIR__)
try
    using GLMakie, Colors
catch
    Pkg.add(["GLMakie", "Colors"])
    using GLMakie, Colors
end

# GLMakie を描画バックエンドとして有効化します。
GLMakie.activate!()

# 表示する文字列やフォント、色、影のずらし量などの見た目を設定します。
txt = "X : @vloomy_mario"   # 好みのセリフに変更可
fontname = "Helvetica Neue"
fontsize = 120
bg, fg, shadow = RGB(0.05,0.06,0.08), RGB(1,1,1), RGBA(0,0,0,0.75)
offset = (8.0, -5.0)

# 描画先となる Figure と Axis を作成し、軸や枠線を消して
# テキスト表示専用のキャンバスにします。
fig = Figure(size=(1200,420), backgroundcolor=bg)
ax  = Axis(fig[1,1]); hidedecorations!(ax); hidespines!(ax); ax.aspect = DataAspect()

# 少しずらした位置に半透明の文字を描き、ドロップシャドウを作ります。
text!(ax, txt;
        position=Point2f(0,0).+Point2f(offset...),
        align=(:center,:center), fontsize=fontsize, font=fontname, color=shadow)

# 本体の文字を中央に重ねて描画します。
text!(ax, txt;
        position=Point2f(0,0),
        align=(:center,:center), fontsize=fontsize, font=fontname, color=fg)

# 表示範囲を固定してウィンドウを表示します。
xlims!(ax,-700,700); ylims!(ax,-160,160)
display(fig)

# ウィンドウが閉じられるまでループして終了を待ちます。
while isopen(fig.scene); sleep(0.1); end
