#!/bin/bash
# 🤖 Migasfree AI Standards - Setup Script
# Description: Idempotent installation and verification of global AI standards.
# Version: 1.1.0

set -euo pipefail

# Configuration
ANTIGRAVITY_DIR="$HOME/.gemini/antigravity"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERIFY_MODE=false

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -v|--verify)
            VERIFY_MODE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

if [ "$VERIFY_MODE" = true ]; then
    echo -e "${BLUE}🔍 Verifying Migasfree AI Standards Installation...${NC}\n"
else
    echo -e "${BLUE}🚀 Starting Migasfree AI Standards Installation...${NC}\n"
fi

# Function to check versions and metadata
check_metadata() {
    local file="$1"
    if [ -f "$file" ]; then
        local version=$(grep "version:" "$file" | head -n1 | cut -d':' -f2 | tr -d ' "')
        echo "$version"
    else
        echo "MISSING"
    fi
}

# Function to sync or verify directories
process_dir() {
    local src="$1"
    local dest="$2"
    local name="$3"

    if [ ! -d "$src" ]; then
        echo -e "${RED}❌ Error: Source $src not found.${NC}"
        return 1
    fi

    if [ "$VERIFY_MODE" = true ]; then
        echo -e "${YELLOW}📋 Checking $name...${NC}"
        if [ ! -d "$dest" ]; then
            echo -e "  ${RED}✗ Directory missing: $dest${NC}"
            return 0
        fi

        # Check files inside
        find "$src" -maxdepth 2 -name "*.md" | while read -r src_file; do
            local rel_path="${src_file#$src/}"
            local dest_file="$dest/$rel_path"
            
            if [ -f "$dest_file" ]; then
                local src_ver=$(check_metadata "$src_file")
                local dest_ver=$(check_metadata "$dest_file")
                
                if [ "$src_ver" != "MISSING" ] && [ "$dest_ver" != "MISSING" ]; then
                    if [ "$src_ver" == "$dest_ver" ]; then
                        echo -e "  ${GREEN}✓${NC} $rel_path (v$dest_ver)"
                    else
                        echo -e "  ${YELLOW}!${NC} $rel_path (${RED}Outdated${NC}: Local v$dest_ver vs Repo v$src_ver)"
                    fi
                else
                    echo -e "  ${GREEN}✓${NC} $rel_path (Installed)"
                fi
            else
                echo -e "  ${RED}✗${NC} $rel_path (Missing)"
            fi
        done
    else
        echo -e "${YELLOW}📦 Syncing $name...${NC}"
        mkdir -p "$dest"
        if command -v rsync >/dev/null 2>&1; then
            rsync -av --quiet "$src/" "$dest/"
        else
            cp -rv "$src/." "$dest/" > /dev/null
        fi
        echo -e "${GREEN}✓ $name synchronized.${NC}"
    fi
}

# 1. Global Workflows
process_dir "$SOURCE_DIR/global_workflows" "$ANTIGRAVITY_DIR/global_workflows" "Global Workflows"

# 2. Templates
process_dir "$SOURCE_DIR/templates" "$ANTIGRAVITY_DIR/templates" "Templates"

# 3. Global Skills (Core Roles)
process_dir "$SOURCE_DIR/global_skills" "$ANTIGRAVITY_DIR/global_skills" "Global Skills"

if [ "$VERIFY_MODE" = false ]; then
    echo -e "\n${GREEN}✨ Installation Complete!${NC}"
    echo -e "Verify your installation anytime with: ${BLUE}./setup.sh --verify${NC}"
else
    echo -e "\n${GREEN}🔍 Verification finished.${NC}"
fi
