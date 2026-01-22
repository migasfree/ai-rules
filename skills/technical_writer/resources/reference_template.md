# Reference: [Component/Feature Name]

> **Type**: Command | Configuration | API | Module  
> **Since**: vX.X.X  
> **Platforms**: Linux, Windows

## Overview

Brief technical description of this component and its purpose.

## Synopsis

```bash
migasfree <command> [OPTIONS] [ARGUMENTS]
```

## Options

| Option | Short | Default | Description |
|--------|-------|---------|-------------|
| `--option-name` | `-o` | `value` | What the option does |
| `--flag` | `-f` | `false` | Boolean flag description |
| `--required` | `-r` | *(required)* | Required option description |

## Arguments

| Argument | Type | Required | Description |
|----------|------|----------|-------------|
| `PATTERN` | string | Yes | Description of the argument |
| `FILE` | path | No | Optional file path |

## Configuration

Related settings in `migasfree.conf`:

```ini
[section]
# Description of option
Option_Name = default_value

# Another option with constraints
Other_Option = value  # Valid: option1, option2, option3
```

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Option_Name` | string | `default` | Detailed description |
| `Other_Option` | boolean | `True` | What this enables/disables |

## Return Values / Exit Codes

| Code | Meaning |
|------|---------|
| `0` | Success |
| `1` | General error |
| `2` | Configuration error |

## Files

| Path | Platform | Description |
|------|----------|-------------|
| `/etc/migasfree.conf` | Linux | Main configuration file |
| `%PROGRAMDATA%\migasfree-client\migasfree.conf` | Windows | Main configuration file |

## Examples

### Basic Usage

```bash
# Description of what this example does
migasfree <command>
```

### With Options

```bash
# More complex example with options
migasfree <command> --option value --flag
```

**Output**:

```
Expected output here
```

### Advanced Usage

```bash
# Example for advanced use case
migasfree <command> --complex-option "value with spaces"
```

## Environment Variables

| Variable | Description |
|----------|-------------|
| `MIGASFREE_CONF` | Override configuration file path |
| `MIGASFREE_SERVER` | Override server URL |

## Related

- [`migasfree sync`](./sync.md) - Related command
- [Configuration Guide](../howto/configuration.md) - How-to guide
- [mTLS Setup](../tutorials/mtls-setup.md) - Tutorial

## Notes

⚠️ **Warning**: Important warning about this feature.

💡 **Tip**: Helpful tip for using this feature.

---

*Applies to migasfree-client vX.X+*
