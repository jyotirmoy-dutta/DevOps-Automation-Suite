#!/bin/bash
# hardware_health_check.sh: Check disk SMART and RAID health (cross-platform)

if [[ "$OSTYPE" == "linux"* ]]; then
    echo "SMART status for all disks:"
    for disk in /dev/sd?; do
        echo "\n$disk:"
        if command -v smartctl &>/dev/null; then
            smartctl -H "$disk"
        else
            echo "smartctl not found."
        fi
    done
    echo "\nRAID status (mdadm):"
    if command -v mdadm &>/dev/null; then
        mdadm --detail --scan
        cat /proc/mdstat
    else
        echo "mdadm not installed or no RAID configured."
    fi
elif [[ "$OS" == "Windows_NT" ]]; then
    echo "SMART status for all disks:"
    powershell.exe -Command "Get-PhysicalDisk | Select-Object FriendlyName, OperationalStatus, HealthStatus"
    echo "RAID status: Check via Windows Storage Spaces or manufacturer tools."
else
    echo "Unsupported OS."
fi 