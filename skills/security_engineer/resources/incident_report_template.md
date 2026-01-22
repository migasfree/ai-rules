# Security Incident Report

> **Incident ID**: SEC-YYYY-MM-DD-XXX  
> **Date Discovered**: YYYY-MM-DD HH:MM  
> **Reported By**: [Name/Email]  
> **Severity**: ⚠️ Critical | 🔴 High | 🟠 Medium | 🟡 Low

## Executive Summary

*Brief, non-technical description of the security issue and its potential impact.*

## Incident Classification

| Field | Value |
|-------|-------|
| **Type** | Vulnerability / Breach / Misconfiguration / Dependency |
| **Attack Vector** | Network / Local / Physical / Social |
| **Affected Component** | e.g., `mtls.py`, `sync.py`, configuration |
| **Affected Versions** | e.g., v4.x - v5.0 |
| **CVE (if assigned)** | CVE-YYYY-XXXXX |

## Technical Details

### Vulnerability Description

*Detailed technical explanation of the vulnerability.*

### Root Cause

*What led to this vulnerability existing in the code.*

### Proof of Concept

```bash
# Steps to reproduce (sanitized, no exploitation details in public reports)
```

### Impact Analysis

**Confidentiality**: [None/Low/Medium/High]

- What data could be exposed?

**Integrity**: [None/Low/Medium/High]

- What could be modified?

**Availability**: [None/Low/Medium/High]

- Could this cause denial of service?

**Scope**: [Unchanged/Changed]

- Does this affect other systems?

## Affected Systems

| System Type | Estimated Count | Risk Level |
|-------------|-----------------|------------|
| Production clients | X,XXX | High |
| Test environments | XXX | Medium |
| Development machines | XX | Low |

## Timeline

| Date | Time | Event |
|------|------|-------|
| YYYY-MM-DD | HH:MM | Vulnerability discovered by [who] |
| YYYY-MM-DD | HH:MM | Initial triage completed |
| YYYY-MM-DD | HH:MM | Fix developed |
| YYYY-MM-DD | HH:MM | Fix deployed |
| YYYY-MM-DD | HH:MM | Incident closed |

## Remediation

### Immediate Mitigation

*Steps to reduce risk before a fix is available.*

```bash
# Emergency mitigation commands if applicable
```

### Permanent Fix

**PR/Commit Reference**: [Link to PR]

*Description of the code changes that fix the issue.*

```diff
- vulnerable_code()
+ secure_code()
```

### Verification

*How to verify the fix is effective.*

```bash
# Verification commands
```

## Lessons Learned

### What Went Well

-

### What Could Be Improved

-

### Action Items

| Action | Owner | Due Date | Status |
|--------|-------|----------|--------|
| Add unit test for this case | @developer | YYYY-MM-DD | Pending |
| Update security checklist | @security | YYYY-MM-DD | Pending |
| Review similar code patterns | @team | YYYY-MM-DD | Pending |

## Communication

### Internal Notification

- [ ] Development team notified
- [ ] Maintainers notified
- [ ] Stakeholders briefed

### External Disclosure

- [ ] Security advisory drafted
- [ ] CVE requested (if applicable)
- [ ] Public disclosure date: YYYY-MM-DD

## Appendix

### Related Findings

- [Link to related security issues]

### References

- [Link to relevant documentation]
- [Link to security standards/guidelines]

---

*This report is [CONFIDENTIAL/PUBLIC] - handle according to disclosure policy.*
