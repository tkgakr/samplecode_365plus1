# 0501 Prime Factorization Sample

このディレクトリは、素因数分解を行うサンプルコードを **Clojure** と **Python** で実行するためのメモです。

- `code.clj`: Clojure 版
- `code.py`: Python 版

どちらも、与えられた整数を再帰的に素因数分解し、因数のリストを出力します。

## 前提環境

- **OS**: macOS
- **Clojure**: `clojure` コマンドが使えること
- **Python**: `python` コマンドが使えること

## セットアップ

### Clojure のセットアップ

Homebrew を使う場合は以下でインストールできます。

```bash
brew install clojure
```

確認:

```bash
clojure -Sdescribe
```

### Python のセットアップ

macOS では `python` が利用できることが多いですが、未導入の場合は Homebrew でインストールできます。

```bash
brew install python
```

確認:

```bash
python --version
```

## 実行方法

### Clojure 版

リポジトリ直下で次を実行します。

```bash
clojure -M 0501/code.clj
```

または、このディレクトリで次を実行します。

```bash
clojure -M code.clj
```

### Python 版

リポジトリ直下で次を実行します。

```bash
python 0501/code.py
```

または、このディレクトリで次を実行します。

```bash
python code.py
```

## 実行例

### Clojure の実行例

```text
$ clojure -M 0501/code.clj
(5 2 2 2)
(331 3 2)
(1013 2)
```

### Python の実行例

```text
$ python 0501/code.py
[5, 2, 2, 2]
[331, 3, 2]
[1013, 2]
```

## 補足

- Clojure 版はリストを `(5 2 2 2)` のように表示します。
- Python 版はリストを `[5, 2, 2, 2]` のように表示します。
- 表示形式は異なりますが、素因数分解のロジックと出力される因数の順序は同じです。
