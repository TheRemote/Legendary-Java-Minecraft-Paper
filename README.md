# Legendary Minecraft Java Paper Container- Minecraft Java Edition Paper Dedicated Server for Docker
This is the Docker containerized version of my <a href="https://github.com/TheRemote/RaspberryPiMinecraft">Minecraft Java Paper Dedicated Server for Linux/Raspberry Pi</a> scripts.

My <a href="https://jamesachambers.com/legendary-paper-minecraft-java-container/" target="_blank" rel="noopener">main blog article (and the best place for support) is here</a>.<br>
The <a href="https://github.com/TheRemote/Legendary-Java-Minecraft-Paper" target="_blank" rel="noopener">official GitHub repository is located here</a>.<br>
The <a href="https://hub.docker.com/r/05jchambers/legendary-java-minecraft-paper" target="_blank" rel="noopener">official Docker Hub repository is located here</a>.<br>
<br>
The <a href="https://github.com/TheRemote/Legendary-Bedrock-Container" target="_blank" rel="noopener">Bedrock version of the Docker container is available here</a>.  This is for Java Minecraft.<br>
 
<h3>Features</h3>
<ul>
  <li>Sets up fully operational Minecraft server in less than a couple of minutes</li>
  <li>Runs the highly efficient "Paper" Minecraft server</li>
  <li>Uses named Docker volume for safe and easy to access storage of server data files (which enables more advanced Docker features such as automatic volume backups)</li>
  <li>Installs and configures OpenJDK 17</li>
  <li>Automatic backups to minecraft/backups when server restarts</li>
  <li>Full logging available in minecraft/logs folder</li>
  <li>Updates automatically to the latest version when server is started</li>
  <li>Runs on all Docker platforms including Raspberry Pi</li>
</ul>

<h3>Usage</h3>
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


<h3>Configuration / Accessing Server Files</h3>
The server data is stored where Docker stores your volumes.  This is typically a folder on the host OS that is shared and mounted with the container.  I'll give the usual locations here but if you're having trouble just do some Googling for your exact platform and you should find where Docker is storing the volume files.<br>
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

<h3>Buy A Coffee / Donate</h3>
<p>People have expressed some interest in this (you are all saints, thank you, truly)</p>
<ul>
 <li>PayPal: 05jchambers@gmail.com</li>
 <li>Venmo: @JamesAChambers</li>
 <li>CashApp: $theremote</li>
 <li>Bitcoin (BTC): 3H6wkPnL1Kvne7dJQS8h7wB4vndB9KxZP7</li>
</ul>

<h3>Update History</h3>
<ul>
  <li>May 11th 2022</li>
    <ul>
        <li>Fixed optional MaxMemory environment variable (adding missing M for megabytes in -Xmx java parameter)</li>
    </ul>
  <li>May 10th 2022</li>
    <ul>
        <li>Initial release -- thanks to everyone who kept asking about it so I would finally put it together!</li>
    </ul>
</ul>