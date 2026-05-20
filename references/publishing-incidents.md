# 发布事故记录

记录 idea-foundry 历次发布前踩过的坑，每次发布前必读。

## 事故 1: ZIP 未更新 (2026-05-19)

**症状:** 声称「ZIP 已更新，可以发布」，但 ZIP 内 SKILL.md 版本号仍是旧版。
**根因:** 改了桌面包但忘了重建 ZIP，或用旧文件覆盖了新的。
**教训:** 发布前必须 `unzip -p` 验证 ZIP 内 SKILL.md 版本号 + MD5 对比。

## 事故 2: read_file → write_file 行号污染 (2026-05-19)

**症状:** SKILL.md 每行出现 `     1|     1|` 前缀，JSON 文件被清空或写入行号。
**根因:** `read_file` 输出带 `LINE_NUM|CONTENT` 格式，直接传给 `write_file(content=...)` 原样写入。
**教训:** `read_file` 输出 ≠ `write_file` 输入。文件修改用 `patch` 或 `terminal + sed`，不用 execute_code 读改写。

## 事故 3: 声称「可以发布」但未全量审计 (2026-05-19)

**症状:** 三次声称可以发布，每次都发现问题（版本不一致、MD格式错误、功能缺失）。
**根因:** 修一处就声称好了，没跑全量审计。
**教训:** 发布前必须逐项过审计清单（版本/JSON/MD/ZIP/功能/README/CHANGELOG），7 项全绿才说可以发布。

## 审计清单

每次发布前，对桌面成品包执行：

```
[ ] 版本号: 工作=桌面=v8.x.x
[ ] JSON: 5个文件全部可解析，版本一致
[ ] MD: README+CHANGELOG+SKILL.md 首行无行号前缀
[ ] ZIP: unzip -p 验证 SKILL.md 版本号 + MD5 对比桌面包
[ ] 功能: 30+ 关键词覆盖检查
[ ] README: 含版本号+新特性
[ ] CHANGELOG: 含当前版本条目
```

## 反模式

- ❌ 用 execute_code 读写 SKILL.md（必产生行号污染）
- ❌ 修完一处就说好了（必须全量审计）
- ❌ 自己重写文件再造 ZIP（必须从桌面包压缩）
- ❌ 不读回验证就声称写入成功
