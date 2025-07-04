#!/bin/bash
# file_integrity_monitor.sh - Automated file integrity monitoring
# Usage: sudo ./file_integrity_monitor.sh init|check
# Edit MONITOR_PATHS and EMAIL in config.sh or at the top of this script as needed.

[ -f ./config.sh ] && source ./config.sh
MONITOR_PATHS=${MONITOR_PATHS:-"/etc /usr/local/etc"}
EMAIL=${EMAIL:-""}
REPORT="file_integrity_report-$(date +%F-%H%M).txt"
AIDE_DB="/var/lib/aide/aide.db"

if command -v aide &> /dev/null; then
    if [ "$1" == "init" ]; then
        echo "Initializing AIDE database..."
        sudo aideinit
        echo "AIDE database initialized."
    elif [ "$1" == "check" ]; then
        echo "Running AIDE check..."
        sudo aide --check > "$REPORT"
        echo "AIDE check complete. Report saved to $REPORT."
        if [ -n "$EMAIL" ] && [ -s "$REPORT" ]; then
            mail -s "File Integrity Report $(hostname)" "$EMAIL" < "$REPORT"
            echo "Report emailed to $EMAIL."
        fi
    else
        echo "Usage: $0 init|check"
        exit 1
    fi
else
    BASELINE_FILE="integrity_baseline.txt"
    ALERT_FILE="integrity_alerts.txt"
    if [ "$1" == "init" ]; then
        echo "Creating baseline checksums..."
        > "$BASELINE_FILE"
        for path in $MONITOR_PATHS; do
            if [ -e "$path" ]; then
                find "$path" -type f -exec sha256sum {} \; >> "$BASELINE_FILE"
            fi
        done
        echo "Baseline saved to $BASELINE_FILE."
    elif [ "$1" == "check" ]; then
        if [ ! -f "$BASELINE_FILE" ]; then
            echo "Baseline file not found. Run with 'init' first."
            exit 1
        fi
        echo "Checking for file integrity changes..."
        > "$ALERT_FILE"
        for path in $MONITOR_PATHS; do
            if [ -e "$path" ]; then
                find "$path" -type f -exec sha256sum {} \; | sort > current_checksums.txt
            fi
        done
        sort "$BASELINE_FILE" > baseline_sorted.txt
        diff baseline_sorted.txt current_checksums.txt > "$ALERT_FILE"
        if [ -s "$ALERT_FILE" ]; then
            echo "Integrity changes detected! See $ALERT_FILE."
            cp "$ALERT_FILE" "$REPORT"
            if [ -n "$EMAIL" ]; then
                mail -s "File Integrity Alert $(hostname)" "$EMAIL" < "$REPORT"
                echo "Alert emailed to $EMAIL."
            fi
        else
            echo "No file integrity changes detected."
            rm -f "$ALERT_FILE"
        fi
        rm -f current_checksums.txt baseline_sorted.txt
    else
        echo "Usage: $0 init|check"
        exit 1
    fi
fi 