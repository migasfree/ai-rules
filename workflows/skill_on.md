---
description: Enable one or more skills by renaming .md.off to .md
---

# Enable Skills

This workflow enables specified technology skills by removing the `.off` extension from their files.

## Usage Examples

- `/skill_on python-expert`
- `/skill_on frameworks/electron-expert`

## 1. Enable Skills

- **Action**: Search for disabled skills and enable them.
- **Command**:

```bash
# --- Configuration ---
SKILLS_DIR="skills"

if [ -z "$*" ]; then
    echo "❌ No skills specified."
    echo "   Usage: /skill_on skill_name"
    exit 1
fi

echo "🔧 Enabling skills..."
echo ""

for input in "$@"; do
    # Normalize: remove .md or .off if user included them
    target=$(echo "$input" | sed 's/\.md$//' | sed 's/\.off$//')
    
    # Try to find the file exactly or recursively
    found_file=$(find "$SKILLS_DIR" -name "${target}.md.off" | head -n 1)
    
    if [ -n "$found_file" ]; then
        new_name="${found_file%.off}"
        mv "$found_file" "$new_name"
        echo "✅ Enabled: $target"
    else
        # Check if it's already on
        already_on=$(find "$SKILLS_DIR" -name "${target}.md" | head -n 1)
        if [ -n "$already_on" ]; then
            echo "⏭️  Already active: $target"
        else
            echo "❌ Skill not found: $target"
        fi
    fi
done

echo ""
echo "✅ Operation completed."
```
