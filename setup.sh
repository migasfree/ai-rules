#!/bin/bash
# 🤖 Migasfree AI Standards - Setup Script
# Description: Idempotent installation of global workflows, templates, and core roles.

set -euo pipefail

# Configuration
ANTIGRAVITY_DIR="$HOME/.gemini/antigravity"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting Migasfree AI Standards Installation...${NC}"

# Function to sync directories idempotently
sync_dir() {
    local src="$1"
    local dest="$2"
    local name="$3"

    if [ -d "$src" ]; then
        echo -e "${YELLOW}📦 Syncing $name...${NC}"
        mkdir -p "$dest"
        # Using cp -r as a fallback, but rsync is preferred if available
        if command -v rsync >/dev/null 2>&1; then
            rsync -av --progress "$src/" "$dest/"
        else
            cp -rv "$src/." "$dest/"
        fi
        echo -e "${GREEN}✓ $name synchronized.${NC}"
    else
        echo -e "${YELLOW}⚠️ Warning: $src not found, skipping $name.${NC}"
    fi
}

# 1. Global Workflows
sync_dir "$SOURCE_DIR/global_workflows" "$ANTIGRAVITY_DIR/global_workflows" "Global Workflows"

# 2. Templates
sync_dir "$SOURCE_DIR/templates" "$ANTIGRAVITY_DIR/templates" "Templates"

# 3. Global Skills (Core Roles)
sync_dir "$SOURCE_DIR/global_skills" "$ANTIGRAVITY_DIR/global_skills" "Global Skills"

echo -e "\n${GREEN}✨ Installation Complete!${NC}"
echo -e "You can now use workflows like ${BLUE}/skill_list${NC} or ${BLUE}/audit_report${NC} in any project."
echo -e "Don't forget to install project-specific skills from the ${BLUE}skills/${NC} folder into your project's ${BLUE}.agent/skills/${NC} directory."
