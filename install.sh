#/bin/bash

#Exit on error
set -e 

sudo git clone https://github.com/korbincoward/system-hunter.git /opt/system-hunter

sudo cp /opt/system-hunter/hunter.service /etc/systemd/system/system-hunter.service

#Creates a system user that does not have a home directory or shell access
sudo adduser --system --no-create-home --shell /usr/sbin/nologin --group systemhunter

# Create log directory and file
sudo mkdir -p /var/log/system-hunter
sudo touch /var/log/system-hunter/detected_changes.log
sudo chown -R systemhunter:systemhunter /var/log/system-hunter
sudo chmod 750 /var/log/system-hunter
sudo chmod 640 /var/log/system-hunter/detected_changes.log


#Setup systemd service
sudo systemctl daemon-reload
sudo systemctl enable system-hunter.service
sudo systemctl start system-hunter.service

echo "System Hunter has been installed and started successfully."