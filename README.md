# system-hunter
---
System-Hunter is a systemd service that analyzes the directories of systemd and reports activities to a log file. System-Hunter currently logs the creation, modification, and deletion of files within the specified directories and puts them into a log file that includes a date and timestamp, the directory where the event occurred, and the name of the service the event affected. System-Hunter was created to be a lightweight service that when used in conjunction with other tools will offer more insight to adversary movements and provide better TTP management.

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
