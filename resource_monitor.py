#!/usr/bin/env python3
"""
resource_monitor.py - Monitors CPU, memory, and disk usage.
Usage: python3 resource_monitor.py
Edit thresholds and email settings as needed.
"""
import psutil
import smtplib
from email.mime.text import MIMEText

# Thresholds
CPU_THRESHOLD = 80  # percent
MEM_THRESHOLD = 80  # percent
DISK_THRESHOLD = 80  # percent

# Email settings (edit as needed)
SEND_EMAIL = False
EMAIL_TO = "admin@example.com"
EMAIL_FROM = "monitor@example.com"
SMTP_SERVER = "localhost"


def send_email(subject, body):
    msg = MIMEText(body)
    msg["Subject"] = subject
    msg["From"] = EMAIL_FROM
    msg["To"] = EMAIL_TO
    with smtplib.SMTP(SMTP_SERVER) as server:
        server.sendmail(EMAIL_FROM, [EMAIL_TO], msg.as_string())


def main():
    cpu = psutil.cpu_percent(interval=1)
    mem = psutil.virtual_memory().percent
    disk = psutil.disk_usage("/").percent
    print(f"CPU Usage: {cpu}%")
    print(f"Memory Usage: {mem}%")
    print(f"Disk Usage: {disk}%")
    alerts = []
    if cpu > CPU_THRESHOLD:
        alerts.append(f"High CPU usage: {cpu}%")
    if mem > MEM_THRESHOLD:
        alerts.append(f"High Memory usage: {mem}%")
    if disk > DISK_THRESHOLD:
        alerts.append(f"High Disk usage: {disk}%")
    if alerts:
        print("ALERTS:")
        for alert in alerts:
            print(alert)
        if SEND_EMAIL:
            send_email("Resource Monitor Alert", "\n".join(alerts))

if __name__ == "__main__":
    main() 