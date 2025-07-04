#!/bin/bash
# config_backup.sh: Backup configuration files (cross-platform)

if [[ "$OSTYPE" == "linux"* ]]; then
    BACKUP_DIR="/var/backups/etc_$(date +%Y%m%d)"
    if [ -d /etc ]; then
        mkdir -p "$BACKUP_DIR"
        cp -a /etc/* "$BACKUP_DIR"/
        echo "Configuration files from /etc backed up to $BACKUP_DIR"
    else
        echo "/etc does not exist."
    fi
elif [[ "$OS" == "Windows_NT" ]]; then
    BACKUP_DIR="$HOME/config_backup_$(date +%Y%m%d)"
    mkdir -p "$BACKUP_DIR"
    TMP_PS1=$(mktemp --suffix=.ps1)
    cat > "$TMP_PS1" <<'EOF'
$dest = "$BACKUP_DIR"
$src = Join-Path $env:windir 'System32\config\*'
Copy-Item -Path $src -Destination $dest -Recurse -Force
EOF
    powershell.exe -ExecutionPolicy Bypass -File "$TMP_PS1"
    rm -f "$TMP_PS1"
    echo "Windows config files backed up to $BACKUP_DIR"
else
    echo "Unsupported OS."
fi 