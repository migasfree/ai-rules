# Security Audit Checklist for migasfree-client

> **Last Updated**: YYYY-MM-DD  
> **Auditor**: [Name]  
> **Version Audited**: vX.X.X

## 1. Authentication & Authorization

### mTLS Implementation

- [ ] Certificate validation is enforced
- [ ] Private key permissions are 600 (owner read/write only)
- [ ] CA certificate is verified before trusting
- [ ] Certificate expiration is checked
- [ ] Token-based provisioning uses secure transport

### Server Communication

- [ ] HTTPS is enforced for all server requests
- [ ] TLS 1.2+ is required (no SSLv3, TLS 1.0/1.1)
- [ ] Certificate pinning considered for high-security deployments
- [ ] Server certificate validation enabled (`verify=True`)

**Exception Review**: Note any intentional `verify=False` usage:

- CA bootstrap download (expected - chicken/egg problem)
- Others: [List and justify]

## 2. Input Validation

### User Input

- [ ] CLI arguments are validated before processing
- [ ] Configuration file values are type-checked
- [ ] File paths are sanitized against traversal attacks
- [ ] Environment variables are sanitized

### Server Responses

- [ ] JSON responses are properly parsed with error handling
- [ ] Binary data is validated before processing
- [ ] File sizes are limited to prevent DoS
- [ ] Character encoding is handled safely

## 3. Code Execution

### Dynamic Code Evaluation

- [ ] `_eval_code()` execution is sandboxed/controlled
- [ ] Server-provided scripts are validated
- [ ] Execution environment is restricted
- [ ] Error output doesn't leak sensitive information

### Subprocess Execution

- [ ] Shell injection is prevented (use lists, not strings)
- [ ] PATH is controlled/validated
- [ ] Timeouts prevent hanging commands
- [ ] Return codes are properly checked

## 4. Cryptography

### Key Management

- [ ] Private keys are stored securely
- [ ] Keys are never logged or exposed in errors
- [ ] Key rotation procedures are documented
- [ ] Old keys are securely deleted

### Cryptographic Operations

- [ ] Using `cryptography` library (not deprecated `pycrypto`)
- [ ] Secure random number generator for tokens
- [ ] Strong hash algorithms (SHA-256+)
- [ ] Proper password handling (no plaintext storage)

## 5. Data Protection

### Sensitive Data

- [ ] Credentials not logged in debug mode
- [ ] Stack traces sanitized before upload
- [ ] Hardware UUIDs treated as PII
- [ ] Configuration files have restricted permissions

### File Operations

- [ ] Temporary files created securely
- [ ] Atomic writes for critical files
- [ ] Proper cleanup of sensitive temp files
- [ ] Safe file permissions on creation

## 6. Platform-Specific Security

### Linux

- [ ] Runs with minimal privileges
- [ ] Systemd service uses security hardening
- [ ] SELinux/AppArmor profiles available
- [ ] Log files have appropriate permissions

### Windows

- [ ] Uses Windows credential store where appropriate
- [ ] Registry access is properly secured
- [ ] Service runs with minimal privileges
- [ ] PowerShell execution policy respected

## 7. Dependencies

### Dependency Analysis

- [ ] All dependencies audited with `pip-audit`
- [ ] Versions pinned in `pyproject.toml`
- [ ] No known CVEs in dependencies
- [ ] Transitive dependencies reviewed

### Supply Chain

- [ ] Dependencies from trusted sources only
- [ ] Package integrity verified (hashes)
- [ ] Dependency update process documented

## 8. Logging & Monitoring

### Security Logging

- [ ] Authentication events logged
- [ ] Failed operations logged
- [ ] Sensitive data NOT in logs
- [ ] Log rotation configured

### Error Handling

- [ ] Exceptions don't leak stack traces to server
- [ ] Error messages don't reveal system information
- [ ] Graceful degradation on failures

## 9. Network Security

### Request Handling

- [ ] Timeouts configured on all requests
- [ ] Redirect following is limited
- [ ] Proxy settings respected
- [ ] DNS resolution uses system resolver

### DoS Prevention

- [ ] Large response limits
- [ ] Rate limiting awareness
- [ ] Resource cleanup on errors

## Findings Summary

| Finding ID | Severity | Component | Description | Status |
|------------|----------|-----------|-------------|--------|
| SEC-001 | High/Med/Low | module.py | Description | Open/Resolved |

## Recommendations

### Immediate Actions

1. [High priority findings to address]

### Short-term Improvements

1. [Medium priority improvements]

### Long-term Security Roadmap

1. [Strategic security improvements]

---

*This checklist should be reviewed and updated for each major release.*
