# 🔒 Security Dashboard - Your Server's Guardian Angel

**One-liner:** Get instant security alerts every time you SSH into your server, plus comprehensive security scanning with zero configuration.

```
                    🔒 SECURITY STATUS DASHBOARD 🔒
    ==========================================
    🚨 RECENT FAILED LOGINS: 23 attempts detected  
    🔑 SSH LOGINS: 5 successful (Last: from 192.168.1.100)
    ⚡ SUDO COMMANDS: 3 recent privilege escalations
    🌐 LISTENING PORTS: 8 services (⚠️ 2 unusual detected)
    🔗 ACTIVE CONNECTIONS: 15 established 
    👥 USERS LOGGED IN: 2 (stephen, admin)
    📦 SECURITY UPDATES: 12 packages need patching
    ==========================================
    Run 'security-scan' for full analysis
```

## 🚀 Why This Will Save You Time and Headaches

**THE PROBLEM:** You SSH into your server and have NO IDEA if:
- Someone's been trying to brute force your SSH ❌
- Weird services are running on strange ports ❌  
- Your system got compromised while you slept ❌
- Critical security updates are waiting ❌

**THE SOLUTION:** Security Dashboard shows you EVERYTHING the moment you log in. No setup. No configuration. Just security intelligence.

### 🔥 What Makes This Different

- **🚨 INSTANT ALERTS** - See security status the second you login
- **🎯 ZERO CONFIG** - Works immediately after install  
- **⚡ LIGHTNING FAST** - Dashboard loads in under 1 second
- **🔍 COMPREHENSIVE** - Covers network, users, processes, files, logs
- **📱 CLEAN OUTPUT** - Perfect for screenshots and sharing

## ⚡ Install in 10 Seconds

```bash
curl -sSL https://raw.githubusercontent.com/CrazyDubya/security-dashboard/main/install.sh | bash
```

**That's it.** Next time you SSH in, you'll see your security status instantly.

## 🎯 Perfect For

- **🏢 Sysadmins** who need instant security visibility
- **🔒 Security Engineers** running security audits  
- **☁️ Cloud Engineers** managing multiple servers
- **💻 DevOps Teams** who want security in their workflow
- **🏠 Homelab Enthusiasts** protecting their infrastructure
- **🎓 Students** learning Linux security

## 📸 What You'll See

### Login Dashboard (Every SSH Connection)
```
🔒 SECURITY STATUS DASHBOARD 🔒
==========================================
🚨 RECENT FAILED LOGINS: 15 in last 10 attempts
🔑 RECENT SSH LOGINS: 3 successful  
   Last: May-31 19:23:15 from 203.0.113.100
⚡ RECENT SUDO COMMANDS: 5
🌐 LISTENING PORTS: 12
⚠️  UNUSUAL PORTS DETECTED: 2
   0.0.0.0:8888 python3 (PID: 1337)
   127.0.0.1:9999 unknown
🔗 ACTIVE CONNECTIONS: 8
📝 SYSTEM FILES MODIFIED (24h): 15
👥 USERS LOGGED IN: 2
📦 SECURITY UPDATES AVAILABLE: 7 packages
==========================================
Last scan: Sat May 31 19:43:19 UTC 2025
Run 'security-scan' for full analysis
```

### Full Security Scan (30 seconds)
```
🔍 Starting comprehensive security scan...

1️⃣ ROOTKIT DETECTION
✅ rkhunter: No rootkits detected
✅ chkrootkit: System clean

2️⃣ SYSTEM INTEGRITY  
🔍 SUID/SGID files: 78 (normal range)
📝 Recent system changes: 15 files modified

3️⃣ NETWORK SECURITY
🌐 Listening services: 12 ports active
🔥 Firewall: UFW active, 6 rules configured
🔗 Active connections: 8 established

4️⃣ AUTHENTICATION AUDIT
👤 Root accounts: 1 (normal)
🚫 Empty passwords: 0 (secure)
🚨 Failed logins: 23 attempts from 5 IPs

5️⃣ SECURITY SERVICES
✅ fail2ban: Active (protecting SSH)
✅ UFW firewall: Active  
✅ AppArmor: Active

🏁 SCAN COMPLETE - System appears secure!
```

## 🛠️ Commands

```bash
security-check     # Quick dashboard (same as login)
security-scan      # Full comprehensive scan
```

## 🎭 What It Actually Checks

