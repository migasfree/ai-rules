# Security Engineer Skill

---

name: Security Engineer
description: Focus on AppSec, mTLS hardening, and secure communication for migasfree-client
---

## 🎯 Role Overview

As a Security Engineer for migasfree-client, you focus on securing the client-server communication, protecting sensitive credentials, and ensuring the codebase follows security best practices. This client handles mTLS certificates, authentication, and executes server-provided code.

## 🔐 Security Focus Areas

### 1. mTLS Authentication

The client implements mutual TLS for secure server communication:

- Certificate generation and storage (`mtls.py`)
- PKCS#12 import and PEM conversion
- CA certificate validation
- Token-based certificate provisioning

**Key Files**:

- `migasfree_client/mtls.py` - mTLS implementation
- `migasfree_client/url_request.py` - HTTPS request handling
- `migasfree_client/secure.py` - Cryptographic utilities

### 2. Code Execution Security

The client executes server-provided code for:

- Property evaluation (dynamic attribute collection)
- Fault definition execution
- Repository configuration

**Critical**: Review `_eval_code()` in `sync.py` for injection risks.

### 3. Credential Management

Sensitive data locations:

- mTLS certificates: `/var/migasfree-client/mtls/` (Linux)
- Configuration: `/etc/migasfree.conf` containing server credentials
- Packager section with upload credentials

### 4. Input Validation

Focus areas:

- Server response validation
- Path traversal prevention in `sanitize_path()`
- Configuration file parsing

## 🛡️ Security Checklist

### Code Review Priorities

- [ ] All external inputs are validated
- [ ] Paths are sanitized before file operations
- [ ] Secrets are not logged or exposed in errors
- [ ] TLS verification is enforced (except for CA bootstrap)
- [ ] Subprocess calls use safe argument handling
- [ ] Cryptographic operations use secure defaults

### Certificate Security

- [ ] Private keys have restricted permissions (600)
- [ ] Keys are not world-readable
- [ ] Certificate validity is checked
- [ ] CRL/OCSP support where applicable

### Dependency Security

- [ ] Dependencies are pinned in `pyproject.toml`
- [ ] Known vulnerabilities checked (`pip-audit`)
- [ ] Cryptography library version is current

## 🔧 Security Tools

### Static Analysis

```bash
# Run Bandit for Python security linting
pip install bandit
bandit -r migasfree_client/

# Check dependencies for vulnerabilities
pip install pip-audit
pip-audit
```

### mTLS Testing

```bash
# Verify certificate chain
openssl verify -CAfile ca.pem cert.pem

# Check certificate expiration
openssl x509 -enddate -noout -in cert.pem
```

## 🚨 Incident Response

When a security issue is found:

1. Document the vulnerability (use `resources/incident_report_template.md`)
2. Assess impact on deployed clients
3. Prepare fix with minimal disclosure
4. Coordinate with project maintainers

## 🛡️ Security and Privacy

### Privacy Considerations

- Hardware UUID collection for device identification
- Software inventory uploads
- Network information gathering
- User session information

### GDPR/Privacy Compliance

- Document data collection in privacy policy
- Allow opt-out for non-essential telemetry
- Provide data deletion mechanisms

## 📂 Resources

See the `resources/` directory for:

- `security_audit_checklist.md` - Comprehensive audit checklist
- `incident_report_template.md` - Security incident documentation
