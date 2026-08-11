# googletest-lib

GoogleTest 1.17.0 のヘッダーとコンパイル済みライブラリを配布する repo です。

source: [google/googletest](https://github.com/google/googletest)

## 概要

この repo には、GoogleTest / Google Mock の配布用ヘッダーと、Linux / Windows 向けにビルド済みのライブラリが含まれます。

提供している主な配布先は以下です。

- Linux: `lib/linux_el8_x64/`, `lib/linux_el9_x64/`, `lib/linux_el10_x64/`
- Windows: `lib/windows_x64/md/`, `mdd/`, `mt/`, `mtd/`

Windows では `/MD`、`/MDd`、`/MT`、`/MTd` に対応したライブラリと PDB を配布します。

## 使用例

### Linux

```bash
g++ -std=c++14 test_sample.cpp \
  -I /path/to/googletest-lib/include \
  -L /path/to/googletest-lib/lib/linux_el8_x64 \
  -lgtest -lgtest_main -pthread \
  -o test_sample
```

### Windows

```text
cl /EHsc /MD /std:c++14 test_sample.cpp ^
  /I C:\path\to\googletest-lib\include ^
  /link ^
  /LIBPATH:C:\path\to\googletest-lib\lib\windows_x64\md ^
  gtest.lib gtest_main.lib
```

## ビルドと更新

配布物の更新は GitHub Actions の workflow で行います。

- workflow: `.github/workflows/build-gtest.yml`
- バージョン指定: `TARGET_GTEST_VERSION`
- 手動手順: `docs/manual-build.md`

Linux 向け配布物は Oracle Linux 8 / 9 / 10 で生成します。Windows 向け配布物は Visual Studio ベースで生成します。

## 補足

- より詳しい更新手順は [AGENTS.md](./AGENTS.md) と `docs/` を参照してください。
- ライセンスは [LICENSE](LICENSE) を参照してください。
