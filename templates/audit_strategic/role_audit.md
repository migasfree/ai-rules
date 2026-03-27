---
version: 2.2.0
last_modified: 2026-02-10
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

- If ROLE_TYPE is "Core": Focus on systemic health, architectural patterns, multi-module coordination, and high-level security-by-design. Evaluate if the project follows the defined Mega-Role principles. **You MUST consult `/docs/governance/critiques/` to identify known architectural risks and include the verified defense/counter-argument.**
- If ROLE_TYPE is "Skill": Focus on implementation details, idiomatic use of the specific technology/language, dependency security, and version-specific pitfalls.

## REQUIRED STRUCTURE

### ## ${ROLE_INDEX}. [${ROLE_TYPE}] ${role_label} Audit

### ${ROLE_INDEX}.1 Key Implementation Review

#### ✅ ${ROLE_INDEX}.1.1 ${role_label} Strengths

(Instruction: Include a table with Finding | Location | Assessment)

| Finding | Location | Assessment |
| :------ | :------: | :--------- |

#### ⚠️ ${ROLE_INDEX}.1.2 ${role_label} Concerns

(Instruction: Include a table with ID, Severity, Finding, Location, and Recommendation)

| ID | Severidad | Hallazgo (Crítica) | Contraargumentación (Defensa) | Recomendación Final |
| :--- | :-------: | :------ | :-------: | :------------- |

#### Code Examples

Show relevant code snippets with brief explanation.

### ${ROLE_INDEX}.2 Recommendations Summary

Include a Mermaid diagram (graph LR or graph TD) summarizing priorities.

Respond ONLY in Markdown.
