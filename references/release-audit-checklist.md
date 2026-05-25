# 发布审计清单

> 来自 v1→v9 全流程实战教训。每次发布前逐项跑通。

## 🔴 阻断级

- [ ] `grep -rn 'v[0-9]\.[0-9]\.[0-9]' SKILL.md README.md CHANGELOG.md` — 无旧版本号残留
- [ ] 所有 JSON 可解析 (`python3 -c "import json; json.load(open(f))"`)
- [ ] SKILL.md YAML frontmatter 可解析 (`yaml.safe_load`)
- [ ] 所有 Markdown 首行无行号前缀 (`head -1 *.md`)

## 🟠 严重级

- [ ] 全部文件版本号一致 (SKILL.md + 5 JSON + README + CHANGELOG)
- [ ] ZIP 从桌面成品包直接压缩 (`zip -r`)
- [ ] ZIP 解压后逐字节吻合桌面包

## 🟡 警告级

- [ ] 所有预期文件存在 (对照 README 文件结构清单)
- [ ] 无 `.DS_Store` / `.git` 泄漏到 ZIP
- [ ] CHANGELOG 覆盖完整版本链

## 条件触发

- 修改 SKILL.md → 先加载 `writing-skills`
- 准备发布 → 先加载 `hermes-agent-skill-authoring`
- 不被无脑加载——仅在该用时用
