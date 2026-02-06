---
description: Disable one or more skills by renaming .md to .md.off
version: 1.1.0
last_modified: 2026-02-06
---

# Disable Skills

This workflow disables **local workspace skills** located in `.agent/skills/` by adding a `.off` extension to their files. It cannot modify global roles.

## Usage Examples

- `/skill_off python-expert`
- `/skill_off frameworks/electron-expert`

## 1. Disable Skills

- **Action**: Search for enabled skills in `.agent/skills` and disable them.
- **Command**:

```bash
# --- Configuration ---
SKILLS_DIR=".agent/skills"

if [ -z "$*" ]; then
    echo "❌ No skills specified."
    echo "   Usage: /skill_off skill_name | all"
    exit 1
fi

if [ ! -d "$SKILLS_DIR" ]; then
    echo "❌ Local skills directory not found: $SKILLS_DIR"
    exit 1
fi

echo "💤 Disabling workspace skills..."
echo ""

# Helper to get version
get_ver() { grep "^version:" "$1" | head -n 1 | awk '{print $2}' | tr -d '\r'; }

# Support for "all"
if [[ "$1" == "all" ]]; then
    found=0
    while read -r file; do
        v=$(get_ver "$file")
        mv "$file" "${file}.off"
        echo "- 💤 $(basename "$file" .md) [v${v:-?.?.?}]"
        found=1
    done < <(find "$SKILLS_DIR" -type f -name "*.md" ! -name "README.md")
    
    if [ $found -eq 0 ]; then
        echo "⏭️  All skills are already disabled."
    fi
else
    # Individual handling
    for input in "$@"; do
        clean_path=$(echo "$input" | sed 's/\.md$//' | sed 's/\.off$//')
        basename=$(basename "$clean_path")
        
        found_file=$(find "$SKILLS_DIR" -type f -name "${basename}.md" | grep "/${clean_path}\.md$" | head -n 1)
        
        if [ -z "$found_file" ] && [[ "$clean_path" != */* ]]; then
            found_file=$(find "$SKILLS_DIR" -type f -name "${basename}.md" | head -n 1)
        fi

        if [ -n "$found_file" ]; then
            v=$(get_ver "$found_file")
            mv "$found_file" "${found_file}.off"
            echo "- 💤 $(basename "$found_file" .md) [v${v:-?.?.?}]"
        else
            already_off=$(find "$SKILLS_DIR" -type f -name "${basename}.md.off" | grep "/${clean_path}\.md\.off$" | head -n 1)
            if [ -z "$already_off" ] && [[ "$clean_path" != */* ]]; then
                already_off=$(find "$SKILLS_DIR" -type f -name "${basename}.md.off" | head -n 1)
            fi
            
            if [ -n "$already_off" ]; then
                v=$(get_ver "$already_off")
                echo "- 💤 $(basename "$already_off" .md.off) [v${v:-?.?.?}] (Already disabled)"
            else
                echo "❌ Skill not found in workspace: $input"
            fi
        fi
    done
fi

echo ""
echo "✅ Finished. Use /skill_list to verify status."

```
