#/bin/bash

#Exit on error
set -e 

sudo git clone https://github.com/korbincoward/system-hunter.git /opt/system-hunter

sudo cp /opt/system-hunter/hunter.service /etc/systemd/system/system-hunter.service

#Creates a system user that does not have a home directory or shell access
#This is a security measure to prevent unauthorized access to the system
sudo adduser --system --no-create-home --shell /usr/sbin/nologin --group systemhunter

#Secure the service file and script
sudo chmod 640 /etc/systemd/system/system-hunter.service
sudo chown root:systemhunter /etc/systemd/system/system-hunter.service
sudo chmod 740 /opt/system-hunter/hunter.py
sudo chown systemhunter:systemhunter /opt/system-hunter/hunter.py

#Configure logrotate
sudo tee /etc/logrotate.d/system-hunter > /dev/null <<EOL
/var/log/system-hunter/detected_changes.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    create 640 systemhunter systemhunter
}
EOL
sudo logrotate -f /etc/logrotate.d/system-hunter

#Setup systemd service
sudo systemctl daemon-reload
sudo systemctl enable system-hunter.service
sudo systemctl start system-hunter.service

echo "System Hunter has been installed and started successfully."