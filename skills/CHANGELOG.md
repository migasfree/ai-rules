# Expert Skills Changelog
<!-- markdownlint-disable MD024 -->

All notable changes to the Expert Skills ecosystem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.4.0] - 2026-02-07

### Added

- Security hardening of CI/CD pipelines by pinning GitHub Actions to specific commit SHAs.
- Full ecosystem version synchronization to v1.4.0 across all documentation.

### Fixed

- Discrepancies between main README and specialized READMEs regarding the current version.

---

## [1.3.0] - 2026-02-06

### Added

- Polyglot awareness checks in `python-expert` and `go-expert` for hybrid architecture decisions
- Multi-skill orchestration rationalization in `ai-prompt-expert` to prevent redundant Mermaid diagrams
- Cross-skill dependency declarations in YAML frontmatter across all skills
- Explicit styling authority delegation from `migasfree-frontend-expert` to `migasfree-ui-ux-expert`
- Security expert as universal dependency for all technical skills

### Changed

- **BREAKING**: Standardized all skills to unified 6-Pillar Protocol (Persona, Context, Task, Constraints, CoT, Output)
- Merged `quasar-vue-expert` quality standards into `migasfree-frontend-expert` (accessibility, reactivity, security)
- Updated `electron-expert` dependency from deprecated `quasar-vue-expert` to `migasfree-frontend-expert`
- Enhanced `cicd-expert` with explicit `docker-expert` and `security-expert` dependencies
- Upgraded all skills to version 1.3.0 for ecosystem-wide consistency

### Removed

- Deactivated `quasar-vue-expert.md` (renamed to `.md.off`) due to 85% overlap with `migasfree-frontend-expert`

### Fixed

- Resolved structural divergence between Pillar-based and numeric header formats
- Corrected broken dependency references in `electron-expert`, `celery-expert`, and `qa-expert`
- Eliminated redundant security hard stops by centralizing in `security-expert`

### Security

- Centralized all security policies under `security-expert` as CISO authority
- Added 42 enforced critical hard stops across the ecosystem
- Implemented mandatory secret scanning recommendations in CI/CD workflows

---

## [1.2.0] - 2026-02-05

### Added

- Initial skill generation for Migasfree project
- Django, Celery, Terraform, Electron, GraphQL specialized experts

### Changed

- Various individual skill updates without coordinated versioning

---

## [1.1.0] - 2026-02-04

### Added

- Core discipline skills (QA, CI/CD, Docs, Security)
- Framework skills (Docker, PostgreSQL)
- Language skills (Python, Go, Bash)

---

## [1.0.0] - Initial Release

### Added

- Base skill framework with 6-Pillar Protocol
- Initial Migasfree-specific skills (UI/UX, Frontend)
- AI Prompt Engineering skill as orchestrator
