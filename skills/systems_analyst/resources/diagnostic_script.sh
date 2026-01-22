#!/bin/bash
# migasfree-client Diagnostic Script
# Usage: sudo ./diagnostic_script.sh [server_url]
#
# Collects diagnostic information for troubleshooting migasfree-client issues.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
OUTPUT_FILE="migasfree_diagnostic_$(date +%Y%m%d_%H%M%S).txt"
CONFIG_FILE="/etc/migasfree.conf"
LOG_FILE="/var/log/migasfree.log"
MTLS_DIR="/var/migasfree-client/mtls"

# Functions
print_header() {
    echo ""
    echo "========================================"
    echo " $1"
    echo "========================================"
}

print_status() {
    echo -e "${GREEN}[OK]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

run_and_log() {
    echo "$ $1" >> "$OUTPUT_FILE"
    eval "$1" >> "$OUTPUT_FILE" 2>&1 || echo "(command failed)" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
}

# Start
echo "migasfree-client Diagnostic Tool"
echo "================================="
echo "Output will be saved to: $OUTPUT_FILE"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    print_error "Please run as root (sudo)"
    exit 1
fi

# Initialize output file
echo "migasfree-client Diagnostic Report" > "$OUTPUT_FILE"
echo "Generated: $(date)" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# 1. System Information
print_header "System Information"

echo "Hostname: $(hostname)"
run_and_log "hostname"
run_and_log "uname -a"
run_and_log "cat /etc/os-release"
run_and_log "python3 --version"

print_status "Collected system information"

# 2. migasfree-client Version
print_header "migasfree-client Version"

if command -v migasfree &> /dev/null; then
    run_and_log "migasfree version"
    print_status "migasfree-client is installed"
else
    print_error "migasfree command not found"
    echo "ERROR: migasfree command not found" >> "$OUTPUT_FILE"
fi

# 3. Configuration
print_header "Configuration"

if [ -f "$CONFIG_FILE" ]; then
    run_and_log "cat $CONFIG_FILE"
    print_status "Configuration file exists"
    
    # Extract server URL
    SERVER=$(grep -E "^Server\s*=" "$CONFIG_FILE" | cut -d'=' -f2 | tr -d ' ')
    if [ -n "$SERVER" ]; then
        echo "Server configured: $SERVER"
    else
        print_warning "No server configured"
    fi
else
    print_error "Configuration file not found: $CONFIG_FILE"
fi

# 4. mTLS Certificates
print_header "mTLS Certificates"

if [ -d "$MTLS_DIR" ]; then
    echo "mTLS directory contents:" >> "$OUTPUT_FILE"
    run_and_log "ls -la $MTLS_DIR/"
    
    # Check for certificates
    find "$MTLS_DIR" -name "*.pem" | while read cert; do
        echo "Certificate: $cert" >> "$OUTPUT_FILE"
        openssl x509 -in "$cert" -noout -subject -dates 2>/dev/null >> "$OUTPUT_FILE" || echo "  (not a certificate)" >> "$OUTPUT_FILE"
    done
    
    print_status "mTLS directory found"
else
    print_warning "mTLS directory not found: $MTLS_DIR"
fi

# 5. Network Connectivity
print_header "Network Connectivity"

# Get server from config or command line
if [ -n "$1" ]; then
    SERVER_URL="$1"
elif [ -n "$SERVER" ]; then
    PROTOCOL=$(grep -E "^Protocol\s*=" "$CONFIG_FILE" 2>/dev/null | cut -d'=' -f2 | tr -d ' ')
    PROTOCOL=${PROTOCOL:-http}
    SERVER_URL="${PROTOCOL}://${SERVER}"
else
    echo "No server URL provided. Skipping connectivity tests." >> "$OUTPUT_FILE"
    print_warning "No server URL available for connectivity test"
    SERVER_URL=""
fi

if [ -n "$SERVER_URL" ]; then
    echo "Testing connectivity to: $SERVER_URL"
    
    # DNS resolution
    echo "DNS Resolution:" >> "$OUTPUT_FILE"
    HOST=$(echo "$SERVER_URL" | sed -E 's|https?://([^:/]+).*|\1|')
    run_and_log "nslookup $HOST"
    
    # HTTP connectivity
    echo "HTTP Connectivity:" >> "$OUTPUT_FILE"
    run_and_log "curl -s -o /dev/null -w '%{http_code}' --connect-timeout 5 $SERVER_URL/api/v1/public/ || echo 'Failed'"
    
    # Certificate check
    echo "TLS Certificate:" >> "$OUTPUT_FILE"
    run_and_log "echo | openssl s_client -connect $HOST:443 -servername $HOST 2>/dev/null | openssl x509 -noout -dates"
fi

# 6. Package Manager Status
print_header "Package Manager"

if command -v apt &> /dev/null; then
    echo "Package Manager: APT" >> "$OUTPUT_FILE"
    run_and_log "apt-config dump | grep -i proxy"
    run_and_log "ls -la /etc/apt/sources.list.d/"
    run_and_log "grep -r migasfree /etc/apt/sources.list.d/ 2>/dev/null || echo 'No migasfree repos'"
    print_status "APT configuration collected"
elif command -v dnf &> /dev/null; then
    echo "Package Manager: DNF" >> "$OUTPUT_FILE"
    run_and_log "dnf config-manager --dump | grep -i proxy"
    run_and_log "ls -la /etc/yum.repos.d/"
    print_status "DNF configuration collected"
elif command -v yum &> /dev/null; then
    echo "Package Manager: YUM" >> "$OUTPUT_FILE"
    run_and_log "ls -la /etc/yum.repos.d/"
    print_status "YUM configuration collected"
fi

# 7. Recent Logs
print_header "Recent Logs"

if [ -f "$LOG_FILE" ]; then
    echo "Last 50 lines of $LOG_FILE:" >> "$OUTPUT_FILE"
    run_and_log "tail -n 50 $LOG_FILE"
    print_status "Log file collected"
else
    # Try journalctl
    echo "Journalctl output:" >> "$OUTPUT_FILE"
    run_and_log "journalctl -u migasfree --no-pager -n 50 2>/dev/null || echo 'No journal entries'"
fi

# 8. Hardware Info (brief)
print_header "Hardware Info"

run_and_log "dmidecode -s system-uuid 2>/dev/null || echo 'dmidecode not available'"
run_and_log "lshw -short 2>/dev/null || echo 'lshw not available'"

# 9. Running Processes
print_header "Running Processes"

run_and_log "ps aux | grep -i migasfree | grep -v grep"

# Summary
print_header "Summary"

echo ""
echo "Diagnostic collection complete!"
echo "Report saved to: $OUTPUT_FILE"
echo ""
echo "Next steps:"
echo "  1. Review the report for errors"
echo "  2. Check network connectivity if sync fails"
echo "  3. Verify mTLS certificates if authentication fails"
echo "  4. Send $OUTPUT_FILE to support if needed"
