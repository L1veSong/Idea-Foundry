# Idea Foundry — 一键安装脚本 (Windows PowerShell)
# 自动创建配置文件、注册全局优先级

$ErrorActionPreference = "Stop"

$HERMES_HOME = if ($env:HERMES_HOME) { $env:HERMES_HOME } else { "$env:USERPROFILE\.hermes" }
$IDEAS_DIR = "$HERMES_HOME\ideas"
$SKILL_DIR = "$HERMES_HOME\skills\software-development\idea-foundry"

Write-Host "🏗️  Idea Foundry v8.1 — 一键安装 (Windows)" -ForegroundColor Cyan

# 1. Create directories
New-Item -ItemType Directory -Force -Path "$IDEAS_DIR\logs" | Out-Null
New-Item -ItemType Directory -Force -Path $SKILL_DIR | Out-Null
Write-Host "  ✅ 目录创建完成" -ForegroundColor Green

# 2. Write config files
@'
{
  "version": "8.1.1",
  "tags": {
    "engineering": {
      "web": {"trunk": "web-fullstack"},
      "frontend": {"trunk": "web-frontend"},
      "backend": {"trunk": "backend-api"},
      "cli": {"trunk": "cli-tool"},
      "data": {"trunk": "data-pipeline"},
      "mobile": {"trunk": "mobile-app"},
      "devops": {"trunk": "devops-infra"},
      "sdk": {"trunk": "sdk-library"},
      "algorithm": {"trunk": "algorithm-pure"},
      "embedded": {"trunk": "embedded-iot"}
    },
    "industry": {
      "photography": {"plugins": ["visual-check","color-management","composition-rules","copyright-metadata"]},
      "finance": {"plugins": ["compliance-review","risk-assessment","backtest-validation","disclaimer-mandatory"]},
      "academic": {"plugins": ["literature-review","methodology-check","plagiarism-check","format-compliance","academic-language"]},
      "legal": {"plugins": ["regulation-search","clause-review","format-compliance","risk-annotation","disclaimer-mandatory"]},
      "creative": {"plugins": ["brainstorm-divergent","style-consistency","audience-test","humanizer-polish"]},
      "business": {"plugins": ["business-model","competitive-matrix","market-sizing","financial-projection"]},
      "medical": {"plugins": ["evidence-based-check","ethics-review","clinical-validation","data-privacy"]},
      "education": {"plugins": ["learning-objectives","cognitive-hierarchy","assessment-criteria","accessibility"]},
      "gaming": {"plugins": ["gameplay-validation","balance-check","ux-benchmark","performance-target"]},
      "music": {"plugins": ["harmony-rules","arrangement-framework","copyright-check","audio-quality"]}
    }
  },
  "scoring": {
    "dimensions": ["keyword_match","output_form","domain_knowledge_density","constraint_type"],
    "primary_threshold": 0.5,
    "secondary_threshold": 0.3
  },
  "evolution_log": []
}
'@ | Out-File -Encoding UTF8 -FilePath "$IDEAS_DIR\tag-pool.json"
Write-Host "  ✅ tag-pool.json" -ForegroundColor Green

@'
{
  "version": "8.1.1",
  "strategies": {
    "perfection": {"name":"🏆 极致成品","capability_scope":["critical","important","nice_to_have","industry"],"dedup":"complementary_keep","degradation":"warn_user"},
    "balanced": {"name":"⚖️ 均衡性价比","capability_scope":["critical","important"],"dedup":"best_per_capability","degradation":"silent_fallback"},
    "speed": {"name":"⚡ 极速省Token","capability_scope":["critical"],"dedup":"single_best","degradation":"auto_accept"}
  },
  "confirmation_policy": {
    "thresholds": {"silent_execute": 0, "suggest_switch": 1, "force_confirm": 2},
    "strict_mode": false
  }
}
'@ | Out-File -Encoding UTF8 -FilePath "$IDEAS_DIR\strategy-config.json"
Write-Host "  ✅ strategy-config.json" -ForegroundColor Green

@'
{
  "version": "8.1.1",
  "capabilities": {
    "critical": ["VALIDATE","SHARPEN","DESIGN","PLAN","IMPLEMENT","VERIFY"],
    "important": ["DESIGN_REVIEW","ARCH_REVIEW","BREAKDOWN","TDD_ENFORCE","DEBUG","CODE_REVIEW","SECURITY_SCAN","BROWSER_TEST","SECURITY_AUDIT","SHIP","CONTEXT_SAVE"],
    "nice_to_have": ["DX_REVIEW","SECOND_OPINION","CODE_HEALTH","DOCUMENT","RETRO","LEARN"],
    "industry": ["ACADEMIC_REVIEW","FINANCE_COMPLY","LEGAL_REVIEW","CREATIVE_POLISH","PHOTO_CHECK"]
  }
}
'@ | Out-File -Encoding UTF8 -FilePath "$IDEAS_DIR\capability-registry.json"
Write-Host "  ✅ capability-registry.json" -ForegroundColor Green

@'
{
  "version": "8.1.1",
  "global_priority": {
    "foundry": {"level": 110, "role": "global_orchestrator", "force_primary": true},
    "superpowers": {"level": 100, "role": "fallback"},
    "gstack_autoplan": {"level": 90, "role": "fallback"},
    "native_workflows": {"level": 20, "role": "last_resort"},
    "manual_guided": {"level": 0, "role": "ultimate_fallback"}
  }
}
'@ | Out-File -Encoding UTF8 -FilePath "$IDEAS_DIR\global-priority.json"
Write-Host "  ✅ global-priority.json" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 Idea Foundry v8.1 安装完成! (Windows)" -ForegroundColor Cyan
Write-Host ""
Write-Host "触发: 「帮我做XXX」或「用极致模式...」"
Write-Host "调试: 「foundry debug」"
Write-Host "重载: 「foundry reload」"
