#!/bin/bash
set -eu

echo "Attempting to patch tModLoader for Arm32 and Arm64!"
echo "Using modified dlls by https://github.com/joshua-software-dev/tModLoader/releases/tag/v2022.06.96.4arm"
echo "USE AT YOUR OWN RISK!"

# Get archetecture and version
arch=$(uname -m)

tmodversion=$TMODLOADER_VERSION
echo "Currently running ${arch} with tModLoader version ${tmodversion}"

if [[ $arch == aarch64 ]] && [[ $tmodversion = v2022.06.96.4 ]]; then
    echo "Patching for arm64"
    # Patch tModLoader for arm64
    curl -L --silent "https://github.com/joshua-software-dev/tModLoader/releases/download/v2022.06.96.4arm/tModLoader_v2022.06.96.4_arm64_fix.7z" --output arm_patch.7z
    7z x arm_patch.7z -o${TMOD_HOMEDIR} -aoa
    # Clean Up
    rm arm_patch.7z
    echo "Patching Successful!"
elif [[ $arch == aarch32 ]] && [[ $tmodversion = v2022.06.96.4 ]]; then
    echo "Patching for arm32"
    # Patch tModLoader for arm32
    curl -L --silent "https://github.com/joshua-software-dev/tModLoader/releases/download/v2022.06.96.4arm/tModLoader_v2022.06.96.4_arm32_fix.7z" --output arm_patch.7z
    7z x arm_patch.7z -o${TMOD_HOMEDIR} -aoa
    # Clean Up
    rm arm_patch.7z
    echo "Patching Successful!"
else
    echo "Unsupported architecture or version for patch"
fi
