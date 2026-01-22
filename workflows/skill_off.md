---
description: Disable one or more skills by renaming SKILL.md to SKILL.md.off
---

# Disable Skills

This workflow disables specified skill roles by renaming their `SKILL.md` file to `SKILL.md.off`.

## Usage Examples

- `/skill_off technical_writer`
- `/skill_off security_engineer, devops`
- `/skill_off "Technical Writer" "Security Engineer"`

## 1. Disable Skills

- **Action**: Parse input and disable each specified skill.
- **Command**:

```bash
# --- Configuration ---
SKILLS_DIR="$HOME/.gemini/antigravity/global_skills"

# Create skills directory if it doesn't exist
mkdir -p "$SKILLS_DIR"

# Parse input: replace commas with spaces, normalize
INPUT_ROLES="$*"
INPUT_ROLES=$(echo "$INPUT_ROLES" | tr ',' ' ' | tr -s ' ')

if [ -z "$INPUT_ROLES" ]; then
    echo "❌ No roles specified."
    echo "   Usage: /skill_off role1 role2 ..."
    echo ""
    echo "📋 Available skills:"
    for skill_dir in "$SKILLS_DIR"/*/; do
        [ -d "$skill_dir" ] && echo "   - $(basename "$skill_dir")"
    done
    exit 1
fi

echo "🔧 Disabling skills..."
echo ""

# Process each role
for role in $INPUT_ROLES; do
    # Normalize: lowercase, spaces to underscores
    role_dir=$(echo "$role" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
    
    skill_file="$SKILLS_DIR/$role_dir/SKILL.md"
    disabled_file="$SKILLS_DIR/$role_dir/SKILL.md.off"
    
    if [ -f "$skill_file" ]; then
        mv "$skill_file" "$disabled_file"
        echo "🚫 $role_dir: DISABLED"
    elif [ -f "$disabled_file" ]; then
        echo "⏭️  $role_dir: Already disabled"
    elif [ -d "$SKILLS_DIR/$role_dir" ]; then
        echo "⚠️  $role_dir: No SKILL.md found"
    else
        echo "❌ $role_dir: Skill not found"
    fi
done

echo ""
echo "✅ Operation completed."
```
