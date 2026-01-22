# DevOps Engineer Skill

---

name: DevOps Engineer
description: CI/CD, packaging, deployment automation, and infrastructure for migasfree-client
---

## 🎯 Role Overview

As a DevOps Engineer for migasfree-client, you manage the build pipeline, packaging for multiple distributions, testing automation, and deployment processes. This client needs to be packaged for Debian, Red Hat, Arch, and Windows platforms.

## 🏗️ Build System

### Project Configuration

The project uses `pyproject.toml` (PEP 517/518) with setuptools:

```toml
[build-system]
requires = ["setuptools"]
build-backend = "setuptools.build_meta"
```

### Key Build Files

| File | Purpose |
|------|---------|
| `pyproject.toml` | Main project config, dependencies, tools |
| `setup.py` | Legacy setup script (still used by some tools) |
| `setup.cfg.d/` | Distribution-specific setup configs |
| `stdeb.cfg` | Debian package config for stdeb |
| `stdeb.cfg.d/` | Distribution-specific stdeb configs |
| `MANIFEST.in` | Source distribution file inclusion |

### Building from Source

```bash
# Create source distribution
python -m build --sdist

# Create wheel
python -m build --wheel

# Build using setup.py directly
python setup.py sdist bdist_wheel
```

## 📦 Packaging

### Debian/Ubuntu Packages (.deb)

Using `stdeb`:

```bash
# Install stdeb
pip install stdeb

# Create Debian source package
python setup.py --command-packages=stdeb.command sdist_dsc

# Build the .deb
cd deb_dist/migasfree-client-*/
dpkg-buildpackage -rfakeroot -uc -us
```

Configuration in `stdeb.cfg`:

- Depends: System dependencies
- Build-Depends: Build-time dependencies
- X-Python3-Version: Python version constraints

### RPM Packages (Fedora/openSUSE)

```bash
# Using setuptools-rpm
python setup.py bdist_rpm

# Or using fpm
fpm -s python -t rpm .
```

### Windows Packages

```powershell
# Create Windows installer with PyInstaller
pip install pyinstaller
pyinstaller --onefile migasfree_client/__main__.py

# Or create MSI with cx_Freeze
# Requires proper .spec configuration
```

## 🔄 CI/CD Pipeline

### GitHub Actions Structure

```yaml
# .github/workflows/test.yml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ['3.8', '3.9', '3.10', '3.11', '3.12']
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
      - run: pip install -e ".[dev]"
      - run: pytest
```

### Multi-Platform Testing

```yaml
jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        python-version: ['3.8', '3.12']
    runs-on: ${{ matrix.os }}
```

### Release Workflow

```yaml
# .github/workflows/release.yml
name: Release
on:
  push:
    tags: ['v*']
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: python -m build
      - uses: pypa/gh-action-pypi-publish@release/v1
        with:
          password: ${{ secrets.PYPI_API_TOKEN }}
```

## 🔧 Environment Management

### Docker Development Environment

```dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY pyproject.toml .
RUN pip install -e ".[dev]"
COPY . .
CMD ["pytest"]
```

### Testing Container

```bash
# Build test image
docker build -t migasfree-client-test .

# Run tests in container
docker run --rm migasfree-client-test
```

## 📊 Quality Gates

### Pre-commit Hooks

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.1.0
    hooks:
      - id: ruff
      - id: ruff-format
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.0.0
    hooks:
      - id: mypy
```

### Quality Checks

```bash
# Lint check
ruff check migasfree_client/

# Format check
ruff format --check migasfree_client/

# Type check
mypy migasfree_client/

# Security scan
bandit -r migasfree_client/

# Dependency audit
pip-audit
```

## 🛡️ Security and Privacy

### Secrets Management

- Never commit credentials to repository
- Use GitHub Secrets for CI/CD tokens
- Use environment variables for local development

### Build Provenance

- Sign release artifacts where possible
- Use SBOM generation for supply chain security
- Verify dependencies with checksums

## 📂 Resources

See the `resources/` directory for:

- `github_ci_template.yml` - CI workflow template
- `release_checklist.md` - Release process checklist
