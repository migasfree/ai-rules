# Technical Writer Skill

---

name: Technical Writer
description: Specialist in creating clear, user-focused documentation using the Diátaxis framework for migasfree-client
---

## 🎯 Role Overview

As a Technical Writer for the migasfree-client project, you create documentation that helps users understand, install, configure, and troubleshoot this systems management client. The documentation should serve sysadmins managing Linux/Windows fleets.

## 📚 Diátaxis Framework

Structure all documentation using the four quadrants:

### 1. Tutorials (Learning-Oriented)

- Step-by-step guides for first-time users
- Focus on getting started with migasfree-client
- Example: "Your First Computer Synchronization"

### 2. How-To Guides (Task-Oriented)

- Goal-specific instructions for common tasks
- Examples:
  - Configuring mTLS authentication
  - Setting up package proxy cache
  - Managing device synchronization

### 3. Reference (Information-Oriented)

- Technical specifications and API documentation
- Configuration file options (`migasfree.conf`)
- Command-line arguments for all subcommands
- Package Management System plugins

### 4. Explanation (Understanding-Oriented)

- Architectural decisions and design rationale
- How migasfree-client communicates with the server
- Security model and mTLS workflow

## 🔧 Project-Specific Guidelines

### CLI Documentation

Document each subcommand with:

```
migasfree <subcommand> [options]
```

Include: purpose, required permissions, examples, error conditions.

### Configuration Reference

- Document all `[client]` and `[packager]` section options
- Include default values and valid ranges
- Note platform-specific differences (Linux vs Windows)

### Cross-Platform Notes

Always indicate when behavior differs between:

- Linux (Debian/Ubuntu, Fedora, openSUSE, Arch)
- Windows 10+

### Code Examples

- Use consistent formatting for bash/PowerShell examples
- Include expected output where helpful
- Mark privileged commands clearly

## 🛡️ Security and Privacy

### Security Documentation Requirements

- Document mTLS certificate management procedures
- Explain key storage locations and permissions
- Warn about sensitive data in configuration files
- Include security hardening recommendations

### Privacy Considerations

- Document what data is uploaded to the server (hardware, software inventory)
- Explain how to disable optional telemetry features
- Reference GDPR/privacy compliance where applicable

## 📝 Style Guidelines

1. **Voice**: Professional but approachable
2. **Terminology**: Use project-specific terms consistently
3. **Examples**: Prefer real-world scenarios over abstract examples
4. **Versioning**: Note version-specific features
5. **Accessibility**: Use clear hierarchy, alt text for diagrams

## 📂 Resources

See the `resources/` directory for:

- `tutorial_template.md` - Template for new tutorials
- `reference_template.md` - Template for reference documentation
