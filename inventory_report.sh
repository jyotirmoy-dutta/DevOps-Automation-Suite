#!/bin/bash
# inventory_report.sh - Generates a system inventory report
# Usage: ./inventory_report.sh

REPORT="inventory-$(hostname)-$(date +%F).txt"
echo "System Inventory Report - $(date)" > "$REPORT"
echo "Hostname: $(hostname)" >> "$REPORT"
echo "Uptime: $(uptime -p)" >> "$REPORT"
echo "OS: $(lsb_release -d 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME)" >> "$REPORT"
echo "Kernel: $(uname -r)" >> "$REPORT"
echo -e "\nCPU Info:" >> "$REPORT"
lscpu >> "$REPORT"
echo -e "\nMemory Info:" >> "$REPORT"
free -h >> "$REPORT"
echo -e "\nDisk Info:" >> "$REPORT"
ds -h >> "$REPORT"
echo -e "\nNetwork Interfaces:" >> "$REPORT"
ip a >> "$REPORT"
echo -e "\nUsers:" >> "$REPORT"
cut -d: -f1 /etc/passwd >> "$REPORT"
echo "Report saved to $REPORT." 