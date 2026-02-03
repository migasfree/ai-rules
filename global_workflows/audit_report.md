---
description: Create a Premium Role-Based Audit Report with high-end visuals and "packaging".
---

# Agentic Audit Workflow: Premium Role-Based Report

This workflow is designed to be executed directly by you (the AI agent). It generates a "Premium" audit report that balances deep technical insight with executive-level presentation ("Packaging").

## Instructions

### 1. Context Acquisition & Initialization

* **Analyze Structure**: Use `list_dir` to explore the project. Build a mental model of the architecture.
* **Discovery**:
  * Identify **Core Mega-Roles** (e.g., Business Analyst, DevOps, Security).
  * Identify **Technology Skills** (e.g., Python Expert, Bash Expert) in `.agent/skills`.
* **Initialize Report**: Create `role_audit_report.md`. Add a **Premium Header** (Logo placeholder, Date, Auditor Name, clear divider).

### 2. Strategic Assessment (The "Hook")

* **Executive Dashboard**: Instead of just text, create a high-level summary using:
  * **Status Badges**: (e.g., 🟢 Stable, 🟡 Modernize, 🔴 Critical).
  * **Scorecard Table**: Rate key areas (Architecture, Security, Code Quality) out of 10.
  * **Mermaid Graph**: A high-level architecture diagram of what you found.

### 3. Multi-Layer Audit (The "Content")

* **Process Core & Skills**: For each discovered Role/Skill:
  * **Adopt the Persona**: Write *as* that expert. Use their terminology.
  * **Structured Analysis**:
    * **✅ Strengths**: Bullet points of what is good.
    * **⚠️ Concerns**: specific findings with Severity (High/Medium/Low).
    * **📄 Code Examples**: Real snippets from the codebase. **Crucial**: Show "Before" vs "After" or "Current" vs "Recommended" snippets where possible, using syntax highlighting.
  * **REQUIRED VISUALIZATION**: For **every** role/section, you **MUST** include a specific Mermaid diagram. Examples:
    * *Business Analyst*: Flowchart of value delivery or process gaps.
    * *Security*: Attack vector diagram or permission hierarchy.
    * *DevOps*: CI/CD Pipeline visualization.
    * *Code Expert*: Refactoring flow or dependency graph.

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
