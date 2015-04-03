FROM 		debian:jessie
MAINTAINER	uvekilledkenny
WORKDIR		/tmp

ENV             DEBIAN_FRONTEND noninteractive
ENV             TERM dumb

## Installation de MySQL, nginx et PHP
RUN		install="bsdtar nginx fontconfig-config fonts-dejavu-core php5-fpm php5-common php5-json pwgen"; \
		install="$install php5-cli php5-common php5-mysql php5-gd php5-json php5-mcrypt php5-readline"; \
		install="$install psmisc ssl-cert ufw php-pear libgd-tools libmcrypt-dev mcrypt mysql-server"; \
		install="$install mysql-client supervisor curl"; \
		set -x && \
		apt-get update -qq && apt-get install -q -y --no-install-recommends ${install} && \
		apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Mise en place de Pydio
RUN 		cd /var/www && \
		(curl -L http://sourceforge.net/projects/ajaxplorer/files/latest/download -o - | bsdtar -xvf -) && \
		mv pydio-core-* pydio && \
		chown -R www-data:www-data /var/www/pydio && \
		chmod -R 770 /var/www/pydio && \
		chmod 777  /var/www/pydio/data/files/ && \
		chmod 777  /var/www/pydio/data/personal/

## Configuration de nginx
RUN             rm /etc/nginx/sites-enabled/* && \
                rm /etc/nginx/sites-available/* && \
                sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf && \
                sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf && \
                echo "daemon off;" >> /etc/nginx/nginx.conf && \
                mkdir /etc/nginx/ssl && \
                openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj '/CN=localhost/O=My Company Name LTD./C=US'

## Configuration de PHP
RUN             sed -i -e "s/output_buffering\s*=\s*4096/output_buffering = Off/g" /etc/php5/fpm/php.ini && \
                sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini && \
                sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 1G/g" /etc/php5/fpm/php.ini && \
                sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 1G/g" /etc/php5/fpm/php.ini && \
                php5enmod mcrypt

## Configuration de MySQL
RUN             sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf && \
                rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql

## Ajout des fichiers de configuration
ADD		/rootfs		/

## Mise en place du lien symbolique
RUN             mkdir -p /pydio && \
		ln -s /var/www/pydio/data /pydio/data && \
		ln -s /var/lib/mysql	  /pydio/mysql

## Rendre executable le script de lancement		
RUN		chmod +x /root/*.sh

## Volume, expose et commande par défaut
VOLUME		["/pydio/files", "/pydio/personal", "/pydio/mysql"]
EXPOSE 		80 443
CMD 		["/root/start.sh"]
