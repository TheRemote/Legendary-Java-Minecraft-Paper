# Legendary Minecraft Java Paper Container- Minecraft Java Edition Paper Dedicated Server for Docker
<img src="https://jamesachambers.com/wp-content/uploads/2022/05/Minecraft-Docker-Java-1024x576.webp" alt="Legendary Minecraft Java Container">

This is the Docker containerized version of my <a href="https://github.com/TheRemote/RaspberryPiMinecraft">Minecraft Java Paper Dedicated Server for Linux/Raspberry Pi</a> scripts.

My <a href="https://jamesachambers.com/legendary-paper-minecraft-java-container/" target="_blank" rel="noopener">main blog article (and the best place for support) is here</a>.<br>
The <a href="https://github.com/TheRemote/Legendary-Java-Minecraft-Paper" target="_blank" rel="noopener">official GitHub repository is located here</a>.<br>
The <a href="https://hub.docker.com/r/05jchambers/legendary-java-minecraft-paper" target="_blank" rel="noopener">official Docker Hub repository is located here</a>.<br>
<br>
The <a href="https://github.com/TheRemote/Legendary-Bedrock-Container" target="_blank" rel="noopener">Bedrock version of the Docker container is available here</a>.  This is for Java Minecraft.<br>
 
<h2>Features</h2>
<ul>
  <li>Sets up fully operational Minecraft server in less than a couple of minutes</li>
  <li>Runs the highly efficient "Paper" Minecraft server</li>
  <li>Uses named Docker volume for safe and easy to access storage of server data files (which enables more advanced Docker features such as automatic volume backups)</li>
  <li>Plugin support for Paper + Spigot + Bukkit</li>
  <li>Installs and configures OpenJDK 18</li>
  <li>Automatic backups to minecraft/backups when server restarts</li>
  <li>Full logging available in minecraft/logs folder</li>
  <li>Updates automatically to the latest version when server is started</li>
  <li>Runs on all Docker platforms including Raspberry Pi</li>
</ul>

<h2>Usage</h2>
First you must create a named Docker volume.  This can be done with:<br>
<pre>docker volume create yourvolumename</pre>

