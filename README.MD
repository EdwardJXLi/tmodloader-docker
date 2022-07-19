# **Docker container for tModLoader 1.4**

## Features:
- Full support for tModLoader 1.4
- Auto-update with the newest version from github
- Manual and Dynamic (still wip) Mod installing and loading
- Modular patching sytem to fix up the still WIP and somewhat broken tModLoader for Terraria 1.4
- Full support for both ARM64 and ARM32 devices
- Tested on both x86_64 and ARM versions of tModLoader

## Requirements:
### Server-Side:
- docker
- docker-compose

## Setup Guide:
- Clone this repository or copy the `docker-compose.yml` file below
- Modify the `docker-compose.yml` file to your liking
- Create the `/Worlds`, `/Mods` directory in your target location (By default it is in the home directory)
- Start the server with `docker-compose up -d`

## docker-compose.yml example
```
version: '3.2'
services:
  tmodloader:
    build: https://github.com/RadioactiveHydra/tmodloader-docker#main
    container_name: tmodloader
    restart: unless-stopped
    stdin_open: true
    tty: true
    ports:
      - 7777:7777
    volumes:
      - type: bind
        source: ./Worlds
        target: /tmodserver/.local/share/Terraria/tModLoader/Worlds/
      - type: bind
        source: ./Mods
        target: /tmodserver/.local/share/Terraria/tModLoader/Mods/
      - type: bind
        source: ./serverconfig.txt
        target: /tmodserver/serverconfig.txt
        read_only: true
```
