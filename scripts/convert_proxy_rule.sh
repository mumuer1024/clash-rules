#!/bin/bash
set -euo pipefail

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

INPUT_FILE="${TMP_DIR}/sr_proxy_list.module"
OUTPUT_FILE="rules/proxy_list.yaml"

mkdir -p "$(dirname "$OUTPUT_FILE")"

if ! wget --tries=3 --timeout=30 -O "$INPUT_FILE" \
    "https://raw.githubusercontent.com/GMOogway/shadowrocket-rules/master/sr_proxy_list.module"; then
    echo "❌ 代理规则下载失败" >&2
    exit 1
fi

{
    echo "payload:" > "$OUTPUT_FILE" && \
    grep -v '^#' "$INPUT_FILE" | grep -v '^$' | sed 's/^/  - "/;s/$/"/' >> "$OUTPUT_FILE"
} || {
    echo "❌ 代理规则转换失败" >&2
    exit 1
}

LINE_COUNT=$(grep -c '^  -' "$OUTPUT_FILE")
echo "✅ 代理规则转换完成！有效规则数量: $LINE_COUNT"
[ "$LINE_COUNT" -gt 5000 ] || {
    echo "⚠️ 警告：规则数量异常少" >&2
    exit 1
}