#!/bin/bash
# temp_cleanup.sh: Clean up temp files older than 7 days (cross-platform)

if [[ "$OSTYPE" == "linux"* ]]; then
    [ -d /tmp ] && find /tmp -type f -mtime +7 -exec rm -f {} +
    [ -d /var/tmp ] && find /var/tmp -type f -mtime +7 -exec rm -f {} +
    echo "Temporary files older than 7 days have been removed from /tmp and /var/tmp."
elif [[ "$OS" == "Windows_NT" ]]; then
    powershell.exe -Command "Get-ChildItem -Path $env:TEMP -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force -ErrorAction SilentlyContinue"
    echo "Temporary files older than 7 days have been removed from %TEMP%."
else
    echo "Unsupported OS."
fi 