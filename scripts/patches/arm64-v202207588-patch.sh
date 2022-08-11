#!/bin/bash
set -eu

echo "Attempting to patch tModLoader for Arm64!"
echo "Using modified dlls by https://github.com/NicolaeBet/tModLoader-ARM64-Fix/releases/tag/v2022.7.58.8"
echo "USE AT YOUR OWN RISK!"

# Get archetecture and version
arch=$(uname -m)

tmodversion=$TMODLOADER_VERSION
echo "Currently running ${arch} with tModLoader version ${tmodversion}"

if [[ $arch == aarch64 ]] && [[ $tmodversion = v2022.07.58.8 ]]; then
    echo "Patching for arm64"
    # Patch tModLoader for arm64
    curl -L --silent "https://github.com/NicolaeBet/tModLoader-ARM64-Fix/releases/download/v2022.7.58.8/tModLoader_ARM64_Fix_v2022.7.58.8.zip" --output arm_patch.zip
    unzip arm_patch.zip -d .
    cp tModLoader_ARM64_Fix_v2022.7.58.8/tModLoader.dll ${TMOD_HOMEDIR}/tModLoader.dll
    cp tModLoader_ARM64_Fix_v2022.7.58.8/Libraries/steamworks.net/20.1.0/lib/netstandard2.1/Steamworks.NET.dll ${TMOD_HOMEDIR}/Libraries/steamworks.net/20.1.0/lib/netstandard2.1/Steamworks.NET.dll
    # Clean Up
    rm arm_patch.zip
    echo "Patching Successful!"
elif [[ $arch == aarch32 ]] && [[ $tmodversion = v2022.07.58.8 ]]; then
    echo "Unfortunately, there are no supported patches for ARM32..."
else
    echo "Unsupported architecture or version for patch"
fi
