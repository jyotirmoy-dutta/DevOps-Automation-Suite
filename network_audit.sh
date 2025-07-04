#!/bin/bash
# network_audit.sh: Audit open ports and network connections (cross-platform)

if [[ "$OSTYPE" == "linux"* ]]; then
    echo "Open ports (ss):"
    command -v ss &>/dev/null && ss -tuln
    echo "\nActive network connections (netstat):"
    command -v netstat &>/dev/null && netstat -plant
elif [[ "$OS" == "Windows_NT" ]]; then
    echo "Active network connections (netstat):"
    netstat -an
else
    echo "Unsupported OS."
fi 