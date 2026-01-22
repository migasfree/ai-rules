---
description: List all skills showing their enabled/disabled status
---

# List Skills Status

This workflow lists all available skill roles and shows whether they are enabled or disabled.

## Usage

- `/skill_list`

## 1. List Skills

- **Action**: Scan skills directory and display status of each skill.
- **Command**:

```bash
# --- Configuration ---
SKILLS_DIR="$HOME/.gemini/antigravity/global_skills"

# Create skills directory if it doesn't exist
mkdir -p "$SKILLS_DIR"

echo "📋 Global Skills Status"
echo "📂 Location: $SKILLS_DIR"
echo "================================"
echo ""

ENABLED_COUNT=0
DISABLED_COUNT=0
ENABLED_LIST=""
DISABLED_LIST=""

for skill_dir in "$SKILLS_DIR"/*/; do
    [ ! -d "$skill_dir" ] && continue
    
    role=$(basename "$skill_dir")
    
    if [ -f "$skill_dir/SKILL.md" ]; then
        ENABLED_LIST="$ENABLED_LIST$role\n"
        ((ENABLED_COUNT++))
    elif [ -f "$skill_dir/SKILL.md.off" ]; then
        DISABLED_LIST="$DISABLED_LIST$role\n"
        ((DISABLED_COUNT++))
    fi
done

# Print enabled skills (sorted)
echo -e "$ENABLED_LIST" | sort | while read -r role; do
    [ -n "$role" ] && echo "✅ $role [ON]"
done

# Print disabled skills (sorted)
echo -e "$DISABLED_LIST" | sort | while read -r role; do
    [ -n "$role" ] && echo "🚫 $role [OFF]"
done

echo ""
echo "─────────────────"
echo "Total: $((ENABLED_COUNT + DISABLED_COUNT)) skills"
echo "  ✅ Enabled:  $ENABLED_COUNT"
echo "  🚫 Disabled: $DISABLED_COUNT"
```
