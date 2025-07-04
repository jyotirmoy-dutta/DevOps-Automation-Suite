#!/usr/bin/env python3
"""
network_monitor.py - Monitors network connectivity and bandwidth.
Usage: python3 network_monitor.py
"""
import psutil
import subprocess
import time

def ping(host="8.8.8.8"):
    try:
        output = subprocess.check_output(["ping", "-c", "2", host], universal_newlines=True)
        print(f"Ping to {host} successful:")
        print(output)
    except subprocess.CalledProcessError:
        print(f"Ping to {host} failed.")

def network_usage(interval=1):
    net1 = psutil.net_io_counters()
    time.sleep(interval)
    net2 = psutil.net_io_counters()
    sent = (net2.bytes_sent - net1.bytes_sent) / interval / 1024
    recv = (net2.bytes_recv - net1.bytes_recv) / interval / 1024
    print(f"Upload: {sent:.2f} KB/s, Download: {recv:.2f} KB/s")

def main():
    ping()
    network_usage()

if __name__ == "__main__":
    main() 