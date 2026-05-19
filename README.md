# Idea Foundry · 创意锻造
> MIT License · Copyright (c) 2026 · 自由使用、修改、分发
**全局调度中枢 · Lv.110 · 通用开源级自组装工作流引擎**
一个想法 → 一键锻造 → 可交付成果
---
## 模式
### 三种策略
| 模式 | 适用场景 | Token | 触发语 |
    16||------|---------|-------|--------|
    17|| 🏆 极致成品 | 正式项目、产品交付 | 不惜 | 「用极致模式」 |
    18|| ⚖️ 均衡性价比 | 日常开发 (默认) | 适中 | 「均衡模式」 |
    19|| ⚡ 极速省Token | 快速原型、验证想法 | 极少 | 「极速模式」 |
### 三种预设领域
| 预设 | 链路 | 触发语 |
    24||------|------|--------|
    25|| 📝 学术论文 | 纯学术(选题→文献→查重→格式→终稿) | 「学术模式」 |
    26|| 💰 金融风控 | 强制合规+回测+风控+免责 | 「金融模式」 |
    27|| 🎨 纯创作 | 灵感→打磨→审定 | 「创作模式」 |
### 自定义模式
逐项可调: 能力范围 / 去重激进 / 冗余注入 / 降级行为 / 审查深度 / 行业插件 / 复盘
```
    34|「自定义模式」→ 逐项配置
    35|```
---
## 安装
### macOS / Linux
```bash
    44|bash scripts/install.sh
    45|```
### Windows
```powershell
    50|powershell -ExecutionPolicy Bypass -File scripts/install.ps1
    51|```
### 手动
```bash
    56|mkdir -p ~/.hermes/ideas/logs
    57|mkdir -p ~/.hermes/skills/software-development/idea-foundry
    58|cp SKILL.md ~/.hermes/skills/software-development/idea-foundry/
    59|cp tag-pool.json strategy-config.json capability-registry.json global-priority.json ~/.hermes/ideas/
    60|```
---
## 使用
```
    67|# 触发工作流(自动识别项目类型+推荐策略)
    68|「帮我做一个摄影作品集网站」
# 手动指定
    71|「用极致模式帮我设计这个API」
# 交互控制
    74|「foundry hold」      → 暂停, 保存当前状态
    75|「foundry resume」    → 恢复暂停的流程
    76|「foundry restart」   → 重置, 清除进度从头开始
# 运维
    79|「foundry debug」      → 输出完整决策链路
    80|「foundry reload」     → 重载配置, 无需 /reset
    81|「foundry lang zh」    → 切换中文
    82|「foundry lang en」    → Switch to English
    83|「独占调度」            → 锁定Foundry为唯一调度引擎
    84|「弹窗严格一点」         → strict_mode: true
    85|「弹窗宽松一点」         → 降低强制弹窗阈值
    86|```
---
## 环境自适应
| 环境 | UI 交互 |
    93||------|--------|
    94|| CLI 终端 (Hermes CLI / Terminal) | 🖥️ 方向键菜单 · 彩色进度条 · 交互式选择 |
    95|| Web / 消息平台 (OpenWebUI / 飞书 / 微信) | 📱 纯文本降级 · 数字选择 · ASCII 进度条 |
自动检测运行环境，无需手动切换。
---
## 多语言
启动时自动读取 `$LANG` 环境变量，切换 zh_CN / en_US。
```
   106|中文: 「🏆 极致成品 — 完美交付, 不惜Token」
   107|English: 「🏆 Perfection — Maximum quality, full pipeline」
   108|```
手动: `「foundry lang zh」` / `「foundry lang en」`
---
## 跨平台
| 平台 | 路径 |
   117||------|------|
   118|| macOS / Linux | `~/.hermes/` |
   119|| Windows | `%USERPROFILE%\.hermes\` |
所有路径使用 `${HERMES_HOME}` 变量，自动适配。UTF-8 编码。
---
## 架构
```
   128|Phase -4  全局策略选择    🏆/⚖️/⚡ + 预设 + 自定义
   129|Phase -3  Skill 发现扫描  构建能力映射表
   130|Phase -2  多领域打分      主领域 + 辅领域
   131|Phase -1  主干插件拼接    跨行业自动合并
   132|Phase -0.5 策略感知匹配   加权仲裁 + 缺容降级 + 多余择优
   133|Phase 0-N  执行 + 日志    可观测 + 自动 Skill 补全推荐
   134|```
### 全局调度优先级
```
   139|Lv.110  Idea Foundry         ← 最先触发, 全局调度中枢
   140|Lv.100  Superpowers          ← 降级为能力 Skill
   141|Lv.90   GStack autoplan      ← 降级为能力 Skill
   142|Lv.20   外部原生工作流         ← 仅备选
   143|Lv.0    人工引导              ← 最后兜底
   144|```
### 质量预检
```
   149|选策略 → 扫描Skill池 → 输出匹配报告(S/A/B/C/D级)
   150|实际≥目标 → 静默执行
   151|比目标低1级 → 弹窗建议切换
   152|比目标低≥2级 → 强制弹窗确认
   153|阈值可配: strategy-config.json → confirmation_policy
   154|```
---
## 文件结构
```
   161|idea-foundry/
   162|├── SKILL.md                     # 核心引擎
   163|├── README.md                    # 本文档
   164|├── CHANGELOG.md                 # v1→v8.2 完整迭代记录
   165|├── package.json                 # 包清单
   166|├── assets/
   167|│   ├── wechat-pay.png           # 微信赞赏码
   168|│   └── alipay-pay.png           # 支付宝收款码
   169|├── .github/
   170|│   └── ISSUE_TEMPLATE/
   171|│       ├── bug_report.md        # Bug 报告模板
   172|│       ├── feature_request.md   # 功能建议模板
   173|│       └── config.yml           # Issue 配置
   174|├── scripts/
   175|│   ├── install.sh               # macOS/Linux 一键安装
   176|│   └── install.ps1              # Windows 一键安装
   177|├── tag-pool.json                # 领域标签池
   178|├── strategy-config.json         # 策略模式 + 弹窗阈值
   179|├── capability-registry.json     # 能力注册表
   180|└── global-priority.json         # 全局优先级
   181|```
---
## 版本
当前: **v8.2.1** — 通用开源级自组装引擎
详见 [CHANGELOG.md](CHANGELOG.md)
---
## ☕ 支持作者
如果这个项目对你有帮助，欢迎请我喝杯咖啡，你的支持会激励我持续优化迭代。完全自愿，不打赏也不影响任何功能使用。
<table>
   198|<tr>
   199|<td width="50%" align="center">
**🇨🇳 国内**
<img src="assets/wechat-pay.png" width="200" alt="微信"><br>
   204|微信
<img src="assets/alipay-pay.png" width="200" alt="支付宝"><br>
   207|支付宝
</td>
   210|<td width="50%">
**🌍 International**
Bank Transfer
| | |
   217||---|---|
   218|| Recipient | J Li |
   219|| Bank | ERSTE BANK |
   220|| IBAN | AT41 2011 1845 3888 8800 |
   221|| BIC / SWIFT | GIBAATWWXXX |
</td>
   224|</tr>
   225|</table>
---
## 💡 建议与反馈 · Feedback
有 Bug？[点此提交](https://github.com/L1veSong/hermes-idea-foundry/issues/new?template=bug_report.md) · 有想法？[点此提交](https://github.com/L1veSong/hermes-idea-foundry/issues/new?template=feature_request.md)
我会认真阅读每一条反馈，择优纳入后续版本迭代。
---
## License
MIT © 2026 · 自由使用、修改、分发
   240|