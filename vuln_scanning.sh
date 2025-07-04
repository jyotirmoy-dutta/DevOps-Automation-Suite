#!/bin/bash
# vuln_scanning.sh - Automated vulnerability scanning (system and malware)
# Usage: sudo ./vuln_scanning.sh
# Edit EMAIL in config.sh or at the top of this script as needed.

[ -f ./config.sh ] && source ./config.sh
EMAIL=${EMAIL:-""}
REPORT="vuln_scanning_report-$(date +%F-%H%M).txt"

> "$REPORT"
echo "Vulnerability Scanning Report - $(date)" >> "$REPORT"

# System vulnerability scan with Lynis
if command -v lynis &> /dev/null; then
    echo -e "\n--- Lynis Security Audit ---" >> "$REPORT"
    sudo lynis audit system --quick >> "$REPORT"
else
    echo "Lynis not found. Please install Lynis for vulnerability scanning." >> "$REPORT"
fi

# Malware scan with ClamAV
if command -v clamscan &> /dev/null; then
    echo -e "\n--- ClamAV Malware Scan (home directories) ---" >> "$REPORT"
    clamscan -r /home >> "$REPORT"
else
    echo "ClamAV not found. Please install ClamAV for malware scanning." >> "$REPORT"
fi

echo "Vulnerability scanning complete. Report saved to $REPORT."

if [ -n "$EMAIL" ] && [ -s "$REPORT" ]; then
    mail -s "Vulnerability Scanning Report $(hostname)" "$EMAIL" < "$REPORT"
    echo "Report emailed to $EMAIL."
fi 