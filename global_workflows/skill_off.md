---
description: Disable one or more skills by renaming .md to .md.off
version: 1.4.0
last_modified: 2026-02-07
---

# Disable Skills

This workflow disables **local workspace skills** located in `.agent/skills/` by adding a `.off` extension to their files. It cannot modify global roles.

## Usage Examples

- `/skill_off python-expert`
- `/skill_off electron-expert`

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
        skill_name=$(basename "$(dirname "$file")")
        echo "- 💤 $skill_name [v${v:-?.?.?}]"
        found=1
    done < <(find "$SKILLS_DIR" -type f -name "SKILL.md")
    
    if [ $found -eq 0 ]; then
        echo "⏭️  All skills are already disabled."
    fi
else
    # Individual handling
    for input in "$@"; do
        # Input implies skill name (e.g. "python-expert")
        # We look for .../python-expert/SKILL.md
        
        found_file=$(find "$SKILLS_DIR" -type f -name "SKILL.md" | grep "/$input/SKILL.md$" | head -n 1)
        
        if [ -n "$found_file" ]; then
            v=$(get_ver "$found_file")
            mv "$found_file" "${found_file}.off"
            echo "- 💤 $input [v${v:-?.?.?}]"
        else
            # Check if it's already off
            already_off=$(find "$SKILLS_DIR" -type f -name "SKILL.md.off" | grep "/$input/SKILL.md.off$" | head -n 1)
            
            if [ -n "$already_off" ]; then
                v=$(get_ver "$already_off")
                echo "- 💤 $input [v${v:-?.?.?}] (Already disabled)"
            else
                echo "❌ Skill not found in workspace: $input"
            fi
        fi
    done
fi

echo ""
echo "✅ Finished. Use /skill_list to verify status."

```
