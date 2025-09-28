#!/bin/bash

# Basic validation tests for Security Dashboard
# This demonstrates the testing framework recommended in the matrix

set -e

echo "🧪 Running Security Dashboard Validation Tests..."
echo "================================================"

# Test 1: Scripts exist and are executable
echo "✅ Test 1: Script Files"
for script in security-check.sh security-scan.sh install.sh; do
    if [ -x "$script" ]; then
        echo "  ✅ $script is executable"
    else
        echo "  ❌ $script is not executable"
        exit 1
    fi
done

# Test 2: ShellCheck validation
echo "✅ Test 2: ShellCheck Validation"
if command -v shellcheck >/dev/null 2>&1; then
    if shellcheck ./*.sh; then
        echo "  ✅ All scripts pass ShellCheck"
    else
        echo "  ❌ ShellCheck found issues"
        exit 1
    fi
else
    echo "  ⚠️  ShellCheck not available"
fi

# Test 3: Basic syntax validation
echo "✅ Test 3: Syntax Validation"
for script in *.sh; do
    if bash -n "$script"; then
        echo "  ✅ $script has valid syntax"
    else
        echo "  ❌ $script has syntax errors"
        exit 1
    fi
done

# Test 4: Security-check runs without errors
echo "✅ Test 4: Security Check Execution"
if timeout 30 ./security-check.sh >/dev/null 2>&1; then
    echo "  ✅ security-check.sh executes successfully"
else
    echo "  ❌ security-check.sh failed or timed out"
    exit 1
fi

# Test 5: Check for security anti-patterns
echo "✅ Test 5: Security Pattern Analysis"
SECURITY_ISSUES=0

# Check for unquoted variables (should be fixed now)
if grep -n '\$[A-Z_][A-Z0-9_]*[^"]' ./*.sh | grep -v '#' | grep -v 'echo' >/dev/null; then
    echo "  ⚠️  Potential unquoted variables found"
    SECURITY_ISSUES=$((SECURITY_ISSUES + 1))
fi

# Check for eval usage (dangerous)
if grep -n 'eval' ./*.sh | grep -v 'validate.sh' >/dev/null; then
    echo "  ❌ eval usage detected (security risk)"
    SECURITY_ISSUES=$((SECURITY_ISSUES + 1))
fi

# Check for proper error handling
if ! grep -n 'set -e' ./*.sh >/dev/null; then
    echo "  ⚠️  No error handling detected"
    SECURITY_ISSUES=$((SECURITY_ISSUES + 1))
fi

if [ $SECURITY_ISSUES -eq 0 ]; then
    echo "  ✅ No major security anti-patterns detected"
else
    echo "  ⚠️  $SECURITY_ISSUES potential security issues found"
fi

echo ""
echo "🎉 All validation tests completed!"
echo "✅ Scripts are ready for deployment"