### Set up docker base

# Using Rocky Linux
FROM rockylinux:9.0
ENV TMOD_USERNAME=tmod
ENV TMOD_HOMEDIR=/tmodserver
# TODO: replace with alpine soon once the dotnet depencency issue is fixed

# Set up installs
RUN dnf update -y && dnf install -y epel-release && dnf install -y curl unzip findutils p7zip p7zip-plugins dotnet-runtime-6.0 crypto-policies-scripts
# TODO: Look into why dotnet needs to be installed as well as the local version of dotnet installed by test

# Setting User
# Using 7777 as user ID as that is tModLoader port 
RUN set -eux; \
	groupadd -g 7777 ${TMOD_USERNAME}; \
	useradd -u 7777 -g 7777 -d ${TMOD_HOMEDIR} -s /bin/sh ${TMOD_USERNAME};

# Set up folders
RUN mkdir -p ${TMOD_HOMEDIR}/.scripts 
COPY ./scripts ${TMOD_HOMEDIR}/.scripts
RUN chmod -R +x ${TMOD_HOMEDIR}/.scripts

# Relaxing crypto policies to get tModLoader to work
RUN update-crypto-policies --set DEFAULT:SHA1
# TODO: this is kinda hacky. Remove once a better solution is found

# Set User
RUN chown -R ${TMOD_USERNAME}:${TMOD_USERNAME} ${TMOD_HOMEDIR}
USER ${TMOD_USERNAME}:${TMOD_USERNAME}

### General Arguments
ARG TMODLOADER_VERSION=latest \
    MODS_DIR=${TMOD_HOMEDIR}/.local/share/Terraria/tModLoader/Mods \
    WORLDS_DIR=${TMOD_HOMEDIR}/.local/share/Terraria/tModLoader/Worlds \
    MODCONFIGS_DIR=${TMOD_HOMEDIR}/.local/share/Terraria/tModLoader/ModConfigs

### Initialize Container

RUN mkdir -p ${MODS_DIR} ${WORLDS_DIR} ${MODCONFIGS_DIR}
VOLUME ["${MODS_DIR}", "${WORLDS_DIR}", "${MODCONFIGS_DIR}"]

# Download and Install tModLoader 1.4
WORKDIR ${TMOD_HOMEDIR}

RUN ${TMOD_HOMEDIR}/.scripts/install-tmodloader.sh $TMODLOADER_VERSION

# Start Server
CMD [ "sh", "-c", "${TMOD_HOMEDIR}/.scripts/start-tmodloader.sh" ]
