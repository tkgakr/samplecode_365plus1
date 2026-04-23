# 0423 Java Sample

このディレクトリは `AgeInSeconds.java` を **Java でコンパイル・実行**するための最小セットアップです。

`AgeInSeconds.java` は生年月日を入力すると、現在までの経過秒数を表示するサンプルです。

## 前提環境

- **OS**: macOS
- **JDK**: Java 8 以降

`LocalDateTime` と `ChronoUnit` を使っているため、Java 8 以降が必要です。

バージョン確認:

```bash
java -version
javac -version
```

## Build

このディレクトリで以下を実行します。

```bash
javac AgeInSeconds.java
```

## Run

```bash
java AgeInSeconds
```

実行後、年・月・日を整数で入力してください。

## 補足

- ソースファイル名 `AgeInSeconds.java` と公開クラス名 `AgeInSeconds` を一致させてあります。
- 追加ライブラリは不要で、Java 標準ライブラリのみで動作します。
