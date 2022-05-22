# Minecraft Java Paper Server Docker Container
# Author: James A. Chambers - https://jamesachambers.com/legendary-paper-minecraft-java-container/
# GitHub Repository: https://github.com/TheRemote/Legendary-Java-Minecraft-Paper

# Use current Ubuntu LTS version
FROM --platform=linux/arm/v7 ubuntu:latest

# Update apt
RUN apt-get update 

# Fetch dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install sudo curl unzip screen net-tools gawk openssl findutils pigz libcurl4 libc6 libcrypt1 apt-utils libcurl4-openssl-dev ca-certificates qemu-user-static binfmt-support -yqq

# Set port environment variable
ENV Port=25565

# Optional maximum memory Minecraft is allowed to use
ENV MaxMemory=

# Optional Paper Minecraft Version override
ENV Version="1.18.2"

# IPV4 Ports
EXPOSE 25565/tcp

# Copy scripts to minecraftbe folder and make them executable
RUN mkdir /scripts
COPY *.sh /scripts/
COPY *.yml /scripts/
COPY server.properties /scripts/
RUN chmod -R +x /scripts/*.sh

# Run SetupMinecraft.sh
RUN /scripts/SetupMinecraft.sh

# Clean apt
RUN apt-get clean && apt-get autoclean

# Set entrypoint to start.sh script
ENTRYPOINT ["/bin/bash", "/scripts/start.sh"]
