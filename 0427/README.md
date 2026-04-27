# 0427 Julia Sample

このディレクトリは `code.jl` を **Apple Silicon Mac 上でローカル実行**するための手順をまとめたものです。

`code.jl` は `GLMakie` を使ってウィンドウを開き、文字列を描画するサンプルです。

## 前提環境

- **OS**: macOS on Apple Silicon
- **Julia**: 1.10 系またはそれ以降

このサンプルでは Julia パッケージとして `GLMakie` と `Colors` を使用します。

## Julia のインストール

公式の [Julia Downloads](https://julialang.org/downloads/) では、macOS / Linux 向けに `juliaup` を使うインストール方法が案内されています。

Apple Silicon Mac でも、まずはこちらを使うのが簡単です。

```bash
curl -fsSL https://install.julialang.org | sh
```

この方法では、最新の安定版 Julia とバージョン管理ツール `juliaup` が導入されます。

インストール完了後、新しいターミナルを開くか、シェル設定を再読み込みしてから確認します。

設定後、次で確認できます。

```bash
julia --version
```

`juliaup` 自体の確認は次で行えます。

```bash
juliaup --help
```

### 手動インストールを使いたい場合

GUI ベースで入れたい場合は、公式の [Manual Downloads](https://julialang.org/downloads/manual-downloads/) から Apple Silicon 版を取得してインストールすることもできます。

## 実行方法

リポジトリ直下で次を実行します。

```bash
julia 0427/code.jl
```

または、このディレクトリへ移動してから実行しても構いません。

```bash
julia code.jl
```

初回実行時に `GLMakie` と `Colors` が未インストールであれば、スクリプト内の処理で自動的にインストールされます。

その後、描画ウィンドウが開きます。

## 終了方法

表示されたウィンドウを閉じるとスクリプトが終了します。

## 補足

- 初回実行時は、パッケージのインストールと事前コンパイルのため時間がかかることがあります。
- `GLMakie` は GUI 描画を行うため、単純な CLI スクリプトよりはやや重めです。
- `fontname = "Helvetica Neue"` を使用しているため、環境によっては表示結果が多少変わる可能性があります。
