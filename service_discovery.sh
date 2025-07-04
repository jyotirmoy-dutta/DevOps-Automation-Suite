#!/bin/bash
# service_discovery.sh - Automated service discovery and inventory
# Usage: ./service_discovery.sh
# Edit NETWORK_RANGE in config.sh or at the top of this script as needed.

[ -f ./config.sh ] && source ./config.sh
NETWORK_RANGE=${NETWORK_RANGE:-"192.168.1.0/24"}
REPORT="service_discovery_report-$(date +%F-%H%M).txt"

> "$REPORT"
echo "Service Discovery Report - $(date)" >> "$REPORT"

# Network scan for active hosts and open ports (requires nmap)
if command -v nmap &> /dev/null; then
    echo -e "\n--- Network Scan ($NETWORK_RANGE) ---" >> "$REPORT"
    nmap -sP "$NETWORK_RANGE" >> "$REPORT"
    echo -e "\n--- Open Ports on Active Hosts ---" >> "$REPORT"
    nmap -p 1-1024 "$NETWORK_RANGE" >> "$REPORT"
else
    echo "nmap not found. Please install nmap for network scanning features." >> "$REPORT"
fi

# List running services on local machine
echo -e "\n--- Local Running Services ---" >> "$REPORT"
if command -v systemctl &> /dev/null; then
    systemctl list-units --type=service --state=running >> "$REPORT"
else
    service --status-all 2>&1 | grep '+' >> "$REPORT"
fi

echo "Service discovery complete. Report saved to $REPORT." 