#!/bin/bash
# process_monitor.sh: Monitor critical processes (cross-platform)

PROCESSES=("sshd" "cron" "nginx")
if [[ "$OSTYPE" == "linux"* ]]; then
    for PROC in "${PROCESSES[@]}"; do
        if command -v pgrep &>/dev/null; then
            if ! pgrep -x "$PROC" > /dev/null; then
                echo "ALERT: $PROC is not running!"
            else
                echo "$PROC is running."
            fi
        else
            echo "pgrep not found."
        fi
    done
elif [[ "$OS" == "Windows_NT" ]]; then
    for PROC in "${PROCESSES[@]}"; do
        powershell.exe Get-Process -Name "$PROC" -ErrorAction SilentlyContinue | grep "$PROC" > /dev/null
        if [ $? -ne 0 ]; then
            echo "ALERT: $PROC is not running!"
        else
            echo "$PROC is running."
        fi
    done
else
    echo "Unsupported OS."
fi 