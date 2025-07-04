#!/bin/bash
# mount_check.sh: Check if critical filesystems are mounted (cross-platform)

FILESYSTEMS=("/" "/home" "/var")
if [[ "$OSTYPE" == "linux"* ]]; then
    for FS in "${FILESYSTEMS[@]}"; do
        if command -v mountpoint &>/dev/null; then
            mountpoint -q "$FS"
            if [ $? -eq 0 ]; then
                echo "$FS is mounted."
            else
                echo "ALERT: $FS is NOT mounted!"
            fi
        else
            echo "mountpoint command not found."
        fi
    done
elif [[ "$OS" == "Windows_NT" ]]; then
    powershell.exe Get-PSDrive | grep -E 'C|D|E|F' | awk '{print $3}'
    echo "Checked Windows drives."
else
    echo "Unsupported OS."
fi 