---
description: Generate a secure, professional, and linked commit message.
version: 1.0.0
last_modified: 2026-02-04
---

# Generate a message to commit

This workflow analyzes "Staged Changes," performs a security scan, identifies related Issues, and drafts a commit message following Conventional Commits standards.

1.- Generate Commit Message

- **Action**: Security audit and issue-linked drafting.
- **CRITICAL**: ONLY operate on **Staged Changes** (`git diff --cached`). DO NOT run `git add` automatically. If there are unstaged changes, they MUST be ignored.
- **Command**:

```bash
# --- 1. CONTEXT CAPTURE ---
# Capture changes currently in the staging area
STAGED_DIFF=$(git diff --cached)

if [ -z "$STAGED_DIFF" ]; then
  echo "❌ No changes in Staged area. Use 'git add' first."
  exit 1
fi

# Fetch open Issues (requires GitHub CLI 'gh' or custom 'ag' tool)
# Fallback: If neither tool is available, continue without issue linking
if command -v gh &> /dev/null; then
  OPEN_ISSUES=$(gh issue list --limit 5 2>/dev/null || echo "")
elif command -v ag &> /dev/null; then
  OPEN_ISSUES=$(ag issues list --status open --limit 5 2>/dev/null || echo "")
else
  OPEN_ISSUES=""
  echo "ℹ️  No issue CLI found (gh/ag). Skipping issue linking."
fi

# --- 2. SECURITY AUDIT (Security Engineer) ---
SECURITY_CHECK=$(ag run --mode Codebase --model "Gemini 3 Flash" "Act as a Senior Security Engineer.
Analyze this DIFF:
---
$STAGED_DIFF
---
Look for: API keys, passwords, tokens, or exposed .env files.
If you find anything suspicious, respond: 'DANGER: [explanation]'.
If everything is clean, respond: 'SECURE'.")

if [[ "$SECURITY_CHECK" == "DANGER"* ]]; then
  echo "⚠️ SECURITY ALERT: $SECURITY_CHECK"
  echo "Process aborted for security reasons."
  exit 1
fi

# --- 3. DRAFTING (Technical Writer) ---
COMMIT_MSG=$(ag run --mode Codebase --model "Gemini 3 Flash" "Act as a Senior Technical Writer.
Analyze the changes and the list of open Issues.

LIST OF OPEN ISSUES:
$OPEN_ISSUES

STAGED CHANGES:
$STAGED_DIFF

TASKS:
1. Use the Conventional Commits format (feat, fix, docs, style, refactor, test, chore).
2. Format: <type>(<scope>): <short description in lowercase>.
3. Identify if these changes resolve any of the provided Issues.
4. If a match is found, append 'Closes #ID' at the end of the message body.
5. Use active voice and keep the first line under 50 characters.

RESPOND ONLY WITH THE RAW COMMIT MESSAGE TEXT. DO NOT USE MARKDOWN CODE BLOCKS OR BACKTICKS.")

# --- 4. DISPLAY PROPOSAL ---
STAGED_FILES=$(git diff --cached --name-only)
echo "✅ Security Analysis: SECURE"
echo -e "\n� **Files to be committed:**"
echo "$STAGED_FILES"
echo -e "\n�📝 **Proposed Commit Message:**\n"
echo "------------------------------------------------"
echo "$COMMIT_MSG"
echo "------------------------------------------------"

# --- 5. INTERACTIVE APPROVAL ---
# This block forces the user to choose before any action is taken
echo -e "\n"
read -p "🚀 Do you want to execute this commit with only these files? (y/N): " CONFIRM

if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
  # Use temporary file to handle multiline messages correctly
  echo "$COMMIT_MSG" > .git_commit_msg.tmp
  git commit -F .git_commit_msg.tmp
  rm .git_commit_msg.tmp
  echo -e "\n✨ **Changes committed successfully!**"
else
  echo -e "\n🛑 **Commit cancelled.** The message was not applied."
fi
```
