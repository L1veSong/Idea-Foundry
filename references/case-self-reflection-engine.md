# Hermes 自省引擎 — 完整锻造案例

> Idea Foundry v8 成功案例 | 日期: 2026-05-19 | 模式: 🏆极致成品 → ⚡极速 → 🏆极致成品

## 触发

用户说「帮我做一个ai筛图工具」→ Agent 没有触发 idea-foundry，直接进了 brainstorming。

**违规**: 被话题相似性误导——发现了 `photo-organizer-pro`，误以为这是"用现有工具"而非"新建项目"。

用户指出：「你触发idea foundry了吗？我正在测试」

## 纠正流程

1. Phase -4: 用户选 ⚡极速
2. 后来用户说「我要质量优先」→ 切换 🏆极致成品 → **重跑 Phase -3 + Phase -0.5**
3. 质量预检：S级可达 ✅
4. Brainstorming 完整收敛

## 关键学习

### 1. 不要被话题相似性误导
用户说「做」= 新建。用户说「用」= 调用现有。不管话题多接近，先看动词。

### 2. 切换模式必须重扫描
⚡→🏆 时，必须重跑 Phase -3（Skill扫描）和 Phase -0.5（策略裁剪），因为不同模式的能力激活表完全不同。

### 3. Brainstorming 中确认必须用 clarify()
纯文本 "OK吗？" 在 CLI 下让用户困惑。用户明确反馈：「怎没有选择题？而且不是方向键控制的」。

### 4. 硬编码优先级数字不好
用户指出 Lv.110/Lv.111 是"数字军备竞赛"。应改为角色制（guard管道 + orchestrator调度），通过阶段分离而非数字竞争。

### 5. 依赖排查
ralph-loop 被误标为依赖 → 用户指出「不就锁死绑定了吗？」→ 改为内置实现，零外部依赖。灵感来源 ≠ 技术依赖。

## 产出

- hermes-self-reflection v2.2.0 Skill
- GitHub 开源仓库: github.com/L1veSong/hermes-self-reflection
- 4 个版本 zip: v1.0.0 / v2.0.0 / v2.1.0 / v2.2.0
