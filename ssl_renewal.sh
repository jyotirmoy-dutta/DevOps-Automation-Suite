#!/bin/bash
# ssl_renewal.sh - Automates SSL certificate renewal with Let's Encrypt (certbot)
# Usage: sudo ./ssl_renewal.sh

if ! command -v certbot &> /dev/null; then
    echo "certbot not found. Please install certbot first."
    exit 1
fi

echo "Renewing SSL certificates..."
sudo certbot renew --quiet
if [ $? -eq 0 ]; then
    echo "SSL certificate renewal complete."
else
    echo "SSL certificate renewal failed!"
fi 