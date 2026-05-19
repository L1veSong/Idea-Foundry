# Release Audit Checklist

每次声称「可以发布」前必须执行的完整审计流程。

## 1. Markdown 格式

```bash
for f in README.md CHANGELOG.md SKILL.md .github/ISSUE_TEMPLATE/*.md; do
  head -1 "$f" | grep -q '^[[:space:]]*[0-9]|' && echo "❌ $f: 首行有前缀" || echo "✅ $f"
done
```

## 2. JSON 合法性

```bash
for f in *.json .github/ISSUE_TEMPLATE/config.yml; do
  python3 -c "import json; json.load(open('$f'))" 2>/dev/null && echo "✅ $f" || echo "❌ $f"
done
```

## 3. 版本一致性

```bash
grep -h 'version' SKILL.md *.json | grep '8\.'
# 全部应为同一版本号
```

## 4. ZIP 验证

```bash
# ZIP 必须从桌面包压缩
zip -r idea-foundry-vX.Y.Z.zip idea-foundry/ -x "*.git/*" ".gitignore"

# 验证 ZIP 与桌面包字节吻合
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

## 5. CHANGELOG 覆盖

确认 CHANGELOG.md 包含所有已发布版本号，从 v1.0 到当前版本。

## 禁令

- 禁止从非桌面包压缩 ZIP
- 禁止 write_file 后不读回验证
- 禁止修一处不查全包
- 禁止 read_file 输出当 write_file 输入
