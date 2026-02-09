---
description: Analyze the codebase technology stack and generate specialized technology skills dynamic and specific to the workspace content.
version: 1.5.0
last_modified: 2026-02-07
---

# Generate Dynamic Technology Skills

This workflow is designed to be executed by the agent to analyze the current workspace and provide the best set of specialized Knowledge Skills (`.md` files). It prioritizes downloading high-quality existing skills from the global repository.

## 🗃️ Skills Catalog & Source

**Base URL**: `https://raw.githubusercontent.com/migasfree/ai-rules/main/skills/`

| Category | Skills available in repository | Path in GitHub |
| :--- | :--- | :--- |
| **Languages** | `bash-expert`, `go-expert`, `python-expert` | `languages/` |
| **Frameworks** | `celery-expert`, `django-expert`, `docker-expert`, `electron-expert`, `graphql-expert`, `migasfree-frontend-expert`, `postgresql-expert`, `terraform-expert` | `frameworks/` |
| **Disciplines** | `ai-prompt-expert`, `cicd-expert`, `docs-expert`, `migasfree-ui-ux-expert`, `output-standard-expert`, `qa-expert`, `security-expert` | `disciplines/` |

## 📊 Skill Dependencies Matrix

Skills often work together. When recommending a skill, **automatically include its dependencies**.

| Skill | Required Dependencies | Optional Companions | Tech Detection Markers |
| ----- | --------------------- | ------------------- | ---------------------- |
| `django-expert` | `python-expert`, `postgresql-expert` | `security-expert`, `celery-expert` | `django`, `manage.py`, `settings.py` |
| `graphql-expert` | `django-expert` | - | `graphene`, `schema.py`, `graphql` |
| `celery-expert` | `python-expert` | `django-expert`, `security-expert` | `celery`, `tasks.py`, `worker` |
| `migasfree-frontend-expert` | `migasfree-ui-ux-expert` | `security-expert` | `quasar.config.js`, `vue`, `composition api` |
| `electron-expert` | `migasfree-frontend-expert` | - | `electron`, `electron-builder` |
| `docker-expert` | - | `cicd-expert`, `bash-expert` | `Dockerfile`, `docker-compose.yml` |
| `terraform-expert` | - | `docker-expert`, `cicd-expert` | `*.tf`, `terraform` |
| `cicd-expert` | - | `docker-expert`, `security-expert` | `.github/workflows`, `.gitlab-ci.yml` |
| `postgresql-expert` | - | `django-expert`, `security-expert` | `psycopg2`, `postgresql`, `pg_` |
| `python-expert` | - | `security-expert`, `qa-expert` | `requirements.txt`, `pyproject.toml`, `*.py` |
| `bash-expert` | - | `cicd-expert` | `*.sh`, `#!/bin/bash` |
| `go-expert` | - | `security-expert` | `go.mod`, `*.go` |

## 🎯 Instructions

### 1. **Automatic Prerequisite Installation**

* Check if the following mandatory skills exist in the local workspace:
  * `.agent/skills/disciplines/ai-prompt-expert/SKILL.md`
  * `.agent/skills/disciplines/output-standard-expert/SKILL.md`
* 🛠️ **ACTION**: If any are missing, **DO NOT STOP**. Instead, download them:

    1. **AI Prompt Engineer**:

       ```bash
       mkdir -p .agent/skills/disciplines/ai-prompt-expert
       curl -s -L -o .agent/skills/disciplines/ai-prompt-expert/SKILL.md https://raw.githubusercontent.com/migasfree/ai-rules/main/skills/disciplines/ai-prompt-expert/SKILL.md
       ```

    2. **Output Standard Expert**:

       ```bash
       mkdir -p .agent/skills/disciplines/output-standard-expert
       curl -s -L -o .agent/skills/disciplines/output-standard-expert/SKILL.md https://raw.githubusercontent.com/migasfree/ai-rules/main/skills/disciplines/output-standard-expert/SKILL.md
       ```

    3. Inform the user: "Missing prerequisites (`ai-prompt-expert`, `output-standard-expert`) have been automatically downloaded from GitHub."

### 2. **Analyze the Workspace**

* Use `list_dir` and configuration files to identify the tech stack (Python, Django, Docker, etc.).

### 3. **Build Recommendation Graph**

* resolve dependencies using the **Skill Dependencies Matrix**.

### 4. **Identify Missing Skills**

* Check which of the recommended skills are NOT yet in `.agent/skills/` (look for `[Category]/[SkillName]/SKILL.md`).

### 5. **Final Report & Interactive Installation**

Present the recommendation and **ask for permission** to install them. Use this format:

```markdown
## 🎯 Skill Installation Recommendations

### Technology Stack Detected
[List detected techs and files]

### Suggested Skills from Catalog 📦
The following skills are recommended for your stack but are currently missing:

- **django-expert** (Frameworks)
- **python-expert** (Languages - Dependency)
- **postgresql-expert** (Frameworks - Dependency)

### 🤖 Action Required
Would you like me to automatically download and install these skills from the GitHub repository into your `.agent/skills/` directory?
```

### 6. **Post-Validation Action**

* If the user says "yes", "install them", or similar:
    1. Create the destination directory: `mkdir -p .agent/skills/[Category]/[SkillName]/`
    2. Use `curl` to download the specific `SKILL.md`:
       `curl -o .agent/skills/[Category]/[SkillName]/SKILL.md .../skills/[Category]/[SkillName]/SKILL.md`
    3. If the skill has resources (like templates), verify if they need to be downloaded too (recursively or specifically).
    4. Confirm installation success to the user.

---
*Maintained by the Migasfree Community.*
