#!/bin/bash
# log_rotation.sh - Automates log file rotation and cleanup
# Usage: ./log_rotation.sh
# Edit LOG_DIR, RETENTION_DAYS, and LOG_PATTERN as needed.

LOG_DIR="/var/log"
RETENTION_DAYS=7
LOG_PATTERN="*.log"

find "$LOG_DIR" -name "$LOG_PATTERN" -type f -mtime +$RETENTION_DAYS -exec rm -f {} \;
echo "Log rotation complete for $LOG_DIR ($LOG_PATTERN), older than $RETENTION_DAYS days." 