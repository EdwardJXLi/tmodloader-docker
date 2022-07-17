#!/bin/bash
set -eux

echo "Patching start-tModLoaderServer.sh to Ignore Reads"
sed -i '/read/ s/^#*/#/g' /tmodserver/start-tModLoaderServer.sh
echo "Patch Successful!"
