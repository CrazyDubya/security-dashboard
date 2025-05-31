# Security Dashboard 🔒

A lightweight security monitoring dashboard that displays system security status at login and provides comprehensive security scanning capabilities.

## Features

### 🚨 Login Dashboard
- **System Load Monitoring** - Alerts on high CPU load
- **Failed Login Detection** - Shows recent failed authentication attempts  
- **Root Access Tracking** - Monitors privileged user sessions
- **Port Scanning** - Quick localhost port enumeration
- **Resource Monitoring** - Disk and memory usage warnings
- **Process Monitoring** - Detects suspicious network tools

### 🔍 Comprehensive Scanning
- **Rootkit Detection** - Multiple rootkit scanners (rkhunter, chkrootkit)
- **Security Auditing** - Lynis-based system security assessment
- **Network Analysis** - Port scanning of critical services
- **System Integrity** - SUID file monitoring

## Quick Start

```bash
# Clone and install
git clone <repository-url>
cd security-dashboard-project
chmod +x install.sh
./install.sh

# Manual run
./security-check.sh     # Quick security status
./security-scan.sh      # Comprehensive scan
```

## Installation Options

### Option 1: User Installation (Recommended)
```bash
./install.sh
```
- Installs to user home directory
- Adds dashboard to user login profile
- No root privileges required for installation

### Option 2: System-wide Installation
```bash
sudo ./install.sh
```
- Installs to `/usr/local/bin`
- Adds to system MOTD (Message of the Day)
- Available for all users

### Option 3: Manual Setup

1. **Copy scripts to desired location**
   ```bash
   cp security-check.sh ~/
   cp security-scan.sh ~/
   chmod +x ~/security-*.sh
   ```

2. **Add to login profile** (choose one):
   
   **For bash users** - Add to `~/.bash_profile`:
   ```bash
   # Security Dashboard
   if [ -f ~/security-check.sh ] && [ -n "$PS1" ]; then
       ~/security-check.sh
   fi
   ```
   
   **For system-wide MOTD** (requires root):
   ```bash
   sudo cp security-check.sh /etc/update-motd.d/01-security
   sudo chmod +x /etc/update-motd.d/01-security
   ```

## Dependencies

### Required
- **bash** - Shell scripting environment
- **sudo** - Elevated privileges for log access

### Optional (for enhanced features)
- **nmap** - Network port scanning
- **rkhunter** - Rootkit detection
- **chkrootkit** - Additional rootkit scanning  
- **lynis** - Security auditing
- **bc** - Mathematical calculations

### Installing Security Tools

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install nmap rkhunter chkrootkit lynis
```

**CentOS/RHEL:**
```bash
sudo yum install nmap rkhunter chkrootkit
# Lynis requires EPEL repository
```

**Manual Installation:**
The scripts will attempt to find tools in common locations and gracefully handle missing dependencies.

## Configuration

### Customizing Thresholds

Edit the scripts to adjust monitoring thresholds:

```bash
# In security-check.sh
LOAD_THRESHOLD="2.0"        # System load warning level
DISK_THRESHOLD="80"         # Disk usage warning (%)
MEMORY_THRESHOLD="80"       # Memory usage warning (%)
```

### Customizing Checks

Add or remove security checks by modifying the script sections:
- System resource monitoring
- Log file analysis  
- Process monitoring
- Network scanning

## Security Considerations

⚠️ **Important Security Notes:**

1. **Sudo Access**: Scripts require sudo for accessing system logs and running security tools
2. **Log Privacy**: Auth logs may contain sensitive information
3. **Network Scanning**: Port scanning may trigger security alerts
4. **Performance**: Comprehensive scans may impact system performance

## Sample Output

### Login Dashboard
```
🔒 SECURITY STATUS DASHBOARD 🔒
==========================================
🚨 RECENT FAILED LOGINS: 3 in last 5 attempts
👤 RECENT ROOT ACCESS: 2025-05-31 17:24:15
🌐 OPEN PORTS: 4
💾 DISK WARNING: 85% full
==========================================
Last security scan: Sat May 31 17:31:34 UTC 2025
Run './security-scan.sh' for full analysis
```

### Comprehensive Scan
```
🔍 Starting comprehensive security scan...

1️⃣ Running Rootkit Hunter...
✅ No rootkits detected

2️⃣ Running chkrootkit...
✅ No rootkits detected

3️⃣ Running Lynis security audit (quick)...
[Suggestions and warnings displayed]

4️⃣ Network scan of critical ports...
22/tcp open  ssh
80/tcp open  http

5️⃣ Checking system integrity...
SUID files found: 45

✅ Security scan complete - Sat May 31 17:31:34 UTC 2025
```

## Troubleshooting

### Dashboard Not Showing on Login

1. **Check installation:**
   ```bash
   ls -la ~/security-check.sh
   cat ~/.bash_profile | grep security
   ```

2. **Test manually:**
   ```bash
   ~/security-check.sh
   source ~/.bash_profile
   ```

3. **Check shell type:**
   ```bash
   echo $SHELL
   echo $0
   ```

### Permission Issues

1. **Script permissions:**
   ```bash
   chmod +x ~/security-*.sh
   ```

2. **Sudo configuration:**
   ```bash
   sudo -v  # Test sudo access
   ```

### Missing Tools

1. **Check available tools:**
   ```bash
   which nmap rkhunter chkrootkit lynis
   ```

2. **Install missing tools:**
   ```bash
   sudo apt install <missing-tool>
   ```

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Test thoroughly
4. Submit a pull request

## License

MIT License - Feel free to use, modify, and distribute.

## Changelog

### v1.0.0
- Initial release
- Basic security dashboard
- Comprehensive scanning support
- Multi-tool integration
- Automated installation

---

**⚠️ Disclaimer**: This tool is provided as-is for educational and monitoring purposes. Always review security tools before use in production environments.