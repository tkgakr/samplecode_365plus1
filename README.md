# samplecode_365plus1

翔泳社日めくりカレンダー『[サンプルコード365+1](https://www.shoeisha.co.jp/book/detail/9784798192970)』のサンプルコードを、環境構築して動作確認するためのリポジトリです。

各サブディレクトリが個別の検証用プロジェクトです。各プロジェクトでは、翔泳社のGitHubリポジトリから取得したコードを配置し、必要に応じて環境構築や動作確認を行います。

オリジナルのコードは、以下のGitHubリポジトリから取得できます。  
https://github.com/shoeisha-books/samplecode_365plus1

また、このリポジトリではオリジナルのコードを Git サブモジュールとして `upstream/samplecode_365plus1` に保持しています。

## セットアップ

初回クローン時は、サブモジュールもあわせて取得してください。

```bash
git clone --recursive https://github.com/tkgakr/samplecode_365plus1.git
```

すでにクローン済みの場合は、以下でサブモジュールを取得できます。

```bash
git submodule update --init --recursive
```

サブモジュールを最新の状態に更新する場合は、以下を実行してください。

```bash
git submodule update --remote --merge upstream/samplecode_365plus1
```

## 日付フォルダの取り込み

オリジナルの `upstream/samplecode_365plus1/dates/<日付>` から、リポジトリ直下に同名の日付フォルダをコピーするには、以下を実行してください。

```bash
bash scripts/copy-date-folder.sh 0423
```

このコマンドは `upstream/samplecode_365plus1/dates/0423` を `./0423` としてコピーします。

同名ディレクトリがすでに存在する場合は、上書きせずにエラーで終了します。

## ライセンス

各サブディレクトリに含まれるコードの著作権およびライセンスは、特に明記がない限り、元の配布元および各サブディレクトリ内のライセンス表記に従います。
