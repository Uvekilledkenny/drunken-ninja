#! /bin/bash

CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CYELLOW="${CSI}1;33m"
CBLUE="${CSI}1;34m"

PASS=$(pwgen -s 13 1)
VOLUME_HOME="/var/lib/mysql"

if [[ ! -e /var/www/sonerezh/app/Config/core.php ]]; then
	mv /var/www/sonerezh/app/Config.bak/* /var/www/sonerezh/app/Config
	chown -R www-data:www-data /var/www/sonerezh/app/Config
else
	rm -rf /var/www/sonerezh/app/Config.bak
fi

if [[ ! -d $VOLUME_HOME/mysql ]]; then
	echo -e "${CBLUE}=> Aucune base de données MySQL n'a été détecté. $CEND"
	echo -e "${CBLUE}=> Création d'une base de données MySQL ... $CEND"
	mysql_install_db > /dev/null 2>&1
	echo -e "${CGREEN}=> Fait! $CEND"  
fi

if [[ ! -e $VOLUME_HOME/sonerezh-pwd ]]; then
	echo -e "${CBLUE}=> Lancement de MySQL ... $CEND"
	/usr/bin/mysqld_safe > /dev/null 2>&1 &

	RET=1
	while [[ RET -ne 0 ]]; do
    		echo -e "${CBLUE}=> En attente de la confirmation du démarrage de MySQL. $CEND"
    		sleep 5
    		mysql -uroot -e "status" > /dev/null 2>&1
    		RET=$?
	done

	echo -e "${CBLUE}=> Installation de la base de données Sonerezh.$CEND"
	mysql -h127.0.0.1 -uroot -e "CREATE DATABASE sonerezh; GRANT ALL PRIVILEGES ON sonerezh.* TO 'sonerezh'@'%' IDENTIFIED BY '$PASS'; FLUSH PRIVILEGES;"
	echo -e "${CGREEN}=> Fait !$CEND"
	echo ""
	echo -e "${CGREEN}=> Voici votre mot de passe Sonerezh: ${CYELLOW}$PASS$CEND"
	echo "$PASS" >> /var/lib/mysql/sonerezh-pwd
	echo ""
	echo -e "${CBLUE}=> Arrêt de MySQL ... $CEND"
	mysqladmin -uroot shutdown
	echo -e "${CGREEN}=> Fait !$CEND"

else
	PASS=$(cat "/var/lib/mysql/sonerezh-pwd")
        echo -e "${CBLUE}=> Utilisation de la base de données Sonerezh. $CEND"
        echo -e "${CBLUE}=> Rappel du mot de passe Sonerezh: ${CYELLOW}$PASS$CEND $CEND"
        echo ""

fi

supervisord -n
