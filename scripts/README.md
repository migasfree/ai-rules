# Automation Scripts

This directory contains maintenance and automation scripts for the `ai-rules` repository.

## 📋 Available Scripts

### `sync_skills_catalog.sh`

**Purpose**: Automatically synchronizes the skills catalog in the `skill_generate.md` workflow with the actual skills available in the repository.

**Usage**:

```bash
# Apply changes
./scripts/sync_skills_catalog.sh

# Preview without applying changes (dry-run)
./scripts/sync_skills_catalog.sh --dry-run
```

**When to run**:

- ✅ After adding a new skill to `skills/`
- ✅ After renaming an existing skill
- ✅ After deleting a skill
- ✅ Before making a pull request that modifies skills
- ✅ As part of your commit process (see pre-commit hook)

**What it does**:

1. Scans the `skills/languages/`, `skills/frameworks/`, and `skills/disciplines/` folders
2. Detects `.md` files and directories with `SKILL.md`
3. Generates the updated markdown catalog table
4. Automatically updates `global_workflows/skill_generate.md`

**Example output**:

```text
📊 Scanning skills directory structure...
✓ Languages:   `bash-expert`, `go-expert`, `python-expert`
✓ Frameworks:  `celery-expert`, `django-expert`, `docker-expert`, ...
✓ Disciplines: `ai-prompt-expert`, `cicd-expert`, `docs-expert`, ...

✅ Successfully updated /path/to/global_workflows/skill_generate.md
```

## 🔧 Git Integration

### Pre-commit Hook (Recommended)

To run automatically before each commit:

```bash
# Create the pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
# Auto-sync skills catalog before commit

if git diff --cached --name-only | grep -q "^skills/"; then
    echo "🔄 Skills modified, syncing catalog..."
    ./scripts/sync_skills_catalog.sh
    
    # If there were changes, add them to the commit
    if git diff --name-only | grep -q "global_workflows/skill_generate.md"; then
        git add global_workflows/skill_generate.md
        echo "✅ Catalog updated and staged"
    fi
fi
EOF

# Make it executable
chmod +x .git/hooks/pre-commit
```

### CI/CD Validation ✅

**Already implemented** in `.github/workflows/quality-gates.yml`

The workflow runs automatically on every push and pull request:

```yaml
- name: Validate Skills Catalog Sync
  run: |
    ./scripts/sync_skills_catalog.sh
    if git diff --exit-code global_workflows/skill_generate.md; then
      echo "✅ Skills catalog is up to date!"
    else
      echo "❌ ERROR: Skills catalog is out of sync!"
      exit 1
    fi
```

**What it does**:

- ✅ Runs automatically on every PR and push to `main`
- ✅ Blocks merging if the catalog is out of sync
- ✅ Shows the exact diff of what needs to be updated
- ✅ Provides clear instructions to resolve the issue

## 📝 Notes

- The script automatically ignores `README.md` files in skill folders
- Supports both individual `.md` files and directories with `SKILL.md`
- Maintains alphabetical order automatically
- Is idempotent: running it multiple times produces the same result

## 🐛 Troubleshooting

**The script doesn't find skills**:

- Verify that you're in the repository root directory
- Confirm that `skills/` exists and has the correct structure

**Error "Could not find the catalog table"**:

- The script looks for a table that starts with `| Category |`
- Verify that `global_workflows/skill_generate.md` hasn't been manually modified in an incompatible way
