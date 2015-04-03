FROM		debian:jessie
MAINTAINER	uvekilledkenny
WORKDIR         /root

ENV             TERM dumb
ENV             DEBIAN_FRONTEND noninteractive

# Installation de MySQL, nginx et php-fpm
RUN             install="apache2-utils libc-ares2 php5 php5-cli php5-fpm nginx pwgen mysql-server"; \
		install="$install libav-tools php5-gd php5-mysql supervisor git mysql-client"; \
		set -x && \
                apt-get update && apt-get install -q -y --no-install-recommends ${install} && \
                rm -rf /var/lib/apt/lists/* && rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql

# Enlever le bind sur le localhost de MySQL
RUN             sed -i -r 's/bind-address.*$/bind-address = 0.0.0.0/' /etc/mysql/my.cnf

RUN		echo 'daemon off;' | cat - /etc/nginx/nginx.conf > tmp && \ 
		mv tmp /etc/nginx/nginx.conf && rm -f tmp

## Téléchargement de Sonerezh
RUN		git clone git://github.com/Sonerezh/sonerezh.git/ /var/www/sonerezh

## Installation de Sonerezh
RUN		chown -R www-data:www-data /var/www/sonerezh/ && \
		mv /var/www/sonerezh/app/Config /var/www/sonerezh/app/Config.bak && \
		mkdir -p /Musique && \
		find /var/www/sonerezh/ -type f -exec chmod 644 {} \; && \
                find /var/www/sonerezh/ -type d -exec chmod 755 {} \; 

## Copie des fichiers de configuration
ADD 		/rootfs		/

RUN		chmod +x /root/init.sh

RUN		apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Commande, volume et expose
VOLUME		["/Musique", "/var/www/sonerezh/app/Config", "/var/lib/mysql"]
EXPOSE		80
CMD		["/root/init.sh"]
