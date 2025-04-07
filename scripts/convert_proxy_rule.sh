#!/bin/bash
set -euo pipefail

# 配置参数
INPUT_URL="https://raw.githubusercontent.com/GMOogway/shadowrocket-rules/master/sr_proxy_list.module"
OUTPUT_FILE="proxy_list.yaml"  # 直接输出到根目录
TEMP_FILE=$(mktemp)  # 使用系统临时目录

cleanup() {
  rm -f "$TEMP_FILE"
}
trap cleanup EXIT

# 下载规则
if ! wget --tries=3 --timeout=30 -O "$TEMP_FILE" "$INPUT_URL"; then
  echo "❌ $1规则下载失败" >&2
  exit 1
fi

# 转换规则
echo "payload:" > "$OUTPUT_FILE"
grep -v '^#' "$TEMP_FILE" | grep -v '^$' | sed 's/^/  - "/;s/$/"/' >> "$OUTPUT_FILE"

# 验证输出
LINE_COUNT=$(grep -c '^  -' "$OUTPUT_FILE")
echo "✅ $1规则转换完成！数量: $LINE_COUNT"
[ "$LINE_COUNT" -gt 10000 ] || { echo "⚠️ 规则数量不足"; exit 1; }