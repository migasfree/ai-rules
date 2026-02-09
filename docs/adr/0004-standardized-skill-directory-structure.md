# 4. Standardized Skill Directory Structure & Tiered Output

- **Status**: Accepted
- **Date**: 2026-02-09
- **Context**:
  - The previous flat structure (`skills/category/skill.md`) made it difficult to bundle resources (templates, examples) with skills.
  - AI responses were inconsistent, with some skills having massive "Output Style" guides and others having none.
- **Decision**:
    1. **Directory-Based Skills**: All skills must reside in `skills/[Category]/[SkillName]/SKILL.md`.
    2. **Recursive Copying**: Installation scripts (`setup.sh`, `skill_generate`) must copy the *entire directory* to preserve resources.
    3. **Tiered Output Strategy**:
        - **Level 1 (Lightweight)**: Standard skills use `output-standard-expert` for basic formatting consistency.
        - **Level 2 (Structural)**: Complex skills (e.g., FastAPI, Redis) use strict templates located in `resources/templates/`.
- **Consequences**:
  - **Breaking Change**: Older installation commands (`cp skill.md`) are invalid. Documentation has been updated to use `cp -r`.
  - **Scalability**: New resources can be added to skills without cluttering the main `skills/` directory.
  - **Consistency**: All skills now share a unified mental model for output formatting.
