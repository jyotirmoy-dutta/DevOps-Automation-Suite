#!/bin/bash
# disk_alert.sh - Checks disk usage and sends alert if threshold exceeded
# Usage: ./disk_alert.sh
# Edit THRESHOLD and EMAIL as needed.

THRESHOLD=80
EMAIL="admin@example.com"

USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Disk usage is at ${USAGE}% on $(hostname)" | mail -s "Disk Usage Alert" "$EMAIL"
    echo "Alert sent: Disk usage is at ${USAGE}%"
else
    echo "Disk usage is at ${USAGE}%. No alert needed."
fi 