#/bin/bash

#Exit on error
set -e 

#Variables
SERVICE_NAME="hunter.service"
SCRIPT_NAME="hunter.py"
echo "Select installation directory:"
read directory
INSTALL_DIR="$directory/system-hunter"
LOG_DIR="/var/log/system-hunter"
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME"

# Pre installation tasks
echo "Starting pre-installation tasks..."
if [[ $USER = 'root' ]]; then
    mkdir -p $INSTALL_DIR
    git clone https://github.com/korbincoward/system-hunter.git $INSTALL_DIR
    cp $INSTALL_DIR/$SERVICE_NAME $SERVICE_FILE
    echo "Pre-installation tasks completed."
else
    echo "Please run this script as root or with sudo."
    exit 1
fi

#Systemd setup
systemctl daemon-reload
systemctl enable $SERVICE_NAME
systemctl start $SERVICE_NAME

#Securing installation
echo "Securing installation..."
sudo adduser --system --no-create-home --group systemhunter
sudo chown -R systemhunter:systemhunter $INSTALL_DIR
sudo chmod 700 $INSTALL_DIR/$SCRIPT_NAME
sudo chmod 640 $SERVICE_FILE    
declare -r status=$(systemctl is-active $SERVICE_NAME)
#Check 
if [ "$status" = "active" ]; then
    echo "Installation complete. The service is now running."
    else
    echo "Installation failed. The service is not running."
    exit 1
fi