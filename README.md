# system-hunter
---
System-Hunter will be a systemd service that analyzes suspicious and malicious
systemd services and configurations on linux systems. ATT&CK T1501 is the technique
of creating or modifying system processes, specifically the systemd service.
Adversaries modify or create these services to establish persistence and escalate
privileges. Many adversaries set malicious binaries to execute on reboot, this tool aims
to mitigate this. It will scan the systemd directories to include the user level paths and
identify any suspicious or malicious systemd activities to include modificationsa, creations, and deletions.

## How to Install
---
Run the following commands to start system-hunter on your machine:
```
1. cd /opt
2. sudo git clone https://github.com/korbincoward/system-hunter.git system-hunter
3. sudo cp /opt/system-hunter/hunter.service /etc/systemd/system/system-hunter.service
4. sudo systemctl daemon-reload
5. sudo systemctl enable system-hunter.service
6. sudo systemctl start system-hunter.service
```
Logs will be stored in `/var/log` in the `detected_changes.txt` file
