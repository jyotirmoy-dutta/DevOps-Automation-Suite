#!/bin/bash
# patch_rollback.sh - Automated security patch rollback for apt/yum systems
# Usage: sudo ./patch_rollback.sh list|rollback

if [ -x "$(command -v apt)" ]; then
    if [ "$1" == "list" ]; then
        echo "Recently installed packages (apt):"
        grep " install " /var/log/dpkg.log | tail -20
    elif [ "$1" == "rollback" ]; then
        echo "Rolling back last apt upgrade (using apt-mark and apt-get)..."
        echo "This will attempt to downgrade packages marked as manually installed in the last upgrade."
        echo "Manual intervention may be required."
        # List last 10 manually installed packages
        grep " install " /var/log/dpkg.log | tail -10 | awk '{print $4}' > rollback_list.txt
        for pkg in $(cat rollback_list.txt); do
            sudo apt-get install --reinstall $pkg
        done
        echo "Rollback attempted for packages in rollback_list.txt."
    else
        echo "Usage: $0 list|rollback"
        exit 1
    fi
elif [ -x "$(command -v yum)" ]; then
    if [ "$1" == "list" ]; then
        echo "Recently updated packages (yum):"
        grep Updated /var/log/yum.log | tail -20
    elif [ "$1" == "rollback" ]; then
        echo "Rolling back last yum update (using yum history)..."
        sudo yum history
        echo "Enter the transaction ID to rollback:"
        read TXID
        sudo yum history undo $TXID
        echo "Rollback attempted for transaction $TXID."
    else
        echo "Usage: $0 list|rollback"
        exit 1
    fi
else
    echo "No supported package manager found (apt or yum)."
    exit 1
fi 