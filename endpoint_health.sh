#!/bin/bash
# endpoint_health.sh - Automated endpoint health check
# Usage: ./endpoint_health.sh
# Edit SERVICES and EMAIL in config.sh or at the top of this script as needed.

[ -f ./config.sh ] && source ./config.sh
SERVICES=${SERVICES:-"ssh cron"}
EMAIL=${EMAIL:-""}
REPORT="endpoint_health_report-$(date +%F-%H%M).txt"

> "$REPORT"
echo "Endpoint Health Check Report - $(date)" >> "$REPORT"

echo -e "\n--- System Uptime ---" >> "$REPORT"
uptime >> "$REPORT"

echo -e "\n--- System Load ---" >> "$REPORT"
cat /proc/loadavg >> "$REPORT"

echo -e "\n--- Network Connectivity (8.8.8.8) ---" >> "$REPORT"
ping -c 2 8.8.8.8 >> "$REPORT" 2>&1

echo -e "\n--- Critical Service Status ---" >> "$REPORT"
for svc in $SERVICES; do
    if systemctl is-active --quiet "$svc"; then
        echo "$svc: running" >> "$REPORT"
    else
        echo "$svc: NOT running" >> "$REPORT"
    fi
done

echo "Endpoint health check complete. Report saved to $REPORT."

if [ -n "$EMAIL" ] && [ -s "$REPORT" ]; then
    mail -s "Endpoint Health Report $(hostname)" "$EMAIL" < "$REPORT"
    echo "Report emailed to $EMAIL."
fi 