#!/bin/bash
# db_backup_restore.sh - Backup and restore MySQL/PostgreSQL/MongoDB/Oracle databases
# Usage: ./db_backup_restore.sh backup|restore
# Edit variables in config.sh or at the top of this script as needed.

[ -f ./config.sh ] && source ./config.sh

DB_TYPE=${DB_TYPE:-mysql} # mysql, postgres, mongo, oracle
DB_NAME=${DB_NAME:-mydb}
USER=${USER:-dbuser}
PASS=${PASS:-dbpass}
HOST=${HOST:-localhost}
BACKUP_DIR=${BACKUP_DIR:-/backup/db}
DATE=$(date +%F)
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$DATE.sql.gz"

mkdir -p "$BACKUP_DIR"

if [ "$1" == "backup" ]; then
    if [ "$DB_TYPE" == "mysql" ]; then
        mysqldump -h "$HOST" -u "$USER" -p"$PASS" "$DB_NAME" | gzip > "$BACKUP_FILE"
    elif [ "$DB_TYPE" == "postgres" ]; then
        PGPASSWORD="$PASS" pg_dump -h "$HOST" -U "$USER" "$DB_NAME" | gzip > "$BACKUP_FILE"
    elif [ "$DB_TYPE" == "mongo" ]; then
        mongodump --host "$HOST" --username "$USER" --password "$PASS" --db "$DB_NAME" --archive | gzip > "$BACKUP_FILE"
    elif [ "$DB_TYPE" == "oracle" ]; then
        echo "Oracle backup not implemented. Please add your backup command here."
        exit 1
    else
        echo "Unsupported DB_TYPE: $DB_TYPE"
        exit 1
    fi
    echo "Database backup complete: $BACKUP_FILE"
elif [ "$1" == "restore" ]; then
    if [ ! -f "$BACKUP_FILE" ]; then
        echo "Backup file not found: $BACKUP_FILE"
        exit 1
    fi
    if [ "$DB_TYPE" == "mysql" ]; then
        gunzip < "$BACKUP_FILE" | mysql -h "$HOST" -u "$USER" -p"$PASS" "$DB_NAME"
    elif [ "$DB_TYPE" == "postgres" ]; then
        gunzip < "$BACKUP_FILE" | PGPASSWORD="$PASS" psql -h "$HOST" -U "$USER" "$DB_NAME"
    elif [ "$DB_TYPE" == "mongo" ]; then
        gunzip < "$BACKUP_FILE" | mongorestore --host "$HOST" --username "$USER" --password "$PASS" --db "$DB_NAME" --archive
    elif [ "$DB_TYPE" == "oracle" ]; then
        echo "Oracle restore not implemented. Please add your restore command here."
        exit 1
    else
        echo "Unsupported DB_TYPE: $DB_TYPE"
        exit 1
    fi
    echo "Database restore complete."
else
    echo "Usage: $0 backup|restore"
    exit 1
fi 