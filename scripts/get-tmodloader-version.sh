#!/bin/bash
set -eu

curl -v -L --silent \
  https://github.com/tModLoader/tModLoader/releases 2>&1 \
  | grep -o 'tModLoader/tModLoader/releases/tag/[^"]*' \
  | head -1 | grep -oE "[^/]+$"
