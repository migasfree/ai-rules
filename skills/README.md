# Expert Skills Directory

This directory contains **specialized AI personas** organized by domain to provide precise, context-aware assistance for the Migasfree project.

## 📂 Directory Structure

skills/
├── disciplines/       # Cross-cutting concerns
│   ├── ai-prompt-expert/SKILL.md
│   ├── cicd-expert/SKILL.md
│   ├── docs-expert/SKILL.md
│   ├── migasfree-ui-ux-expert/SKILL.md
│   ├── ui-designer-expert/SKILL.md
│   ├── qa-expert/SKILL.md
│   └── security-expert/SKILL.md
├── frameworks/        # Framework-specific expertise
│   ├── celery-expert/SKILL.md
│   ├── django-expert/SKILL.md
│   ├── docker-expert/SKILL.md
│   ├── electron-expert/SKILL.md
│   ├── graphql-expert/SKILL.md
│   ├── migasfree-frontend-expert/SKILL.md
│   ├── postgresql-expert/SKILL.md
│   └── terraform-expert/SKILL.md
├── languages/         # Language-specific expertise
│   ├── bash-expert/SKILL.md
│   ├── go-expert/SKILL.md
│   └── python-expert/SKILL.md
└── CHANGELOG.md       # Version history

```text

## 🎯 How to Choose Skills

**Install skills based on your project's technology stack, not globally.**

### Backend Development

```bash
mkdir -p .agent/skills/languages/python-expert
cp -r skills/languages/python-expert/. .agent/skills/languages/python-expert/

mkdir -p .agent/skills/frameworks/django-expert
cp -r skills/frameworks/django-expert/. .agent/skills/frameworks/django-expert/

mkdir -p .agent/skills/frameworks/postgresql-expert
cp -r skills/frameworks/postgresql-expert/. .agent/skills/frameworks/postgresql-expert/
```

### Frontend Development (Migasfree Projects)

```bash
mkdir -p .agent/skills/disciplines/migasfree-ui-ux-expert
cp -r skills/disciplines/migasfree-ui-ux-expert/. .agent/skills/disciplines/migasfree-ui-ux-expert/

mkdir -p .agent/skills/frameworks/migasfree-frontend-expert
cp -r skills/frameworks/migasfree-frontend-expert/. .agent/skills/frameworks/migasfree-frontend-expert/
```

### Desktop Applications

```bash
mkdir -p .agent/skills/frameworks/electron-expert
cp -r skills/frameworks/electron-expert/. .agent/skills/frameworks/electron-expert/

mkdir -p .agent/skills/frameworks/migasfree-frontend-expert
cp -r skills/frameworks/migasfree-frontend-expert/. .agent/skills/frameworks/migasfree-frontend-expert/
```

### Infrastructure & DevOps

```bash
mkdir -p .agent/skills/languages/bash-expert
cp -r skills/languages/bash-expert/. .agent/skills/languages/bash-expert/

mkdir -p .agent/skills/disciplines/cicd-expert
cp -r skills/disciplines/cicd-expert/. .agent/skills/disciplines/cicd-expert/

mkdir -p .agent/skills/frameworks/docker-expert
cp -r skills/frameworks/docker-expert/. .agent/skills/frameworks/docker-expert/

mkdir -p .agent/skills/frameworks/terraform-expert
cp -r skills/frameworks/terraform-expert/. .agent/skills/frameworks/terraform-expert/
```

## 🔗 Understanding Dependencies

Skills declare dependencies in their YAML frontmatter:

```yaml
---
name: Django & DRF Expert
dependencies: [python-expert, postgresql-expert]
---
```

When you install a skill, **also install its dependencies** for optimal context.

## 📋 Version Compatibility

All skills follow [Semantic Versioning](https://semver.org/).

- **Current Version**: `1.5.0` (2026-02-09)
- **Changelog**: See [CHANGELOG.md](CHANGELOG.md) for version history

To verify skill versions:

```bash
grep "^version:" skills/*/*/SKILL.md
```

## 🏗️ Skill Architecture

All skills follow the **6-Pillar Protocol**:

1. **Persona & Role Overview**: Who the AI is acting as
2. **Project Context & Resources**: Technical constraints and tools
3. **Main Task & Objectives**: Primary responsibilities
4. **Critical Constraints & Hard Stops**: Security and quality gates
5. **Cognitive Process & Decision Logs**: Mandatory reasoning chain
6. **Output Style & Format Guide**: How to structure responses

## 🛡️ Security-First Approach

The `security-expert` skill is a **universal dependency** for all technical skills. It acts as the CISO authority, enforcing:

- OWASP Top 10 compliance
- Zero Trust architecture
- 42+ critical hard stops across the ecosystem

## 🔄 Updates & Contributions

When updating skills:

1. Update the version number following semver
2. Document changes in `CHANGELOG.md`
3. Update `last_modified` timestamp
4. Test with `/skill_list` to verify activation

---
*Part of the Migasfree AI Standards v1.4.0*
