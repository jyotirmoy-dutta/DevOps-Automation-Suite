#!/bin/bash
# swap_monitor.sh: Monitor swap usage (cross-platform)

THRESHOLD=80
if [[ "$OSTYPE" == "linux"* ]]; then
    if command -v free &>/dev/null; then
        SWAP_USED=$(free | awk '/Swap:/ {if ($2>0) printf("%.0f", $3/$2*100); else print 0}')
        if [ "$SWAP_USED" -ge "$THRESHOLD" ]; then
            echo "ALERT: Swap usage is at $SWAP_USED%"
        else
            echo "Swap usage is at $SWAP_USED%"
        fi
    else
        echo "free command not found."
    fi
elif [[ "$OS" == "Windows_NT" ]]; then
    TMP_PS1=$(mktemp --suffix=.ps1)
    cat > "$TMP_PS1" <<'EOF'
$THRESHOLD = 80
Get-WmiObject Win32_PageFileUsage | ForEach-Object {
    if ($_.AllocatedBaseSize -gt 0) {
        $pct = ($_.CurrentUsage / $_.AllocatedBaseSize) * 100
        Write-Output "Swap usage is at $pct%"
        if ($pct -ge $THRESHOLD) {
            Write-Output "ALERT: Swap usage is at $pct%"
        }
    }
}
EOF
    powershell.exe -ExecutionPolicy Bypass -File "$TMP_PS1"
    rm -f "$TMP_PS1"
else
    echo "Unsupported OS."
fi 