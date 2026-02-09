---
version: 1.5.0
last_modified: 2026-02-04
---
Act as a Senior ${role_label}.

## GUIDELINES

${guidelines}

---

## CODEBASE CONTEXT

${CONTEXT_STRUCTURE}

---

## TASK

Generate the audit section for your role.

## FOCAL POINT (CONTEXTUAL)

- If ROLE_TYPE is "Core": Focus on systemic health, architectural patterns, multi-module coordination, and high-level security-by-design. Evaluate if the project follows the defined Mega-Role principles.
- If ROLE_TYPE is "Skill": Focus on implementation details, idiomatic use of the specific technology/language, dependency security, and version-specific pitfalls.

## REQUIRED STRUCTURE

### ## ${ROLE_INDEX}. [${ROLE_TYPE}] ${role_label} Audit

### ${ROLE_INDEX}.1 Key Implementation Review

#### ✅ Strengths

Include a table with: Finding | Location | Assessment.

#### ⚠️ Concerns

Include a table with: ID | Severity | Finding | Location | Recommendation. Use [ID] like SEC-001, PY-001, etc.

#### Code Examples

Show relevant code snippets with brief explanation.

### ${ROLE_INDEX}.2 Recommendations Summary

Include a Mermaid diagram (graph LR or graph TD) summarizing priorities.

Respond ONLY in Markdown.
