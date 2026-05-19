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
# 自动触发(识别项目类型+推荐策略)
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
├── CHANGELOG.md                 # v1→v8.1 完整迭代记录
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

当前: **v8.2.0** — 通用开源级自组装引擎

详见 [CHANGELOG.md](CHANGELOG.md)

---

## ☕ 支持与打赏

**核心功能永久开源、免费使用。** 打赏完全自愿，是对开发者维护和迭代的支持。打赏用户不会获得任何特权或功能差异，所有用户体验完全一致。

如果你觉得这个工具帮到了你，欢迎请我喝杯咖啡，激励我继续优化迭代 ☕️

> 💰 ETH/BSC: `0x...`  
> 🪙 BTC: `bc1q...`  
> 📱 微信/支付宝赞赏码: [暂未设置，欢迎PR补充]

---

## 💡 建议与反馈

如果你在使用过程中有任何体验问题、功能想法、优化建议，欢迎随时在 [Issues](https://github.com/L1veSong/idea-foundry/issues) 中留言。

我会认真阅读每一条反馈，并择优纳入后续版本迭代。你的每一个建议，都是这个项目不断进化的动力。

---

## License

MIT © 2026 · 自由使用、修改、分发
