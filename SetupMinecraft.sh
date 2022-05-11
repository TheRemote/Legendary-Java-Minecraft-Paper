#!/bin/bash
# Legendary Paper Minecraft Java Server Docker script by James A. Chambers - image build time
# Author: James A. Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/
# GitHub Repository: https://github.com/TheRemote/Legendary-Java-Minecraft-Paper

Install_Java() {
  # Install Java
  echo "Installing OpenJDK..."

  cd /

  CPUArch=$(uname -m)
  if [[ "$CPUArch" == *"armv7"* || "$CPUArch" == *"armhf"* ]]; then
    curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4.212 Safari/537.36" https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.3%2B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.3_7.tar.gz -o /jre17.tar.gz -L
    tar -xf /jre17.tar.gz
    rm -f /jre17.tar.gz
    mv /jdk-* /jre
  elif [[ "$CPUArch" == *"aarch64"* || "$CPUArch" == *"arm64"* ]]; then
    curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4.212 Safari/537.36" https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.3%2B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.3_7.tar.gz -o /jre17.tar.gz -L
    tar -xf /jre17.tar.gz
    rm -f /jre17.tar.gz
    mv /jdk-* /jre
  elif [[ "$CPUArch" == *"x86_64"* ]]; then
    curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4.212 Safari/537.36" https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.3%2B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.3_7.tar.gz -o /jre17.tar.gz -L
    tar -xf /jre17.tar.gz
    rm -f /jre17.tar.gz
    mv /jdk-* /jre
  fi

  if [ -e "/jre/bin/java" ]; then
    CurrentJava=$(/jre/bin/java -version 2>&1 | head -1 | cut -d '"' -f 2 | cut -d '.' -f 1)
    if [[ $CurrentJava -lt 16 || $CurrentJava -gt 17 ]]; then
      echo "Required OpenJDK version 16 or 17 could not be installed."
      exit 1
    else
      echo "OpenJDK installation completed."
    fi
  else
      rm -rf /jre
      echo  "Required OpenJDK version 16 or 17 could not be installed." 
      exit 1
  fi
}

Install_Java 