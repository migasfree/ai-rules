---
description: Create a Premium Role-Based Audit Report with high-end visuals and "packaging".
version: 1.6.0
last_modified: 2026-02-10
---

# Agentic Audit Workflow: Premium Role-Based Report

This workflow is designed to be executed directly by you (the AI agent). It generates a "Premium" audit report that balances deep technical insight with executive-level presentation ("Packaging"), utilizing standardized templates.

## Instructions

### 1. Context Acquisition & Discovery

* **Analyze Structure**: Discover the technical stack (Languages, Frameworks, Infrastructure).
* **Role Discovery (Dynamic)**: Identify relevant **Mega-Roles** and **Skills** based on project evidence.
* **Template Loading**: Read all templates from `~/.gemini/antigravity/templates/audit_report/`:
  * `executive_summary.md`
  * `role_audit.md`
  * `consolidated.md`
  * `metrics.md`
* **Initialize Report**: Create `premium_audit_report.md` with a Premium Header.

### 2. Strategic Assessment (The "Executive View")

Use the `executive_summary.md` template to generate:

* **Executive Summary**: Distinguishing between Core Architectural Health and Skill/Technology Compliance.
* **Overall Assessment Table**: Scoring key areas (Security, Code Quality, etc.) with 🟢/🟡/🔴 indicators.
* **Stack-Specific Dashboard**:
  * **Badges**: Use dynamic badges reflecting the detected stack.
  * **Mermaid Overview**: A high-level architecture diagram.

### 3. Multi-Layer Audit (The "Adaptative Packaging")

For each discovered **Role** (Core or Skill), use the `role_audit.md` template:

* **Role-Specific Context**: Apply the correct `ROLE_TYPE` (Core for Mega-Roles, Skill for specific techs).
* **Key Implementation Review**: Generate tables for Strengths and Concerns (with IDs like SEC-001).
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
* **Delivery**: Save the final `premium_audit_report.md` and inform the user.
