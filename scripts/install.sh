#!/usr/bin/env bash
# Idea Foundry v8.1 — 一键安装脚本 (macOS/Linux)
# 自动部署 Skill + 配置文件 + 注册全局优先级

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
IDEAS_DIR="$HERMES_HOME/ideas"
SKILL_DIR="$HERMES_HOME/skills/software-development/idea-foundry"

echo "🏗️  Idea Foundry v8.1 — 一键安装"
echo "   源目录: $SCRIPT_DIR"
echo "   目标:   $HERMES_HOME"
echo ""

# 1. Create directories
mkdir -p "$IDEAS_DIR/logs"
mkdir -p "$SKILL_DIR/scripts"
echo "  ✅ 目录创建完成"

# 2. Copy skill
cp "$SCRIPT_DIR/SKILL.md" "$SKILL_DIR/"
echo "  ✅ SKILL.md"

# 3. Copy configs
for f in tag-pool.json strategy-config.json capability-registry.json global-priority.json success-rates.json; do
    if [ -f "$SCRIPT_DIR/$f" ]; then
        cp "$SCRIPT_DIR/$f" "$IDEAS_DIR/"
        echo "  ✅ $f"
    fi
done

# 4. Copy docs
for f in README.md CHANGELOG.md; do
    if [ -f "$SCRIPT_DIR/$f" ]; then
        cp "$SCRIPT_DIR/$f" "$SKILL_DIR/"
    fi
done

# 5. Copy scripts
if [ -f "$SCRIPT_DIR/scripts/install.ps1" ]; then
    cp "$SCRIPT_DIR/scripts/install.ps1" "$SKILL_DIR/scripts/"
fi

# 6. Verify
echo ""
echo "── 验证 ──"
echo "  Skill:  $([ -f "$SKILL_DIR/SKILL.md" ] && echo '✅' || echo '❌')"
echo "  Configs: $([ -f "$IDEAS_DIR/tag-pool.json" ] && echo '✅(4 files)' || echo '❌')"
echo "  Docs:   $([ -f "$SKILL_DIR/README.md" ] && echo '✅' || echo '❌')"

# 7. Register (auto-discovered by Hermes skills_list)
if command -v hermes &> /dev/null; then
    echo "  Hermes:  ✅ 检测到, Skill 将在下次启动时自动发现"
else
    echo "  Hermes:  ⚠️ 未检测到, Skill 文件已就位, 安装Hermes后自动生效"
fi

echo ""
echo "🎉 Idea Foundry v8.1 安装完成!"
echo ""
echo "触发: 「帮我做XXX」或「用极致模式...」"
echo "调试: 「foundry debug」"
echo "重载: 「foundry reload」"
echo "文档: $SKILL_DIR/README.md"
echo ""
echo "Packaged with ❤️ — Lv.110 Global Orchestrator"
