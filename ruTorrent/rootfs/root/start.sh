#! /bin/bash

# Couleurs
CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CBLUE="${CSI}1;34m"


if [ -z $PORTS  ]; then
        echo -e "${CRED}=> Aucun port n'a été donné. $CEND"
        exit 1
else
	echo -e "${CBLUE}=> Configuration des ports pour rTorrent  $CEND"
	sed -i "s/@PORTS@/$PORTS/g;" /root/.rtorrent.rc
	echo -e "${CGREEN}=> Fait! $CEND"
fi

echo ""

if [[ ! -d /rtorrent/.session/ ]];then
        echo -e "${CBLUE}=> Aucune session de rTorrent n'a été détecté. $CEND"
        echo -e "${CBLUE}=> Création d'une session de rTorrent ... $CEND"
        mkdir -p /rtorrent/downloads
        mkdir -p /rtorrent/.session
        mkdir -p /rtorrent/watch
	chmod --recursive 777 /rtorrent/downloads
	chmod --recursive 777 /rtorrent/watch
        echo -e "${CGREEN}=> Fait! $CEND"
else
	echo -e "${CBLUE}=> Utilisation d'une session de rTorrent existante. $CEND"
fi

if [[ -e /rtorrent/.session/rtorrent.lock ]]; then
	echo ""
	echo -e "${CBLUE}=> Supression du verrou de rTorrent. $CEND"
	rm -f /rtorrent/.session/rtorrent.lock
	echo -e "${CGREEN}=> Fait! $CEND"
fi

if [[ ! -e /rtorrent/.rutorrent/.htpasswd ]]; then
	echo -e "${CRED}=> Aucun compte ruTorrent détecté. $CEND"
	exit 1
fi

echo ""

echo -e "${CBLUE}=> Lancement de rTorrent et ruTorrent ... $CEND"

supervisord -n
