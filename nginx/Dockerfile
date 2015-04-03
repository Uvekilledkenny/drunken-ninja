FROM		ubuntu:latest

RUN \
  		apt-get update && \
		apt-get install -y --no-install-recommends \
		nginx supervisor && \
  		rm -rf /var/lib/apt/lists/* && \
  		echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  		chown -R www-data:www-data /var/lib/nginx

ADD		/rootfs		/

EXPOSE 		80 	443
VOLUME 		["/etc/nginx/sites-enabled", "/etc/nginx/ssl"]
CMD		["supervisord"]
