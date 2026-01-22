# Python Developer Skill

---

name: Python Developer
description: Expert in Python development patterns, testing, and code quality for migasfree-client
---

## 🎯 Role Overview

As a Python Developer for migasfree-client, you maintain and extend this cross-platform systems management client. The codebase uses Python 3.6+ features while maintaining compatibility with older systems.

## 🏗️ Project Architecture

### Core Modules

| Module | Purpose |
|--------|---------|
| `__main__.py` | CLI entry point, argument parsing |
| `sync.py` | Main synchronization logic (`MigasFreeSync` class) |
| `command.py` | Command execution and subprocess handling |
| `url_request.py` | HTTP client with auth and retry logic |
| `mtls.py` | mTLS certificate management |
| `utils.py` | Shared utilities and helpers |
| `settings.py` | Configuration and constants |

### Plugin Architecture

**Package Management Systems** (`pms/`):

- Base class: `pms.py` - Abstract PMS interface
- Implementations: `apt.py`, `yum.py`, `dnf.py`, `zypper.py`, `pacman.py`, `apk.py`, `wpt.py`

**Device Management** (`devices/`):

- Base class: `__init__.py`
- Implementations: `printer.py`, `cupswrapper.py`

## 📐 Coding Standards

### Style Guide

- **Formatter**: Ruff with single quotes, 120 char line length
- **Linters**: ruff, flake8, mypy
- **Type hints**: Required for new code (see `pyproject.toml` mypy config)

### Code Conventions

```python
# Single quotes for strings
message = 'Hello, migasfree'

# Type hints on functions
def process_response(self, data: dict) -> Optional[str]:
    ...

# Docstrings for public methods
def sync_packages(self) -> bool:
    """
    Synchronize packages with the migasfree server.
    
    Returns:
        bool: True if synchronization succeeded.
    """
```

### Logging

```python
import logging
logger = logging.getLogger('migasfree_client')

# Use appropriate levels
logger.debug('Detailed info for debugging')
logger.info('Normal operational messages')
logger.warning('Something unexpected but recoverable')
logger.error('An error occurred: %s', error_message)
```

## 🧪 Testing

### Test Structure

```
tests/
├── conftest.py       # Shared fixtures
├── fixtures/         # Test data files
└── unit/             # Unit tests (test_*.py)
```

### Running Tests

```bash
# Install dev dependencies
pip install -e ".[dev]"

# Run all tests with coverage
pytest

# Run specific test file
pytest tests/unit/test_mtls.py -v

# Run with specific markers
pytest -m "not slow"
```

### Writing Tests

```python
import pytest
from migasfree_client.mtls import get_mtls_path

class TestMtlsPath:
    def test_returns_server_specific_path(self):
        result = get_mtls_path('server.example.com')
        assert 'server.example.com' in result
    
    @pytest.fixture
    def mock_config(self, mocker):
        return mocker.patch('migasfree_client.settings.MTLS_PATH')
```

### Mocking External Dependencies

```python
import responses

@responses.activate
def test_server_request(self):
    responses.add(
        responses.GET,
        'https://server/api/endpoint',
        json={'status': 'ok'},
        status=200
    )
    # Test code here
```

## 🔧 Development Workflow

### Setup Environment

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # Linux
# or: venv\Scripts\activate  # Windows

# Install in editable mode with dev deps
pip install -e ".[dev]"
```

### Quality Checks

```bash
# Lint with ruff
ruff check migasfree_client/

# Format with ruff
ruff format migasfree_client/

# Type check
mypy migasfree_client/
```

### Cross-Platform Considerations

- Use `os.path` or `pathlib` for paths
- Check `sys.platform` for platform-specific code
- Test on both Linux and Windows when modifying shared code

## 🛡️ Security and Privacy

### Secure Coding Practices

- Never log credentials or tokens
- Use `secrets` module for random tokens
- Validate all external input
- Use parameterized subprocess calls (lists, not shell strings)

### Handling Sensitive Data

```python
# Bad: Shell injection risk
os.system(f'command {user_input}')

# Good: Safe subprocess call
subprocess.run(['command', user_input], check=True)
```

## 📂 Resources

See the `resources/` directory for:

- `test_template.py` - Template for new test files
- `pms_plugin_template.py` - Template for new PMS plugins
