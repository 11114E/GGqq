#!/bin/bash

# Define the username and password
USERNAME="user"
PASSWORD="1"
SOURCE_FILES=(
  "node-2.0.5-linux-amd64.dgst"
  "node-2.0.5-linux-amd64.dgst.sig.1"
  "node-2.0.5-linux-amd64.dgst.sig.2"
  "node-2.0.5-linux-amd64.dgst.sig.4"
  "node-2.0.5-linux-amd64.dgst.sig.5"
  "node-2.0.5-linux-amd64.dgst.sig.7"
  "node-2.0.5-linux-amd64.dgst.sig.9"
  "node-2.0.5-linux-amd64.dgst.sig.11"
  "node-2.0.5-linux-amd64.dgst.sig.13"
  "node-2.0.5-linux-amd64.dgst.sig.14"
  "node-2.0.5-linux-amd64.dgst.sig.16"
  "node-2.0.5-linux-amd64"
)
DEST_DIR="/home/user"

# List of IP addresses (excluding 172.16.6.122)
IP_ADDRESSES=(
  172.16.6.34 172.16.6.9 172.16.6.7 172.16.6.10 172.16.6.40
  172.16.6.52 172.16.6.96 172.16.6.20 172.16.6.29 172.16.6.4
  172.16.6.61 172.16.6.62 172.16.6.64 172.16.6.63 172.16.6.66
  172.16.6.68 172.16.6.69 172.16.6.67 172.16.6.82 172.16.6.83
  # Add more IPs as needed
)

# Loop through each IP and transfer the files
for IP in "${IP_ADDRESSES[@]}"; do
  echo "Transferring files to $IP..."
  
  for FILE in "${SOURCE_FILES[@]}"; do
    /usr/bin/expect <<EOF
    spawn scp -o StrictHostKeyChecking=no /root/ceremonyclient/node/$FILE $USERNAME@$IP:$DEST_DIR
    expect {
      "password:" { send "$PASSWORD\r"; exp_continue }
      "yes/no" { send "yes\r"; exp_continue }
    }
    expect eof
EOF
  done
  
  if [ $? -eq 0 ]; then
    echo "Files transferred to $IP successfully."
  else
    echo "Failed to transfer files to $IP."
  fi
done
