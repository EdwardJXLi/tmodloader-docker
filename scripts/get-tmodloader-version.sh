#!/bin/bash
set -eux

curl -v -L --silent \
  -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36" \
  https://github.com/tModLoader/tModLoader/releases 2>&1 \
  | grep -o 'tModLoader/tModLoader/releases/tag/[^"]*' \
  | head -1 | grep -oE "[^/]+$"
