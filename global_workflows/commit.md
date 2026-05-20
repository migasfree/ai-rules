---
description: Generate a secure, professional, and linked commit message, with support for functional grouping.
version: 2.3.0
last_modified: 2026-05-20
---

# Generate a message to commit

This workflow analyzes staged/modified changes, performs a security scan, identifies related Issues, and drafts one or more commit messages grouped by functionality following Conventional Commits standards.

## 1. **Context Capture & Security Audit**

The assistant must first capture the current state of changes and perform a security screening.

- **Action**: Run `git status` and `git diff --cached` to see staged files and detailed changes.
- **Security Audit**: Act as a **Senior Security Engineer**. Scan the diff for:
  - API keys, passwords, or tokens.
  - Exposed `.env` files or sensitive credentials.
- **Stop Condition**: If any sensitive data is found, **ABORT** and warn the user. Do NOT proceed to drafting.

## 2. **Drafting the Commit Message (with Functional Grouping)**

Act as a **Senior Technical Writer**. Analyze the changes and determine if they should be grouped by functionality:

- **Grouping Analysis**:
  - Evaluate if the changes represent a single logical unit or multiple independent functional changes (e.g., frontend components vs. backend APIs, or translation updates vs. core package refactorings).
  - If multiple distinct functionalities are changed, plan a sequence of commits grouped by functionality.
- **Format**: Conventional Commits (`feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`).
- **Structure**: `<type>(<scope>): <short description in lowercase>`.
- **Guidelines**:
  - Use active voice.
  - Keep the first line under 50 characters.
  - Reference issues if found in the context (e.g., `Closes #123`).
  - Provide a bulleted list for the body if the changes are complex.
  - **Efficiency & Zero Redundancy Rule**:
    - **No Redundant Commands**: Do not run test suites, lint checks, or build commands if they have already passed in the current session.
    - **Pre-execution Check**: Check the porcelain status of the repository (`git status --porcelain`) to confirm what is actually staged or modified.
    - **Surgical Staging**: When executing a grouped commit plan, do not unstage files (`git reset`) if the current staged files already match the targeted functional group perfectly.
    - **No Double-Compiling**: In projects with auto-compiling steps, do not manually invoke build/compile targets if the subsequent execution or testing system automatically does so.

## 3. **Interactive Commitment**

Present the proposal to the user.

### Case A: Single Commit

If the changes represent a single logical functionality:

```markdown
✅ **Security Analysis**: [SECURE | DANGER: explanation]

📝 **Proposed Commit Message**:
---
[Commit Message Text]
---

🚀 **Files Staged**:
[List of files]
```

### Case B: Grouped Commits

If the changes span multiple functional groups:

```markdown
✅ **Security Analysis**: [SECURE | DANGER: explanation]

📝 **Proposed Grouped Commit Plan**:
- **Group 1**: [Description of functionality]
  - **Files**: [List of files]
  - **Commit Message**:
    ```
    [Commit Message Text 1]
    ```
- **Group 2**: [Description of functionality]
  - **Files**: [List of files]
  - **Commit Message**:
    ```
    [Commit Message Text 2]
    ```
```

**Ask for permission** before executing the final commit(s). If grouped commits are approved:

1. Check if staging matches the current group. Only unstage (`git reset`) if there are staged files that do not belong to the targeted group.
2. For each group in sequence, stage its specific files (`git add ...`) and commit them with its proposed message, avoiding duplicate or redundant staging actions.
