#!/bin/bash
# cert_expiry_monitor.sh - Monitors SSL/TLS certificate expiry for domains or files
# Usage: ./cert_expiry_monitor.sh
# Edit CERT_DOMAINS, CERT_FILES, EMAIL, and WARNING_DAYS in config.sh or at the top of this script as needed.

[ -f ./config.sh ] && source ./config.sh
CERT_DOMAINS=${CERT_DOMAINS:-"example.com"}
CERT_FILES=${CERT_FILES:-""}
EMAIL=${EMAIL:-""}
WARNING_DAYS=${WARNING_DAYS:-30}
REPORT="cert_expiry_report-$(date +%F-%H%M).txt"

> "$REPORT"
echo "Certificate Expiry Report - $(date)" >> "$REPORT"

# Check remote domains
for domain in $CERT_DOMAINS; do
    echo -n "$domain: " >> "$REPORT"
    end_date=$(echo | openssl s_client -servername "$domain" -connect "$domain":443 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f2)
    if [ -n "$end_date" ]; then
        end_epoch=$(date -d "$end_date" +%s)
        now_epoch=$(date +%s)
        days_left=$(( (end_epoch - now_epoch) / 86400 ))
        echo "$days_left days left (expires $end_date)" >> "$REPORT"
        if [ "$days_left" -le "$WARNING_DAYS" ]; then
            echo "WARNING: $domain certificate expires in $days_left days!" >> "$REPORT"
        fi
    else
        echo "Could not retrieve certificate info." >> "$REPORT"
    fi
done

# Check local cert files
for file in $CERT_FILES; do
    if [ -f "$file" ]; then
        echo -n "$file: " >> "$REPORT"
        end_date=$(openssl x509 -in "$file" -noout -enddate | cut -d= -f2)
        if [ -n "$end_date" ]; then
            end_epoch=$(date -d "$end_date" +%s)
            now_epoch=$(date +%s)
            days_left=$(( (end_epoch - now_epoch) / 86400 ))
            echo "$days_left days left (expires $end_date)" >> "$REPORT"
            if [ "$days_left" -le "$WARNING_DAYS" ]; then
                echo "WARNING: $file certificate expires in $days_left days!" >> "$REPORT"
            fi
        else
            echo "Could not retrieve certificate info." >> "$REPORT"
        fi
    fi
done

echo "Certificate expiry check complete. Report saved to $REPORT."

if [ -n "$EMAIL" ] && [ -s "$REPORT" ]; then
    mail -s "Certificate Expiry Report $(hostname)" "$EMAIL" < "$REPORT"
    echo "Report emailed to $EMAIL."
fi 