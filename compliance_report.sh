#!/bin/bash
# compliance_report.sh - Automated compliance reporting (CIS/PCI-DSS/HIPAA)
# Usage: sudo ./compliance_report.sh
# Requires Lynis for advanced checks (free, open-source)

[ -f ./config.sh ] && source ./config.sh
REPORT="compliance_report-$(date +%F-%H%M).txt"

> "$REPORT"
echo "Compliance Report - $(date)" >> "$REPORT"

# Run Lynis if available
if command -v lynis &> /dev/null; then
    echo -e "\n--- Lynis Security Audit ---" >> "$REPORT"
    sudo lynis audit system --quick >> "$REPORT"
else
    echo "Lynis not found. Please install Lynis for advanced compliance checks." >> "$REPORT"
fi

# Basic system checks
# Password policy
echo -e "\n--- Password Policy ---" >> "$REPORT"
grep PASS_MAX_DAYS /etc/login.defs >> "$REPORT"
grep PASS_MIN_DAYS /etc/login.defs >> "$REPORT"
grep PASS_MIN_LEN /etc/login.defs >> "$REPORT"

# SSH configuration
echo -e "\n--- SSH Configuration ---" >> "$REPORT"
grep -E 'PermitRootLogin|PasswordAuthentication' /etc/ssh/sshd_config >> "$REPORT"

# Firewall status
echo -e "\n--- Firewall Status ---" >> "$REPORT"
if command -v ufw &> /dev/null; then
    sudo ufw status verbose >> "$REPORT"
elif command -v iptables &> /dev/null; then
    sudo iptables -L -v -n >> "$REPORT"
else
    echo "No firewall detected." >> "$REPORT"
fi

echo "Compliance report complete. Report saved to $REPORT." 