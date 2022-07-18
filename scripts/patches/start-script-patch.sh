#!/bin/bash
set -eu

echo "Patching start-tModLoaderServer.sh to Ignore Reads"
sed -i '/read/ s/^#*/#/g' ${TMOD_HOMEDIR}/start-tModLoaderServer.sh
echo "Patch Successful!"
