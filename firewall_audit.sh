#!/bin/bash
# firewall_audit.sh - Lists and audits firewall rules (iptables/ufw)
# Usage: sudo ./firewall_audit.sh

if command -v ufw &> /dev/null; then
    echo "UFW rules:"
    sudo ufw status verbose
elif command -v iptables &> /dev/null; then
    echo "iptables rules:"
    sudo iptables -L -v -n
else
    echo "No supported firewall (ufw or iptables) found."
    exit 1
fi 