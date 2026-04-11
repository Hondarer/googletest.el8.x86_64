# GoogleTest バージョン更新ガイド

## バージョンを更新する方法

1. TARGET_GTEST_VERSIONファイルを編集:
   ```bash
   echo "1.18.0" > TARGET_GTEST_VERSION
   ```

2. 変更をコミット・プッシュ:
   ```bash
   git add TARGET_GTEST_VERSION
   git commit -m "Bump GoogleTest version to 1.18.0"
   git push
   ```

3. GitHub Actionsが自動的に:
   - GoogleTest v1.18.0 をクローン
   - Linux/Windows 向けにビルド
   - ドキュメント（README.md、manual-build.md）を生成
   - すべての変更をコミット

## 確認事項

ワークフロー完了後、以下を確認:
- [ ] README.md にバージョン 1.18.0 が表示される
- [ ] manual-build.md にバージョン 1.18.0 が表示される
- [ ] lib/ ディレクトリに新しいビルドが含まれる
- [ ] include/ ヘッダーが更新される

## 重要な注意事項

- **TARGET_GTEST_VERSIONファイルのみ**を編集してください
- README.md や manual-build.md は**直接編集しないでください**（自動生成されます）
- ドキュメントを更新する場合は、README.md.template または manual-build.md.template を編集してください

## ローカルでのドキュメント生成テスト

変更をプッシュする前に、ローカルでドキュメント生成をテストできます:

```bash
# ドキュメント生成スクリプトを実行
./.github/scripts/generate_docs.sh

# 生成されたドキュメントを確認
git diff README.md
git diff manual-build.md
```

## トラブルシューティング

### ワークフローが失敗する場合

- TARGET_GTEST_VERSIONファイルに記載されたバージョンが GoogleTest リポジトリに存在するか確認してください
- GoogleTest の正式なリリースタグ形式は `v1.X.X` です（例: v1.17.0, v1.18.0）

### ロールバック方法

誤ったバージョンを設定した場合:

```bash
# TARGET_GTEST_VERSIONファイルを以前のコミットに戻す
git log TARGET_GTEST_VERSION
git checkout <commit-hash> TARGET_GTEST_VERSION
git commit -m "Revert GoogleTest version to 1.17.0"
git push
```

ワークフローが自動的に旧バージョンで再ビルドします。
