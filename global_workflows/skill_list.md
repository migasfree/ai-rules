---
description: List all skills showing their enabled/disabled status, merging Global and Workspace scopes, and checking for updates.
version: 1.6.0
last_modified: 2026-02-10
---

# 📋 Unified AI Skill Report (v1.6.0)

This workflow lists all Global Roles/Skills and Local Workspace Skills, giving a complete overview and checking for available updates from the official repository.

## Usage

- `/skill_list`

## 1. List Global & Local Skills

- **Action**: Execute the dedicated skill listing script from the global storage or local fallback.
- **Command**:

```bash
GLOBAL_SCRIPT="$HOME/.gemini/antigravity/scripts/skill_list.sh"

if [ -f "$GLOBAL_SCRIPT" ]; then
    bash "$GLOBAL_SCRIPT"
else
    echo "❌ Error: skill_list.sh not found."
    echo "Expected global: $GLOBAL_SCRIPT"
    exit 1
fi
```
