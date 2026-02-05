# Skill Dependency Graph

> **Purpose**: Visual reference for understanding relationships between technology skills.  
> **Last Updated**: 2026-02-05

## Overview

This diagram shows the logical dependencies and relationships between skills in the `ai-rules` ecosystem. An arrow from A → B means "A often benefits from B's context".

```mermaid
graph TD
    subgraph Backend["🐍 Backend Stack"]
        PY[python-expert] --> DJ[django-expert]
        DJ --> PG[postgresql-expert]
        DJ --> GQL[graphql-expert]
        DJ --> CEL[celery-expert]
    end

    subgraph Infra["⚙️ Infrastructure Stack"]
        BASH[bash-expert] --> CICD[cicd-expert]
        CICD --> DOCKER[docker-expert]
        DOCKER --> TF[terraform-expert]
    end

    subgraph Frontend["🎨 Frontend Stack"]
        QV[quasar-vue-expert] --> ELEC[electron-expert]
    end

    subgraph CrossCutting["🛡️ Cross-Cutting Disciplines"]
        SEC[security-expert]
        QA[qa-expert]
        DOCS[docs-expert]
    end

    SEC -.->|Audits| Backend
    SEC -.->|Audits| Infra
    QA -.->|Tests| Backend
    QA -.->|Tests| Frontend
    DOCS -.->|Documents| Backend
    DOCS -.->|Documents| Infra
```

## Dependency Matrix

| Skill | Recommended Companions |
|-------|------------------------|
| `django-expert` | `python-expert`, `postgresql-expert` |
| `graphql-expert` | `django-expert` |
| `celery-expert` | `django-expert`, `python-expert` |
| `docker-expert` | `cicd-expert`, `bash-expert` |
| `terraform-expert` | `docker-expert`, `cicd-expert` |
| `electron-expert` | `quasar-vue-expert` |

## Usage Notes

- **Backend projects**: Start with `python-expert` + `django-expert` + `postgresql-expert`
- **Full-stack projects**: Add `quasar-vue-expert` to the backend stack
- **Desktop apps**: Use `electron-expert` + `quasar-vue-expert`
- **Infrastructure**: Use `bash-expert` + `cicd-expert` + `docker-expert`

---
*Maintained by the Migasfree AI Standards Team.*
