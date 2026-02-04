---
description: Analyze the codebase technology stack and generate specialized technology skills dynamic and specific to the workspace content.
---

# Generate Dynamic Technology Skills

This workflow is designed to be executed by the agent to analyze the current workspace and generate specialized Knowledge Skills (`.md` files) for the technologies, frameworks, and languages detected. These skills complement the **Core Mega-Roles**.

## Instructions

1. **Analyze the Workspace**:
    * Use `list_dir` to explore the root directory and key subdirectories (e.g., `src`, `lib`, `app`, `core`, `.agent`).
    * Read configuration files to understand the stack (e.g., `package.json`, `requirements.txt`, `go.mod`, `pom.xml`, `docker-compose.yml`, `README.md`).
    * Identify specific versions and key libraries used.

2. **Identify Skills Needed**:
    * Determine 2-4 key technical skills (e.g., "FastAPI Expert", "SvelteKit & Tailwind Expert", "PostgreSQL Architect").
    * **Constraint**: Do not recreate Core roles (Architect, Operations, Designer). Focus ONLY on the technology-specific knowledge.

3. **Generate Skills**:
    * Create each skill as a single Markdown file in `.agent/skills/<tech_name_snake_case>.md`.
    * **Structure of the Skill File**:
        * **YAML Frontmatter**:

            ```yaml
            ---
            name: [Tech Name] Expert (Skill)
            version: 1.0.0
            description: Specialized module for [Technology]. Focus on [Key Areas].
            last_modified: [Current Date in YYYY-MM-DD]
            triggers: [list, of, trigger, keywords]
            ---
            ```

        * **Role Overview**: Define the Persona (e.g., "You are the Senior Architect").
        * **🧠 Cognitive Process (Mandatory)**: A step-by-step reasoning chain the agent MUST perform *before* generating code (e.g., "Check for N+1", "Verify Idempotency").
        * **🤝 Collaboration**: Explicit instructions to cross-reference other experts (e.g., "Consult the PostgreSQL Expert for schema changes").
        * **Technical Deep-Dive**: Best practices, specific version idiomatic code.
        * **🛑 Critical Hard Stops**: Negative constraints (e.g., "NEVER use shell=True", "NEVER commit secrets").
        * **🗣️ Output Style Guide**: Enforce a structured response format (Why -> Code -> Improve).
        * **Project-Specific standards**: Idioms found in the existing codebase.

4. **Important**:
    * If a skill already exists in `.agent/skills/`, update it only if you can add significant value or if the versions/stack have changed.
    * Do not overwrite global skills; always prioritize local `.agent/skills/` for workspace-specific customizations.

5. **Report**:
    * Summarize the skills generated and explain how they interact with the Core Mega-Roles to the user.
