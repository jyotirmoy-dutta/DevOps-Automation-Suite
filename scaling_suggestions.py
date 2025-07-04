#!/usr/bin/env python3
"""
scaling_suggestions.py - Automated resource scaling suggestions
Usage: python3 scaling_suggestions.py
Edit thresholds and email in config.sh or at the top of this script as needed.
"""
import os
import psutil
import smtplib
from email.mime.text import MIMEText
from datetime import datetime

# Load config.sh variables if present
config_vars = {}
if os.path.exists('config.sh'):
    with open('config.sh') as f:
        for line in f:
            if '=' in line and not line.strip().startswith('#'):
                k, v = line.strip().split('=', 1)
                config_vars[k.strip()] = v.strip('"')

CPU_THRESHOLD = int(config_vars.get('THRESHOLD', 80))
MEM_THRESHOLD = int(config_vars.get('THRESHOLD', 80))
DISK_THRESHOLD = int(config_vars.get('THRESHOLD', 80))
EMAIL = config_vars.get('EMAIL', '')
REPORT = f"scaling_suggestions_report-{datetime.now().strftime('%Y-%m-%d-%H%M')}.txt"

# Collect current usage
cpu = psutil.cpu_percent(interval=1)
mem = psutil.virtual_memory().percent
disk = psutil.disk_usage('/').percent

suggestions = []
if cpu > CPU_THRESHOLD:
    suggestions.append(f"Consider scaling UP: CPU usage is high ({cpu}%).")
if cpu < 20:
    suggestions.append(f"Consider scaling DOWN: CPU usage is low ({cpu}%).")
if mem > MEM_THRESHOLD:
    suggestions.append(f"Consider scaling UP: Memory usage is high ({mem}%).")
if mem < 20:
    suggestions.append(f"Consider scaling DOWN: Memory usage is low ({mem}%).")
if disk > DISK_THRESHOLD:
    suggestions.append(f"Consider scaling UP: Disk usage is high ({disk}%).")
if disk < 20:
    suggestions.append(f"Consider scaling DOWN: Disk usage is low ({disk}%).")

with open(REPORT, 'w') as f:
    f.write(f"Resource Scaling Suggestions Report - {datetime.now()}\n")
    f.write(f"CPU Usage: {cpu}%\nMemory Usage: {mem}%\nDisk Usage: {disk}%\n\n")
    if suggestions:
        f.write("SUGGESTIONS:\n")
        for s in suggestions:
            f.write(f"- {s}\n")
    else:
        f.write("No scaling suggestions at this time.\n")

print(f"Scaling suggestions report saved to {REPORT}.")

if EMAIL and suggestions:
    msg = MIMEText('\n'.join(suggestions))
    msg['Subject'] = f'Scaling Suggestions {os.uname().nodename}'
    msg['From'] = EMAIL
    msg['To'] = EMAIL
    try:
        with smtplib.SMTP('localhost') as server:
            server.sendmail(EMAIL, [EMAIL], msg.as_string())
        print(f"Suggestions emailed to {EMAIL}.")
    except Exception as e:
        print(f"Failed to send email: {e}") 