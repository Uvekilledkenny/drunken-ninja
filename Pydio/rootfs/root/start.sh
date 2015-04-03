#! /bin/bash

CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CYELLOW="${CSI}1;33m"
CBLUE="${CSI}1;34m"

PASS=$(pwgen -s 16 1)
VOLUME_HOME="/var/lib/mysql"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
	echo -e "${CBLUE}=> Aucune base de données MySQL n'a été détecté. $CEND"
	echo -e "${CBLUE}=> Création d'une base de données MySQL ... $CEND"
	mysql_install_db > /dev/null 2>&1
	echo -e "${CGREEN}=> Fait! $CEND"  

	echo -e "${CBLUE}=> Lancement de MySQL ... $CEND"
	/usr/bin/mysqld_safe > /dev/null 2>&1 &

	RET=1
	while [[ RET -ne 0 ]]; do
    		echo -e "${CBLUE}=> En attente de la confirmation du démarrage de MySQL. $CEND"
    		sleep 5
    		mysql -uroot -e "status" > /dev/null 2>&1
    		RET=$?
	done

	echo -e "${CBLUE}=> Création des identifiants pour Pydio.$CEND"
	mysql -h127.0.0.1 -uroot -e "CREATE DATABASE pydio; GRANT ALL PRIVILEGES ON pydio.* TO 'pydio'@'%' IDENTIFIED BY '$PASS'; FLUSH PRIVILEGES;"
	echo -e "${CGREEN}=> Fait !$CEND"
	echo ""
	echo -e "${CGREEN}=> Voici votre mot de passe Pydio: ${CYELLOW}$PASS$CEND"
	echo "$PASS" >> /var/lib/mysql/pydio-pwd
	echo ""
	echo -e "${CBLUE}=> Arrêt de MySQL ... $CEND"
	mysqladmin -uroot shutdown
	echo -e "${CGREEN}=> Fait !$CEND"
	echo ""
else
	PASS=$(cat "/var/lib/mysql/pydio-pwd")
        echo -e "${CBLUE}=> Utilisation de la base de données existante de Pydio. $CEND"
        echo -e "${CBLUE}=> Rappel du mot de passe Pydio: ${CYELLOW}$PASS$CEND $CEND"
        echo ""

fi

echo -e "${CBLUE}=> Lancement de Pydio ... $CEND"
echo ""
supervisord -n
