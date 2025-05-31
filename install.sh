#!/bin/bash

# Security Dashboard Installation Script
echo "🔒 Installing Security Dashboard..."

# Make scripts executable
chmod +x security-check.sh
chmod +x security-scan.sh

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  Running as root - will install system-wide"
    INSTALL_PATH="/usr/local/bin"
    MOTD_PATH="/etc/update-motd.d"
else
    echo "📂 Installing to user home directory"
    INSTALL_PATH="$HOME"
    MOTD_PATH=""
fi

# Copy scripts to appropriate location
echo "📋 Copying scripts to $INSTALL_PATH..."
cp security-check.sh $INSTALL_PATH/
cp security-scan.sh $INSTALL_PATH/

# Option 1: Add to bash profile for user login
echo "🔧 Setting up login dashboard..."
if [ ! -f ~/.bash_profile ]; then
    touch ~/.bash_profile
fi

# Check if already configured
if ! grep -q "security-check.sh" ~/.bash_profile; then
    cat >> ~/.bash_profile << 'EOF'

# Security Dashboard - show at login
if [ -f ~/security-check.sh ] && [ -n "$PS1" ]; then
    ~/security-check.sh
fi
EOF
    echo "✅ Added to ~/.bash_profile"
fi

# Option 2: Add to system MOTD (if running as root)
if [ -n "$MOTD_PATH" ] && [ -d "$MOTD_PATH" ]; then
    echo "🎯 Installing system-wide MOTD..."
    cp security-check.sh $MOTD_PATH/01-security
    chmod +x $MOTD_PATH/01-security
    echo "✅ Added to system MOTD"
fi

echo ""
echo "🎉 Installation complete!"
echo ""
echo "📖 Usage:"
echo "  • Security dashboard will show on next login"
echo "  • Run 'security-scan.sh' for comprehensive scan"
echo "  • Run 'security-check.sh' for quick status"
echo ""
echo "⚠️  Note: Some features require sudo privileges"
echo "📋 Install security tools with: sudo apt install nmap rkhunter chkrootkit"