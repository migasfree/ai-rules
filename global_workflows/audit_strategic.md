---
description: Create a Premium Strategic Audit Report with role-based architecture assessment, adversarial governance, and executive-level visuals.
version: 2.2.0
last_modified: 2026-03-27
---

# Agentic Audit Workflow: Premium Strategic Report

This workflow is designed to be executed directly by you (the AI agent). It generates a "Premium" strategic audit report that balances deep technical insight with executive-level presentation ("Packaging"), utilizing standardized templates.

## Instructions

### 0. Adversarial Governance Gate (Pre-Audit)

Before generating any audit content, execute this prerequisite gate:

1. **Detect Adversarial Agents (Dynamic Discovery)**:
   * Scan **all** `SKILL.md` files in both:
     * **Workspace**: `.agent/skills/**/SKILL.md`
     * **Global**: `~/.gemini/antigravity/global_skills/**/SKILL.md`
   * Read the YAML frontmatter of each skill file.
   * Collect every skill that declares `governance_role: adversarial` in its frontmatter.
   * Build a list of detected adversarial agents with their `name` and file path.

2. **Check Governance Directory**: Verify if `docs/governance/critiques/` exists and contains formalized critique/defense documents.

3. **Decision Gate** — Apply the following logic:

   * **If adversarial agents are FOUND and `docs/governance/critiques/` is MISSING or EMPTY**:
     * 🛑 **STOP and ASK the user**. List the dynamically discovered agents, for example:

       > I have detected the following adversarial agents in the workspace (skills with `governance_role: adversarial`):
       > * ✅ `CTO - Strategic Oversight` — `.agent/skills/disciplines/cto/SKILL.md`
       > * ✅ `Software Architect` — `.agent/skills/disciplines/software-architect/SKILL.md`
       > * ✅ `Technical Analyst` — `.agent/skills/disciplines/technical-analyst/SKILL.md`
       >
       > However, **the directory `docs/governance/critiques/` does not exist** with formal critique and defense documents.
       >
       > Would you like me to generate adversarial governance files before the audit?
       > For each detected agent, I will create a critique file in `docs/governance/critiques/`, plus:
       > * `docs/governance/critiques/mitigation-plan.md` — Consolidated mitigation plan
       > * `docs/governance/critiques/protocol-defense.md` — Formal protocol defense
       >
       > **[Yes]** → I will generate the critique files by invoking each agent, then proceed with the audit using real data.
       > **[No]** → I will proceed with the audit in **Virtual Adversary** mode (synthetic critiques generated during the audit).

     * **If user answers YES**: For each detected adversarial agent, read its `SKILL.md` and execute its adversarial perspective against the codebase. Generate one critique file per agent in `docs/governance/critiques/` (e.g., `cto-risk-assessment.md`). Then:
       * Generate `mitigation-plan.md` consolidating counterarguments (defenses) for each critique.
       * Generate `protocol-defense.md` as a formal justification of the protocol's architectural choices.
       * Update the project `README.md` to link to the Governance Portal (section 3).
       * After generation, continue to Step 1.

     * **If user answers NO**: Continue to Step 1 with `[Virtual Adversary]` mode active.

   * **If adversarial agents are FOUND and `docs/governance/critiques/` EXISTS with content**:
     * Log: `✅ Adversarial governance documents found. Audit will use real critique/defense data.`
     * Continue to Step 1.

   * **If NO adversarial agents are detected** (no skills have `governance_role: adversarial`):
     * Log: `ℹ️ No adversarial agents found in workspace. Audit will use Virtual Adversary mode.`
     * Continue to Step 1 with `[Virtual Adversary]` mode active.

### 1. Context Acquisition & Discovery

* **Analyze Structure**: Discover the technical stack (Languages, Frameworks, Infrastructure).
* **Role Discovery (Dynamic)**: Identify relevant **Mega-Roles** and **Skills** based on project evidence.
* **Template Loading**: Read all templates from `~/.gemini/antigravity/templates/audit_strategic/`:
  * `executive_summary.md`
  * `role_audit.md`
  * `consolidated.md`
  * `metrics.md`
* **Initialize Report**: Create a `docs/governance/audits/` directory if it does not exist. Initialize `strategic_audit_report.md` there.

### 2. Strategic Assessment (The "Executive View")

Use the `executive_summary.md` template to generate:

* **Executive Summary**: Distinguishing between Core Architectural Health and Skill/Technology Compliance.
* **Overall Assessment Table**: Scoring key areas (Security, Code Quality, etc.) with 🟢/🟡/🔴 indicators.
* **Stack-Specific Dashboard**:
  * **Badges**: Use dynamic badges reflecting the detected stack.
  * **Mermaid Overview**: A high-level architecture diagram.

### 3. Multi-Layer Audit (The "Adaptive Packaging")

For each discovered **Role** (Core or Skill), use the `role_audit.md` template:

* **Role-Specific Context**: Apply the correct `ROLE_TYPE` (Core for Mega-Roles, Skill for specific techs).
* **Key Implementation Review**: Generate tables for Strengths and Concerns (with IDs like SEC-001).
* **Adversarial Governance Logic**:
  * If `docs/governance/critiques/` exists: Search for official defenses/mitigations and populate the "Counter-Argument (Defense)" column with real, referenced data from the critique files.
  * If directory is MISSING (Virtual Adversary mode): Perform an internal **Devil's Advocate** pass. Label the defense as: `[Virtual Adversary]: Seed critique generated during audit. Formalization recommended.`
* **Code Examples**: Showcase specific implementation patterns found in the codebase.
* **Role Diagram**: **Mandatory** Mermaid diagram summarizing priorities for that role.

### 4. Synthesis & Recommendations (The "Value")

Use the `consolidated.md` template to generate:

* **Consolidated Recommendations Matrix**:
  * Categorize into "Strategic & Architectural (Core)" and "Tactical & Technical (Skills)".
  * Rank by priority (P0 to P3) using the template's table structure.

### 5. Metrics & Documentation (The "Evidence")

Use the `metrics.md` template to generate:

* **Metrics Summary**: Codebase statistics and Core-Skill alignment scoring.
* **Skill Ecosystem Status**: A table showing all detected Skills and their compliance levels.
* **Appendices**: Files Analyzed and Glossary.

### 6. Final Polish ("Packaging")

* **Visual Consistency**: Ensure headers, emojis, and tables follow a premium, professional aesthetic.
* **Format Check**:
  * 🛑 **CRITICAL**: Verify there is at least one blank line before EVERY table to ensure correct rendering.
  * 🛑 **CRITICAL**: Verify all headings are unique by including the Role Index or descriptive labels (avoid duplicate "Strengths" or "Concerns" headers).
  * 🛑 **CRITICAL**: Use only `##` (h2) or lower for numbered sections. Reserve `#` (h1) for the document title only (MD025 compliance).
* **Delivery**: Save the final `docs/governance/audits/strategic_audit_report.md` and inform the user.
