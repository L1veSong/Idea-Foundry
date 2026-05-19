# Hermes Canon Mnemonic Guard — 完整锻造案例

> Idea Foundry v8 成功案例 | 日期: 2026-05-19 | 模式: 🏆极致成品 → ⚡极速 → 🏆极致成品

## 触发

用户说「帮我做一个ai筛图工具」→ Agent 没有触发 idea-foundry，直接进了 brainstorming。

**违规 3 & 反模式:** 被话题相似性误导——发现了 `photo-organizer-pro`，误以为这是"用现有工具"而非"新建项目"。

用户指出：「你触发idea foundry了吗？我正在测试」

## 纠正流程

1. Phase -4: 用户选 ⚡极速 → 后来切 🏆极致成品 → 重跑 Phase -3 + Phase -0.5
2. 完整 brainstorming: 收敛需求 → 三类错误(ban/gap/lazy) → 分层匹配 → Ralph Loop 借鉴 → 依赖排查
3. writing-plans: 14 个 task → 直接执行 → v1.0.0 → v2.0.0 → v2.1.0 → v2.2.0
4. GitHub 开源 + Release v1.0.0

## 关键学习

### 违规 9 (新增): 用户问「需要吗/应该吗」时预判执行
用户问「两条线合并成 4.0.0 可以吗？」→ Agent 直接改了 version。用户纠正：「停，改回来，我问你需要吗？给建议不是让你改。」
→ 教训: 决策咨询 ≠ 执行指令。先分析 + clarify()，等选择再动代码。

### 违规 8 (新增): 权限通胀
设计自省引擎时，Agent 提议 Lv.111（比 Idea Foundry Lv.110 高 1）。用户指出：「为什么我每一个写的 skill 权限都这么高？是不是写死 110 111 不太好？」
→ 教训: 硬编码数字 = 军备竞赛。应使用角色声明 + 阶段分离。

### 违规 7: 依赖排查
ralph-loop 被误标为依赖 → 用户指出「不就锁死绑定了吗？」→ 改为内置实现，零外部依赖。

### 违规 2/4: 不用 clarify()
Brainstorming 中用纯文本问"OK吗？" → 用户反馈：「怎没有选择题？而且不是方向键控制的」→ 此后全部改用 clarify()。

## 产出

- hermes-canon-mnemonic-guard v2.2.0 Skill (19 文件)
- GitHub: github.com/L1veSong/hermes-canon-mnemonic-guard
- 两条版本线: 典则线 Canon (2.x) / 忆存线 Mnemonic (3.x) → 时机成熟合并 v4.0.0
- 核心功能: 三类错误 + 分层匹配 + 固化引擎 + 防偷懒清单 + 扫盘提取 + Obsidian 结构化 + 跨会话状态
