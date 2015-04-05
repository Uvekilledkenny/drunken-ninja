#!/bin/bash

# Creation de la BDD
ln -s /data /var/lib/mysql
mysql_install_db > /dev/null 2>&1

# Lancement de MySQL
/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

# Récupération de l'adresse IP WAN
WANIP=$(dig +short myip.opendns.com @resolver1.opendns.com)

if [ "$IP" = "" ]; then
    WANIP=$(wget -qO- ipv4.icanhazip.com)
fi

read -p "> Veuillez saisir le nom d'hôte : " HOSTNAME
read -p "> Veuillez saisir le nom de domaine : " DOMAIN

FQDN="${HOSTNAME}.${DOMAIN}"

# Modification du nom d'hôte
echo $HOSTNAME > /etc/hostname

# Modification du FQDN
cat > /etc/hosts <<EOF
127.0.0.1 localhost.localdomain localhost
${WANIP} ${FQDN}               ${HOSTNAME}

::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts
EOF

mysqladmin -uroot create postfix

SQLQUERY="CREATE USER 'postfix'@'localhost' IDENTIFIED BY 'postfix'; \
          GRANT USAGE ON *.* TO 'postfix'@'localhost'; \
          GRANT ALL PRIVILEGES ON postfix.* TO 'postfix'@'localhost';"

mysql -uroot "postfix" -e "$SQLQUERY" &> /dev/null

sed -i -e "s|\(myhostname.*=\).*|\1 '${FQDN}';|" \
       -e "s|\(myorigin.*=\).*|\1 '${FQDN}';|" \
       -e "s|\(error_notice_recipient.*=\).*|\1 'admin${DOMAIN}';|" /etc/postfix/main.cf

mkdir -p /var/mail/vhosts/${DOMAIN}

sed -i -e "s|\(connect.*=\).*|\1 'host=127.0.0.1 dbname=postfix user=postfix password='postfix';|" /etc/dovecot/dovecot-sql.conf.ext

cat > /etc/opendkim/TrustedHosts <<EOF
127.0.0.1
localhost
192.168.0.1/24

*.${DOMAIN}
EOF

cat > /etc/opendkim/KeyTable <<EOF
mail._domainkey.${DOMAIN} ${DOMAIN}:mail:/etc/opendkim/keys/${DOMAIN}/mail.private
EOF

cat > /etc/opendkim/SigningTable <<EOF
*@${DOMAIN} mail._domainkey.${DOMAIN}
EOF

cd /etc/opendkim/keys

mkdir $DOMAIN && cd $DOMAIN
opendkim-genkey -s mail -d $DOMAIN -b 4096

chown opendkim:opendkim mail.private
chmod 400 mail.private mail.txt

supervisord -n
