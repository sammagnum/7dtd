FROM ubuntu:latest
EXPOSE 8080 8081 8082 26900 26900/UDP 26901/UDP 26902/UDP
RUN useradd -m steam && \
	apt-get update && apt-get install -y \
        apt-utils \
        curl  \
	lib32gcc1 && \
        su steam && \
	cd /home/steam && \
        curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - && \
./steamcmd.sh +login anonymous +force_install_dir /home/steam/Servers/7dtd +app_update 294420 +quit
COPY serverconfig.xml /home/steam/Servers/7dtd/serverconfig.xml
COPY startserver.sh /home/steam/Servers/7dtd/startserver.sh
COPY serveradmin.xml /root/.local/share/7DaysToDie/Saves/serveradmin.xml
RUN ls /home
CMD /home/steam/Servers/7dtd/startserver.sh -configfile=/home/steam/Servers/7dtd/serverconfig.xml
