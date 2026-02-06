# Workspace Skill Configuration

This document explains the **minimalist skill installation strategy** for the `ai-rules` repository.

## 🎯 Installed Skills (Default)

Only **2 skills** are installed by default in this workspace:

### 1. `ai-prompt-expert` (Orchestrator)

**Purpose**: Ensures all skills follow the 6-Pillar Protocol when creating or updating skill definitions.

**Why Critical**: This repository IS the skill ecosystem. Any new skill or modification must comply with the standardized structure. The AI Prompt Expert acts as the quality gate.

**Triggers**: `prompt`, `instruction`, `system message`, `LLM`, `agent`, `orchestration`

### 2. `docs-expert` (Technical Writer)

**Purpose**: Maintains living documentation following the Diátaxis framework.

**Why Critical**: This is fundamentally a documentation project (READMEs, CHANGELOGs, skill specifications, onboarding guides). Every file is markdown-based technical writing.

**Triggers**: `docs`, `documentation`, `readme`, `markdown`, `mermaid`, `adr`

---

## 🚫 Why NOT Install All Skills?

### The "Context Overflow" Problem

Each additional skill introduces:

1. **Token Bloat**: Every skill adds ~3KB of context to EVERY agent interaction
   - 2 skills = ~6KB
   - 5 skills = ~15KB
   - 10 skills = **30KB** (before even reading your actual code)

2. **Cognitive Fragmentation**: The agent must "juggle" multiple personas simultaneously
   - Python Expert conflicts with Bash Expert on scripting paradigms
   - Security Expert adds paranoia to every trivial change
   - Result: Slower, overthought responses

3. **Reduced Precision**: With too many skills active, the agent becomes a "jack of all trades, master of none"
   - Generic responses instead of specialized expertise
   - Harder to predict which skill's reasoning will dominate

4. **Maintenance Debt**: More active skills = more dependency chains to manage
   - Security-expert → Python-expert → Django-expert → PostgreSQL-expert
   - Each dependency adds complexity

---

## ✅ The "Just-in-Time" Loading Strategy

Instead of installing all skills upfront, dynamically activate them for specific tasks:

### When Editing Shell Scripts (`setup.sh`, `validate_frontmatter.sh`)

```bash
/skill_on bash-expert
# Make your edits
/skill_off bash-expert
```

### When Modifying GitHub Actions (`.github/workflows/`)

```bash
/skill_on cicd-expert
# Edit workflows
/skill_off cicd-expert
```

### When Conducting Security Audits

```bash
/skill_on security-expert
# Run forensic analysis
/skill_off security-expert
```

### When Writing Tests

```bash
/skill_on qa-expert
# Create validation tests
/skill_off qa-expert
```

---

## 📊 Performance Comparison

| Approach | Tokens/Request | Response Time | Precision |
| -------- | -------------- | ------------- | --------- |
| **Minimalist (2 skills)** | ~6KB | Fast ⚡ | High 🎯 |
| **Moderate (5 skills)** | ~15KB | Medium ⏱️ | Medium 🎲 |
| **Maximalist (10+ skills)** | ~30KB+ | Slow 🐌 | Low 😕 |

---

## 🧠 Decision Rationale (ADR)

### Context

The `ai-rules` repository is a meta-project that defines AI skill personas. Contributors work primarily with:

- Markdown documentation
- Shell scripts for automation
- GitHub Actions for CI/CD
- YAML frontmatter for skill metadata

### Decision

Install only `ai-prompt-expert` and `docs-expert` by default. Use dynamic skill activation (`/skill_on`, `/skill_off`) for specialized tasks.

### Consequences

**Positive**:

- ✅ Faster agent responses (lower token overhead)
- ✅ More precise recommendations (focused expertise)
- ✅ Easier to understand which skill is "speaking"
- ✅ Lower cognitive load for contributors

**Negative**:

- ⚠️ Requires manual skill activation for specialized tasks
- ⚠️ Contributors must know which skills exist

**Mitigation**:

- Document available skills in this README
- Use `/skill_list` to view active skills at any time
- Create workflows (e.g., `/audit_report`) that auto-activate needed skills

---

## 📚 Available Skills (On-Demand)

Skills available in the `skills/` directory that can be activated when needed:

### Disciplines

- `ai-prompt-expert` ✅ (Installed)
- `cicd-expert` (GitHub Actions, CI/CD)
- `docs-expert` ✅ (Installed)
- `migasfree-ui-ux-expert` (UI/UX design - rarely needed here)
- `qa-expert` (Testing and validation)
- `security-expert` (Security audits)

### Languages

- `bash-expert` (Shell scripting)
- `go-expert` (Not used in this project)
- `python-expert` (Minimal Python usage)

### Frameworks

- All framework skills (Django, Celery, Docker, etc.) are **not relevant** to this repository's technology stack

---

## 🔄 Skill Lifecycle Commands

```bash
# View currently active skills
/skill_list

# Activate a skill temporarily
/skill_on bash-expert

# Deactivate a skill
/skill_off bash-expert

# Permanently install a skill (rare)
cp skills/disciplines/security-expert.md .agent/skills/
```

---

**Philosophy**: *"Load only what you need, when you need it."*

*Last Updated: 2026-02-06 | v1.3.0*
