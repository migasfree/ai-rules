# Systems Analyst Skill

---

name: Systems Analyst
description: System architecture analysis, integration patterns, and troubleshooting for migasfree deployments
---

## 🎯 Role Overview

As a Systems Analyst for migasfree-client, you analyze client-server interactions, diagnose integration issues, design deployment architectures, and ensure the client works correctly across diverse IT environments.

## 🏗️ System Architecture

### Component Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                        Managed Computer                         │
│  ┌─────────────┐  ┌──────────────┐  ┌────────────────────────┐ │
│  │ migasfree   │  │ Package      │  │ Device Drivers          │ │
│  │ client      │──│ Manager      │  │ (CUPS, etc.)            │ │
│  │             │  │ (apt/yum/..) │  │                         │ │
│  └──────┬──────┘  └──────────────┘  └────────────────────────┘ │
│         │ HTTPS/mTLS                                            │
└─────────┼───────────────────────────────────────────────────────┘
          │
          ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Network Layer                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐  │
│  │ Proxy Server │  │ Package Cache│  │ Firewall             │  │
│  │ (optional)   │  │ (apt-cacher) │  │                      │  │
│  └──────────────┘  └──────────────┘  └──────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
          │
          ▼
┌─────────────────────────────────────────────────────────────────┐
│                     migasfree Server                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐  │
│  │ Web API      │  │ Package      │  │ Database              │  │
│  │              │  │ Repository   │  │ (PostgreSQL)          │  │
│  └──────────────┘  └──────────────┘  └──────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

### Communication Flow

1. **Registration**: Client requests mTLS token → Server issues certificate
2. **Synchronization**:
   - Client sends attributes (hardware UUID, user, etc.)
   - Server responds with repositories, packages, faults to check
   - Client configures package manager, installs/removes packages
   - Client reports results back to server

### Key Integration Points

| Component | Protocol | Purpose |
|-----------|----------|---------|
| migasfree server | HTTPS + mTLS | API communication |
| Package repository | HTTP/HTTPS | Package downloads |
| CUPS | Local D-Bus/CUPS API | Printer management |
| Hardware (lshw) | Local subprocess | Hardware inventory |
| dmidecode | Local subprocess | UUID extraction |

## 🔧 Configuration Analysis

### Configuration Hierarchy

```
1. Environment variables (MIGASFREE_*)
   ↓ (overrides)
2. Command-line arguments
   ↓ (overrides)
3. Configuration file (/etc/migasfree.conf)
   ↓ (overrides)
4. Built-in defaults (settings.py)
```

### Critical Settings

| Setting | Impact | Troubleshooting |
|---------|--------|-----------------|
| `Server` | Which server to connect to | DNS resolution, firewall |
| `Protocol` | http/https | Certificate issues if https |
| `Project` | Which packages to receive | Wrong packages if mismatch |
| `Auto_Update_Packages` | Whether to upgrade | Missing updates if False |
| `Debug` | Verbose logging | Enable for troubleshooting |

### Platform Differences

| Aspect | Linux | Windows |
|--------|-------|---------|
| Config path | `/etc/migasfree.conf` | `%PROGRAMDATA%\migasfree-client\migasfree.conf` |
| Key storage | `/var/migasfree-client/` | `%PROGRAMDATA%\migasfree-client\` |
| Package manager | apt, yum, etc. | wpt (Windows Package Tool) |
| Service mode | systemd timer | Windows Task Scheduler |

## 🔍 Diagnostic Procedures

### Connectivity Testing

```bash
# Check DNS resolution
nslookup migasfree-server.example.com

# Check HTTPS connectivity
curl -v https://migasfree-server.example.com/api/v1/public/

# Check with mTLS
curl --cert cert.pem --key key.pem --cacert ca.pem \
     https://migasfree-server.example.com/api/v1/
```

### Client Diagnostics

```bash
# Enable debug mode
migasfree sync -d

# Check version and configuration
migasfree version

# Test server connectivity
migasfree info

# View current computer attributes
migasfree traits
```

### Log Analysis

**Linux**: `/var/log/migasfree.log` or systemd journal  
**Windows**: Event Viewer or log file location

Key log patterns:

- `ERROR` - Critical failures
- `WARNING` - Potential issues
- Connection timeouts - Network issues
- Certificate errors - mTLS problems

## 📊 Performance Analysis

### Sync Time Factors

| Factor | Impact | Mitigation |
|--------|--------|------------|
| Network latency | Slow API calls | Local cache proxy |
| Package size | Slow downloads | Package proxy (apt-cacher) |
| Hardware inventory | Slow lshw | Adjust capture frequency |
| Repository update | apt update time | Mirror configuration |

### Optimization Recommendations

1. **Package Proxy Cache**: Deploy apt-cacher-ng for large deployments
2. **mTLS Session Caching**: Reduce TLS handshake overhead
3. **Selective Sync**: Use flags to sync only needed data

## 🚨 Common Issues

### Connection Problems

| Symptom | Possible Cause | Resolution |
|---------|---------------|------------|
| "Connection refused" | Server down, wrong port | Check server status, port |
| "SSL certificate verify failed" | CA not trusted | Import CA certificate |
| "401 Unauthorized" | Invalid credentials | Re-register computer |
| Timeout | Firewall, proxy | Check network path |

### Package Management Issues

| Symptom | Possible Cause | Resolution |
|---------|---------------|------------|
| "Package not found" | Repository misconfigured | Check repo URLs |
| Dependency errors | Conflicting packages | Clean apt cache, force |
| Lock file errors | Another process running | Wait or kill |

### Certificate Issues

| Symptom | Possible Cause | Resolution |
|---------|---------------|------------|
| "Certificate expired" | mTLS cert expired | Re-register |
| "Certificate not yet valid" | Clock skew | Sync NTP |
| "Unable to verify" | Missing CA cert | Download CA from server |

## 🛡️ Security and Privacy

### Security Assessment Areas

- Network security (firewall rules, proxy configs)
- Certificate lifecycle management
- Access control for config files
- Audit logging requirements

### Compliance Considerations

- Data retention policies for inventory data
- Access logging for regulatory compliance
- Encryption requirements for data in transit

## 📂 Resources

See the `resources/` directory for:

- `diagnostic_script.sh` - Automated diagnostic script
- `deployment_diagram.md` - Deployment architecture templates
