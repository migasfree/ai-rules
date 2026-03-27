---
description: Execute a Deep-Dive Technical Audit of the codebase, enforcing Senior Expert rules and forensic code analysis.
version: 2.2.0
last_modified: 2026-03-27
---

# Agentic Audit Workflow: Deep Codebase Inspection

This workflow generates a **Codebase Audit Report**. Unlike the high-level strategic assessment, this workflow requires you to actively *read* and *search* the codebase for specific patterns defined by the Expert Skills.

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
       > Would you like me to generate adversarial governance files before the codebase audit?
       > For each detected agent, I will create a critique file in `docs/governance/critiques/`, plus:
       > * `docs/governance/critiques/mitigation-plan.md` — Consolidated mitigation plan
       > * `docs/governance/critiques/protocol-defense.md` — Formal protocol defense
       >
       > **[Yes]** → I will generate the critique files by invoking each agent, then proceed with the codebase audit using real data.
       > **[No]** → I will proceed with the codebase audit in **Virtual Adversary** mode (synthetic critiques generated during the audit).

     * **If user answers YES**: For each detected adversarial agent, read its `SKILL.md` and execute its adversarial perspective against the codebase. Generate one critique file per agent in `docs/governance/critiques/` (e.g., `cto-risk-assessment.md`). Then:
       * Generate `mitigation-plan.md` consolidating counterarguments (defenses) for each critique.
       * Generate `protocol-defense.md` as a formal justification of the protocol's architectural choices.
       * Update the project `README.md` to link to the Governance Portal (section 3).
       * After generation, continue to Step 1.

     * **If user answers NO**: Continue to Step 1 with `[Virtual Adversary]` mode active.

   * **If adversarial agents are FOUND and `docs/governance/critiques/` EXISTS with content**:
     * Log: `✅ Adversarial governance documents found. Codebase audit will cross-reference real critique/defense data.`
     * Continue to Step 1.

   * **If NO adversarial agents are detected** (no skills have `governance_role: adversarial`):
     * Log: `ℹ️ No adversarial agents found in workspace. Codebase audit will use Virtual Adversary mode.`
     * Continue to Step 1 with `[Virtual Adversary]` mode active.

### 1. Initialization & Discovery

* **Setup**: Create `docs/governance/audits/` if it does not exist. Initialize `codebase_audit_report.md` there.
* **Inspection Dashboard**: Create a high-level summary using:
  * **Visual Investigation Badges**: Use Shields.io badges (e.g., `![Integrity](https://img.shields.io/badge/Integrity-Verified-brightgreen?style=for-the-badge)`) for Integrity, Risk, and Traceability.
  * **Inspection Scorecard**: Confidence ratings for key layers.
* **Load Experts**: Read all `.md` files in `.agent/skills/` to load the "Hard Stops" and "Cognitive Processes".
* **Map Trace**: Use `list_dir` on the project root to identify all application modules.

### 2. Codebase Analysis (The "Deep Dive")

**CRITICAL: Dynamic Stack Detection**
Before running any checks, **identify the technology stack** present in the workspace. Only execute the modules below if the relevant files/technologies are detected.

#### 🕵️ Phase 1: Stack Identification

* Check for `manage.py` or `requirements.txt` -> **Active: Django Module**
* Check for `package.json`, `quasar.config.js`, or `*.vue` files -> **Active: Frontend Module**
* Check for `Dockerfile` or `docker-compose.yml` -> **Active: Infrastructure Module**
* Check for `pytest.ini`, `tests/`, `.github/workflows`, or `*.tf` -> **Active: DevOps & Quality Module**
* Check for `*.md` in `docs/standards/` or `docs/guides/` -> **Active: Standards & Documentation Module**

---

#### 🐍 Module A: Python & Django Inspection (If Django detected)

* **Security Scan**:
  * Grep for `password=None`, `shell=True`, `eval(`, `exec(`.
  * Grep for `print(` (logging violation) and `pdb` (debug leftovers).
* **Architecture Scan**:
  * Read `models.py`: Are models Fat? (Business logic in models is good, but keep it readable).
  * Read `views.py` / `viewsets`: Are they Skinny?
  * Check `serializers.py` for `SerializerMethodField` usage (high risk of N+1).
* **Celery/Async**:
  * Find `@app.task` or `@shared_task`.
  * **Verify**: Do they have `time_limit` set? Are arguments primitive types?

#### ⚛️ Module B: Frontend Inspection (If Vue/Quasar detected)

