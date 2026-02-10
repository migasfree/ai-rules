#!/bin/bash
# --- Configuration ---
GLOBAL_SKILLS_DIR="$HOME/.gemini/antigravity/global_skills"
WORKSPACE_SKILLS_DIR=".agent/skills"
GITHUB_REPO_URL="https://raw.githubusercontent.com/migasfree/ai-rules/main"
MANIFEST_URL="$GITHUB_REPO_URL/global_workflows/skill_generate.md"
TEMP_MANIFEST="/tmp/ai_rules_manifest.md"

echo "📋 Migasfree AI Skill Report"
echo "=================================================="
echo ""

# --- Pre-fetch Manifest to optimize lookups ---
echo "🔍 Fetching remote catalog for update check..."
curl -s -L --max-time 5 -o "$TEMP_MANIFEST" "$MANIFEST_URL" || touch "$TEMP_MANIFEST"

# --- Helper: Extract version from file ---
get_version() {
    local file="$1"
    grep "^version:" "$file" | head -n 1 | awk '{print $2}' | tr -d '\r'
}

# --- Helper: Map skill to category using manifest ---
get_skill_category() {
    local skill_name="$1"
    # Find category in the Catalog table (column 3 contains skill names, column 4 contains path)
    awk -F'|' -v skill="\`$skill_name\`" '$3 ~ skill {print $4}' "$TEMP_MANIFEST" | head -n 1 | tr -d ' `/'
}

# --- Helper: Get remote version efficiently ---
get_remote_version() {
    local skill_name="$1"
    local cat=$(get_skill_category "$skill_name")
    
    if [ -z "$cat" ]; then
        return # Not in official catalog
    fi

    # Try as directory/SKILL.md (Standard)
    local url="$GITHUB_REPO_URL/skills/$cat/$skill_name/SKILL.md"
    local v=$(curl -s -L --max-time 2 "$url" | grep "^version:" | head -n 1 | awk '{print $2}' | tr -d '\r')
    echo "$v"
}

# --- Helper Function: List ---
list_skills() {
    local dir="$1"
    local label="$2"
    local type="$3"

    echo "$label"
    echo "-----------------------------------"
    
    if [ ! -d "$dir" ]; then
        echo "   ⚠️  Directory not found: $dir"
        echo ""
        return
    fi

    if [ "$type" == "role" ]; then
        found=0
        for skill_dir in "$dir"/*/; do
            [ ! -d "$skill_dir" ] && continue
            role=$(basename "$skill_dir")
            echo "- 🌎 $role"
            found=1
        done
        [ $found -eq 0 ] && echo "   (No roles found)"
    else
        found=0
        if [ -z "$(ls -A "$dir" 2>/dev/null)" ]; then
             echo "   (No skills found)"
             echo ""
             return
        fi

        # Find both new style (SKILL.md) and old style (*.md) skills, excluding manifest/readme
        files=$(find "$dir" -maxdepth 4 \( -name "SKILL.md*" -o -name "*.md" \) ! -name "README.md" ! -name "CHANGELOG.md" | sort -u)
        
        declare -A seen_skills
        
        while read -r file; do
            [ -z "$file" ] && continue
            name=$(basename "$file")
            
            clean_name=${name%.md}
            clean_name=${clean_name%.off}
            
            if [[ "$name" == "SKILL.md" || "$name" == "SKILL.md.off" ]]; then
                clean_name=$(basename "$(dirname "$file")")
            fi

            # Avoid duplicates if a skill has both SKILL.md and a legacy .md file
            if [[ ${seen_skills[$clean_name]} ]]; then continue; fi
            seen_skills[$clean_name]=1

            # Icon only: 🔌 for ON, 💤 for OFF
            icon="🔌"
            [[ "$name" == *.off || "$name" == *.off.md ]] && icon="💤"

            local_v=$(get_version "$file")
            [ -z "$local_v" ] && local_v="?.?.?"
            vers_info="v$local_v"
            
            update_note=""
            override_note=""
            
            if [ "$label" == "🏠 Workspace Skills (Local)" ]; then
                remote_v=$(get_remote_version "$clean_name")
                if [ -n "$remote_v" ] && [ "$remote_v" != "$local_v" ]; then
                    update_note=" 🆙 UPDATE AVAILABLE: v$remote_v"
                fi
                if [ -f "$GLOBAL_SKILLS_DIR/$name" ] || [ -d "$GLOBAL_SKILLS_DIR/$clean_name" ]; then
                    override_note=" [Overrides Global]"
                fi
            fi

            # Minimalist Output: - [Icon] [Name] [Version] [Metadata]
            printf -- "- %s %-25s [%s]%s%s\n" "$icon" "$clean_name" "$vers_info" "$update_note" "$override_note"
            found=1
        done <<< "$files"
        [ $found -eq 0 ] && echo "   (No active skills found)"
    fi
    echo ""
}

# 1. GLOBAL ROLES
list_skills "$GLOBAL_SKILLS_DIR" "🌍 Global Roles (Core)" "role"

# 2. WORKSPACE SKILLS (Local)
list_skills "$WORKSPACE_SKILLS_DIR" "🏠 Workspace Skills (Local)" "file"

echo "=================================================="
echo ""
echo "💡 Use /skill_on <name> or /skill_off <name> to toggle local skills."
echo "🚀 Use /skill_generate to update or install new skills."
rm -f "$TEMP_MANIFEST"
