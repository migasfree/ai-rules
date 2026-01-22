---
description: Analyze the codebase technology stack and generate specialized role-based skills dynamic and specific to the workspace content.
---

# Generate Dynamic Role-Based Skills with Resources

This workflow analyzes the project's file structure to dynamically create specialized "Skill" configurations, including `SKILL.md` guidelines AND practical resources (templates, checklists) for each role.

1.- Create Rich Skills

- **Action**: Create skills with detailed resources.
- **Command**:

```bash
# --- Configuration ---
SKILLS_DIR=".agent/skills"
mkdir -p "$SKILLS_DIR"

# 1. CONTEXT CAPTURE
CONTEXT_STRUCTURE=$(find . -maxdepth 3 -not -path '*/.*' | head -n 40)

# 2. DISCOVERY PHASE
AI_ROLES=$(ag run --mode Planning --model "Claude Opus 4.5 (thinking)" "Analyze this structure: $CONTEXT_STRUCTURE
List only additional technical roles (Backend, DevOps, etc.) that you detect.
Respond only with the comma-separated list.")

# Se incluyen obligatoriamente Technical Writer y Security Engineer según tus preferencias
ROLES_LIST="Technical Writer, Security Engineer, Business Analyst, Systems Analyst, $AI_ROLES"

echo "🎯 Processing master role list: $ROLES_LIST"

# 3. GENERATION LOOP
IFS=',' read -ra ADDR <<< "$ROLES_LIST"
for role in "${ADDR[@]}"; do
    role=$(echo $role | xargs)
    [[ -z "$role" ]] && continue

    role_dir="${role// /_}"; role_dir=${role_dir,,}
    mkdir -p "$SKILLS_DIR/$role_dir/resources"

    echo "⚙️  Processing Role: $role..."

    # 3.1 SKILL.md GENERATION
    if [[ "$role" == *"Technical Writer"* ]]; then
        SYSTEM_PROMPT="You are a Senior Technical Writer. Structure SKILL.md using Diátaxis."
    elif [[ "$role" == *"Security"* ]]; then
        SYSTEM_PROMPT="You are a Security Engineer. Focus on AppSec and Hardening."
    else
        SYSTEM_PROMPT="You are a Senior Expert in $role. Generate pragmatic guidelines."
    fi

    if [ ! -f "$SKILLS_DIR/$role_dir/SKILL.md" ]; then
        echo "   > Generating SKILL.md..."
        ag run --mode Planning --model "Claude Opus 4.5 (thinking)" --system "$SYSTEM_PROMPT Respond in Markdown." \
                       --user "Generate SKILL.md for: $CONTEXT_STRUCTURE" > "$SKILLS_DIR/$role_dir/SKILL.md"
    fi

    # 3.2 RESOURCE GENERATION (Templates/Tools)
    echo "   > Generating resources (Templates & Scripts)..."

    RESOURCES_SCRIPT=$(ag run --mode Planning --model "Claude Opus 4.5 (thinking)" "You are an expert $role.
    Context: I have a 'SKILL.md' for this role.
    Task: Create 2-3 practical resource files in '$SKILLS_DIR/$role_dir/resources'.

    Guidelines:
    1. If likely meaningful, create a Markdown Template (e.g., 'tutorial_template.md', 'incident_report.md').
    2. If likely meaningful, create a simple checklist or stub script (e.g., 'security_audit_checklist.md').
    3. Content should be high-quality and ready to use.

    Output:
    Provide ONLY a valid BASH script that uses 'cat <<EOF' to create these files.
    Do NOT use markdown code fences in your output. Just raw bash commands.")

    eval "$RESOURCES_SCRIPT"

    # 4. AUDIT (Security Role Check)
    AUDIT_CONTENT=$(ag run --mode Planning --model "Claude Opus 4.5 (thinking)" "Analyze $SKILLS_DIR/$role_dir/SKILL.md. Ensure it has '### 🛡️ Security and Privacy'. If compliant, say COMPLIANT. Else, provide the section.")
    if [[ "$AUDIT_CONTENT" != "COMPLIANT" ]]; then
        echo -e "\n$AUDIT_CONTENT" >> "$SKILLS_DIR/$role_dir/SKILL.md"
    fi


    # 5. ENHANCE the skill
    ag run --mode Planning --model "Claude Opus 4.5 (thinking)" "Enhance all skills"

done

echo "✅ Rich Skills created and optimized by Technical Writer in $SKILLS_DIR"
```
