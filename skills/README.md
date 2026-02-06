# Expert Skills Directory

This directory contains **specialized AI personas** organized by domain to provide precise, context-aware assistance for the Migasfree project.

## 📂 Directory Structure

```text
skills/
├── disciplines/       # Cross-cutting concerns (6 skills)
│   ├── ai-prompt-expert.md
│   ├── cicd-expert.md
│   ├── docs-expert.md
│   ├── migasfree-ui-ux-expert.md
│   ├── qa-expert.md
│   └── security-expert.md
├── frameworks/        # Framework-specific expertise (9 skills)
│   ├── celery-expert.md
│   ├── django-expert/
│   │   └── SKILL.md
│   ├── docker-expert.md
│   ├── electron-expert.md
│   ├── graphql-expert.md
│   ├── migasfree-frontend-expert.md
│   ├── postgresql-expert.md
│   └── terraform-expert.md
├── languages/         # Language-specific expertise (3 skills)
│   ├── bash-expert.md
│   ├── go-expert.md
│   └── python-expert.md
└── CHANGELOG.md       # Version history
```

## 🎯 How to Choose Skills

**Install skills based on your project's technology stack, not globally.**

### Backend Development

```bash
cp skills/languages/python-expert.md .agent/skills/
cp -r skills/frameworks/django-expert .agent/skills/
cp skills/frameworks/postgresql-expert.md .agent/skills/
```

### Frontend Development (Migasfree Projects)

```bash
cp skills/disciplines/migasfree-ui-ux-expert.md .agent/skills/
cp skills/frameworks/migasfree-frontend-expert.md .agent/skills/
```

### Desktop Applications

```bash
cp skills/frameworks/electron-expert.md .agent/skills/
cp skills/frameworks/migasfree-frontend-expert.md .agent/skills/
```

### Infrastructure & DevOps

```bash
cp skills/languages/bash-expert.md .agent/skills/
cp skills/disciplines/cicd-expert.md .agent/skills/
cp skills/frameworks/docker-expert.md .agent/skills/
cp skills/frameworks/terraform-expert.md .agent/skills/
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

- **Current Version**: `1.3.0` (2026-02-06)
- **Changelog**: See [CHANGELOG.md](CHANGELOG.md) for version history

To verify skill versions:

```bash
grep "^version:" skills/**/*.md
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
*Part of the Migasfree AI Standards v1.3.0*
