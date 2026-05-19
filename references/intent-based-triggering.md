# Intent-Based Skill Triggering · 意图识别触发模式

## 问题

关键词匹配模式有致命缺陷：漏一个词就漏判，误命中就误触发。

```
「我想搞一个自动发邮件的工具」 → 没命中「帮我做」→ 漏判
「帮我查一下这个API怎么用」   → 命中了「帮我」→ 误触发
```

## 方案

用**意图分类**替代**关键词列表**。描述用户想做什么（CREATE/BUILD/DESIGN），而非用户说了什么词。

## description 字段

```yaml
description: |
  TRIGGER INTENT: User wants to CREATE, BUILD, DESIGN, or IMPLEMENT 
  something substantial — a new project, tool, system, app, service, 
  script, website, framework, or architecture.
  
  DO NOT TRIGGER WHEN: User is asking a factual question, looking up 
  documentation, making a tiny edit (≤3 lines), or engaging in casual 
  chat. The intent is QUERY, not CREATE.
```

## 意图分类表

| 触发意图 | 典型场景 | 本质 |
|---------|---------|------|
| CREATE | 「做一个」「写一个」「建一个」「搞一个」 | 从无到有创造 |
| BUILD | 「帮我开发」「实现这个功能」 | 工程实现 |
| DESIGN | 「帮我设计」「架构怎么弄」 | 方案设计 |
| REFACTOR | 「重构」「重写」「翻新」 | 大规模改造 |

| 排除意图 | 典型场景 | 本质 |
|---------|---------|------|
| QUERY | 「这个命令是什么意思」「X和Y有什么区别」 | 信息查询 |
| LOOKUP | 「帮我查文档」「这个API怎么用」 | 查阅检索 |
| TWEAK | 「改一行」「修个bug」「配置调一下」 | 微调修改 |
| CHAT | 「你觉得呢」「随便聊聊」 | 对话交流 |

## 核心判断

```
「用户要我产出东西，还是回答东西？」
  产出 → 触发
  回答 → 跳过
```

## 与关键词模式的对比

| | 关键词 | 意图 |
|---|---|---|
| 「帮我做一个网站」 | ✅ 命中 | ✅ CREATE |
| 「我想搞个自动发邮件的东西」 | ❌ 漏判 | ✅ CREATE |
| 「帮我查一下API文档」 | ❌ 误触发 | ✅ QUERY → 跳过 |
| 「开发一个命令行工具」 | ✅ 命中 | ✅ BUILD |
| 「这个错误怎么修」 | ❌ 跳过 | ✅ QUERY → 跳过 |

## 总结

> 描述意图，不列举关键词。Hermes 的 Skill 匹配器对语义意图的识别比关键词匹配更精准，覆盖更广。
