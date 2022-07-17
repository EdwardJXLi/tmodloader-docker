### Set up docker base

# Using Alpine
FROM alpine:3.15

# Set up installs
# Use Edge
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories \
    && echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk update \
    && apk upgrade
RUN apk add curl unzip bash p7zip

# Setting User
# Using 7777 as user ID as that is tModLoader port 
RUN set -eux; \
	addgroup -g 7777 -S tmodloader; \
	adduser -u 7777 -S -D -G tmodloader -H -h /tmodserver -s /bin/sh tmodloader;

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
ARG TMODCONFIG_autocreate=2 \
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
