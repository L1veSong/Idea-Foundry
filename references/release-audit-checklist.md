# 发布审计清单 — Release Audit Checklist

每次声称「可以发布」前必须执行。源于多次「以为好了但用户发现问题的真实事故。

## 事故档案

| 日期 | 事故 | 根因 |
|------|------|------|
| 05-19 | ZIP 名 v8.2.0 含旧内容 | ZIP 从旧桌面包压缩后未更新 |
| 05-19 | 3 个 JSON 被清空 | `execute_code` 的 `write_file` 传空内容 |
| 05-19 | package.json + global-priority.json 行号污染 | `read_file` 输出当 `write_file` 输入 |
| 05-19 | README 整篇每行都有 `NN|` 前缀 | 同上，且首次修复只修了首行 |
| 05-19 | 工作副本 v8.3.2 vs 桌面 v8.3.1 不同步 | 只同步了部分文件，漏了 SKILL.md |

## 禁令（铁律，触犯即事故）

1. **禁止 `read_file` 输出当 `write_file` 输入** — `read_file` 返回 `LINE_NUM|CONTENT` 格式，写回会污染整个文件
2. **禁止 ZIP 从非桌面包压缩** — ZIP 必须从已验证的桌面包压缩，不自己造文件
3. **禁止 `execute_code` 的 `write_file` 不验证** — 写入后必须 `read_file` 读回首行确认无前缀
4. **禁止修一处不查全包** — 修完一个文件必须检查组内所有文件是否被连带污染
5. **禁止声称「可以发布」前不做全量审计**

## 审计步骤

### 1. Markdown 格式（全量，不止首行）

```bash
for f in README.md CHANGELOG.md SKILL.md .github/ISSUE_TEMPLATE/*.md; do
  polluted=$(grep -c '^[[:space:]]*[0-9]|' "$f" 2>/dev/null || echo 0)
  if [ "$polluted" -gt 0 ]; then
    echo "❌ $f: $polluted 行被污染"
  else
    echo "✅ $f"
  fi
done
```

**注意：必须检查全文件，不止首行。** 首次修复只修了首行，导致其他 160+ 行仍然有前缀。

### 2. JSON 合法性

```bash
for f in package.json tag-pool.json strategy-config.json capability-registry.json global-priority.json; do
  python3 -c "import json; json.load(open('$f'))" 2>/dev/null && echo "✅ $f" || echo "❌ $f 损坏"
done
```

**常见损坏模式：** 文件 0 字节（execute_code 写入失败）、行号前缀混入（`     1|     1|{`）

### 3. 版本一致性

所有文件版本号必须一致：

```bash
echo "SKILL.md: $(grep -oP 'version:\s*\K[0-9.]+' SKILL.md)"
for f in package.json tag-pool.json strategy-config.json capability-registry.json global-priority.json; do
  python3 -c "import json; print(f'$f: ' + json.load(open('$f')).get('version','?'))"
done
```

### 4. 工作副本 ≡ 桌面包

```bash
diff -rq ~/.hermes/skills/software-development/idea-foundry ~/Desktop/idea-foundry \
  --exclude='.git' --exclude='.gitignore' | grep -v 'references/'
# 无输出 = 一致
```

### 5. ZIP 验证

```bash
# 从桌面包压缩（不改名、不自造）
cd ~/Desktop && zip -rq idea-foundry-vX.Y.Z.zip idea-foundry/ -x "*.git/*" ".gitignore" "__MACOSX/*" ".DS_Store"

# 逐字节验证 ZIP 与桌面包吻合
python3 -c "
import zipfile, os, hashlib
base='idea-foundry'
with zipfile.ZipFile('idea-foundry-vX.Y.Z.zip') as zf:
    for info in zf.infolist():
        if info.is_dir(): continue
        n = info.filename.replace(base+'/', '')
        with open(f'{base}/{n}','rb') as fh:
            if zf.read(info.filename) != fh.read():
                print(f'❌ {n}')
                break
    else:
        print('✅ ZIP 吻合')
"
```

### 6. 最终确认清单

- [ ] 所有 Markdown 文件无行号前缀（全量检查，不止首行）
- [ ] 所有 JSON 文件合法（非 0 字节、非行号污染）
- [ ] 所有文件版本号一致
- [ ] 桌面包 ≡ 工作副本
- [ ] ZIP 逐字节吻合桌面包
- [ ] ZIP 文件名版本号正确
- [ ] CHANGELOG 包含当前版本

**以上 7 项全绿才能说「可以发布」。**
