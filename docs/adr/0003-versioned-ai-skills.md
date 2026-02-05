# ADR 0003: Versioned AI Skills

**Status**: Accepted  
**Date**: 2026-02-04

## Context

As the project scales and more skills are created, it becomes difficult to track which version of a skill is currently synchronized in a project. Without versioning, improvements in the global repository do not propagate clearly, and there is no way for a project to audit its compliance with the latest standards.

## Decision

We will implement a mandatory metadata header (YAML frontmatter) for every Skill (`SKILL.md` or `.md` in `skills/`).

The header must include:

* `name`: Human-readable name of the skill.
* `version`: Semantic versioning (e.g., `1.0.0`).
* `description`: Short objective of the skill.
* `last_modified`: ISO 8601 date.
* `triggers`: Keywords that activate the skill.

Example:

```yaml
---
name: Technical Lead & Architect
version: 1.0.0
description: Senior expert in system architecture...
last_modified: 2026-02-04
triggers: [architecture, design pattern]
---
```

## Consequences

* **Traceability**: Projects can now specify exactly which version of a skill they depend on.
* **Update Verification**: Future tooling (like `setup.sh --check`) can compare local versions against the global repository.
* **Documentation Overhead**: Authors must manually increment the version when making changes to the logic.