* **Internationalization (i18n) Hard Stop**:
  * **Pattern**: Text inside templates *not* wrapped in `$gettext` or `$t`.
  * **Command**: `grep -rP "(?<=\>)[^<>{}\\n]+(?=<)" src/components` (Manual verify required).
* **Reactivity Violations**:
  * **Pattern**: Direct DOM manipulation methods like `document.getElementById` or `document.querySelector`.
  * **Rule**: MUST use `ref` or `computed` in Vue 3.
* **Migasfree Specifics** (Only if `migasfree` in package.json):
  * **Pattern**: `axios.get` or `fetch` directly.
  * **Rule**: MUST use `smartRequest` composable to handle long URIs.

#### 🐳 Module C: Infrastructure Inspection (If Docker detected)

* **Stability Risk**:
  * Search for `:latest` tag in `Dockerfile` or `docker-compose`.
* **Security Risk**:
  * Search for `USER root` or missing `USER` instruction in `Dockerfile`.
  * Check for hardcoded secrets or passwords in ENV vars.

#### 🔧 Module D: DevOps & Quality Inspection

* **🧪 QA & Testing (If tests detected)**:
  * **Determinism**: Grep for `sleep(` in `tests/`. **Hard Stop**. Use polling/await instead.
  * **Isolation**: Check for external network calls (e.g., `requests.get`) in unit tests.
  * **Maintenance**: Grep for `@skip` or commented out tests.

* **🚀 CI/CD Pipelines (If .github/.gitlab-ci detected)**:
  * **Secret Leaks**: Grep for `echo` printing potential variables/secrets.
  * **Permissions**: Search for `permissions: write-all` (Critical Vulnerability).
  * **Updates**: Check for deprecated actions (e.g., `actions/checkout@v2`).

* **☁️ Terraform/IaC (If *.tf detected)**:
  * **Secrets**: Grep for `access_key` or `secret_key` in `.tf` files.
  * **State**: Verify no local state usage (ensure `backend` block exists).
  * **Git**: Verify `.tfstate` is in `.gitignore`.

#### 📄 Module E: Standards & Documentation Inspection (If docs/standards detected)

* **Structural Consistency**:
  * Verify all RFCs/standards use consistent heading hierarchy and cross-reference each other.
  * Check for orphan documents (referenced but missing, or existing but unreferenced from README).
* **Specification Completeness**:
  * Identify schemas, templates, or artifacts that are mandated by standards but not yet materialized.
  * Cross-reference provider guide checklists against actual validation tooling.
* **Glossary Drift**:
  * Verify that terms defined in the glossary match their usage across all documents.

### 3. Detailed Reporting

* **Role Integration**: For each Technology Domain, add a **Role Badge** (e.g., `![Staff Engineer](https://img.shields.io/badge/Role-Staff_Engineer-black?style=for-the-badge)`).
* **🔍 Evidence**: Use visual badges for "Evidence" and "Concerns" headers.
* **📉 Metrics**: (e.g., "Found 12 Async Tasks", "Found 5 Security Hotspots") using metric badges.
* **🛡️ Adversarial Justification**: Cross-reference each concern with `docs/governance/critiques/`.
  * If critiques exist (from Step 0): State if it's a known trade-off and quote the specific defense document.
  * If missing (Virtual Adversary mode): Propose an **Initial Assessment** (the Devil's Advocate view). Label as: `[Virtual Adversary]: Seed critique generated during codebase audit. Formalization recommended.`
* **💡 Senior Analysis**: Apply the "Cognitive Process" from the Skill to explain *why* findings are critical.
* **🚑 Remediation Plan**: Code snippets for the most critical fixes.

### 4. Required Visualizations (Mermaid)

* **Entity-Relationship Diagram (ERD)**: Infer from `models.py` analysis (if Django detected).
* **Task Flow**: Diagram how a key async task interacts with the DB (if applicable).
* **Architecture Overview**: High-level component diagram showing the detected stack relationships.

### 5. Final Delivery

* Ensure the tone is "Staff Engineer Code Review" (strict, precise, technically dense).
* **Format Check**:
  * 🛑 **CRITICAL**: Verify there is at least one blank line before EVERY table to ensure correct rendering.
  * 🛑 **CRITICAL**: Verify all headings are unique by including the Module Index or descriptive labels.
  * 🛑 **CRITICAL**: Use only `##` (h2) or lower for numbered sections. Reserve `#` (h1) for the document title only (MD025 compliance).
* Save to `docs/governance/audits/codebase_audit_report.md`.
