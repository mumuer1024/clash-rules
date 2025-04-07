# 🐱 openclash-rules
自用的openclash规则格式转换仓库

---

# 鸣谢！
> 感谢用户Aethersailor！我的openclash整个的设置是使用这个用户的“全网最详细的 OpenClash 设置方案”
> 
> https://github.com/Aethersailor/Custom_OpenClash_Rules/wiki

> 感谢用户GMOogway！本项目的rules列表转换自这个用户的“🚀 shadowrocket-rules”
> 
> https://github.com/GMOogway/shadowrocket-rules

---

# 备注
规则列表每8小时更新，格式转换脚本基于GitHub Actions，所以大概是需要代理才能使用的。

其实Aethersailor的设置方案中规则已经很完善了，但它的广告屏蔽脚本我运行失败，所以我使用了GMOogway的广告屏蔽列表。

那既然屏蔽列表做了转换，索性把另两个列表也做转换放在这里备用。

---

# 关于使用方法
一共三个规则列表：
* 直链（DIRECT）规则：direct_list.yaml
* 代理（PROXY）规则：proxy_list.yaml
* 屏蔽（REJECT）规则：reject_list.yaml

这三个列表在仓库“rules”目录中可以自取

## 具体使用方法
点击文件 → "Raw" 按钮，复制 URL

然后修改openclash的配置文件config.yaml（以屏蔽（REJECT）规则列表为例）

```
rule-providers:
  reject_list:
    type: http
    behavior: domain
    url: "xxxxxxxxxxxx"  #复制到的URL
    path: ./rule_provider/reject_list.yaml
    interval: 28800  # 8小时更新

rules:
  - RULE-SET,reject_list,REJECT  # 引用规则
```

另外两个规则列表的使用方法同上，可按照实际需求选用。

---

# 常见问题
* 我使用的是clash for Windows能用吗？
> 可以用，openclash、clash、clash for Windows都可以用。

* 规则与我自己的规则哪个优先级高？
> 按照yaml语言，优先级按照顺序排列，如果你自己的规则写在前面那么你自己的规则优先级更高。你可以按照需求决定编写顺序。

* 这么多规则，如何选择适合我的？
> 最常用的规则是黑名单和白名单。区别在于对待 *未知网站* 的不同处理方式，黑名单默认直连，而白名单则默认使用代理。
>
> 如果你选择恐惧症爆发，那就两个都下载好了，黑白名单切换使用，天下无忧。

* 广告过滤不完全？
> 该规则并不保证 100% 过滤所有的广告，尤其是视频广告，与网页广告不同的是，优酷等 App 每次升级都有可能更换一次广告策略，因此难以保证其广告屏蔽的实时有效性。而油管广告则不能通过简单的 url 匹配实现完全去广告。
> 
> 可以尝试Aethersailor的设置方案中的广告屏蔽脚本！
