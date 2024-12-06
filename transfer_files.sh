#!/bin/bash

# Define the username and password
USERNAME="user"
PASSWORD="1"

# List of IP addresses (excluding 172.16.6.122)
IP_ADDRESSES=(
  172.16.6.34 172.16.6.9 172.16.6.7 172.16.6.10 172.16.6.40
  172.16.6.52 172.16.6.96 172.16.6.20 172.16.6.29 172.16.6.4
  172.16.6.61 172.16.6.62 172.16.6.64 172.16.6.63 172.16.6.66
  172.16.6.68 172.16.6.69 172.16.6.67 172.16.6.82 172.16.6.83
  # Add more IPs as needed
)

# Loop through each IP and execute a command
for IP in "${IP_ADDRESSES[@]}"; do
  echo "Logging in to $IP..."
  
  # Use expect to log in and execute a command
  /usr/bin/expect <<EOF
  spawn ssh -o StrictHostKeyChecking=no $USERNAME@$IP
  expect "password:"
  send "$PASSWORD\r"
  expect "$USERNAME@"
  send "echo 'Logged in successfully'\r"
  expect eof
EOF
  
  if [ $? -eq 0 ]; then
    echo "Logged in to $IP successfully."
  else
    echo "Failed to log in to $IP."
  fi
done
