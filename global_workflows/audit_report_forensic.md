---
description: Execute a Deep-Dive Technical Audit of the codebase, enforcing Senior Expert rules and forensic code analysis.
version: 1.4.0
last_modified: 2026-02-07
---

# Agentic Audit Workflow: Deep Code Inspection

This workflow generates a **Forensic Audit Report**. Unlike the high-level assessment, this workflow requires you to actively *read* and *search* the codebase for specific patterns defined by the Expert Skills.

## Instructions

### 1. Initialization & Discovery

* **Setup**: Create `forensic_audit_report.md`. Add header with "Deep Inspection" tag.
* **Forensic Dashboard**: Create a high-level summary using:
  * **Visual Investigation Badges**: Use Shields.io badges (e.g., `![Integrity](https://img.shields.io/badge/Integrity-Verified-brightgreen?style=for-the-badge)`) for Integrity, Risk, and Traceability.
  * **Forensic Scorecard**: Confidence ratings for key layers.
* **Load Experts**: Read all `.md` files in `.agent/skills/` to load the "Hard Stops" and "Cognitive Processes".
* **Map Trace**: Use `list_dir` on `migasfree/` to identify all Django Apps.

### 2. Forensic Analysis (The "Deep Dive")

**CRITICAL: Dynamic Stack Detection**
Before running any checks, **identifiy the technology stack** present in the workspace. Only execute the modules below if the relevant files/technologies are detected.

#### 🕵️ Phase 1: Stack Identification

* Check for `manage.py` or `requirements.txt` -> **Active: Django Module**
* Check for `package.json`, `quasar.config.js`, or `*.vue` files -> **Active: Frontend Module**
* Check for `Dockerfile` or `docker-compose.yml` -> **Active: Infrastructure Module**
* Check for `pytest.ini`, `tests/`, `.github/workflows`, or `*.tf` -> **Active: DevOps & Quality Module**

---

#### 🐍 Module A: Python & Django Forensics (If Django detected)

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

#### ⚛️ Module B: Frontend Forensics (If Vue/Quasar detected)

* **Internationalization (i18n) Hard Stop**:
  * **Pattern**: Text inside templates *not* wrapped in `$gettext` or `$t`.
  * **Command**: `grep -rP "(?<=>)[^<>{}\n]+(?=<)" src/components` (Manual verify required).
* **Reactivity Violations**:
  * **Pattern**: Direct DOM manipulation methods like `document.getElementById` or `document.querySelector`.
  * **Rule**: MUST use `ref` or `computed` in Vue 3.
* **Migasfree Specifics** (Only if `migasfree` in package.json):
  * **Pattern**: `axios.get` or `fetch` directly.
  * **Rule**: MUST use `smartRequest` composable to handle long URIs.

#### 🐳 Module C: Infrastructure Forensics (If Docker detected)

* **Stability Risk**:
  * Search for `:latest` tag in `Dockerfile` or `docker-compose`.
* **Security Risk**:
  * Search for `USER root` or missing `USER` instruction in `Dockerfile`.
  * Check for hardcoded secrets or passwords in ENV vars.

#### 🔧 Module D: DevOps & Quality Forensics

* **🧪 QA & Testing (If tests detected)**:
  * **Determinism**: Grep for `sleep(` in `tests/`. **Hard Stop**. Use polling/await instead.
  * **Isolation**: check for external network calls (e.g., `requests.get`) in unit tests.
  * **Maintenance**: Grep for `@skip` or commented out tests.

* **🚀 CI/CD Pipelines (If .github/.gitlab-ci detected)**:
  * **Secret Leaks**: Grep for `echo` printing potential variables/secrets.
  * **Permissions**: Search for `permissions: write-all` (Critical Vulnerability).
  * **Updates**: Check for deprecated actions (e.g., `actions/checkout@v2`).

* **☁️ Terraform/IaC (If *.tf detected)**:
  * **Secrets**: Grep for `access_key` or `secret_key` in `.tf` files.
  * **State**: Verify no local state usage (ensure `backend` block exists).
  * **Git**: Verify `.tfstate` is in `.gitignore`.

### 3. Detailed Reporting

* **Role Integration**: For each Technology Domain, add a **Forensic Role Badge** (e.g., `![Staff Engineer](https://img.shields.io/badge/Role-Staff_Engineer-black?style=for-the-badge)`).
* **🔍 Forensic Evidence**: Use visual badges for "Evidence" and "Concerns" headers.
* **📉 Metrics**: (e.g., "Found 12 Async Tasks", "Found 5 Security Hotspots") using metric badges.
* **💡 Senior Analysis**: Apply the "Cognitive Process" from the Skill to explain *why* findings are critical.
* **🚑 Remediation Plan**: Code snippets for the most critical fixes.

### 4. Required Visualizations (Mermaid)

* **Entity-Relationship Diagram (ERD)**: Infer from `models.py` analysis.
* **Task Flow**: Diagram how a key Celery task interacts with the DB.

### 5. Final Delivery

* Ensure the tone is "Staff Engineer Code Review" (strict, precise, technically dense).
* Save to `forensic_audit_report.md`.
