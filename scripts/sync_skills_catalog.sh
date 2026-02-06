#!/usr/bin/env bash
#
# sync_skills_catalog.sh
# Automatically synchronizes the skills catalog in skill_generate.md workflow
# with the actual skills available in the repository.
#
# Usage:
#   ./scripts/sync_skills_catalog.sh [--dry-run]
#
# Options:
#   --dry-run    Show what would be updated without making changes
#

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="${REPO_ROOT}/skills"
WORKFLOW_FILE="${REPO_ROOT}/global_workflows/skill_generate.md"
DRY_RUN=false

# Parse arguments
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo -e "${YELLOW}🔍 Running in DRY-RUN mode (no changes will be made)${NC}\n"
fi

# Function to scan a skills category directory
scan_skills_category() {
    local category_path="$1"
    local skills=()
    
    if [[ ! -d "$category_path" ]]; then
        echo ""
        return
    fi
    
    # Find all .md files and SKILL.md directories
    while IFS= read -r -d '' file; do
        if [[ -f "$file" ]]; then
            # Regular .md file
            basename "${file%.md}"
        elif [[ -d "$file" && -f "$file/SKILL.md" ]]; then
            # Directory with SKILL.md
            basename "$file"
        fi
    done < <(find "$category_path" -maxdepth 1 \( -name "*.md" -o -type d \) -print0 | sort -z) | \
        grep -v "^README$" | \
        paste -sd ',' - | \
        sed 's/, *$//;s/,/, /g;s/[^, ][^,]*/`&`/g'
}

echo -e "${BLUE}📊 Scanning skills directory structure...${NC}"

# Scan each category
LANGUAGES=$(scan_skills_category "${SKILLS_DIR}/languages")
FRAMEWORKS=$(scan_skills_category "${SKILLS_DIR}/frameworks")
DISCIPLINES=$(scan_skills_category "${SKILLS_DIR}/disciplines")

echo -e "${GREEN}✓${NC} Languages:   ${LANGUAGES:-none}"
echo -e "${GREEN}✓${NC} Frameworks:  ${FRAMEWORKS:-none}"
echo -e "${GREEN}✓${NC} Disciplines: ${DISCIPLINES:-none}"
echo ""

# Generate the new catalog table
NEW_CATALOG="| Category | Skills available in repository |
| :--- | :--- |
| **Languages** | ${LANGUAGES:-none} |
| **Frameworks** | ${FRAMEWORKS:-none} |
| **Disciplines** | ${DISCIPLINES:-none} |"

# Check if workflow file exists
if [[ ! -f "$WORKFLOW_FILE" ]]; then
    echo -e "${RED}❌ Error: Workflow file not found at ${WORKFLOW_FILE}${NC}"
    exit 1
fi

# Read current workflow file
CURRENT_CONTENT=$(cat "$WORKFLOW_FILE")

# Find the catalog table section (between "| Category" and the next blank line after the table)
if ! echo "$CURRENT_CONTENT" | grep -q "^| Category |"; then
    echo -e "${RED}❌ Error: Could not find the catalog table in ${WORKFLOW_FILE}${NC}"
    echo -e "${YELLOW}💡 Expected to find a markdown table starting with '| Category |'${NC}"
    exit 1
fi

# Create the updated content
# Strategy: Replace from "| Category" to the end of the table (next line that doesn't start with |)
UPDATED_CONTENT=$(echo "$CURRENT_CONTENT" | awk -v new_table="$NEW_CATALOG" '
    BEGIN { in_table = 0; replaced = 0 }
    /^\| Category \|/ {
        if (!replaced) {
            print new_table
            replaced = 1
            in_table = 1
        }
        next
    }
    in_table && /^\|/ {
        next
    }
    in_table && !/^\|/ {
        in_table = 0
    }
    { print }
')

# Compare and update
if [[ "$CURRENT_CONTENT" == "$UPDATED_CONTENT" ]]; then
    echo -e "${GREEN}✅ Catalog is already up to date!${NC}"
    exit 0
fi

if [[ "$DRY_RUN" == true ]]; then
    echo -e "${YELLOW}📝 Changes that would be made:${NC}\n"
    echo "--- Current catalog ---"
    echo "$CURRENT_CONTENT" | grep -A 3 "^| Category |" || true
    echo ""
    echo "--- New catalog ---"
    echo "$NEW_CATALOG"
    echo ""
    echo -e "${YELLOW}⚠️  Run without --dry-run to apply changes${NC}"
    exit 0
fi

# Apply changes
echo "$UPDATED_CONTENT" > "$WORKFLOW_FILE"

echo -e "${GREEN}✅ Successfully updated ${WORKFLOW_FILE}${NC}"
echo -e "${BLUE}📋 New catalog:${NC}\n"
echo "$NEW_CATALOG"
echo ""
echo -e "${GREEN}💡 Don't forget to commit the changes!${NC}"
