#!/usr/bin/env python3
"""
email_notify.py - Sends email notifications.
Usage: python3 email_notify.py "Subject" "Message" "to@example.com"
Can also be imported as a module.
"""
import smtplib
import sys
from email.mime.text import MIMEText

EMAIL_FROM = "monitor@example.com"
SMTP_SERVER = "localhost"

def send_email(subject, body, to_email):
    msg = MIMEText(body)
    msg["Subject"] = subject
    msg["From"] = EMAIL_FROM
    msg["To"] = to_email
    with smtplib.SMTP(SMTP_SERVER) as server:
        server.sendmail(EMAIL_FROM, [to_email], msg.as_string())

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python3 email_notify.py 'Subject' 'Message' 'to@example.com'")
        sys.exit(1)
    subject, message, to_email = sys.argv[1:4]
    send_email(subject, message, to_email)
    print("Email sent.") 