#! /bin/bash

if [[ -e /mnt/media/.syncthing/config.xml ]]; then
        supervisord -n
else
        mkdir -p /mnt/media/.syncthing
        supervisord
        sleep 15
        kill $(pgrep supervisord*) && 
        sleep 15
        sed -i "s/127.0.0.1:8080/:8080/g;" /mnt/media/.syncthing/config.xml
#       sed -i "s/udp4://announce.syncthing.net:22026//g" /mnt/media/.syncthing/config.xml
        supervisord -n
fi


