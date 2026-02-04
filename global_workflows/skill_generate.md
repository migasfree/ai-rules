---
description: Analyze the codebase technology stack and generate specialized technology skills dynamic and specific to the workspace content.
version: 1.1.0
last_modified: 2026-02-04
---

# Generate Dynamic Technology Skills

This workflow is designed to be executed by the agent to analyze the current workspace and generate specialized Knowledge Skills (`.md` files) for the technologies, frameworks, and languages detected. These skills complement the **Core Mega-Roles**.

## Instructions

1. **Analyze the Workspace**:
    * Use `list_dir` to explore the root directory and key subdirectories.
    * Read configuration files (`package.json`, `requirements.txt`, etc.) to identify specific versions and key libraries.

2. **Identify Skills Needed**:
    * Determine 2-4 key technical skills (e.g., "FastAPI Expert", "PostgreSQL Architect").
    * **Constraint**: Do not recreate Global Core roles. Focus ONLY on the technology-specific knowledge.

3. **Generate Skills (The 6-Pillar Protocol)**:
    * Create each skill in `.agent/skills/`. All skills MUST follow this mandatory structure:
    * **YAML Frontmatter**:

        ```yaml
        ---
        name: [Tech Name] Expert (Skill)
        version: 1.0.0
        description: Specialized module for [Technology].
        last_modified: [YYYY-MM-DD]
        triggers: [list, of, triggers]
        ---
        ```

    * **Pillar 1: Persona & Role Overview**: Define the Senior level persona and mission.
    * **Pillar 2: Project Context & Resources**: Specify the tech stack versions and standards.
    * **Pillar 3: Main Task & Objectives**: Clear list of deliverables and engineering goals.
    * **Pillar 4: Critical Constraints & Hard Stops**: 🛑 Negative constraints and security rules.
    * **Pillar 5: Cognitive Process & Decision Logs (Mandatory)**: The step-by-step reasoning chain (CoT) to execute before any action.
    * **Pillar 6: Output Style & Format Guide**: Mandatory response structure (Analysis -> Code -> Verification).

4. **Self-Audit**:
    * After generating a skill, use the **AI Prompt Engineer** role to verify that all 6 pillars are robust and unambiguous.

5. **Report**:
    * Summarize the skills generated and explain how they interact with the Global Core Mega-Roles.

---
*Maintained by the Migasfree Community.*
