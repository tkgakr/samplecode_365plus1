# 0404 myd2d_1

このディレクトリは `myd2d_1.cpp` を **Windows 上で Direct2D アプリとしてビルド・実行**するための最小構成です。

## 前提環境

- **OS**: Windows 10 / 11
- **IDE / Toolchain**: Visual Studio 2022
- **必須ワークロード**: `Desktop development with C++`
- **必要コンポーネント**:
  - MSVC v143 以降
  - Windows 10 または Windows 11 SDK
  - CMake

`myd2d_1.cpp` は `Windows.h` と `Direct2D` を使用するため、**macOS 単体では実行できません**。

## ビルド方法

### Visual Studio で開く場合

1. この `0404` ディレクトリを Visual Studio で開きます。
2. CMake プロジェクトとして自動認識されます。
3. 構成を `x64-Debug` または `x64-Release` にします。
4. `myd2d_1` を起動します。

### コマンドラインでビルドする場合

Visual Studio の Developer PowerShell で次を実行します。

```powershell
cmake -S . -B build -G "Visual Studio 17 2022" -A x64
cmake --build build --config Debug
```

実行ファイルは次に生成されます。

```text
build/Debug/myd2d_1.exe
```

## 実行結果

起動すると、白っぽい背景のウィンドウが表示されます。

## 追加したファイル

- `CMakeLists.txt`
  - Windows GUI アプリとしてビルドする設定です。
- `myd2d_1.cpp`
  - 最小の Win32 エントリポイントと描画処理を含む状態にしました。

## 補足

この環境は **Windows ネイティブ向け**です。もし macOS 上から操作したい場合は、次のいずれかが必要です。

- Windows 実機
- Parallels Desktop などの仮想環境
- リモートの Windows マシン
