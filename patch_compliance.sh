#!/bin/bash
# patch_compliance.sh - Checks for missing security patches and reports compliance
# Usage: sudo ./patch_compliance.sh

if [ -x "$(command -v apt)" ]; then
    echo "Checking for missing security updates (apt)..."
    apt update > /dev/null
    MISSING=$(apt list --upgradable 2>/dev/null | grep -i security)
    if [ -z "$MISSING" ]; then
        echo "System is patch compliant (no pending security updates)."
    else
        echo "Missing security updates:"
        echo "$MISSING"
    fi
elif [ -x "$(command -v yum)" ]; then
    echo "Checking for missing security updates (yum)..."
    yum check-update --security > /tmp/yum-security.txt 2>&1
    if grep -q "No packages needed" /tmp/yum-security.txt; then
        echo "System is patch compliant (no pending security updates)."
    else
        echo "Missing security updates:"
        cat /tmp/yum-security.txt
    fi
else
    echo "No supported package manager found (apt or yum)."
    exit 1
fi 