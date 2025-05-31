#!/bin/bash

# Enhanced Security Alert Dashboard
# Displays comprehensive security status at session start

echo -e "\n🔒 \033[1;36mSECURITY STATUS DASHBOARD\033[0m 🔒"
echo "=========================================="

# Check for system load anomalies
LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | tr -d ' ')
if (( $(echo "$LOAD > 2.0" | bc -l 2>/dev/null || echo "0") )); then
    echo "⚠️  HIGH SYSTEM LOAD: $LOAD"
fi

# Check for failed login attempts
FAILED_LOGINS=$(sudo grep "Failed password" /var/log/auth.log 2>/dev/null | tail -10 | wc -l)
if [ "$FAILED_LOGINS" -gt 0 ]; then
    echo "🚨 RECENT FAILED LOGINS: $FAILED_LOGINS in last 10 attempts"
fi

# Check for successful SSH logins
SSH_LOGINS=$(sudo grep "Accepted" /var/log/auth.log 2>/dev/null | tail -5 | wc -l)
if [ "$SSH_LOGINS" -gt 0 ]; then
    echo "🔑 RECENT SSH LOGINS: $SSH_LOGINS successful"
    LAST_SSH=$(sudo grep "Accepted" /var/log/auth.log 2>/dev/null | tail -1 | awk '{print $1, $2, $3, "from", $11}')
    echo "   Last: $LAST_SSH"
fi

# Check for sudo usage
SUDO_USAGE=$(sudo grep "sudo:" /var/log/auth.log 2>/dev/null | grep -v "pam_unix" | tail -5 | wc -l)
if [ "$SUDO_USAGE" -gt 0 ]; then
    echo "⚡ RECENT SUDO COMMANDS: $SUDO_USAGE"
fi

# Quick port scan of localhost
OPEN_PORTS=$(ss -tlnp 2>/dev/null | grep LISTEN | wc -l)
echo "🌐 LISTENING PORTS: $OPEN_PORTS"

# Check for new/unusual listening ports
UNUSUAL_PORTS=$(ss -tlnp 2>/dev/null | grep LISTEN | grep -vE "(:22|:53|:80|:443|:3306|:5432)" | wc -l)
if [ "$UNUSUAL_PORTS" -gt 0 ]; then
    echo "⚠️  UNUSUAL PORTS DETECTED: $UNUSUAL_PORTS"
    ss -tlnp 2>/dev/null | grep LISTEN | grep -vE "(:22|:53|:80|:443|:3306|:5432)" | head -3
fi

# Check active network connections
ESTABLISHED=$(ss -tnp 2>/dev/null | grep ESTAB | wc -l)
echo "🔗 ACTIVE CONNECTIONS: $ESTABLISHED"

# Check for modified system files in last 24h
MODIFIED_SYSTEM=$(sudo find /etc /bin /sbin /usr/bin /usr/sbin -type f -mtime -1 2>/dev/null | wc -l)
if [ "$MODIFIED_SYSTEM" -gt 0 ]; then
    echo "📝 SYSTEM FILES MODIFIED (24h): $MODIFIED_SYSTEM"
fi

# Check for users logged in
USERS_LOGGED=$(who | wc -l)
echo "👥 USERS LOGGED IN: $USERS_LOGGED"
if [ "$USERS_LOGGED" -gt 0 ]; then
    who | awk '{print "   -", $1, "from", $5}' | head -3
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

# Check for suspicious processes
SUSPICIOUS=$(ps aux | grep -E "(nc |ncat |socat |/tmp/|curl.*sh|wget.*sh)" | grep -v grep | grep -v systemd | wc -l)
if [ "$SUSPICIOUS" -gt 0 ]; then
    echo "⚠️  SUSPICIOUS PROCESSES: $SUSPICIOUS"
fi

# Check if critical security services are running
if ! systemctl is-active --quiet fail2ban 2>/dev/null; then
    echo "🚨 FAIL2BAN NOT RUNNING!"
fi

if ! systemctl is-active --quiet ufw 2>/dev/null && ! systemctl is-active --quiet firewalld 2>/dev/null; then
    echo "🚨 NO FIREWALL ACTIVE!"
fi

# Check for world-writable directories
WORLD_WRITABLE=$(find /tmp /var/tmp /dev/shm -type d -perm -0002 2>/dev/null | grep -v "^/tmp$" | grep -v "^/var/tmp$" | grep -v "^/dev/shm$" | wc -l)
if [ "$WORLD_WRITABLE" -gt 0 ]; then
    echo "⚠️  WORLD-WRITABLE DIRS: $WORLD_WRITABLE"
fi

# Check package updates
UPDATES=$(apt list --upgradable 2>/dev/null | grep -c "upgradable" || echo "0")
if [ "$UPDATES" -gt 0 ]; then
    echo "📦 SECURITY UPDATES AVAILABLE: $UPDATES packages"
fi

echo "=========================================="
echo "Last scan: $(date)"
echo -e "Run 'security-scan' for full analysis\n"