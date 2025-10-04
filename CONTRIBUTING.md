# Contributing to Security Dashboard

Thank you for your interest in contributing to Security Dashboard! This guide will help you get started.

## 🎯 How to Contribute

We welcome contributions in several areas:

- **🔍 New Security Checks**: Additional security validations and scans
- **🐛 Bug Fixes**: Improvements to existing functionality
- **📚 Documentation**: Better guides, examples, and explanations
- **🎨 Output Formatting**: Clearer, more useful display formats
- **🐧 OS Support**: Compatibility with more Linux distributions
- **⚡ Performance**: Faster scans and better resource usage
- **🔗 Integrations**: Connect with monitoring systems and alerting

## 🚀 Getting Started

### 1. Fork and Clone

```bash
git clone https://github.com/YOUR_USERNAME/security-dashboard.git
cd security-dashboard
```

### 2. Create a Branch

```bash
git checkout -b feature/your-feature-name
```

### 3. Make Your Changes

Edit the relevant files:
- `security-check.sh` - Quick dashboard shown on login
- `security-scan.sh` - Comprehensive security scanning
- `install.sh` - Installation script
- `validate.sh` - Installation validation

### 4. Test Your Changes

```bash
# Test the quick check
./security-check.sh

# Test the full scan
./security-scan.sh

# Test installation (in a VM/container is safest)
./install.sh
```

## 📝 Contribution Guidelines

### Code Style

**Shell Script Best Practices:**
- Use `#!/bin/bash` shebang
- Quote variables: `"$variable"`
- Use `[[` for conditionals instead of `[`
- Add comments for complex logic
- Use functions for reusable code
- Handle errors gracefully
- Provide informative output

**Example:**
```bash
#!/bin/bash

# Function: Check if service is running
# Args: $1 - service name
check_service() {
    local service_name="$1"
    
    if systemctl is-active --quiet "$service_name" 2>/dev/null; then
        echo "✅ $service_name: Active"
        return 0
    else
        echo "❌ $service_name: Inactive"
        return 1
    fi
}
```

### Security Considerations

When adding security checks, ensure:
- **Read-only by default**: Don't modify system state
- **Sudo warnings**: Clearly indicate when sudo is needed
- **Safe commands**: Avoid destructive operations
- **Privacy respect**: Don't expose sensitive data unnecessarily
- **Performance**: Keep scans fast and lightweight
- **Compatibility**: Test on multiple distros when possible

### Output Formatting

Follow these conventions:
- Use emojis for visual categorization (🔒 🚨 ✅ ❌ ⚠️ 🌐 👥 📦)
- Keep output concise but informative
- Use color sparingly (some terminals don't support it)
- Align related information
- Provide actionable recommendations

### Testing Checklist

Before submitting:
- [ ] Tested on Ubuntu/Debian
- [ ] Tested on CentOS/RHEL (if applicable)
- [ ] Works without sudo (or gracefully indicates need)
- [ ] Works with missing optional dependencies
- [ ] Handles errors gracefully
- [ ] Output is clear and well-formatted
- [ ] Performance is acceptable (<5s for quick check, <60s for full scan)
- [ ] No sensitive data leakage
- [ ] Documentation updated

## 🔍 Adding New Security Checks

### Quick Check (security-check.sh)

For immediate feedback on login:
- Keep execution time under 1 second
- Focus on high-priority security indicators
- Provide summary statistics
- Highlight urgent issues

### Full Scan (security-scan.sh)

For comprehensive analysis:
- Can take 30-60 seconds
- Detailed investigation and reporting
- Multiple validation methods
- In-depth explanations

### Example: Adding a New Check

```bash
# In security-check.sh or security-scan.sh

echo "🔍 CHECKING DOCKER SECURITY"
echo "--------------------------------"

# Check if Docker is installed
if command -v docker >/dev/null 2>&1; then
    # Check if Docker socket is secure
    if [[ -S /var/run/docker.sock ]]; then
        socket_perms=$(stat -c %a /var/run/docker.sock 2>/dev/null)
        if [[ "$socket_perms" == "660" ]] || [[ "$socket_perms" == "600" ]]; then
            echo "✅ Docker socket permissions: Secure ($socket_perms)"
        else
            echo "⚠️  Docker socket permissions: Insecure ($socket_perms)"
            echo "   Recommendation: chmod 660 /var/run/docker.sock"
        fi
    fi
    
    # Check running containers
    container_count=$(docker ps -q 2>/dev/null | wc -l)
    echo "📦 Running containers: $container_count"
else
    echo "ℹ️  Docker not installed"
fi
echo ""
```

## 📚 Documentation

When adding features:
- Update README.md with new capabilities
- Add examples of new output
- Document any new dependencies
- Update installation instructions if needed
- Add to the "What It Checks" section

## 🐛 Bug Reports

### Good Bug Report Includes:

1. **Clear description** of the issue
2. **Steps to reproduce**
3. **Expected behavior**
4. **Actual behavior**
5. **Environment details**:
   - OS and version
   - Shell version
   - Relevant tool versions
6. **Error messages** (full output)
7. **Screenshots** if relevant

### Template:

```markdown
## Description
Brief description of the bug

## Steps to Reproduce
1. Run `security-check.sh`
2. Observe output
3. See error

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- OS: Ubuntu 22.04
- Bash: 5.1.16
- Security Dashboard version: latest

## Error Output
```
Paste error messages here
```

## Additional Context
Any other relevant information
```

## 💡 Feature Requests

We love new ideas! Please include:
- **Problem statement**: What issue does this solve?
- **Proposed solution**: How would it work?
- **Use cases**: When would this be used?
- **Examples**: Show expected output
- **Alternatives**: Other approaches considered?

## 🔄 Pull Request Process

1. **Update documentation** for any changed functionality
2. **Test thoroughly** on multiple systems if possible
3. **Follow commit conventions** (see below)
4. **Reference issues** that your PR addresses
5. **Request review** from maintainers

### PR Template:

```markdown
## Description
What does this PR do?

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Code cleanup

## Testing
How was this tested?
- [ ] Ubuntu 22.04
- [ ] CentOS 8
- [ ] Debian 11
- [ ] Manual testing
- [ ] Automated tests

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] Tested on multiple systems
- [ ] No sensitive data exposed
- [ ] Performance acceptable

## Screenshots
[If applicable]

## Additional Notes
[Any other context]
```

## 📋 Commit Message Format

Use clear, descriptive commit messages:

```
type(scope): brief description

[optional detailed description]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting, no code change
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

**Examples:**
```
feat(scan): add Docker container security check
fix(check): handle missing sudo gracefully
docs(readme): update installation instructions
perf(scan): optimize port scanning speed
```

## 🏆 Recognition

Contributors are credited in:
- README.md contributors section
- Release notes
- Documentation

## 🤝 Community

- Be respectful and constructive
- Help others learn
- Share knowledge
- Welcome newcomers
- Follow the Code of Conduct

## 📞 Questions?

- Open an issue for questions
- Check existing documentation
- Review closed issues and PRs

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for helping make servers more secure! 🔒**
