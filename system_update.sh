#!/bin/bash
# system_update.sh - Automates system updates
# Usage: sudo ./system_update.sh

if [ -x "$(command -v apt)" ]; then
    echo "Updating system with apt..."
    sudo apt update && sudo apt upgrade -y
elif [ -x "$(command -v yum)" ]; then
    echo "Updating system with yum..."
    sudo yum update -y
else
    echo "No supported package manager found (apt or yum)."
    exit 1
fi

echo "System update complete." 