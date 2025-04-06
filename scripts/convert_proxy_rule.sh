#!/bin/bash
# 创建目录（如果不存在）
mkdir -p rules

# 下载 Shadowrocket 规则
wget -O sr_proxy_list.module "https://raw.githubusercontent.com/GMOogway/shadowrocket-rules/master/sr_proxy_list.module"

# 转换为 OpenClash YAML 格式
echo "payload:" > rules/proxy_list.yaml
grep -v '^#' sr_proxy_list.module | grep -v '^$' | sed 's/^/  - "/;s/$/"/' >> rules/proxy_list.yaml

# 输出日志
echo "转换完成！规则数量: $(grep -c '^  -' rules/proxy_list.yaml)"