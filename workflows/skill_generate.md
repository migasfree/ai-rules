---
description: Analyze the codebase technology stack and generate specialized role-based skills dynamic and specific to the workspace content.
---

# Generate Dynamic Role-Based Skills

This workflow is designed to be executed by you (the agent) directly. Your goal is to analyze the current workspace and generate specialized skill definitions (`SKILL.md`) for the roles you identify as necessary.

## Instructions

1. **Analyze the Workspace**:
    * Use `list_dir` to explore the root directory and key subdirectories (e.g., `src`, `docs`, `.agent`).
    * Read configuration files to understand the stack (e.g., `package.json`, `requirements.txt`, `docker-compose.yml`, `README.md`).

2. **Identify Roles**:
    * Based on the technologies and project structure, determine 2-4 key technical roles (e.g., "Svelte Frontend Expert", "Python Backend Developer", "DevOps Engineer").
    * *Self-Correction*: Do not create generic roles. Be specific to the framework/library versions found.

3. **Generate Skills**:
    * For each identified role, create a directory in `.agent/skills/<role_name_snake_case>/`.
    * Create a `SKILL.md` file in that directory.
    * **Content of SKILL.md**:
        * **Role Definition**: "You are an expert in [Technology]..."
        * **Topic Expertise**: Detailed knowledge about the specific version or library.
        * **Coding Standards**: Idioms and patterns preferred for this project.
    * **Important**: Check if a skill already exists before overwriting. If it exists, update it only if you can significantly improve it.

4. **Create Resources (Optional)**:
    * If useful, create a `resources/` folder within the skill directory and add templates or checklists (e.g., `checklist_pr_review.md`).

5. **Report**:
    * Summarize the roles created and the rationale behind them to the user.
