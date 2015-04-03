#Créer les prérequis pour le conteneur

`docker run -it --rm -v /path/to/rutorrent:/rtorrent -e USER='username' -e PASS='password' rutorrent ./init.sh`

#Lancer le conteneur

`docker run -it -d --name="" -p 80:80 -v /path/to/rutorrent:/rtorrent -e PORTS='port-range' -p PORTS:PORTS -p PORTS:PORTS/udp rutorrent`
