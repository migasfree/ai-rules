---
description: Automate the version release process for the AI Rules ecosystem, ensuring synchronization across all components.
version: 1.5.0
last_modified: 2026-02-09
---

# 🚀 Release & Versioning Workflow

This workflow guides the AI Agent through the process of releasing a new version of the **Migasfree AI Rules**, ensuring that `skills`, `workflows`, `templates`, and `scripts` remain synchronized to avoid "version mismatch" errors.

## 📦 Scope of Updates

When a release (e.g., `v1.6.0`) occurs, the following components MUST be updated:

1. **Skills**: `skills/` and `global_skills/`
2. **Workflows**: `global_workflows/`
3. **Templates**: `templates/`
4. **Installer**: `setup.sh` (Version header)
5. **Documentation**: `CHANGELOG.md`

## 🛠️ Step-by-Step Instructions

### 1. **Prepare Release**

* **Ask the User**: "What is the new version number? (e.g., 1.6.0)"
* **Define Date**: Use the current date (YYYY-MM-DD).

### 2. **Batch Version Bump** ⚡

Use `sed` to update all components simultaneously. Assuming NEW_VERSION is provided:

**Command Pattern:**

```bash
# 1. Update SKILL.md files (Skills & Global Skills)
find skills global_skills -name "SKILL.md" -exec sed -i 's/^version: .*/version: <NEW_VERSION>/' {} +
find skills global_skills -name "SKILL.md" -exec sed -i 's/^last_modified: .*/last_modified: <DATE>/' {} +

# 2. Update Workflows
find global_workflows -name "*.md" -exec sed -i 's/^version: .*/version: <NEW_VERSION>/' {} +
find global_workflows -name "*.md" -exec sed -i 's/^last_modified: .*/last_modified: <DATE>/' {} +

# 3. Update Templates
find templates -name "*.md" -exec sed -i 's/^version: .*/version: <NEW_VERSION>/' {} +

# 4. Update setup.sh header
sed -i 's/^# Version: .*/# Version: <NEW_VERSION>/' setup.sh
```

### 3. **Verify Consistency** 🔍

Run a consistency check to ensure no file was left behind:

```bash
grep -r "^version:" skills global_skills global_workflows templates | grep -v "<NEW_VERSION>"
```

* **Goal**: The output should be EMPTY (or only show legacy content explicitly excluded).
* **Action**: If mismatches are found, fix them immediately.

### 4. **Update Changelog** 📝

Update `skills/CHANGELOG.md` with:

```markdown
## [<NEW_VERSION>] - <DATE>
### Added/Changed/Fixed
- Summary of changes...
```

### 5. **Final Commit** 💾

Commit all changes with a standardized message:

```bash
git add .
git commit -m "release: v<NEW_VERSION> - synchronized ecosystem update"
```

---
*Run this workflow whenever a new version is declared to ensure `setup.sh --verify` passes cleanly.*
