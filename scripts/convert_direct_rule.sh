#!/bin/bash
# 创建目录（如果不存在）
mkdir -p rules

# 下载 Shadowrocket 规则
wget -O sr_direct_list.module "https://raw.githubusercontent.com/GMOogway/shadowrocket-rules/master/sr_direct_list.module"

# 转换为 OpenClash YAML 格式
echo "payload:" > rules/reject_list.yaml
grep -v '^#' sr_direct_list.module | grep -v '^$' | sed 's/^/  - "/;s/$/"/' >> rules/direct_list.yaml

# 输出日志
echo "转换完成！规则数量: $(grep -c '^  -' rules/direct_list.yaml)"
