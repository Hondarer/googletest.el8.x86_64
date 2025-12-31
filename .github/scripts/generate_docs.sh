#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
# コメント行(#で始まる)と空行を除外してバージョンを取得
VERSION=$(grep -v '^#' "${REPO_ROOT}/TARGET_GTEST_VERSION" | grep -v '^$' | head -n 1 | tr -d '[:space:]')

echo "Generating documentation for GoogleTest version: ${VERSION}"

# README.md生成
sed "s/{{GOOGLETEST_VERSION}}/${VERSION}/g" \
  "${REPO_ROOT}/README.md.template" > "${REPO_ROOT}/README.md"

# MANUAL_BUILD.md生成 (docs-src/)
sed "s/{{GOOGLETEST_VERSION}}/${VERSION}/g" \
  "${REPO_ROOT}/docs-src/MANUAL_BUILD.md.template" > "${REPO_ROOT}/docs-src/MANUAL_BUILD.md"

echo "Documentation generated successfully"
