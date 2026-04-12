# AGENTS.md

## 重要事項

- 自動ステージング、コミット禁止。指示があるまでステージング、コミットは行わないこと。
- 思考の断片は英語でもよいが、ユーザーに気づきを与えたり報告する際は日本語を用いること。

## リポジトリ概要

GoogleTest のヘッダーとコンパイル済みライブラリを配布するための repo です。ソース実装を育てる場所ではなく、配布成果物、バージョン情報、ビルド workflow を管理します。

## 作業時の入口

- `TARGET_GTEST_VERSION` - 配布対象の GoogleTest バージョン
- `include/` - 配布ヘッダー
- `lib/` - Linux と Windows の配布ライブラリ
- `.github/workflows/build-gtest.yml` - 配布物を更新する CI
- `docs/manual-build.md` - 手動更新手順
- `docs/version-update.md` - バージョン更新手順

## 配布構成

- Linux: `lib/linux-el8-x64/`, `lib/linux-el10-x64/`
- Windows: `lib/windows-x64/md/`, `mdd/`, `mt/`, `mtd/`

## 注意点

- `include/` と `lib/` は配布成果物です。内容更新時は workflow、README、ドキュメントも一緒に確認すること。
- Windows のランタイム別ディレクトリは利用者の選択肢そのものなので、命名や配置を安易に変えないこと。
- ローカルで手動更新する場合は `docs/manual-build.md` を正本として扱うこと。
