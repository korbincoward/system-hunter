#bin/bash
# This script installs the system hunter service.
set -e 
cd /opt && sudo git clone https://github.com/korbincoward/system-hunter.git system-hunter
sudo cp /opt/system-hunter/hunter.service /etc/systemd/system/system-hunter.service
sudo systemctl daemon-reload
sudo systemctl enable system-hunter.servicesudo systemctl start system-hunter.service

