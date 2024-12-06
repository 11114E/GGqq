#!/bin/bash
SERVICE_FILE=/etc/systemd/system/para.service
curl -s https://raw.githubusercontent.com/qrux-opterator/clustermaster/main/install_service | sudo bash
sudo sed -i '/^ExecStart=/c\ExecStart=/bin/bash /root/ceremonyclient/node/para.sh linux amd64 79 24 2.0.5' $SERVICE_FILE
sudo systemctl daemon-reload
echo 'para.service has been updated with the new ExecStart line:'
grep 'ExecStart=' $SERVICE_FILE
curl -s -o $HOME/ceremonyclient/node/para.sh https://raw.githubusercontent.com/qrux-opterator/clustermaster/main/para.sh
if [ -f $HOME/ceremonyclient/node/para.sh ]; then echo '✅ para.sh created'; else echo 'Failed to create para.sh ❌'; fi
echo '💻 Downloading clustermaster.bash...'
curl -s -o $HOME/clustermaster.bash https://raw.githubusercontent.com/qrux-opterator/clustermaster/main/clustermaster.bash
if [ -f $HOME/clustermaster.bash ]; then chmod +x $HOME/clustermaster.bash; echo 'clustermaster.bash downloaded and made executable'; else echo 'Could not download clustermaster.bash ❌'; fi
if [ -x $HOME/clustermaster.bash ]; then echo '💻 clustermaster.bash is ready ✅'; else echo 'clustermaster.bash is not executable ❌'; fi
