#!/bin/bash
set -eux

echo "Starting tModLoader..."

# Set up server config
echo "Setting up server config!"
touch /tmodserver/serverconfig.txt

# Read out environment variables, dump them into serverconfig
set | grep TMODCONFIG | while read line; do 
    echo $line | sed 's/TMODCONFIG_//g' >> /tmodserver/serverconfig.txt
done 

# Start Server
/tmodserver/start-tModLoaderServer.sh
