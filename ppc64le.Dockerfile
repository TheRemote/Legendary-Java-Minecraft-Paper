# Minecraft Java Paper Server Docker Container
# Author: James A. Chambers - https://jamesachambers.com/legendary-paper-minecraft-java-container/
# GitHub Repository: https://github.com/TheRemote/Legendary-Java-Minecraft-Paper

# Use Ubuntu rolling version for builder
FROM ubuntu:rolling AS builder

# Update apt
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install qemu-user-static binfmt-support apt-utils -yqq && rm -rf /var/cache/apt/*

# Use Ubuntu rolling version
FROM --platform=linux/ppc64le ubuntu:rolling

# Add QEMU
COPY --from=builder /usr/bin/qemu-ppc64le-static /usr/bin/

# Fetch dependencies
RUN apt update && DEBIAN_FRONTEND=noninteractive apt-get install openjdk-19-jre-headless systemd-sysv tzdata sudo curl unzip net-tools gawk openssl findutils pigz libcurl4 libc6 libcrypt1 apt-utils libcurl4-openssl-dev ca-certificates binfmt-support nano -yqq && rm -rf /var/cache/apt/*

# Set port environment variable
ENV Port=25565

# Optional maximum memory Minecraft is allowed to use
ENV MaxMemory=

# Optional Paper Minecraft Version override
ENV Version="1.19.2"

# Optional Timezone
ENV TZ="America/Denver"

# Optional folder to ignore during backup operations
ENV NoBackup=""

# Number of rolling backups to keep
ENV BackupCount=10

# Optional switch to skip permissions check
ENV NoPermCheck=""

# Optional switch to schedule a daily restart (use 24 hour time format like 3:30 for 3:30am)
ENV ScheduleRestart=""

# IPV4 Ports
EXPOSE 25565/tcp

# Copy scripts to minecraftbe folder and make them executable
RUN mkdir /scripts
COPY *.sh /scripts/
COPY *.yml /scripts/
COPY server.properties /scripts/
RUN chmod -R +x /scripts/*.sh

# Set entrypoint to start.sh script
ENTRYPOINT ["/bin/bash", "/scripts/start.sh"]
