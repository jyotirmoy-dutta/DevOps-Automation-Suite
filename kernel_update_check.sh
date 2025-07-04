#!/bin/bash
# kernel_update_check.sh: Check for available kernel updates (cross-platform)

if [[ "$OSTYPE" == "linux"* ]]; then
    if command -v apt &>/dev/null; then
        apt update > /dev/null
        apt list --upgradable 2>/dev/null | grep linux-image
    elif command -v yum &>/dev/null; then
        yum check-update kernel
    else
        echo "Unsupported package manager."
    fi
elif [[ "$OS" == "Windows_NT" ]]; then
    echo "Check for Windows Updates via Settings or PowerShell."
    powershell.exe -Command "Get-WindowsUpdateLog"
else
    echo "Unsupported OS."
fi 