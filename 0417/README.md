# 0417 Scheme Sample

このディレクトリは `code.scm` を **Scheme 処理系で実行**するための環境構築メモです。

`code.scm` は継続（`call/cc`）を使って、ライプニッツの公式で円周率を逐次的に計算するサンプルです。
Enter キーを押すたびに次の項までの近似値を表示し、`q` + Enter で終了します。

## 前提環境

- **OS**: macOS（本リポジトリは macOS 上で動作確認しています）
- **Scheme 処理系**: [Gauche](https://practical-scheme.net/gauche/)（`gosh`）

`read-line` を使うため、R7RS 相当の処理系が必要です。本ディレクトリでは Gauche を使用します。

## セットアップ

Homebrew でインストールします。

```bash
brew install gauche
```

インストール後、バージョンを確認します。

```bash
gosh -V
```

## 実行方法

このディレクトリで次を実行します。

```bash
gosh code.scm
```

- Enter を押すと次の項までの近似値が表示されます。
- `q` + Enter で終了します。

## 実行例

```text
$ gosh code.scm
0
4.0
2.666666666666667
3.466666666666667
2.8952380952380956
q
```

表示の改行は処理系・端末設定により揃わない場合があります（元のコードでは `display` のみで `newline` を呼んでいないため）。

## 補足

- 他の R7RS 準拠処理系（Chicken, Racket の `plt-r7rs` など）でも、`read-line` と `string=?` が使えれば同様に動作します。
- 空リストリテラル `()` を使っているため、R6RS 系の厳格な処理系（Chez Scheme など）ではエラーになる可能性があります。その場合は `()` を `'()` に置き換えてください。
