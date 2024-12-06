#!/bin/bash

# Define the username and new password
USERNAME="user"
NEW_PASSWORD="1"

# List of IP addresses (excluding 172.16.6.122)
IP_ADDRESSES=(
  172.16.6.34 172.16.6.9 172.16.6.7 172.16.6.10 172.16.6.40
  172.16.6.52 172.16.6.96 172.16.6.20 172.16.6.29 172.16.6.4
  172.16.6.61 172.16.6.62 172.16.6.64 172.16.6.63 172.16.6.66
  172.16.6.68 172.16.6.69 172.16.6.67 172.16.6.82 172.16.6.83
  # Add more IPs as needed
)

# Loop through each IP and set the password
for IP in "${IP_ADDRESSES[@]}"; do
  echo "Setting password for $USERNAME on $IP..."
  
  # Use sshpass to log in and set the password
  sshpass -p "1" ssh -o StrictHostKeyChecking=no root@$IP "echo -e \"$NEW_PASSWORD\n$NEW_PASSWORD\" | passwd $USERNAME"
  
  if [ $? -eq 0 ]; then
    echo "Password for $USERNAME on $IP set successfully."
  else
    echo "Failed to set password on $IP."
  fi
done