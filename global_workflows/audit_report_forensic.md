---
description: Execute a Deep-Dive Technical Audit of the codebase, enforcing Senior Expert rules and forensic code analysis.
version: 1.0.0
last_modified: 2026-02-04
---

# Agentic Audit Workflow: Deep Code Inspection

This workflow generates a **Forensic Audit Report**. Unlike the high-level assessment, this workflow requires you to actively *read* and *search* the codebase for specific patterns defined by the Expert Skills.

## Instructions

### 1. Initialization & Discovery

* **Setup**: Create `role_audit_report.md`. Add header with "Deep Inspection" tag.
* **Forensic Dashboard**: Create a high-level summary using:
  * **Visual Investigation Badges**: Use Shields.io badges (e.g., `![Integrity](https://img.shields.io/badge/Integrity-Verified-brightgreen?style=for-the-badge)`) for Integrity, Risk, and Traceability.
  * **Forensic Scorecard**: Confidence ratings for key layers.
* **Load Experts**: Read all `.md` files in `.agent/skills/` to load the "Hard Stops" and "Cognitive Processes".
* **Map Trace**: Use `list_dir` on `migasfree/` to identify all Django Apps.

### 2. Forensic Analysis (The "Deep Dive")

For each **Expert Skill** available, perform a targeted search:

#### 🐍 Python & Security Forensics

* **Action**: Search for "Hard Stop" violations in the *entire* codebase.
* **Commands**:
  * Use `grep_search` for `password=None`, `shell=True`, `eval(`, `exec(`.
  * Use `grep_search` for `print(` (logging violation) and `pdb` (debug leftovers).
* **Output**: List specific file paths and line numbers of any violation.

#### 🌐 Django & DRF Forensics

* **Action**: Analyze Architecture and Performance.
* **Inspection**:
  * Read `migasfree/device/models.py` and `migasfree/device/views.py` (and other key apps).
  * **Check**: Are models Fat? Are ViewSets Skinny?
  * **Check**: key `serializers.py` files for `SerializerMethodField` (N+1 risk).
* **Metrics**: Count total Models and ViewSets to estimate complexity.

#### ⚡ Celery & Async Forensics

* **Action**: Audit Task Design.
* **Inspection**:
  * Find all functions decorated with `@app.task` or `@shared_task`.
  * **Verify**: Do they have `time_limit`? Do they take complex objects?

#### 🗄️ Database Forensics

* **Action**: Schema review.
* **Inspection**:
  * Look for `JSONField` usage. check if they have `GinIndex` in `Meta`.
  * Look for `__icontains` usage in code.

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
* Save to `role_audit_report.md`.
