#!/bin/bash

# Check if a domain or IP address is provided as an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <TARGET_IP>"
  exit 1
fi

TARGET_IP=$1
DIRECTORY=${TARGET_IP}_recon
echo "Creating directory $DIRECTORY."
mkdir -p $DIRECTORY

# Nmap scan
nmap $TARGET_IP > $DIRECTORY/nmap
echo "The results of the Nmap scan are stored in $DIRECTORY/nmap."

# nslookup
nslookup $TARGET_IP > $DIRECTORY/nslookup
echo "The results of the nslookup scan are stored in $DIRECTORY/nslookup."

# Ping the target
ping -c 4 $TARGET_IP > $DIRECTORY/ping
echo "Ping results are stored in $DIRECTORY/ping."

# Send an HTTP request using curl
curl -I $TARGET_IP > $DIRECTORY/curl
echo "Curl results are stored in $DIRECTORY/curl."

# File Transfer to Metasploitable (Modify the paths as needed)
echo "Transferring files to Metasploitable..."
scp /path/to/local/file msfadmin@$TARGET_IP:/path/on/metasploitable/ > $DIRECTORY/scp_upload_result

# You can add more tests or commands here as needed

echo "Reconnaissance for $TARGET_IP is complete."