# googletest-lib

GoogleTest 1.17.0 のコンパイル済みライブラリ配布レポジトリ

source: [google/googletest](https://github.com/google/googletest)

## 概要

このレポジトリは、GoogleTest 1.17.0 をビルドしたライブラリファイルとヘッダーファイルを提供します。GitHub Actions によって自動的にビルドされ、Linux と Windows の両方のプラットフォームに対応しています。

## ディレクトリ構造

```
googletest-lib/
├── include/              # GoogleTest ヘッダーファイル
│   ├── gmock/
│   └── gtest/
└── lib/
    ├── linux-el8-x64/    # Linux (Oracle Linux 8 x64) ライブラリ
    └── windows-x64/      # Windows (x64) ライブラリ
```

## 配布ライブラリ

### Linux (Oracle Linux 8 x64)

**ビルド設定:**
- ビルドタイプ: RelWithDebInfo (最適化あり、デバッグ情報あり)
- 静的ライブラリ (.a)

**ライブラリファイル:**
- `libgmock.a` - Google Mock ライブラリ
- `libgmock_main.a` - Google Mock main 関数付き
- `libgtest.a` - Google Test ライブラリ
- `libgtest_main.a` - Google Test main 関数付き

**追加ファイル:**
- `cmake/GTest/` - CMake 設定ファイル
- `pkgconfig/` - pkg-config ファイル

### Windows (x64)

**ビルド設定:**
- ビルドタイプ: RelWithDebInfo (最適化あり、デバッグ情報あり)
- ランタイムライブラリ: /MD (MultiThreadedDLL)
- 静的ライブラリ (.lib)

**ライブラリファイル:**
- `gmock.lib` - Google Mock ライブラリ
- `gmock_main.lib` - Google Mock main 関数付き
- `gtest.lib` - Google Test ライブラリ
- `gtest_main.lib` - Google Test main 関数付き

各 .lib ファイルには対応する .pdb ファイル (デバッグシンボル) も含まれます。

**追加ファイル:**
- `cmake/GTest/` - CMake 設定ファイル
- `pkgconfig/` - pkg-config ファイル

## 使用方法

### Linux での使用例

```bash
# コンパイル例
g++ -std=c++14 test_sample.cpp \
  -I /path/to/googletest-lib/include \
  -L /path/to/googletest-lib/lib/linux-el8-x64 \
  -lgtest -lgtest_main -pthread \
  -o test_sample

./test_sample
```

### Windows での使用例

```bash
# MSVC でのコンパイル例 (コマンドライン)
cl /EHsc /MD /std:c++14 test_sample.cpp ^
  /I C:\path\to\googletest-lib\include ^
  /link ^
  /LIBPATH:C:\path\to\googletest-lib\lib\windows-x64 ^
  gtest.lib gtest_main.lib

test_sample.exe
```

### CMake での使用例

```cmake
# CMakeLists.txt
cmake_minimum_required(VERSION 3.5)
project(MyTest)

set(CMAKE_CXX_STANDARD 14)

# GoogleTest のパスを設定
set(GOOGLETEST_ROOT "/path/to/googletest-lib")

# インクルードパスを追加
include_directories(${GOOGLETEST_ROOT}/include)

# ライブラリパスを追加 (プラットフォームに応じて選択)
if(UNIX)
    link_directories(${GOOGLETEST_ROOT}/lib/linux-el8-x64)
elseif(WIN32)
    link_directories(${GOOGLETEST_ROOT}/lib/windows-x64)
endif()

# テスト実行ファイル
add_executable(test_sample test_sample.cpp)

# ライブラリをリンク
if(UNIX)
    target_link_libraries(test_sample gtest gtest_main pthread)
elseif(WIN32)
    target_link_libraries(test_sample gtest gtest_main)
endif()
```

または、GoogleTest の CMake 設定ファイルを使用:

```cmake
# CMakeLists.txt
cmake_minimum_required(VERSION 3.5)
project(MyTest)

set(CMAKE_CXX_STANDARD 14)

# GoogleTest のパスを設定
if(UNIX)
    set(GTest_DIR "/path/to/googletest-lib/lib/linux-el8-x64/cmake/GTest")
elseif(WIN32)
    set(GTest_DIR "/path/to/googletest-lib/lib/windows-x64/cmake/GTest")
endif()

# GoogleTest を検索
find_package(GTest REQUIRED)

# テスト実行ファイル
add_executable(test_sample test_sample.cpp)

# ライブラリをリンク
target_link_libraries(test_sample GTest::gtest GTest::gtest_main)

if(UNIX)
    target_link_libraries(test_sample pthread)
endif()
```

## テストサンプルコード

```cpp
// test_sample.cpp
#include <gtest/gtest.h>

TEST(SampleTest, BasicTest) {
    EXPECT_EQ(1, 1);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
```

## ビルド方法 (CI/CD)

このレポジトリのライブラリは、GitHub Actions によって自動的にビルドされます。

**ワークフロー:** `.github/workflows/build-googletest.yml`

**ビルドプロセス:**
1. GoogleTest 1.17.0 のソースコードを clone
2. Linux (Oracle Linux 8) でビルド
3. Windows (x64) でビルド (/MD, RelWithDebInfo)
4. ビルド成果物を `lib/` と `include/` に配置
5. main ブランチへの push 時に自動的にコミット

## 手動ビルド手順

手動でビルドする場合の詳細な手順については、[MANUAL_BUILD.md](MANUAL_BUILD.md) を参照してください。

## ライブラリバージョン

- GoogleTest: 1.17.0
- Linux ビルド環境: Oracle Linux 8
- Windows ビルド環境: Visual Studio 2025 (MSVC v144)
- ランタイムライブラリ: /MD (MultiThreadedDLL)

## ライセンス

GoogleTest は BSD 3-Clause License の下で配布されています。詳細は [LICENSE](LICENSE) ファイルを参照してください。

## トラブルシューティング

### Linux でのリンクエラー

pthread リンクエラーが発生する場合は、リンク時に `-pthread` オプションを追加してください。

```bash
g++ test_sample.cpp -lgtest -lgtest_main -pthread -o test_sample
```

### Windows でのランタイムエラー

このライブラリは /MD (MultiThreadedDLL) でビルドされています。アプリケーションも同じランタイムライブラリを使用する必要があります。

Visual Studio のプロジェクト設定:
- プロジェクトのプロパティ → C/C++ → コード生成 → ランタイム ライブラリ
- Release ビルド: "マルチスレッド DLL (/MD)" を選択
- Debug ビルド: "マルチスレッド DLL (/MD)" を選択

注意: このライブラリは /MD (MultiThreadedDLL) でビルドされています。アプリケーションのビルド構成（Debug/Release）に関わらず、ランタイムライブラリは /MD を使用してください。/MDd (MultiThreadedDebugDLL) を使用したい場合は、別途 /MDd でビルドされたライブラリが必要です。

### CMake で GoogleTest が見つからない

`GTest_DIR` を正しく設定してください:

```bash
# Linux
cmake -DGTest_DIR=/path/to/googletest-lib/lib/linux-el8-x64/cmake/GTest ..

# Windows
cmake -DGTest_DIR=C:/path/to/googletest-lib/lib/windows-x64/cmake/GTest ..
```

## 参考リンク

- [GoogleTest 公式ドキュメント](https://google.github.io/googletest/)
- [GoogleTest GitHub リポジトリ](https://github.com/google/googletest)
