# Legendary Minecraft Java Paper Container- Minecraft Java Edition Paper Dedicated Server for Docker
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
  <li>Installs and configures OpenJDK 17</li>
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
        "Mountpoint": "/var/lib/docker/volumes/minecraftbe/_data",
        "Name": "minecraftbe",
        "Options": {},
        "Scope": "local"
    }</pre>
<br>
On Linux it's typically available at: <pre>/var/lib/docker/volumes/yourvolumename/_data</pre><br>
On Windows it's at <pre>C:\ProgramData\DockerDesktop</pre> but may be located at something more like <pre>\wsl$\docker-desktop-data\version-pack-data\community\docker\volumes\</pre>if you are using WSL (Windows Subsystem for Linux<br>
<br>
On Mac it's typically <pre>~/Library/Containers/com.docker.docker/Data/vms/0/</pre><br>
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
  <li>May 17h 2022</li>
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