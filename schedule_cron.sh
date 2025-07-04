#!/bin/bash
# schedule_cron.sh - Helps schedule automation scripts via cron
# Usage: ./schedule_cron.sh
# Edit CRON_SCHEDULE and SCRIPT_PATH as needed.

# Example: Schedule log rotation daily at 2am
# (Uncomment to use)
# CRON_SCHEDULE="0 2 * * *"
# SCRIPT_PATH="/path/to/automation-suite/log_rotation.sh"
# (crontab -l; echo "$CRON_SCHEDULE $SCRIPT_PATH") | crontab -

# Example: Schedule resource monitoring every hour
# CRON_SCHEDULE="0 * * * *"
# SCRIPT_PATH="/path/to/automation-suite/resource_monitor.py"
# (crontab -l; echo "$CRON_SCHEDULE python3 $SCRIPT_PATH") | crontab -

# Add similar lines for other scripts as needed.

echo "Edit this script to add your desired cron jobs. See comments for examples." 