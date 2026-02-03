---
description: Disable one or more skills by renaming .md to .md.off
---

# Disable Skills

This workflow disables specified technology skills by adding a `.off` extension to their files. Note: Core Mega-Roles cannot be disabled.

## Usage Examples

- `/skill_off python-expert`
- `/skill_off frameworks/electron-expert`

## 1. Disable Skills

- **Action**: Search for enabled skills and disable them.
- **Command**:

```bash
# --- Configuration ---
SKILLS_DIR="skills"

if [ -z "$*" ]; then
    echo "❌ No skills specified."
    echo "   Usage: /skill_off skill_name"
    exit 1
fi

echo "🚫 Disabling skills..."
echo ""

for input in "$@"; do
    # Normalize
    target=$(echo "$input" | sed 's/\.md$//' | sed 's/\.off$//')
    
    # Try to find the file
    found_file=$(find "$SKILLS_DIR" -name "${target}.md" | head -n 1)
    
    if [ -n "$found_file" ]; then
        mv "$found_file" "${found_file}.off"
        echo "🚫 Disabled: $target"
    else
        # Check if it's already off
        already_off=$(find "$SKILLS_DIR" -name "${target}.md.off" | head -n 1)
        if [ -n "$already_off" ]; then
            echo "⏭️  Already disabled: $target"
        else
            echo "❌ Skill not found or is a Core role: $target"
        fi
    fi
done

echo ""
echo "✅ Operation completed."
```
