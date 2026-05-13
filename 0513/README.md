# 0513 CoffeeScript Maze Sample

このディレクトリは `maze.coffee` を **ローカルインストールした CoffeeScript** で実行するための手順をまとめたものです。

`maze.coffee` は深さ優先探索を使って迷路を生成し、開始地点 `S` とゴール `G` を含む迷路をコンソールに表示するサンプルです。

## 前提環境

- **OS**: macOS
- **Node.js**: `node` コマンドが使えること
- **npm**: `npm` コマンドが使えること

確認:

```bash
node -v
npm -v
```

## セットアップ

このディレクトリで以下を実行します。

```bash
npm install
```

`coffeescript` はローカルの `node_modules` にインストールされます。

## 実行方法

このディレクトリで以下を実行します。

```bash
npm run start
```

## 補足

- `CoffeeScript` はグローバルインストール不要です。
- 実行時には `package.json` の `start` スクリプトから `coffee maze.coffee` が呼ばれます。
- 出力はターミナル上の文字幅により見え方が多少変わることがあります。
