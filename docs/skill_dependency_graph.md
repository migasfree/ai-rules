# Skill Dependency Graph

> **Purpose**: Visual reference for understanding relationships between technology skills.  
> **Last Updated**: 2026-02-07 | **Ecosystem Version**: v1.4.0

## Overview

This diagram shows the logical dependencies and relationships between skills in the `ai-rules` ecosystem. An arrow from A → B means "A depends on B's context" or "A frequently collaborates with B".

```mermaid
graph TB
    subgraph Orchestration["📐 Orchestration"]
        PROMPT[ai-prompt-expert]
    end
    
    subgraph CrossCutting["🛡️ Cross-Cutting Disciplines"]
        SEC[security-expert]
        QA[qa-expert]
        DOCS[docs-expert]
        CICD[cicd-expert]
    end
    
    subgraph Backend["🐍 Backend Stack"]
        PY[python-expert]
        DJANGO[django-expert]
        PG[postgresql-expert]
        GQL[graphql-expert]
        CEL[celery-expert]
    end
    
    subgraph Frontend["🎨 Frontend Stack"]
        UX[migasfree-ui-ux-expert]
        FE[migasfree-frontend-expert]
        ELEC[electron-expert]
    end
    
    subgraph Infra["⚙️ Infrastructure Stack"]
        BASH[bash-expert]
        GO[go-expert]
        DOCKER[docker-expert]
        TF[terraform-expert]
    end
    
    %% Core Orchestration
    PROMPT --> SEC
    PROMPT --> DOCS
    
    %% Security as Universal Dependency
    SEC -.->|Audits| PY
    SEC -.->|Audits| DJANGO
    SEC -.->|Audits| FE
    SEC -.->|Audits| CICD
    SEC -.->|Audits| GO
    
    %% Backend Dependencies
    PY --> DJANGO
    PY --> CEL
    DJANGO --> PG
    DJANGO --> GQL
    
    %% Frontend Dependencies
    UX <-->|Styling Authority| FE
    FE --> ELEC
    
    %% Infrastructure Dependencies
    CICD --> DOCKER
    CICD --> TF
    DOCKER --> TF
    
    %% Polyglot Relationship
    PY <-.->|Polyglot Check| GO
    BASH -.->|DevOps| CICD
    
    %% QA Coverage
    QA -.->|Tests| Backend
    QA -.->|Tests| Frontend
    
    %% Documentation
    DOCS -.->|Documents| Backend
    DOCS -.->|Documents| Infra
    
    style PROMPT fill:#9b59b6,color:#fff
    style SEC fill:#e74c3c,color:#fff
    style UX fill:#3498db,color:#fff
```

## Dependency Matrix

| Skill | Required Dependencies | Optional Companions |
| ----- | --------------------- | ------------------- |
| `django-expert` | `python-expert`, `postgresql-expert` | `security-expert`, `celery-expert` |
| `graphql-expert` | `django-expert` | - |
| `celery-expert` | `python-expert` | `django-expert`, `security-expert` |
| `migasfree-frontend-expert` | `migasfree-ui-ux-expert` | `security-expert` |
| `electron-expert` | `migasfree-frontend-expert` | - |
| `docker-expert` | - | `cicd-expert`, `bash-expert` |
| `terraform-expert` | - | `docker-expert`, `cicd-expert` |
| `cicd-expert` | - | `docker-expert`, `security-expert` |

## Usage Recommendations

### Backend Projects

```bash
# Minimal
cp -r skills/languages/python-expert/. .agent/skills/languages/python-expert/
cp -r skills/frameworks/django-expert/. .agent/skills/frameworks/django-expert/

# Full Stack
cp -r skills/frameworks/postgresql-expert/. .agent/skills/frameworks/postgresql-expert/
cp -r skills/frameworks/celery-expert/. .agent/skills/frameworks/celery-expert/
cp -r skills/disciplines/security-expert/. .agent/skills/disciplines/security-expert/
```

### Frontend Projects (Migasfree)

```bash
cp -r skills/disciplines/migasfree-ui-ux-expert/. .agent/skills/disciplines/migasfree-ui-ux-expert/
cp -r skills/frameworks/migasfree-frontend-expert/. .agent/skills/frameworks/migasfree-frontend-expert/
```

### Desktop Applications

```bash
cp -r skills/disciplines/migasfree-ui-ux-expert/. .agent/skills/disciplines/migasfree-ui-ux-expert/
cp -r skills/frameworks/migasfree-frontend-expert/. .agent/skills/frameworks/migasfree-frontend-expert/
cp -r skills/frameworks/electron-expert/. .agent/skills/frameworks/electron-expert/
```

### Infrastructure & DevOps

```bash
cp -r skills/languages/bash-expert/. .agent/skills/languages/bash-expert/
cp -r skills/disciplines/cicd-expert/. .agent/skills/disciplines/cicd-expert/
cp -r skills/frameworks/docker-expert/. .agent/skills/frameworks/docker-expert/
```

### Polyglot Projects (Python + Go)

```bash
cp -r skills/languages/python-expert/. .agent/skills/languages/python-expert/
cp -r skills/languages/go-expert/. .agent/skills/languages/go-expert/
cp -r skills/disciplines/security-expert/. .agent/skills/disciplines/security-expert/
```

## Version Notes (v1.3.0)

### Breaking Changes

- **Removed**: `quasar-vue-expert` (merged into `migasfree-frontend-expert`)
- **Standardized**: All skills now follow 6-Pillar Protocol
- **Dependencies**: Explicit YAML frontmatter declarations required

### New Features

- Polyglot awareness checks between Python and Go
- Security expert as universal dependency
- Cross-skill orchestration via `ai-prompt-expert`

---
*Maintained by the Migasfree AI Standards Team.*
