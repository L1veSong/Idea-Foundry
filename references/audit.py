#!/usr/bin/env python3
"""Idea Foundry 发布前全量审计脚本"""
import json, os, re, sys, yaml

def audit(package_dir):
    errors = []
    expected = [
        "SKILL.md","README.md","CHANGELOG.md","package.json",
        "tag-pool.json","strategy-config.json","capability-registry.json","global-priority.json",
        "assets/wechat-pay.png","assets/alipay-pay.png",
        ".github/ISSUE_TEMPLATE/bug_report.md",".github/ISSUE_TEMPLATE/feature_request.md",
        ".github/ISSUE_TEMPLATE/config.yml",
        "scripts/install.sh","scripts/install.ps1"
    ]
    
    for f in expected:
        if not os.path.exists(os.path.join(package_dir, f)):
            errors.append(f"MISSING: {f}")
    
    for f in ["README.md","CHANGELOG.md","SKILL.md"]:
        path = os.path.join(package_dir, f)
        with open(path) as fh:
            for line in fh:
                if re.match(r'^[ \t]+\d+\|', line):
                    errors.append(f"MD_POLLUTED: {f}")
                    break
    
    for f in ["package.json","tag-pool.json","strategy-config.json","capability-registry.json","global-priority.json"]:
        try:
            with open(os.path.join(package_dir, f)) as fh:
                json.load(fh)
        except Exception as e:
            errors.append(f"JSON_INVALID: {f}")
    
    version = None
    for f in ["package.json","tag-pool.json","strategy-config.json","capability-registry.json","global-priority.json"]:
        with open(os.path.join(package_dir, f)) as fh:
            v = json.load(fh).get("version")
        if version is None: version = v
        elif v != version: errors.append(f"VERSION: {f} v{v} != v{version}")
    
    with open(os.path.join(package_dir, "SKILL.md")) as fh:
        parts = fh.read().split("---", 2)
    if len(parts) >= 3:
        fm = yaml.safe_load(parts[1])
        for k in ["name","version","priority","description"]:
            if k not in fm: errors.append(f"SKILL_FM_NO_{k}")
    
    if errors:
        print(f"FAIL {len(errors)} issues")
        for e in errors: print(f"  {e}")
        sys.exit(1)
    print(f"PASS v{version} {len(expected)} files")
    return version

if __name__ == "__main__":
    audit(sys.argv[1] if len(sys.argv)>1 else os.path.expanduser("~/Desktop/idea-foundry"))
