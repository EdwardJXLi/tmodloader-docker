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
- Create the `/Worlds`, `/Mods`, and `/ModConfigs` directory in your target location (By default it is in the home directory)
- Start the server with `docker-compose up -d`

## docker-compose.yml example
```
version: '3.2'
services:
  tmodloader:
    image: radioactivehydra/tmodloader:latest
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
        source: ./ModConfigs
        target: /tmodserver/.local/share/Terraria/tModLoader/ModConfigs/
      - type: bind
        source: ./serverconfig.txt
        target: /tmodserver/serverconfig.txt
        read_only: true
```

## Acknowledgements
Thank you to [Chicken-Bones](https://github.com/Chicken-Bones), [joshua-software-dev](https://github.com/joshua-software-dev), [NicolaeBet](https://github.com/NicolaeBet), and many more people with greater C# experience than I do for implementing patches for SteamWorks on tModLoader 1.4! 
- https://github.com/tModLoader/tModLoader/pull/2639
- https://github.com/joshua-software-dev/tModLoader/releases/tag/v2022.06.96.4arm
- https://github.com/NicolaeBet
