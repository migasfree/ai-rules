---
description: Enable one or more skills by renaming .md.off to .md
version: 1.4.0
last_modified: 2026-02-07
---

# Enable Skills

This workflow enables **local workspace skills** located in `.agent/skills/` by removing the `.off` extension from their files.

## Usage Examples

- `/skill_on python-expert`
- `/skill_on frameworks/electron-expert`

## 1. Enable Skills

- **Action**: Search for disabled skills in `.agent/skills` and enable them.
- **Command**:

```bash
# --- Configuration ---
SKILLS_DIR=".agent/skills"

if [ -z "$*" ]; then
    echo "❌ No skills specified."
    echo "   Usage: /skill_on skill_name | all"
    exit 1
fi

if [ ! -d "$SKILLS_DIR" ]; then
    echo "❌ Local skills directory not found: $SKILLS_DIR"
    exit 1
fi

echo "🔌 Enabling workspace skills..."
echo ""

# Helper to get version
get_ver() { grep "^version:" "$1" | head -n 1 | awk '{print $2}' | tr -d '\r'; }

# Support for "all"
if [[ "$1" == "all" ]]; then
    found=0
    while read -r file; do
        new_name="${file%.off}"
        v=$(get_ver "$file")
        mv "$file" "$new_name"
        echo "- 🔌 $(basename "$new_name" .md) [v${v:-?.?.?}]"
        found=1
    done < <(find "$SKILLS_DIR" -type f -name "*.md.off")
    
    if [ $found -eq 0 ]; then
        echo "⏭️  All skills are already active."
    fi
else
    # Individual handling
    for input in "$@"; do
        clean_path=$(echo "$input" | sed 's/\.md$//' | sed 's/\.off$//')
        basename=$(basename "$clean_path")
        
        found_file=$(find "$SKILLS_DIR" -type f -name "${basename}.md.off" | grep "/${clean_path}\.md\.off$" | head -n 1)
        
        if [ -z "$found_file" ] && [[ "$clean_path" != */* ]]; then
            found_file=$(find "$SKILLS_DIR" -type f -name "${basename}.md.off" | head -n 1)
        fi

        if [ -n "$found_file" ]; then
            v=$(get_ver "$found_file")
            new_name="${found_file%.off}"
            mv "$found_file" "$new_name"
            echo "- 🔌 $(basename "$new_name" .md) [v${v:-?.?.?}]"
        else
            already_on=$(find "$SKILLS_DIR" -type f -name "${basename}.md" | grep "/${clean_path}\.md$" | head -n 1)
            if [ -z "$already_on" ] && [[ "$clean_path" != */* ]]; then
                already_on=$(find "$SKILLS_DIR" -type f -name "${basename}.md" | head -n 1)
            fi

            if [ -n "$already_on" ]; then
                v=$(get_ver "$already_on")
                echo "- 🔌 $(basename "$already_on" .md) [v${v:-?.?.?}] (Already active)"
            else
                echo "❌ Skill not found in workspace: $input"
            fi
        fi
    done
fi

echo ""
echo "✅ Finished. Use /skill_list to verify status."

```
