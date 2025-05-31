#!/bin/bash

# Comprehensive Security Scan Script
# Generic version for public use - requires security tools to be installed

echo "🔍 Starting comprehensive security scan..."

# Check if security tools are available
RKHUNTER_PATH=""
CHKROOTKIT_PATH=""
LYNIS_PATH=""

# Try to find rkhunter
if command -v rkhunter >/dev/null 2>&1; then
    RKHUNTER_PATH="rkhunter"
elif [ -f "/usr/local/bin/rkhunter" ]; then
    RKHUNTER_PATH="/usr/local/bin/rkhunter"
fi

# Try to find chkrootkit
if command -v chkrootkit >/dev/null 2>&1; then
    CHKROOTKIT_PATH="chkrootkit"
elif [ -f "./chkrootkit-master/chkrootkit" ]; then
    CHKROOTKIT_PATH="./chkrootkit-master/chkrootkit"
fi

# Try to find lynis
if command -v lynis >/dev/null 2>&1; then
    LYNIS_PATH="lynis"
elif [ -f "./lynis-3.0.9/lynis" ]; then
    LYNIS_PATH="./lynis-3.0.9/lynis"
fi

# Run Rootkit Hunter if available
if [ -n "$RKHUNTER_PATH" ]; then
    echo -e "\n1️⃣ Running Rootkit Hunter..."
    sudo $RKHUNTER_PATH --check --sk --nocolors | grep -E "(Warning|Found|INFECTED)" || echo "✅ No rootkits detected"
else
    echo -e "\n1️⃣ Rootkit Hunter not found - skipping"
fi

# Run chkrootkit if available
if [ -n "$CHKROOTKIT_PATH" ]; then
    echo -e "\n2️⃣ Running chkrootkit..."
    sudo $CHKROOTKIT_PATH | grep -E "(INFECTED|suspicious|WARNING)" || echo "✅ No rootkits detected"
else
    echo -e "\n2️⃣ chkrootkit not found - skipping"
fi

# Run Lynis if available
if [ -n "$LYNIS_PATH" ]; then
    echo -e "\n3️⃣ Running Lynis security audit (quick)..."
    if [ "$LYNIS_PATH" = "lynis" ]; then
        sudo lynis audit system --quick --no-colors | grep -E "(Warning|Suggestion)" | head -10
    else
        sudo bash -c "cd $(dirname $LYNIS_PATH) && ./$(basename $LYNIS_PATH) audit system --quick --no-colors" | grep -E "(Warning|Suggestion)" | head -10
    fi
else
    echo -e "\n3️⃣ Lynis not found - skipping"
fi

# Network scan of critical ports
echo -e "\n4️⃣ Network scan of critical ports..."
if command -v nmap >/dev/null 2>&1; then
    nmap -sT -p 22,23,25,53,80,110,135,139,143,443,993,995,1433,3306,3389,5432 localhost | grep "open"
else
    echo "nmap not installed - cannot perform port scan"
fi

# Check system integrity
echo -e "\n5️⃣ Checking system integrity..."
sudo find /bin /sbin /usr/bin /usr/sbin -type f -perm -4000 -ls | wc -l | xargs echo "SUID files found:"

echo -e "\n✅ Security scan complete - $(date)"