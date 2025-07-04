#!/bin/bash
# log_aggregate.sh - Aggregates and compresses logs for archiving
# Usage: ./log_aggregate.sh
# Edit LOG_DIR and ARCHIVE_DEST as needed.

LOG_DIR="/var/log"
ARCHIVE_DEST="/archive"
DATE=$(date +%F)
ARCHIVE_FILE="$ARCHIVE_DEST/logs-$DATE.tar.gz"

mkdir -p "$ARCHIVE_DEST"
tar -czf "$ARCHIVE_FILE" -C "$LOG_DIR" .
echo "Logs aggregated and compressed to $ARCHIVE_FILE." 