# 发布前审计清单

本文件记录 v8 开发中反复踩坑后建立的发布纪律。每次声称「可以发布」前，必须逐项通过。

## 铁律（来自血泪教训）

1. **ZIP 必须从桌面成品包压缩**，绝不自建 ZIP 内容
2. **write_file 后立即 read_file 验证首行无行号前缀**
3. **修一处检查全包**，不头痛医头
4. **read_file 输出 ≠ write_file 输入**（会导致行号 `NN|` 污染）
5. **补全内容必须从老版本取原文**，禁止凭记忆自写

## 审计清单

### 1. 版本一致性
```
[ ] SKILL.md version: 目标版本
[ ] package.json version: 目标版本
[ ] tag-pool.json version: 目标版本
[ ] strategy-config.json version: 目标版本
[ ] capability-registry.json version: 目标版本
[ ] global-priority.json version: 目标版本
```

### 2. Markdown 格式
```
[ ] README.md 首行无行号前缀
[ ] CHANGELOG.md 无行号污染
[ ] SKILL.md 无行号污染
[ ] 所有表格 `|` 分隔符未与行号前缀合并成 `||`
[ ] 代码块正确关闭（``` 成对）
```

### 3. JSON 合法性
```
[ ] package.json 可被 json.load() 解析
[ ] tag-pool.json 可解析
[ ] strategy-config.json 可解析
[ ] capability-registry.json 可解析
[ ] global-priority.json 可解析
```

### 4. SKILL.md 功能完整性
```
[ ] YAML frontmatter 可被 yaml.safe_load() 解析
[ ] name / version / priority / role 字段正确
[ ] 所有关键功能关键词存在（对比 CHANGELOG 中声明的功能）
```

### 5. ZIP 完整性
```
[ ] ZIP 内文件列表 = 桌面成品包文件列表
[ ] ZIP 内每个文件逐字节 = 桌面成品包对应文件
```

### 6. 工作副本 ≡ 桌面成品包
```
[ ] SKILL.md MD5 一致
[ ] README.md MD5 一致
[ ] 所有 JSON 文件 MD5 一致
```

## 常见失败模式

| 症状 | 根因 | 修复 |
|------|------|------|
| 首行 `NN|` 前缀 | `read_file` 输出被当 `write_file` 输入 | `re.sub(r'^[ \t]*\d+\|', '', content)` |
| JSON `Extra data` 错误 | 同上，JSON 被行号污染 | 同上或从备份恢复 |
| 表格 `||` 双竖线 | 行号前缀的 `|` 与表格 `|` 合并 | 清洗后重建 |
| 桌面目录只剩 README/CHANGELOG | `write_file` 覆盖目录时清空其他文件 | 从工作副本 rsync 恢复 |
| ZIP 含旧版内容 | ZIP 名更新但内容未重压 | 删除旧 ZIP 后重新从桌面包压缩 |

## 参考

- 本文件基于 2026-05-19 v8.1→v8.4 迭代中实际踩坑记录
- 相关铁律已写入 memory
