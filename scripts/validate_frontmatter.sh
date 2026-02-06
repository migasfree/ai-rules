#!/bin/bash
# validate_frontmatter.sh - Validates YAML frontmatter in skill files
# Required fields: name, version, triggers (for skills) or description (for workflows)

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
CHECKED=0

validate_skill() {
    local file="$1"
    local has_name has_version has_triggers
    
    # Extract frontmatter (between first two ---)
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$file" | head -20)
    
    has_name=$(echo "$frontmatter" | grep -c "^name:" || true)
    has_version=$(echo "$frontmatter" | grep -c "^version:" || true)
    has_triggers=$(echo "$frontmatter" | grep -c "^triggers:" || true)
    
    if [[ $has_name -eq 0 || $has_version -eq 0 || $has_triggers -eq 0 ]]; then
        echo -e "${RED}✗${NC} $file"
        [[ $has_name -eq 0 ]] && echo "    Missing: name"
        [[ $has_version -eq 0 ]] && echo "    Missing: version"
        [[ $has_triggers -eq 0 ]] && echo "    Missing: triggers"
        ERRORS=$((ERRORS + 1))
    else
        echo -e "${GREEN}✓${NC} $file"
    fi
    CHECKED=$((CHECKED + 1))
}

validate_workflow() {
    local file="$1"
    local has_description
    
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$file" | head -10)
    has_description=$(echo "$frontmatter" | grep -c "^description:" || true)
    
    if [[ $has_description -eq 0 ]]; then
        echo -e "${YELLOW}⚠${NC} $file (missing description)"
        ERRORS=$((ERRORS + 1))
    else
        echo -e "${GREEN}✓${NC} $file"
    fi
    CHECKED=$((CHECKED + 1))
}

echo "🔍 Validating YAML Frontmatter..."
echo ""

# Validate skills using find (exclude CHANGELOG.md and README.md)
echo "📦 Checking Skills..."
while IFS= read -r file; do
    validate_skill "$file"
done < <(find skills -name "*.md" -type f ! -name "CHANGELOG.md" ! -name "README.md" 2>/dev/null || true)

echo ""
echo "📋 Checking Workflows..."
while IFS= read -r file; do
    validate_workflow "$file"
done < <(find global_workflows -name "*.md" -type f 2>/dev/null || true)

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checked: $CHECKED files"

if [[ $ERRORS -gt 0 ]]; then
    echo -e "${RED}Errors: $ERRORS${NC}"
    exit 1
else
    echo -e "${GREEN}All frontmatter valid!${NC}"
    exit 0
fi
