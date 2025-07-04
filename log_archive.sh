#!/bin/bash
# log_archive.sh: Archive old logs (cross-platform)

if [[ "$OSTYPE" == "linux"* ]]; then
    LOG_DIR="/var/log"
    ARCHIVE_DIR="/var/log/archive"
    DAYS=30
    if [ -d "$LOG_DIR" ]; then
        mkdir -p "$ARCHIVE_DIR"
        find "$LOG_DIR" -type f -mtime +$DAYS ! -path "$ARCHIVE_DIR/*" -exec tar -czf "$ARCHIVE_DIR/logs_$(date +%Y%m%d).tar.gz" {} +
        echo "Archived logs older than $DAYS days to $ARCHIVE_DIR"
    else
        echo "$LOG_DIR does not exist."
    fi
elif [[ "$OS" == "Windows_NT" ]]; then
    LOG_DIR="C:/Windows/Temp"
    ARCHIVE_DIR="C:/Windows/Temp/archive"
    mkdir -p "$ARCHIVE_DIR" 2>/dev/null
    powershell.exe Compress-Archive -Path "$LOG_DIR/*" -DestinationPath "$ARCHIVE_DIR/logs_$(date +%Y%m%d).zip"
    echo "Archived logs to $ARCHIVE_DIR"
else
    echo "Unsupported OS."
fi

# Optionally, remove archived logs
# find "$LOG_DIR" -type f -mtime +$DAYS ! -path "$ARCHIVE_DIR/*" -delete 