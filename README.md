# DevOps Automation Suite

A comprehensive, cross-platform collection of Bash and Python scripts to automate IT operations, system administration, and DevOps workflows. This suite empowers teams to streamline monitoring, backup, compliance, reporting, and remediation tasks—on both Linux and Windows environments.

---

## 🚀 Features

- **Cross-Platform:** Most scripts auto-detect and adapt to Linux or Windows.
- **Modular:** Use scripts independently or orchestrate as a suite.
- **Covers Key DevOps Areas:**
  - System & resource monitoring
  - Log management & rotation
  - Backup & restore (files, databases, configs)
  - Security & compliance audits
  - Patch management & rollback
  - Incident & inventory reporting
  - User & access management
  - Docker/container cleanup
  - Network & firewall audits
  - Automated notifications
- **Easy Integration:** Schedule via cron, Task Scheduler, or CI/CD pipelines.

---

## 📂 Script Index

| Script Name                | Description                                      | OS Support      |
|----------------------------|--------------------------------------------------|-----------------|
| `log_rotation.sh`          | Log file rotation and cleanup                    | Linux, Windows  |
| `system_update.sh`         | System updates (apt/yum/Windows Update)          | Linux, Windows  |
| `resource_monitor.py`      | CPU, memory, disk monitoring (with alerts)       | Linux, Windows  |
| `disk_alert.sh`            | Disk usage checks and alerts                     | Linux, Windows  |
| `service_check.sh`         | Service status checks and restarts               | Linux, Windows  |
| `user_management.sh`       | User creation, deletion, password resets         | Linux, Windows  |
| `backup.sh`                | Directory/file backup                            | Linux, Windows  |
| `config_backup.sh`         | System config backup (cross-platform)            | Linux, Windows  |
| `db_backup_restore.sh`     | MySQL/PostgreSQL backup & restore                | Linux           |
| `security_audit.sh`        | Security checks (ports, logins, etc.)            | Linux, Windows  |
| `network_monitor.py`       | Network connectivity and bandwidth monitoring    | Linux, Windows  |
| `email_notify.py`          | Email notifications (used by other scripts)      | Linux, Windows  |
| `schedule_cron.sh`         | Schedule scripts via cron                        | Linux           |
| `ssl_renewal.sh`           | SSL certificate renewal (Let's Encrypt)          | Linux           |
| `docker_cleanup.sh`        | Docker containers/images/volumes cleanup         | Linux           |
| `deploy_app.sh`            | Deploy app from Git                              | Linux, Windows  |
| `log_aggregate.sh`         | Aggregate and compress logs                      | Linux, Windows  |
| `firewall_audit.sh`        | Firewall rules audit                             | Linux, Windows  |
| `inventory_report.sh`      | System inventory report                          | Linux, Windows  |
| `patch_compliance.sh`      | Patch compliance check                           | Linux, Windows  |
| `incident_report.sh`       | Automated incident report                        | Linux, Windows  |
| ...and many more!          |                                                  |                 |

> See each script's header for details and usage.

---

## 🛠️ Getting Started

1. **Clone the repository:**
   ```sh
   git clone https://github.com/your-org/devopAutomation.git
   cd devopAutomation/automation-suite
   ```

2. **Install Python dependencies (if using Python scripts):**
   ```sh
   pip install -r requirements.txt
   ```

3. **Make shell scripts executable (Linux/macOS):**
   ```sh
   chmod +x *.sh
   ```

4. **Edit configuration variables as needed:**
   - Use `config.sh` or a `.env` file for environment-specific settings.
   - Example:
     ```sh
     EMAIL="admin@example.com"
     LOG_DIR="/var/log"
     BACKUP_DIR="/backup"
     THRESHOLD=80
     ```

5. **Run scripts directly or schedule via cron/Task Scheduler.**

---

## 🧪 Automated Testing

A master test script is included:

```sh
bash test_all.sh
```

- Runs all `.sh` scripts, logs output, and summarizes results.
- Check `test_<script>.log` for details on failures.

---

## 💡 Usage Examples

- **Log Rotation:**  
  `./log_rotation.sh`
- **System Update:**  
  `sudo ./system_update.sh`
- **Resource Monitoring:**  
  `python3 resource_monitor.py`
- **Database Backup:**  
  `./db_backup_restore.sh backup`
- **Incident Report:**  
  `./incident_report.sh`

---

## 🔒 Security & Compliance

- Scripts for patch compliance, user access review, firewall audit, and vulnerability scanning.
- Easily extendable for your organization's policies.

---

## ☁️ Cloud & Container Support

- AWS, Azure, and GCP inventory/reporting (extendable).
- Docker and container cleanup scripts included.

---

## 🤝 Contributing

- Fork, branch, and submit pull requests!
- Request new features or integrations via GitHub Issues.
- All scripts are modular and easy to extend.

---

## 🙋 Support

For questions, feature requests, or customizations, open an issue or contact your DevOps team.

---

**Empower your IT operations with automation.  
Contributions welcome!** 
