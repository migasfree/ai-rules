---
description: Create a Premium Role-Based Audit Report with high-end visuals and "packaging".
version: 1.5.0
last_modified: 2026-02-07
---

# Agentic Audit Workflow: Premium Role-Based Report

This workflow is designed to be executed directly by you (the AI agent). It generates a "Premium" audit report that balances deep technical insight with executive-level presentation ("Packaging").

## Instructions

### 1. Context Acquisition & Discovery

* **Analyze Structure**: Discover the technical stack (Languages, Frameworks, Infrastructure).
* **Role Discovery (Dynamic)**: Identify relevant **Mega-Roles** based on project evidence:
  * `src/*.vue` -> Activate **Frontend Architect**.
  * `Dockerfile` -> Activate **Platform Engineer**.
  * `tests/` -> Activate **QA/SDET**.
  * `models.py` / `Schema` -> Activate **Data Architect**.
* **Initialize Report**: Create `premium_audit_report.md` with a Premium Header.

### 2. Strategic Assessment (The "Hook")

* **Stack-Specific Dashboard**:
  * **Badges**: Use dynamic badges reflecting the detected stack (e.g., `![Stack](https://img.shields.io/badge/Stack-Django-blue)`).
  * **Scorecard**: Rate 3-4 key areas found (e.g., Security, Testability, Containerization).
  * **Mermaid Overview**: A high-level architecture diagram. Choose the type:
    * Deployment Flow (if DevOps detected).
    * Component Hierarchy (if Frontend detected).
    * Data Model (if Backend detected).

### 3. Multi-Layer Audit (The "Adaptative Packaging")

For each discovered **Role**, generate a premium section:

* **Role Badge**: Use a Shields.io badge for the role.
* **Persona Insights**: Write strictly from that role's perspective.
* **Visual Evidence**:
  * **Mermaid Diagram**: **Mandatory** per role. (e.g., QA Role -> Testing Pyramid; Platform Role -> CI/CD Graph).
  * **Code Highlights**: Showcase "Premium" patterns (Clean Code) vs "Draft" patterns.
* **Domain Strengths & Concerns**: Use visual indicators for severity.

### 4. Synthesis & Recommendations (The "Value")

* **Consolidated Recommendations Matrix**:
  * Group findings into a robust table: `| Priority | Domain | Finding | Actionable Recommendation |`.
* **Metrics & Appendix**:
  * Include a "Files Analyzed" list.
  * Include a Glossary if technical terms were used.

### 5. Final Polish ("Packaging")

* **Review**: Read the generated markdown.
* **Format Check**:
  * Are headers clear?
  * Are there enough emojis to guide the eye (without being clownish)?
  * Are the tables well-spaced?
* **Delivery**: Save the file and inform the user the Premium Audit is ready.
