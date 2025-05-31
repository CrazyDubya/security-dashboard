#!/bin/bash

# Security Alert Dashboard
# Displays security status at session start
# Generic version for public use

echo -e "\n🔒 \033[1;36mSECURITY STATUS DASHBOARD\033[0m 🔒"
echo "=========================================="

# Check for system load anomalies
LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | tr -d ' ')
if (( $(echo "$LOAD > 2.0" | bc -l 2>/dev/null || echo "0") )); then
    echo "⚠️  HIGH SYSTEM LOAD: $LOAD"
fi

# Check for failed login attempts
FAILED_LOGINS=$(sudo grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5 | wc -l)
if [ "$FAILED_LOGINS" -gt 0 ]; then
    echo "🚨 RECENT FAILED LOGINS: $FAILED_LOGINS in last 5 attempts"
fi

# Check for root logins
ROOT_LOGINS=$(sudo grep "session opened for user root" /var/log/auth.log 2>/dev/null | tail -1)
if [ -n "$ROOT_LOGINS" ]; then
    echo "👤 RECENT ROOT ACCESS: $(echo $ROOT_LOGINS | awk '{print $1, $2, $3}')"
fi

# Quick port scan of localhost (requires nmap)
if command -v nmap >/dev/null 2>&1; then
    OPEN_PORTS=$(nmap -sT -O localhost 2>/dev/null | grep "^[0-9]" | wc -l)
    echo "🌐 OPEN PORTS: $OPEN_PORTS"
else
    echo "🌐 NMAP NOT INSTALLED - Cannot check open ports"
fi

# Check disk usage
DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -gt 80 ]; then
    echo "💾 DISK WARNING: ${DISK_USAGE}% full"
fi

# Check memory usage
MEM_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100.0}')
if [ "$MEM_USAGE" -gt 80 ]; then
    echo "🧠 MEMORY WARNING: ${MEM_USAGE}% used"
fi

# Check for suspicious processes (exclude system processes)
SUSPICIOUS=$(ps aux | grep -E "(nc|ncat|socat)" | grep -v grep | grep -v systemd | grep -v lxc | wc -l)
if [ "$SUSPICIOUS" -gt 0 ]; then
    echo "⚠️  SUSPICIOUS NETWORK TOOLS RUNNING: $SUSPICIOUS"
fi

echo "=========================================="
echo "Last security scan: $(date)"
echo -e "Run './security-scan.sh' for full analysis\n"