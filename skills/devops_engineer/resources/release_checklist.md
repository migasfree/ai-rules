# Release Checklist for migasfree-client

> **Version**: vX.X.X  
> **Release Date**: YYYY-MM-DD  
> **Release Manager**: [Name]

## Pre-Release

### Code Preparation

- [ ] All features for this release are merged to main/master
- [ ] All pending PRs are reviewed and merged or deferred
- [ ] No critical bugs open for this milestone
- [ ] CHANGELOG.md updated with all changes
- [ ] Version number updated in `migasfree_client/__init__.py`

### Quality Checks

- [ ] All CI checks passing on main branch
- [ ] Full test suite passes locally
- [ ] Coverage meets minimum threshold (e.g., 80%)
- [ ] No new security vulnerabilities (run `bandit`, `pip-audit`)
- [ ] Type checking passes (mypy)

### Documentation

- [ ] README.md is current
- [ ] API changes documented
- [ ] Migration guide if breaking changes
- [ ] Release notes drafted

## Build

### Source Distribution

- [ ] Clean build directory: `rm -rf dist/ build/`
- [ ] Build sdist: `python -m build --sdist`
- [ ] Verify tarball contents
- [ ] Test install from tarball: `pip install dist/*.tar.gz`

### Wheel

- [ ] Build wheel: `python -m build --wheel`
- [ ] Verify wheel contents: `unzip -l dist/*.whl`
- [ ] Test install from wheel: `pip install dist/*.whl`

### Platform Packages

#### Debian/Ubuntu

- [ ] stdeb.cfg updated if needed
- [ ] Build .deb: `python setup.py --command-packages=stdeb.command bdist_deb`
- [ ] Test installation on target Ubuntu/Debian versions
- [ ] Lintian check: `lintian *.deb`

#### RPM (Optional)

- [ ] Build RPM if applicable
- [ ] Test on target Fedora/openSUSE versions

#### Windows (Optional)

- [ ] Build Windows installer if applicable
- [ ] Test on Windows 10+

## Testing

### Installation Testing

- [ ] Clean install on Ubuntu LTS
- [ ] Upgrade from previous version
- [ ] Verify all commands work: `migasfree --help`
- [ ] Test basic sync workflow

### Regression Testing

- [ ] Critical user workflows verified
- [ ] Known issue workarounds still work

## Release

### Git

- [ ] Create annotated tag: `git tag -a vX.X.X -m "Version X.X.X"`
- [ ] Push tag: `git push origin vX.X.X`

### PyPI

- [ ] Verify package with twine: `twine check dist/*`
- [ ] Upload to TestPyPI first: `twine upload --repository testpypi dist/*`
- [ ] Install from TestPyPI and verify
- [ ] Upload to PyPI: `twine upload dist/*`

### GitHub Release

- [ ] Create GitHub Release from tag
- [ ] Attach build artifacts
- [ ] Copy release notes

### Distribution Packages

- [ ] Submit to appropriate repositories/PPAs
- [ ] Update download links in documentation

## Post-Release

### Verification

- [ ] Install from PyPI: `pip install migasfree-client`
- [ ] Verify version: `migasfree version`
- [ ] Smoke test sync operation

### Communication

- [ ] Announce on project channels (if any)
- [ ] Update documentation site
- [ ] Close release milestone on GitHub

### Cleanup

- [ ] Create next version milestone
- [ ] Update version to next dev version
- [ ] Archive old release branches if applicable

## Rollback Plan

If critical issues are discovered:

1. **Immediate**: Yank the release from PyPI

   ```bash
   pip install twine
   # Contact PyPI support or use project settings
   ```

2. **Hot Fix**:
   - Create hotfix branch from release tag
   - Fix issue with minimal changes
   - Release as vX.X.1

3. **Communication**:
   - Post issue on GitHub
   - Notify known affected users

## Sign-Off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Developer | | | |
| Reviewer | | | |
| Release Manager | | | |

---

*This checklist should be completed for each release.*
