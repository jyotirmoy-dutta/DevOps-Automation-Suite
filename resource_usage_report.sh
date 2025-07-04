#!/bin/bash
# resource_usage_report.sh: Generate resource usage report (cross-platform)

REPORT="resource_usage_$(date +%Y%m%d_%H%M%S).txt"
if [[ "$OSTYPE" == "linux"* ]]; then
    echo "Resource Usage Report - $(date)" > "$REPORT"
    echo "\nCPU Usage:" >> "$REPORT"
    command -v top &>/dev/null && top -b -n1 | head -20 >> "$REPORT"
    echo "\nMemory Usage:" >> "$REPORT"
    command -v free &>/dev/null && free -h >> "$REPORT"
    echo "\nDisk Usage:" >> "$REPORT"
    df -h >> "$REPORT"
    echo "\nNetwork Usage:" >> "$REPORT"
    command -v ip &>/dev/null && ip -s link >> "$REPORT"
    echo "Report saved to $REPORT"
elif [[ "$OS" == "Windows_NT" ]]; then
    echo "Resource Usage Report - $(date)" > "$REPORT"
    echo "\nCPU Usage:" >> "$REPORT"
    powershell.exe Get-WmiObject win32_processor | powershell.exe Format-List >> "$REPORT"
    echo "\nMemory Usage:" >> "$REPORT"
    powershell.exe Get-WmiObject win32_OperatingSystem | powershell.exe Format-List >> "$REPORT"
    echo "\nDisk Usage:" >> "$REPORT"
    powershell.exe Get-WmiObject win32_logicaldisk | powershell.exe Format-List >> "$REPORT"
    echo "\nNetwork Usage:" >> "$REPORT"
    powershell.exe Get-NetAdapterStatistics >> "$REPORT"
    echo "Report saved to $REPORT"
else
    echo "Unsupported OS."
fi 