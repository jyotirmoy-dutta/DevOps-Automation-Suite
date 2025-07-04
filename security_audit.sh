#!/bin/bash
# security_audit.sh - Runs basic security checks
# Usage: ./security_audit.sh

# Check open ports
echo "Open ports:"
ss -tuln

# Check failed login attempts
echo -e "\nFailed login attempts:"
lastb | head -20

# Check for world-writable files
echo -e "\nWorld-writable files:"
find / -xdev -type f -perm -0002 -ls 2>/dev/null | head -20

echo -e "\nSecurity audit complete." 