Now you may launch the server and open the ports necessary with one of the following Docker launch commands:<br>
<br>
With default port:
<pre>docker run -it -v yourvolumename:/minecraft -p 25565:25565 05jchambers/legendary-java-minecraft-paper:latest</pre>
With custom port:
<pre>docker run -it -v yourvolumename:/minecraft -p 12345:12345 -e Port=12345 05jchambers/legendary-java-minecraft-paper:latest</pre>
With a custom Minecraft version (add -e Version=1.X.X, must be present on Paper's API servers to work):
<pre>docker run -it -v yourvolumename:/minecraft -p 25565:25565 -e Version=1.17.1 05jchambers/legendary-java-minecraft-paper:latest</pre>
With a maximum memory limit in megabytes (optional, prevents crashes on platforms with limited memory, -e MaxMemory=2048):
<pre>docker run -it -v yourvolumename:/minecraft -p 25565:25565 -e MaxMemory=2048 05jchambers/legendary-java-minecraft-paper:latest</pre>

<h2>Configuration / Accessing Server Files</h2>
The server data is stored where Docker stores your volumes.  This is typically a folder on the host OS that is shared and mounted with the container.<br>
You can find your exact path by typing: <pre>docker volume inspect yourvolumename</pre>  This will give you the fully qualified path to your volume like this:
<pre>{
        "CreatedAt": "2022-05-09T21:08:34-06:00",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/yourvolumename/_data",
        "Name": "yourvolumename",
        "Options": {},
        "Scope": "local"
    }</pre>
<br>
On Linux it's typically available at: <pre>/var/lib/docker/volumes/yourvolumename/_data</pre><br>
On Windows it's at <pre>C:\ProgramData\DockerDesktop</pre> but may be located at something more like <pre>\wsl$\docker-desktop-data\version-pack-data\community\docker\volumes\</pre>if you are using WSL (Windows Subsystem for Linux<br>
<br>
On Mac it's typically <pre>~/Library/Containers/com.docker.docker/Data/vms/0/</pre><br>
If you are using Docker Desktop on Mac then you need to access the Docker VM with the following command first:
<pre>screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty</pre>
You can then normally access the Docker volumes using the path you found in the first step with docker volume inspect<br><br>
Most people will want to edit server.properties.  You can make the changes to the file and then restart the container to make them effective.<br>
<br>
Backups are stored in the "backups" folder<br>
<br>
Log files with timestamps are stored in the "logs" folder.

<h2>Plugins</h2>
This is a "Paper" Minecraft server which has plugin compatibility with Paper / Spigot / Bukkit.<br>
<br>
Installation is simple.  There is a "plugins" folder on your Docker named volume.<br>
<br>
Navigate to your server files on your host operating system (see accessing server files section if you don't know where this is) and you will see the "plugins" folder.<br>
<br>
You just need to drop the extracted version of the plugin (a .jar file) into this folder and restart the container.  That's it!<br>
<br>
Some plugins have dependencies so make sure you read the installation guide first for the plugin you are looking at.<br>
A popular place to get plugins is: <a href="https://dev.bukkit.org/bukkit-plugins">https://dev.bukkit.org/bukkit-plugins</a>

<h2>Buy A Coffee / Donate</h2>
<p>People have expressed some interest in this (you are all saints, thank you, truly)</p>
<ul>
 <li>PayPal: 05jchambers@gmail.com</li>
 <li>Venmo: @JamesAChambers</li>
 <li>CashApp: $theremote</li>
 <li>Bitcoin (BTC): 3H6wkPnL1Kvne7dJQS8h7wB4vndB9KxZP7</li>
</ul>

<h2>Update History</h2>
<ul>
  <li>August 17th 2022</li>
    <ul>
      <li>Add XX:-UseAESCTRIntrinsics to java launch line to prevent encryption issue on 10th Gen Intel processors</li>
    </ul>
  <li>August 10th 2022</li>
    <ul>
      <li>Adjust query.port in server.properties to be the same as the main server port to keep the "ping port" working properly</li>
      <li>Add enforce-secure-profile=false to default server.properties to prevent login errors</li>
      <li>Add text editor inside the container (nano) for diagnostic/troubleshooting purposes</li>
    </ul>
  <li>August 6th 2022</li>
  <ul>
    <li>Update to 1.19.2</li>
  </ul>
  <li>August 6th 2022</li>
  <ul>
    <li>Update to 1.19.2</li>
  </ul>
  <li>July 31st 2022</li>
  <ul>
    <li>Upgrade Adoptium OpenJDK to 18.0.2</li>
  </ul>
  <li>July 27th 2022</li>
  <ul>
    <li>Update to 1.19.1</li>
  </ul>
  <li>July 13th 2022</li>
  <ul>
    <li>Update base Ubuntu image</li>
  </ul>
  <li>June 27th 2022</li>
  <ul>
    <li>Update base Ubuntu image</li>
  </ul>
  <li>June 15th 2022</li>
  <ul>
    <li>Fix 1.19 paperclip.jar upgrades</li>
  </ul>
  <li>June 11th 2022</li>
  <ul>
    <li>Update to Paper experimental 1.19 release as default installation</li>
    <li>Make sure you have backups of your server from your "backups" folder stored separately before upgrading</li>
    <li>If you have problems with 1.19 you need to restore a backup to go back to 1.18 as it will not take your server data files on 1.18 once the 1.19 structures/data have been added</li>
  </ul>
  <li>June 7th 2022</li>
  <ul>
    <li>Add docker-compose.yml file for use with Docker Compose</li>
  </ul>
  <li>May 25th 2022</li>
  <ul>
    <li>Updated documentation (additional packages no longer required and a base Docker install will work)</li>
  </ul>
  <li>May 21st 2022</li>
  <ul>
    <li>Added multiarch support with separate images for each architecture</li>
    <li>Switched from JDK to JRE to save space</li>
    <li>Added Adoptium OpenJDK support for s390x and ppc64le architectures</li>
  </ul>
  <li>May 17th 2022</li>
  <ul>
    <li>Bump Dockerfile base image to ubuntu:latest</li>
  </ul>
  <li>May 16th 2022</li>
  <ul>
    <li>Add -DPaper.IgnoreJavaVersion=true to allow OpenJDK 17 to run the older Paper Minecraft versions (thanks NotMick)</li>
  </ul>
  <li>May 15th 2022</li>
    <ul>
        <li>Added screen -wipe to beginning of start.sh to prevent a startup issue that could occur if there was a "dead" screen instance (thanks grimholme)</li>
    </ul>
  <li>May 12th 2022</li>
    <ul>
        <li>Added platform argument to avoid issues on aarch64 platforms</li>
    </ul>
  <li>May 11th 2022</li>
    <ul>
        <li>Fixed optional MaxMemory environment variable (adding missing M for megabytes in -Xmx java parameter)</li>
    </ul>
  <li>May 10th 2022</li>
    <ul>
        <li>Initial release -- thanks to everyone who kept asking about it so I would finally put it together!</li>
    </ul>
</ul>