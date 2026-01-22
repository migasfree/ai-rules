---
description: Enable one or more skills by renaming SKILL.md.off to SKILL.md
---

# Enable Skills

This workflow enables specified skill roles by renaming their `SKILL.md.off` file back to `SKILL.md`.

## Usage Examples

- `/skill_on technical_writer`
- `/skill_on security_engineer, devops`
- `/skill_on "Technical Writer" "Security Engineer"`

## 1. Enable Skills

- **Action**: Parse input and enable each specified skill.
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
    echo "   Usage: /skill_on role1 role2 ..."
    echo ""
    echo "📋 Disabled skills:"
    for skill_dir in "$SKILLS_DIR"/*/; do
        if [ -f "$skill_dir/SKILL.md.off" ]; then
            echo "   - $(basename "$skill_dir") [DISABLED]"
        fi
    done
    exit 1
fi

echo "🔧 Enabling skills..."
echo ""

# Process each role
for role in $INPUT_ROLES; do
    # Normalize: lowercase, spaces to underscores
    role_dir=$(echo "$role" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
    
    skill_file="$SKILLS_DIR/$role_dir/SKILL.md"
    disabled_file="$SKILLS_DIR/$role_dir/SKILL.md.off"
    
    if [ -f "$disabled_file" ]; then
        mv "$disabled_file" "$skill_file"
        echo "✅ $role_dir: ENABLED"
    elif [ -f "$skill_file" ]; then
        echo "⏭️  $role_dir: Already enabled"
    elif [ -d "$SKILLS_DIR/$role_dir" ]; then
        echo "⚠️  $role_dir: No SKILL.md.off found"
    else
        echo "❌ $role_dir: Skill not found"
    fi
done

echo ""
echo "✅ Operation completed."
```
