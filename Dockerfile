### Set up docker base

# Using Rocky Linux
FROM rockylinux:9.0
# TODO: replace with alpine soon once the dotnet depencency issue is fixed

# Set up installs
RUN dnf update -y && dnf install -y epel-release && dnf install -y curl unzip findutils p7zip p7zip-plugins dotnet-runtime-6.0
# TODO: Look into why dotnet needs to be installed as well as the local version of dotnet installed by test

# Setting User
# Using 7777 as user ID as that is tModLoader port 
RUN set -eux; \
	groupadd -g 7777 tmodloader; \
	useradd -u 7777 -g 7777 -d /tmodserver -s /bin/sh tmodloader;

# Set up folders
RUN mkdir -p /tmodserver/.scripts; 
COPY ./scripts/* /tmodserver/.scripts
COPY ./scripts/patches* /tmodserver/.scripts/patches
RUN chmod +x /tmodserver/.scripts/*

# Set User
RUN chown -R tmodloader:tmodloader /tmodserver
USER tmodloader:tmodloader

### General Arguments
ARG TMODLOADER_VERSION=latest \
    MODS_DIR=/tmodserver/.local/share/Terraria/ModLoader/Mods \
    WORLDS_DIR=/tmodserver/.local/share/Terraria/ModLoader/Worlds \
    PLAYERS_DIR=/tmodserver/.local/share/Terraria/ModLoader/Players

# Set Terraria Server Config Arguments
ENV TMODCONFIG_autocreate=2 \
    TMODCONFIG_seed= \
    TMODCONFIG_worldname=TerrariaWorld \
    TMODCONFIG_difficulty=0 \
    TMODCONFIG_maxplayers=16 \
    TMODCONFIG_port=7777 \
    TMODCONFIG_password='' \
    TMODCONFIG_motd="Welcome To tModLoader!" \
    TMODCONFIG_worldpath=${WORLDS_DIR} \
    TMODCONFIG_banlist=banlist.txt \
    TMODCONFIG_secure=1 \
    TMODCONFIG_language=en/US \
    TMODCONFIG_upnp=1 \
    TMODCONFIG_npcstream=1 \
    TMODCONFIG_priority=1

### Initialize Container

RUN mkdir -p ${MODS_DIR} ${WORLDS_DIR} ${PLAYERS_DIR}
VOLUME ["${MODS_DIR}", "${WORLDS_DIR}", "${PLAYERS_DIR}"]

# Download and Install tModLoader 1.4
WORKDIR /tmodserver

RUN /tmodserver/.scripts/install-tmodloader.sh $TMODLOADER_VERSION

# Start Server
CMD [ "/tmodserver/.scripts/start-tmodloader.sh" ]
