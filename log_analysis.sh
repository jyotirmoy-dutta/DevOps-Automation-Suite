#!/bin/bash
# log_analysis.sh - Automated log analysis for errors, warnings, and security events
# Usage: ./log_analysis.sh
# Edit LOG_FILES and EMAIL in config.sh or at the top of this script as needed.

[ -f ./config.sh ] && source ./config.sh
LOG_FILES=${LOG_FILES:-"/var/log/syslog /var/log/auth.log /var/log/messages"}
EMAIL=${EMAIL:-""}
REPORT="log_analysis_report-$(date +%F-%H%M).txt"

PATTERNS="error|fail|critical|alert|panic|denied|unauthorized|segfault|security"

> "$REPORT"
echo "Log Analysis Report - $(date)" >> "$REPORT"
for file in $LOG_FILES; do
    if [ -f "$file" ]; then
        echo -e "\n--- $file ---" >> "$REPORT"
        grep -Ei "$PATTERNS" "$file" | tail -100 >> "$REPORT"
    fi
done

echo "Log analysis complete. Report saved to $REPORT."

if [ -n "$EMAIL" ] && [ -s "$REPORT" ]; then
    mail -s "Log Analysis Report $(hostname)" "$EMAIL" < "$REPORT"
    echo "Report emailed to $EMAIL."
fi 