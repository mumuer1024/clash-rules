#!/bin/bash
set -euo pipefail

# 使用临时目录防止文件泄露
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

# 严格定义路径
INPUT_FILE="${TMP_DIR}/sr_direct_list.module"
OUTPUT_FILE="rules/direct_list.yaml"

# 创建输出目录
mkdir -p "$(dirname "$OUTPUT_FILE")"

# 下载规则（带重试机制）
if ! wget --tries=3 --timeout=30 -O "$INPUT_FILE" \
    "https://raw.githubusercontent.com/GMOogway/shadowrocket-rules/master/sr_direct_list.module"; then
    echo "❌ 直连规则下载失败" >&2
    exit 1
fi

# 转换规则
{
    echo "payload:" > "$OUTPUT_FILE" && \
    grep -v '^#' "$INPUT_FILE" | grep -v '^$' | sed 's/^/  - "/;s/$/"/' >> "$OUTPUT_FILE"
} || {
    echo "❌ 直连规则转换失败" >&2
    exit 1
}

# 验证输出
LINE_COUNT=$(grep -c '^  -' "$OUTPUT_FILE")
echo "✅ 直连规则转换完成！有效规则数量: $LINE_COUNT"
[ "$LINE_COUNT" -gt 10000 ] || {
    echo "⚠️ 警告：规则数量异常少" >&2
    exit 1
}