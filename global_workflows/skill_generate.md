---
description: Analyze the codebase technology stack and generate specialized technology skills dynamic and specific to the workspace content.
version: 1.3.0
last_modified: 2026-02-04
---

# Generate Dynamic Technology Skills

This workflow is designed to be executed by the agent to analyze the current workspace and provide the best set of specialized Knowledge Skills (`.md` files). It prioritizes reusing high-quality existing skills from the global repository over generating new ones.

## 🗃️ Catalog of Existing Skills

*Prioritize copying these from [ai-rules](https://github.com/migasfree/ai-rules) if detected:*

| Category | Skills available in repository |
| :--- | :--- |
| **Languages** | `bash-expert`, `go-expert`, `python-expert` |
| **Frameworks** | `celery-expert`, `django-expert`, `electron-expert`, `graphql-expert`, `postgresql-expert`, `quasar-vue-expert`, `terraform-expert` |
| **Disciplines** | `ai-prompt-expert`, `cicd-expert`, `docs-expert`, `qa-expert`, `security-expert` |

## Instructions

1. **Mandatory Prerequisite Check**:
    * Verify that `.agent/skills/ai-prompt-expert.md` exists in the current workspace.
    * 🛑 **CRITICAL**: If the file is missing, **STOP IMMEDIATELY**.
    * Inform the user that they must install the `ai-prompt-expert` first (e.g., using `cp path/to/ai-rules/skills/disciplines/ai-prompt-expert.md .agent/skills/`) before this workflow can proceed.

2. **Analyze the Workspace**:
    * Use `list_dir` and configuration files (`package.json`, `requirements.txt`, `go.mod`, etc.) to identify the tech stack and versions.

3. **Compare with Global Catalog**:
    * Compare detected technologies with the **Catalog of Existing Skills** above.
    * **Recommendation**: Identify which technologies already have an "Expert" in the `ai-rules` repo.
    * **Generation**: Identify which technologies are MISSING from the repo and require a new 6-Pillar Protocol skill.

4. **Generate New Skills (Only if missing from Catalog)**:
    * For technologies NOT in the catalog, create a new skill in `.agent/skills/` following the **6-Pillar Protocol**:
    * **YAML Frontmatter**: Includes `name`, `version: 1.0.0`, `description`, `last_modified`, and `triggers`.
    * **The 6 Pillars**: Persona, Context, Task, Constraints, Cognitive Process, and Output Format.

5. **Self-Audit**:
    * Use the **AI Prompt Engineer** role (mandatory) to verify that any newly generated skill is robust and follows the standard.

6. **Final Report**:
    * **REUSE**: List the skills the user should copy from `https://github.com/migasfree/ai-rules` (specifying paths: `skills/languages/`, `skills/frameworks/`, or `skills/disciplines/`).
    * **NEW**: Summarize the newly generated skills created in `.agent/skills/`.
    * **INSTRUCTIONS**: Provide the exact `cp` commands for the user to import existing skills if they are not already present.

---
*Maintained by the Migasfree Community.*
