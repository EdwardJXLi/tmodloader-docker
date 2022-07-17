#!/bin/bash
set -eux

echo "Starting tModLoader..."
echo "n" | /tmodserver/start-tModLoaderServer.sh -config server-config.conf
