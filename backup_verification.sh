#!/bin/bash
# backup_verification.sh - Automated backup verification
# Usage: ./backup_verification.sh
# Edit BACKUP_DIR and EMAIL in config.sh or at the top of this script as needed.

[ -f ./config.sh ] && source ./config.sh
BACKUP_DIR=${BACKUP_DIR:-"/backup"}
EMAIL=${EMAIL:-""}
REPORT="backup_verification_report-$(date +%F-%H%M).txt"

> "$REPORT"
echo "Backup Verification Report - $(date)" >> "$REPORT"

# Check for recent backup files (last 2 days)
RECENT_BACKUPS=$(find "$BACKUP_DIR" -name '*.tar.gz' -mtime -2)
if [ -z "$RECENT_BACKUPS" ]; then
    echo "No recent backup files found in $BACKUP_DIR!" >> "$REPORT"
else
    echo -e "\n--- Recent Backup Files ---" >> "$REPORT"
    for file in $RECENT_BACKUPS; do
        echo "$file" >> "$REPORT"
        # Test extraction
        if tar -tzf "$file" > /dev/null 2>&1; then
            echo "  [OK] Archive is valid." >> "$REPORT"
        else
            echo "  [FAIL] Archive is corrupted!" >> "$REPORT"
        fi
    done
fi

echo "Backup verification complete. Report saved to $REPORT."

if [ -n "$EMAIL" ] && [ -s "$REPORT" ]; then
    mail -s "Backup Verification Report $(hostname)" "$EMAIL" < "$REPORT"
    echo "Report emailed to $EMAIL."
fi 