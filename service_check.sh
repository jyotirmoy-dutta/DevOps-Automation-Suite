#!/bin/bash
# service_check.sh - Checks and restarts critical services if needed
# Usage: sudo ./service_check.sh
# Edit SERVICES array as needed.

SERVICES=("ssh" "cron")

for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$SERVICE"; then
        echo "$SERVICE is running."
    else
        echo "$SERVICE is not running. Attempting to restart..."
        sudo systemctl restart "$SERVICE"
        if systemctl is-active --quiet "$SERVICE"; then
            echo "$SERVICE restarted successfully."
        else
            echo "Failed to restart $SERVICE!"
        fi
    fi
done 