# Idea Foundry · 创意锻造
> MIT License · Copyright (c) 2026 · 自由使用、修改、分发
**全局调度中枢 · Lv.110 · 通用开源级自组装工作流引擎**
一个想法 → 一键锻造 → 可交付成果
---
## 模式
### 三种策略
| 模式 | 适用场景 | Token | 触发语 |
|------|---------|-------|--------|
| 🏆 极致成品 | 正式项目、产品交付 | 不惜 | 「用极致模式」 |
| ⚖️ 均衡性价比 | 日常开发 (默认) | 适中 | 「均衡模式」 |
| ⚡ 极速省Token | 快速原型、验证想法 | 极少 | 「极速模式」 |
### 三种预设领域
| 预设 | 链路 | 触发语 |
|------|------|--------|
| 📝 学术论文 | 纯学术(选题→文献→查重→格式→终稿) | 「学术模式」 |
| 💰 金融风控 | 强制合规+回测+风控+免责 | 「金融模式」 |
| 🎨 纯创作 | 灵感→打磨→审定 | 「创作模式」 |
### 自定义模式
逐项可调: 能力范围 / 去重激进 / 冗余注入 / 降级行为 / 审查深度 / 行业插件 / 复盘
```
「自定义模式」→ 逐项配置
```
---
## 安装
### macOS / Linux
```bash
bash scripts/install.sh
```
### Windows
```powershell
powershell -ExecutionPolicy Bypass -File scripts/install.ps1
```
### 手动
```bash
mkdir -p ~/.hermes/ideas/logs
mkdir -p ~/.hermes/skills/software-development/idea-foundry
cp SKILL.md ~/.hermes/skills/software-development/idea-foundry/
cp tag-pool.json strategy-config.json capability-registry.json global-priority.json ~/.hermes/ideas/
```
---
## 使用
```
# 触发工作流(自动识别项目类型+推荐策略)
「帮我做一个摄影作品集网站」
# 手动指定
「用极致模式帮我设计这个API」
# 交互控制
「foundry hold」      → 暂停, 保存当前状态
「foundry resume」    → 恢复暂停的流程
「foundry restart」   → 重置, 清除进度从头开始
# 运维
「foundry debug」      → 输出完整决策链路
「foundry reload」     → 重载配置, 无需 /reset
「foundry lang zh」    → 切换中文
「foundry lang en」    → Switch to English
「独占调度」            → 锁定Foundry为唯一调度引擎
「弹窗严格一点」         → strict_mode: true
「弹窗宽松一点」         → 降低强制弹窗阈值
```
---
## 环境自适应
| 环境 | UI 交互 |
|------|--------|
| CLI 终端 (Hermes CLI / Terminal) | 🖥️ 方向键菜单 · 彩色进度条 · 交互式选择 |
| Web / 消息平台 (OpenWebUI / 飞书 / 微信) | 📱 纯文本降级 · 数字选择 · ASCII 进度条 |
自动检测运行环境，无需手动切换。
---
## 多语言
启动时自动读取 `$LANG` 环境变量，切换 zh_CN / en_US。
```
中文: 「🏆 极致成品 — 完美交付, 不惜Token」
English: 「🏆 Perfection — Maximum quality, full pipeline」
```
手动: `「foundry lang zh」` / `「foundry lang en」`
---
## 跨平台
| 平台 | 路径 |
|------|------|
| macOS / Linux | `~/.hermes/` |
| Windows | `%USERPROFILE%\.hermes\` |
所有路径使用 `${HERMES_HOME}` 变量，自动适配。UTF-8 编码。
---
## 架构
```
Phase -4  全局策略选择    🏆/⚖️/⚡ + 预设 + 自定义
Phase -3  Skill 发现扫描  构建能力映射表
Phase -2  多领域打分      主领域 + 辅领域
Phase -1  主干插件拼接    跨行业自动合并
Phase -0.5 策略感知匹配   加权仲裁 + 缺容降级 + 多余择优
Phase 0-N  执行 + 日志    可观测 + 自动 Skill 补全推荐
```
### 全局调度优先级
```
Lv.110  Idea Foundry         ← 最先触发, 全局调度中枢
Lv.100  Superpowers          ← 降级为能力 Skill
Lv.90   GStack autoplan      ← 降级为能力 Skill
Lv.20   外部原生工作流         ← 仅备选
Lv.0    人工引导              ← 最后兜底
```
### 质量预检
```
选策略 → 扫描Skill池 → 输出匹配报告(S/A/B/C/D级)
实际≥目标 → 静默执行
比目标低1级 → 弹窗建议切换
比目标低≥2级 → 强制弹窗确认
阈值可配: strategy-config.json → confirmation_policy
```
---
## 文件结构
```
idea-foundry/
├── SKILL.md                     # 核心引擎
├── README.md                    # 本文档
├── CHANGELOG.md                 # v1→v8.2 完整迭代记录
├── package.json                 # 包清单
├── assets/
│   ├── wechat-pay.png           # 微信赞赏码
│   └── alipay-pay.png           # 支付宝收款码
├── .github/
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md        # Bug 报告模板
│       ├── feature_request.md   # 功能建议模板
│       └── config.yml           # Issue 配置
├── scripts/
│   ├── install.sh               # macOS/Linux 一键安装
│   └── install.ps1              # Windows 一键安装
├── tag-pool.json                # 领域标签池
├── strategy-config.json         # 策略模式 + 弹窗阈值
├── capability-registry.json     # 能力注册表
└── global-priority.json         # 全局优先级
```
---
## 版本
当前: **v8.3.1** — 自进化+自适应仲裁+自检

### v8.3 新特性

- 🆕 **自进化激活** — 陌生领域自动生成标签+插件包
- 📊 **历史成功率反馈** — 加权仲裁动态调优
- 🛡️ **实现阶段安全** — Phase 8 自动开启 `careful`
- 🧪 **自检命令** — `foundry test --self` 四维验证
- 🎨 **版本查询** — `foundry version`
- ✨ **彩蛋：终端弹窗美化** — CLI 方向键菜单+彩色进度条
详见 [CHANGELOG.md](CHANGELOG.md)
---
## ☕ 支持作者
如果这个项目对你有帮助，欢迎请我喝杯咖啡，你的支持会激励我持续优化迭代。完全自愿，不打赏也不影响任何功能使用。
**🇨🇳 国内**

| 微信 | 支付宝 |
|------|--------|
| <img src="assets/wechat-pay.png" width="180"> | <img src="assets/alipay-pay.png" width="180"> |

**🌍 International**

| | |
|---|---|
| Recipient | J Li |
| Bank | ERSTE BANK |
| IBAN | AT41 2011 1845 3888 8800 |
| BIC / SWIFT | GIBAATWWXXX |
---
## 💡 建议与反馈
有 Bug？[点此提交](https://github.com/L1veSong/Idea-Foundry/issues/new?template=bug_report.md)

有想法？[点此提交](https://github.com/L1veSong/Idea-Foundry/issues/new?template=feature_request.md)

我会认真阅读每一条反馈，择优纳入后续版本迭代。
---
## License
MIT © 2026 · 自由使用、修改、分发
