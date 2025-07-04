#!/bin/bash
# user_access_review.sh - Automated user access review
# Usage: ./user_access_review.sh
# Edit EMAIL in config.sh or at the top of this script as needed.

[ -f ./config.sh ] && source ./config.sh
EMAIL=${EMAIL:-""}
REPORT="user_access_review-$(date +%F-%H%M).txt"

> "$REPORT"
echo "User Access Review Report - $(date)" >> "$REPORT"

echo -e "\n--- All User Accounts ---" >> "$REPORT"
cut -d: -f1,3,4,7 /etc/passwd | column -t -s: >> "$REPORT"

echo -e "\n--- Sudoers ---" >> "$REPORT"
if [ -f /etc/sudoers ]; then
    grep -vE '^#|^$' /etc/sudoers >> "$REPORT"
fi
if [ -d /etc/sudoers.d ]; then
    for f in /etc/sudoers.d/*; do
        [ -f "$f" ] && echo -e "\nFile: $f" >> "$REPORT" && grep -vE '^#|^$' "$f" >> "$REPORT"
    done
fi

echo -e "\n--- Group Memberships ---" >> "$REPORT"
getent group | awk -F: 'length($4)>0 {print $1 ": " $4}' >> "$REPORT"

echo "User access review complete. Report saved to $REPORT."

if [ -n "$EMAIL" ] && [ -s "$REPORT" ]; then
    mail -s "User Access Review $(hostname)" "$EMAIL" < "$REPORT"
    echo "Report emailed to $EMAIL."
fi 