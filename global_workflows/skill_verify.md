---
description: Verify that workspace skills are up-to-date, structurally valid, and consistent with global counterparts.
version: 2.2.0
last_modified: 2026-03-30
---

# 🔍 Skill Verification Workflow

This workflow performs a comprehensive health check on all AI skills in the ecosystem. It verifies structural integrity, version freshness, dependency resolution, content safety, and global/workspace synchronization.

## Usage

- `/skill_verify` — Read-only verification report.
- `/skill_verify --fix` — Verify and auto-update outdated workspace skills from GitHub.

## Verification Phases

| Phase | Check | Description |
| :---: | :---- | :---------- |
| 1 | **Frontmatter Integrity** | Validates that all `SKILL.md` files contain required YAML fields (`name`, `version`, `triggers`). Global skills are also checked for `governance_role`. |
| 2 | **Version Drift** | Compares workspace skill versions against the official GitHub catalog. Flags outdated skills with `🆙`. |
| 3 | **Dependency Resolution** | Parses the `dependencies` field and verifies that all declared dependencies exist in the workspace. |
| 4 | **Content Safety Audit** | Scans skill files for known anti-patterns: unquoted Mermaid labels with special characters, hardcoded absolute paths, etc. |
| 5 | **Global / Workspace Sync** | Detects workspace skills that override global skills and flags version mismatches. |
| 6 | **Auto-Fix** *(optional)* | When `--fix` is passed, automatically downloads updated versions of outdated skills from the GitHub repository. |

## 1. Run Verification

- **Action**: Execute the dedicated verification script from the global storage.
- **Command**:

```bash
GLOBAL_SCRIPT="$HOME/.gemini/antigravity/scripts/skill_verify.sh"

if [ -f "$GLOBAL_SCRIPT" ]; then
    bash "$GLOBAL_SCRIPT"
else
    echo "❌ Error: skill_verify.sh not found."
    echo "Expected global: $GLOBAL_SCRIPT"
    exit 1
fi
```

## 2. Run Verification with Auto-Fix

- **Action**: Execute verification AND automatically update outdated workspace skills.
- **Command**:

```bash
GLOBAL_SCRIPT="$HOME/.gemini/antigravity/scripts/skill_verify.sh"

if [ -f "$GLOBAL_SCRIPT" ]; then
    bash "$GLOBAL_SCRIPT" --fix
else
    echo "❌ Error: skill_verify.sh not found."
    echo "Expected global: $GLOBAL_SCRIPT"
    exit 1
fi
```

## Interpreting Results

- `✓` — Check passed.
- `⚠` — Warning (non-blocking, but should be addressed).
- `✗` — Error (structural or dependency failure).

### Exit Codes

| Code | Meaning |
| :--: | :------ |
| `0` | All checks passed (warnings may exist). |
| `1` | One or more errors detected. |

## When to Use

- **Before audits** (`/audit_strategic`, `/audit_codebase`): Ensures the skill ecosystem is consistent before generating governance reports.
- **After `/skill_generate`**: Validates that newly installed skills are complete and their dependencies are satisfied.
- **Periodic maintenance**: Run weekly or before releases to catch version drift.
