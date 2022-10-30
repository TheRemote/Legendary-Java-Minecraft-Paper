#!/bin/bash
# Legendary Paper Minecraft Java Server Docker server startup script
# Author: James A. Chambers - https://jamesachambers.com/legendary-paper-minecraft-java-container/
# GitHub Repository: https://github.com/TheRemote/Legendary-Java-Minecraft-Paper

echo "Paper Minecraft Java Server Docker script by James A. Chambers"
echo "Latest version always at https://github.com/TheRemote/Legendary-Java-Minecraft-Paper"
echo "Don't forget to set up port forwarding on your router!  The default port is 25565"

if [ ! -d '/minecraft' ]; then
    echo "ERROR:  A named volume was not specified for the minecraft server data.  Please create one with: docker volume create yourvolumename"
    echo "Please pass the new volume to docker like this:  docker run -it -v yourvolumename:/minecraft"
    exit 1
fi

# Randomizer for user agent
RandNum=$(echo $((1 + $RANDOM % 5000)))

if [ -z "$Port" ]; then
    Port="25565"
fi
echo "Port used: $Port"

# Change directory to server directory
cd /minecraft

# Create folders if they don't exist
if [ ! -d "/minecraft/downloads" ]; then
    mkdir -p /minecraft/downloads
fi
if [ ! -d "/minecraft/backups" ]; then
    mkdir -p /minecraft/backups
fi
if [ ! -d "/minecraft/plugins" ]; then
    mkdir -p /minecraft/plugins
fi

# Check if network interfaces are up
NetworkChecks=0
if [ -e '/sbin/route' ]; then
    DefaultRoute=$(/sbin/route -n | awk '$4 == "UG" {print $2}')
else
    DefaultRoute=$(route -n | awk '$4 == "UG" {print $2}')
fi
while [ -z "$DefaultRoute" ]; do
    echo "Network interface not up, will try again in 1 second"
    sleep 1
    if [ -e '/sbin/route' ]; then
        DefaultRoute=$(/sbin/route -n | awk '$4 == "UG" {print $2}')
    else
        DefaultRoute=$(route -n | awk '$4 == "UG" {print $2}')
    fi
    NetworkChecks=$((NetworkChecks + 1))
    if [ $NetworkChecks -gt 20 ]; then
        echo "Waiting for network interface to come up timed out - starting server without network connection ..."
        break
    fi
done

# Take ownership of server files and set correct permissions
if [ -z "$NoPermCheck" ]; then
    Permissions=$(sudo bash /scripts/fixpermissions.sh -a)
else
    echo "Skipping permissions check due to NoPermCheck flag"
fi

# Daily scheduled restart
if [ -z "$ScheduleRestart" ]; then
    echo "No daily restart scheduled"
else
    FutureRestart=$(shutdown -r "$ScheduleRestart")
    echo "Scheduling daily restart: $FutureRestart"
fi

# Back up server
if [ -d "world" ]; then
    if [ -n "$(which pigz)" ]; then
        echo "Backing up server (all cores) to cd minecraft/backups folder"
        tarArgs=(-I pigz --exclude='./backups' --exclude='./cache' --exclude='./logs' --exclude='./jre' --exclude='./paperclip.jar')
        IFS=','
        read -ra ADDR <<< "$NoBackup"
        for i in "${ADDR[@]}"; do
            tarArgs+=(--exclude="./$i")
        done
        tarArgs+=(-pvcf backups/$(date +%Y.%m.%d.%H.%M.%S).tar.gz ./*)
        tar "${tarArgs[@]}"
    else
        echo "Backing up server (single core, pigz not found) to cd minecraft/backups folder"
        tarArgs=(--exclude='./backups' --exclude='./cache' --exclude='./logs' --exclude='./jre' --exclude='./paperclip.jar')
        IFS=','
        read -ra ADDR <<< "$NoBackup"
        for i in "${ADDR[@]}"; do
            tarArgs+=(--exclude="./$i")
        done
        tarArgs+=(-pvcf backups/$(date +%Y.%m.%d.%H.%M.%S).tar.gz ./*)
        tar "${tarArgs[@]}"
    fi
fi

# Rotate backups -- keep most recent 10
if [ -d /minecraft/backups ]; then
    Rotate=$(
        pushd /minecraft/backups
        ls -1tr | head -n -$BackupCount | xargs -d '\n' rm -f --
        popd
    )
fi

# Copy config files if this is a brand new server
if [ ! -e "/minecraft/bukkit.yml" ]; then
    cp /scripts/bukkit.yml /minecraft/bukkit.yml
fi
if [ ! -e "/minecraft/paper.yml" ]; then
    cp /scripts/paper.yml /minecraft/paper.yml
fi
if [ ! -e "/minecraft/spigot.yml" ]; then
    cp /scripts/spigot.yml /minecraft/spigot.yml
fi
if [ ! -e "/minecraft/server.properties" ]; then
    cp /scripts/server.properties /minecraft/server.properties
fi

# Test internet connectivity first
# Update paperclip.jar
echo "Updating to most recent paperclip version ..."

# Test internet connectivity first
curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4.212 Safari/537.36" -s google.com -o /dev/null
if [ "$?" != 0 ]; then
    echo "Unable to connect to update website (internet connection may be down).  Skipping update ..."
else
    # Get latest build
    BuildJSON=$(curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4.212 Safari/537.36" https://papermc.io/api/v2/projects/paper/versions/$Version)
    Build=$(echo "$BuildJSON" | rev | cut -d, -f 1 | cut -d']' -f 2 | cut -d'[' -f 2 | rev)
    Build=$(($Build + 0))
    if [[ $Build != 0 ]]; then
        echo "Latest paperclip build found: $Build"
        curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4.212 Safari/537.36" -o /minecraft/paperclip.jar "https://papermc.io/api/v2/projects/paper/versions/$Version/builds/$Build/downloads/paper-$Version-$Build.jar"
    else
        echo "Unable to retrieve latest Paper build (got result of $Build)"
    fi
fi

# Accept EULA
AcceptEULA=$(echo eula=true >eula.txt)

# Change ports in server.properties
sed -i "/server-port=/c\server-port=$Port" /minecraft/server.properties
sed -i "/query\.port=/c\query\.port=$Port" /minecraft/server.properties

# Start server
echo "Starting Minecraft server..."

if [[ -z "$MaxMemory" ]] || [[ "$MaxMemory" -le 0 ]]; then
    exec /jre/bin/java -XX:+UnlockDiagnosticVMOptions -XX:-UseAESCTRIntrinsics -DPaper.IgnoreJavaVersion=true -Xms400M -jar /minecraft/paperclip.jar
else
    exec /jre/bin/java -XX:+UnlockDiagnosticVMOptions -XX:-UseAESCTRIntrinsics -DPaper.IgnoreJavaVersion=true -Xms400M -Xmx${MaxMemory}M -jar /minecraft/paperclip.jar
fi
