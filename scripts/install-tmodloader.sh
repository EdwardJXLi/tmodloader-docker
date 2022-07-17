#!/bin/bash
set -eux

# Get tModLoader Server Version
if [ "${1}" = "latest" ]
then 
    echo "Using latest version."
    export TMODLOADER_VERSION=$(/tmodserver/.scripts/get-tmodloader-version.sh)
else
    echo "Using specified version."
    export TMODLOADER_VERSION=${1}
fi
echo "Using tModLoader Version: ${TMODLOADER_VERSION}"

# Download and Install tModLoader
echo "Downloading tModLoader"

# Example Url: https://github.com/tModLoader/tModLoader/releases/download/v2022.06.96.4/tModLoader.zip
# Download from URL
url='https://github.com/tModLoader/tModLoader/releases'
downloadURL=${url}/download/${TMODLOADER_VERSION}/tModLoader.zip
echo "Downloading tModLoader: ${downloadURL}"
curl -L --silent ${downloadURL} --output /tmodserver/tmodloader-server.zip

# Extract tmod
echo "Extracting tModLoader"
unzip -o tmodloader-server.zip -d /tmodserver/

# Run all patches
echo "Running all patches..."
for f in /tmodserver/.scripts/patches/*.sh; do
  bash "$f" 
done

# Clean up!
echo "Cleaning Up!"
rm tmodloader-server.zip
chmod +x /tmodserver/start-tModLoaderServer.sh
