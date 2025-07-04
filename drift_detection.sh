#!/bin/bash
# drift_detection.sh - Detects configuration drift using checksums
# Usage: ./drift_detection.sh baseline|check
# Edit MONITOR_PATHS in config.sh or at the top of this script as needed.

[ -f ./config.sh ] && source ./config.sh
MONITOR_PATHS=${MONITOR_PATHS:-"/etc /usr/local/etc"}
BASELINE_FILE="drift_baseline.txt"
ALERT_FILE="drift_alerts.txt"

function create_baseline() {
    echo "Creating baseline checksums..."
    > "$BASELINE_FILE"
    for path in $MONITOR_PATHS; do
        if [ -e "$path" ]; then
            find "$path" -type f -exec sha256sum {} \; >> "$BASELINE_FILE"
        fi
    done
    echo "Baseline saved to $BASELINE_FILE."
}

function check_drift() {
    if [ ! -f "$BASELINE_FILE" ]; then
        echo "Baseline file not found. Run with 'baseline' first."
        exit 1
    fi
    echo "Checking for configuration drift..."
    > "$ALERT_FILE"
    for path in $MONITOR_PATHS; do
        if [ -e "$path" ]; then
            find "$path" -type f -exec sha256sum {} \; | sort > current_checksums.txt
        fi
    done
    sort "$BASELINE_FILE" > baseline_sorted.txt
    diff baseline_sorted.txt current_checksums.txt > "$ALERT_FILE"
    if [ -s "$ALERT_FILE" ]; then
        echo "Drift detected! See $ALERT_FILE."
    else
        echo "No configuration drift detected."
        rm -f "$ALERT_FILE"
    fi
    rm -f current_checksums.txt baseline_sorted.txt
}

case "$1" in
    baseline)
        create_baseline
        ;;
    check)
        check_drift
        ;;
    *)
        echo "Usage: $0 baseline|check"
        exit 1
        ;;
esac 