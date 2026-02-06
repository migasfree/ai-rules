---
description: Generate a secure, professional, and linked commit message.
version: 1.0.0
last_modified: 2026-02-04
---

# Generate a message to commit

This workflow analyzes "Staged Changes," performs a security scan, identifies related Issues, and drafts a commit message following Conventional Commits standards.

## 1. **Context Capture & Security Audit**

The assistant must first capture the current state of changes and perform a security screening.

- **Action**: Run `git diff --cached` to see staged changes.
- **Security Audit**: Act as a **Senior Security Engineer**. Scan the diff for:
  - API keys, passwords, or tokens.
  - Exposed `.env` files or sensitive credentials.
- **Stop Condition**: If any sensitive data is found, **ABORT** and warn the user. Do NOT proceed to drafting.

## 2. **Drafting the Commit Message**

Act as a **Senior Technical Writer**. Analyze the changes and use the following standards:

- **Format**: Conventional Commits (`feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`).
- **Structure**: `<type>(<scope>): <short description in lowercase>`.
- **Guidelines**:
  - Use active voice.
  - Keep the first line under 50 characters.
  - Reference issues if found in the context (e.g., `Closes #123`).
  - Provide a bulleted list for the body if the changes are complex.

## 3. **Interactive Commitment**

Present the proposal to the user following this template:

```markdown
✅ **Security Analysis**: [SECURE | DANGER: explanation]

📝 **Proposed Commit Message**:
---
[Commit Message Text]
---

🚀 **Files Staged**:
[List of files]
```

**Ask for permission** before executing the final `git commit -m "[message]"`.
