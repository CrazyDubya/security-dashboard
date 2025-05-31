#!/bin/bash

# Enhanced Comprehensive Security Scan Script
echo "🔍 Starting comprehensive security scan..."
echo "=========================================="

# 1. Check for rootkits
echo -e "\n1️⃣ ROOTKIT DETECTION"
if command -v rkhunter >/dev/null 2>&1; then
    echo "Running Rootkit Hunter..."
    sudo rkhunter --check --sk --nocolors | grep -E "(Warning|Found|INFECTED)" || echo "✅ No rootkits detected"
else
    echo "❌ rkhunter not installed"
fi

if command -v chkrootkit >/dev/null 2>&1; then
    echo "Running chkrootkit..."
    sudo chkrootkit | grep -E "(INFECTED|suspicious|Warning)" | grep -v "not infected" || echo "✅ No rootkits detected"
else
    echo "❌ chkrootkit not installed"
fi

# 2. System integrity check
echo -e "\n2️⃣ SYSTEM INTEGRITY"
echo "SUID/SGID files:"
sudo find / -type f \( -perm -4000 -o -perm -2000 \) -exec ls -la {} \; 2>/dev/null | wc -l | xargs echo "Total SUID/SGID files:"

echo "Recently modified system files (24h):"
sudo find /etc /bin /sbin /usr/bin /usr/sbin -type f -mtime -1 -ls 2>/dev/null | head -10

# 3. Network security audit
echo -e "\n3️⃣ NETWORK SECURITY"
echo "All listening services:"
sudo ss -tlnp | grep LISTEN

echo -e "\nActive connections:"
sudo ss -tnp | grep ESTAB | head -10

echo -e "\nFirewall status:"
sudo ufw status verbose 2>/dev/null || sudo iptables -L -n -v | head -20

# 4. User and authentication audit
echo -e "\n4️⃣ USER & AUTHENTICATION AUDIT"
echo "Users with UID 0 (root privileges):"
awk -F: '$3==0 {print $1}' /etc/passwd

echo -e "\nUsers with empty passwords:"
sudo awk -F: '$2=="" {print $1}' /etc/shadow

echo -e "\nRecent authentication failures (last 20):"
sudo grep -E "(Failed|failure)" /var/log/auth.log | tail -20

# 5. Process and service audit
echo -e "\n5️⃣ PROCESS & SERVICE AUDIT"
echo "Processes running as root:"
ps aux | grep -E "^root" | wc -l | xargs echo "Total root processes:"

echo -e "\nProcesses with deleted binaries:"
sudo ls -la /proc/*/exe 2>/dev/null | grep deleted

echo -e "\nSuspicious network processes:"
ps aux | grep -E "(nc |ncat |socat |cryptominer|xmrig)" | grep -v grep

# 6. File system security
echo -e "\n6️⃣ FILE SYSTEM SECURITY"
echo "World-writable files in system directories:"
sudo find /etc /bin /sbin /usr -type f -perm -0002 2>/dev/null | head -10

echo -e "\nFiles with no owner:"
sudo find / -nouser -o -nogroup 2>/dev/null | head -10

echo -e "\nLarge files in /tmp or /var/tmp:"
find /tmp /var/tmp -type f -size +100M -ls 2>/dev/null

# 7. Log analysis
echo -e "\n7️⃣ LOG ANALYSIS"
echo "SSH brute force attempts:"
sudo grep "Failed password" /var/log/auth.log | awk '{print $(NF-3)}' | sort | uniq -c | sort -rn | head -10

echo -e "\nKernel warnings/errors (last 24h):"
sudo journalctl -p warning -S "24 hours ago" | grep -E "(kernel|security)" | head -10

# 8. Cron job audit
echo -e "\n8️⃣ CRON JOB AUDIT"
echo "System cron jobs:"
for user in $(cut -f1 -d: /etc/passwd); do 
    crontab -u $user -l 2>/dev/null | grep -v "^#" | grep -v "^$" && echo " (User: $user)"
done

echo -e "\nCron directories:"
ls -la /etc/cron.* 2>/dev/null | grep -v "total" | grep -v "^d"

# 9. Package and update status
echo -e "\n9️⃣ PACKAGE SECURITY"
echo "Recently installed packages (last 7 days):"
grep " install " /var/log/dpkg.log 2>/dev/null | tail -10

echo -e "\nSecurity updates available:"
sudo apt update >/dev/null 2>&1
apt list --upgradable 2>/dev/null | grep -i security

# 10. Security tool status
echo -e "\n🔟 SECURITY TOOLS STATUS"
for service in fail2ban ufw apparmor; do
    if systemctl is-active --quiet $service 2>/dev/null; then
        echo "✅ $service is active"
    else
        echo "❌ $service is not active"
    fi
done

# Summary
echo -e "\n=========================================="
echo "🏁 SECURITY SCAN COMPLETE"
echo "Scan completed at: $(date)"
echo "Review the output above for any security concerns"
echo "=========================================="