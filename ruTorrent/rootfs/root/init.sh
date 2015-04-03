#! /bin/bash

# Couleurs
CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CBLUE="${CSI}1;34m"

if [[ ! -e /rtorrent/.rutorrent/.htpasswd ]]; then
        echo -e "${CBLUE}=> Création du compte pour ruTorrent $CEND"

        if [ -z $USER  ]; then
                echo -e "${CRED}=> Aucun nom d'utilisateur n'a été donné. $CEND"
                exit 1
        else
                if [ -z $PASS  ]; then
                        echo -e "${CRED}=> Aucun mot de passe n'a été donné. $CEND"
                        exit 1
                else
			mkdir -p /rtorrent/.rutorrent/
			touch /rtorrent/.rutorrent/.htpasswd
                        htpasswd -cb /rtorrent/.rutorrent/.htpasswd $USER $PASS
                        chown www-data:www-data /rtorrent/.rutorrent/.htpasswd && \
                        echo -e "${CGREEN}=> Fait! $CEND"
			exit 0
                fi
        fi

else
        echo -e "${CBLUE}=> Compte ruTorrent déjà existant. $CEND"
	exit 1
fi