### 🚨 Login Dashboard (Instant)
- **Failed SSH attempts** - Brute force detection
- **Successful logins** - Who accessed your server  
- **Sudo usage** - Privilege escalation tracking
- **Network ports** - What's listening and from where
- **Active connections** - Current network activity
- **System modifications** - Files changed in last 24h
- **User sessions** - Who's currently logged in
- **Security services** - fail2ban, firewall status
- **System resources** - CPU, memory, disk alerts
- **Available updates** - Security patches waiting

### 🔍 Comprehensive Scan (30 seconds)
- **Rootkit detection** - Multiple scanners (rkhunter, chkrootkit)
- **System integrity** - SUID files, permissions, ownership
- **Network security** - Full port scan, firewall audit, connections
- **User security** - Password policies, account audit
- **Process analysis** - Running services, suspicious activity
- **File system** - Permission issues, large files, modifications
- **Log analysis** - Auth failures, kernel warnings, security events
- **Service audit** - Critical security tool status
- **Package security** - Update history, available patches

## 🔧 Installation Options

### 🚀 One-Line Install (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/CrazyDubya/security-dashboard/main/install.sh | bash
```

### 📦 Manual Install
```bash
git clone https://github.com/CrazyDubya/security-dashboard.git
cd security-dashboard
chmod +x install.sh
./install.sh
```

### 🔍 What the installer does:
1. Downloads security scripts to your home directory
2. Makes them executable
3. Adds dashboard to your login profile
4. Tests the installation

**No system modifications. No sudo required for install.**

## 🛡️ Requirements

### Essential
- **Linux** (Ubuntu, Debian, CentOS, RHEL, Arch, etc.)
- **Bash** 4.0+
- **SSH** access

### For Enhanced Features
- **sudo** access (for log analysis and system checks)
- **nmap** - Network port scanning
- **rkhunter** - Rootkit detection  
- **chkrootkit** - Additional rootkit scanning
- **lynis** - Security auditing
- **fail2ban** - Intrusion prevention

### Auto-Install Security Tools
```bash
# Ubuntu/Debian
sudo apt update && sudo apt install -y nmap rkhunter chkrootkit lynis fail2ban

# CentOS/RHEL  
sudo yum install -y nmap rkhunter chkrootkit fail2ban

# Arch Linux
sudo pacman -S nmap rkhunter chkrootkit lynis fail2ban
```

## 🎯 Real Use Cases

### 🏢 Work Scenarios
- **Server maintenance** - Quick security check before changes
- **Incident response** - Fast security assessment
- **Compliance audits** - Document security posture
- **Team handovers** - Show current security status

### 🏠 Personal Projects
- **Raspberry Pi** - Monitor your home server
- **VPS monitoring** - Keep track of your cloud servers
- **Learning tool** - Understand Linux security
- **Development servers** - Ensure clean environments

## 📈 Performance

- **Login dashboard:** ~0.5 seconds
- **Memory usage:** <5MB  
- **CPU impact:** Minimal during normal operation
- **Network:** Only local system scans
- **Storage:** <1MB total

## 🚨 What We've Actually Detected

During development and testing, we've found:
- SSH brute force attempts (common on internet-facing servers)
- Unusual processes running from /tmp directories
- Services listening on unexpected ports
- Failed authentication attempts from various IPs
- Systems missing critical security updates
- World-writable directories in system paths

## 🤝 Contributing

We welcome contributions! Here's how:

1. **🍴 Fork** the repository
2. **🌿 Create** a feature branch
3. **💻 Make** your changes
4. **✅ Test** thoroughly  
5. **📤 Submit** a pull request

### Ideas for contributions:
- Additional security checks
- Support for more Linux distributions  
- Integration with monitoring systems
- Performance improvements
- Documentation updates

## 📄 License

**MIT License** - Use it anywhere, modify freely.

**⚠️ Disclaimer:** This tool is for legitimate security monitoring of systems you own or have permission to monitor. Always follow responsible disclosure and legal guidelines.

## 📞 Support

- **🐛 Issues:** [GitHub Issues](https://github.com/CrazyDubya/security-dashboard/issues)
- **💬 Feature Requests:** [GitHub Discussions](https://github.com/CrazyDubya/security-dashboard/discussions)

---

## ⭐ Like This Project?

**Give us a star ⭐ if this tool helped secure your server!**

```bash
# Quick install reminder
curl -sSL https://raw.githubusercontent.com/CrazyDubya/security-dashboard/main/install.sh | bash
```

**🔒 Simple security monitoring. Real protection. Zero hassle.**