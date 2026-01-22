---
description: Create a Role-Based Audit Report summarizing findings and recommendations for each skill role.
---

# Generate Role-Based Audit Report

This workflow performs an automated audit of the codebase using the personas and guidelines defined in your global skills, formatting the output into a premium, professional report.

## 1. Automated Audit Execution

- **Action**: For each active global skill, analyze the codebase and generate findings following the premium template.
- **Command**:

```bash
# --- Configuration ---
SKILLS_DIR="$HOME/.gemini/antigravity/global_skills"
REPORT_FILE="role_audit_report.md"
PROJECT_NAME=$(basename "$(pwd)")
CURRENT_DATE=$(date +"%Y-%m-%d")
TEMPLATE_DIR="templates/audit_report"
AGENT_TEMPLATE_DIR=".agent/templates/audit_report"
GLOBAL_TEMPLATE_DIR="$HOME/.gemini/antigravity/templates/audit_report"

if [ -d "$SKILLS_DIR" ]; then
    # Skills dir exists
    :
else
    echo "❌ Global skills directory not found at $SKILLS_DIR"
    exit 1
fi

if [ -d "$TEMPLATE_DIR" ]; then
    echo "ℹ️  Using local templates from ./$TEMPLATE_DIR"
elif [ -d "$AGENT_TEMPLATE_DIR" ]; then
    echo "ℹ️  Using agent templates from ./$AGENT_TEMPLATE_DIR"
    TEMPLATE_DIR="$AGENT_TEMPLATE_DIR"
elif [ -d "$GLOBAL_TEMPLATE_DIR" ]; then
    echo "ℹ️  Using global templates from $GLOBAL_TEMPLATE_DIR"
    TEMPLATE_DIR="$GLOBAL_TEMPLATE_DIR"
else
    echo "❌ Template directory not found (checked ./$TEMPLATE_DIR, ./$AGENT_TEMPLATE_DIR, and $GLOBAL_TEMPLATE_DIR)"
    exit 1
fi

echo "🔍 Starting Premium Automated Audit for $PROJECT_NAME..."

# Export variables for envsubst
export PROJECT_NAME
export CURRENT_DATE
export CONTEXT_STRUCTURE

# 1. INITIALIZE REPORT HEADER
cat <<EOF > "$REPORT_FILE"
# $PROJECT_NAME Role-Based Audit Report

> **Date**: $CURRENT_DATE  
> **Repository**: $PROJECT_NAME  
> **Auditor**: Antigravity AI

---

EOF

# 2. CAPTURE CONTEXT
CONTEXT_STRUCTURE=$(find . -maxdepth 3 -not -path '*/.*' | head -n 60)
FILE_LIST=$(find . -maxdepth 2 -not -path '*/.*' -type f | head -n 20)
export CONTEXT_STRUCTURE

# 3. GENERATE EXECUTIVE SUMMARY
echo "📝 Generating Executive Summary..."
PROMPT=$(envsubst < "$TEMPLATE_DIR/executive_summary.md")
EXEC_SUMMARY=$(ag run --mode Planning --model "Claude Opus 4.5" "$PROMPT")

echo "$EXEC_SUMMARY" >> "$REPORT_FILE"
echo -e "\n---\n" >> "$REPORT_FILE"

# 4. LOOP THROUGH ROLES
ROLE_INDEX=1
export ROLE_INDEX
for skill_path in "$SKILLS_DIR"/*; do
    if [ -d "$skill_path" ]; then
        if [ ! -f "$skill_path/SKILL.md" ]; then
            continue
        fi

        role_name=$(basename "$skill_path")
        role_label=$(echo "$role_name" | sed 's/_/ /g' | sed -e 's/\b\(.\)/\u\1/g')
        guidelines=$(cat "$skill_path/SKILL.md")
        
        export role_label
        export guidelines
        export ROLE_INDEX

        echo "⚙️  Auditing Role: $role_label..."

        PROMPT=$(envsubst < "$TEMPLATE_DIR/role_audit.md")
        ROLE_FINDINGS=$(ag run --mode Planning --model "Claude Opus 4.5" "$PROMPT")

        {
            echo "$ROLE_FINDINGS"
            echo ""
            echo "---"
            echo ""
        } >> "$REPORT_FILE"
        
        ((ROLE_INDEX++))
    fi
done

# 5. CONSOLIDATED RECOMMENDATIONS
echo "📊 Consolidating Recommendations..."
REPORT_CONTENT=$(cat "$REPORT_FILE")
export REPORT_CONTENT
PROMPT=$(envsubst < "$TEMPLATE_DIR/consolidated.md")
CONSOLIDATED=$(ag run --mode Planning --model "Claude Opus 4.5" "$PROMPT")

echo "$CONSOLIDATED" >> "$REPORT_FILE"

# 6. METRICS & APPENDIX
echo "📈 Finalizing Metrics and Appendix..."
PROMPT=$(envsubst < "$TEMPLATE_DIR/metrics.md")
METRICS_APPENDIX=$(ag run --mode Planning --model "Claude Opus 4.5" "$PROMPT")

echo -e "\n---\n" >> "$REPORT_FILE"
echo "$METRICS_APPENDIX" >> "$REPORT_FILE"

echo "✅ Premium Audit Report generated: $REPORT_FILE"
```

## 2. Notify User

- **Action**: Inform completion.
- **Message**: "Automated Premium Audit Report generated using the high-fidelity professional template."
