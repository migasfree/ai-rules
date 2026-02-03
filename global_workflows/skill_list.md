---
description: List all skills showing their enabled/disabled status, merging Global and Workspace scopes.
---

# List Skills Status (Unified View)

This workflow lists all Global Roles/Skills and Local Workspace Skills, giving a complete overview of the agent's capabilities.

## Usage

- `/skill_list`

## 1. List Global & Local Skills

- **Action**: Scan both global and local directories.
- **Command**:

```bash
# --- Configuration ---
GLOBAL_SKILLS_DIR="/home/alberto/.gemini/antigravity/global_skills"
WORKSPACE_SKILLS_DIR=".agent/skills"

echo "📋 Migasfree AI Skill Report"
echo "=================================================="
echo ""

# --- Helper Function ---
list_skills() {
    local dir="$1"
    local label="$2"
    local type="$3" # "role" (subdirs) or "file" (.md files)

    echo "$label"
    echo "-----------------------------------"
    
    if [ ! -d "$dir" ]; then
        echo "   ⚠️  Directory not found: $dir"
        return
    fi

    if [ "$type" == "role" ]; then
        # List subdirectories (Legacy Mega-Roles)
        found=0
        for skill_dir in "$dir"/*/; do
            [ ! -d "$skill_dir" ] && continue
            role=$(basename "$skill_dir")
            echo "   🌎 $role [GLOBAL ROLE]"
            found=1
        done
        [ $found -eq 0 ] && echo "   (No roles found)"
    else
        # List .md files (Technology Plugins)
        found=0
        # Check if dir is empty
        if [ -z "$(ls -A "$dir" 2>/dev/null)" ]; then
             echo "   (No skills found)"
             return
        fi

        files=$(find "$dir" -maxdepth 1 -type f \( -name "*.md" -o -name "*.md.off" \) | sort)
        
        while read -r file; do
            [ -z "$file" ] && continue
            
            name=$(basename "$file")
            clean_name=${name%.md}
            clean_name=${clean_name%.off}
            
            status="✅ ON "
            icon="🔌"
            
            if [[ "$name" == *.off ]]; then
                status="🚫 OFF"
                icon="💤"
            fi

            # Check for overrides
            if [ "$label" == "🏠 Workspace Skills (Local)" ] && [ -f "$GLOBAL_SKILLS_DIR/$name" ]; then
                 note="(Overrides Global)"
            else
                 note=""
            fi

            printf "   %s %-25s [%s] %s\n" "$icon" "$clean_name" "$status" "$note"
            found=1
        done <<< "$files"
        [ $found -eq 0 ] && echo "   (No active skills found)"
    fi
    echo ""
}

# 1. GLOBAL ROLES
list_skills "$GLOBAL_SKILLS_DIR" "🌍 Global Roles (Core)" "role"

# 2. WORKSPACE SKILLS
list_skills "$WORKSPACE_SKILLS_DIR" "🏠 Workspace Skills (Local)" "file"


echo "=================================================="
echo "Use /skill_off <name> or /skill_on <name> to toggle local skills."
```
