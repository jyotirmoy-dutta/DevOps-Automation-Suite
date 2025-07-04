#!/bin/bash
# incident_report.sh - Generates an automated incident report
# Usage: ./incident_report.sh
# Edit variables in config.sh or at the top of this script as needed.

[ -f ./config.sh ] && source ./config.sh

INCLUDE_LOGS=${INCLUDE_LOGS:-1}
INCLUDE_ALERTS=${INCLUDE_ALERTS:-1}
INCLUDE_FAILED_LOGINS=${INCLUDE_FAILED_LOGINS:-1}

REPORT="incident-$(hostname)-$(date +%F-%H%M).txt"
echo "Incident Report - $(date)" > "$REPORT"
echo "Hostname: $(hostname)" >> "$REPORT"

if [ "$INCLUDE_LOGS" -eq 1 ]; then
    echo -e "\nRecent System Logs:" >> "$REPORT"
    journalctl -n 100 >> "$REPORT" 2>/dev/null || tail -100 /var/log/syslog >> "$REPORT" 2>/dev/null
fi

if [ "$INCLUDE_ALERTS" -eq 1 ]; then
    echo -e "\nRecent Alerts (disk, resource):" >> "$REPORT"
    df -h >> "$REPORT"
    free -h >> "$REPORT"
    top -b -n1 | head -20 >> "$REPORT"
fi

if [ "$INCLUDE_FAILED_LOGINS" -eq 1 ]; then
    echo -e "\nRecent Failed Logins:" >> "$REPORT"
    lastb | head -10 >> "$REPORT"
fi

echo "Incident report saved to $REPORT." 