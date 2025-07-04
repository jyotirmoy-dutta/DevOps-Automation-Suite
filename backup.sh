#!/bin/bash
# backup.sh - Automates backup of important directories/files
# Usage: ./backup.sh
# Edit SRC, DEST, and RETENTION_DAYS as needed.

SRC="/etc /home"
DEST="/backup"
RETENTION_DAYS=7
DATE=$(date +%F)
BACKUP_FILE="$DEST/backup-$DATE.tar.gz"

mkdir -p "$DEST"
tar -czf "$BACKUP_FILE" $SRC
find "$DEST" -name "backup-*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;
echo "Backup complete: $BACKUP_FILE" 