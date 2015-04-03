FROM 		debian:wheezy
MAINTAINER 	uvekilledkenny

ENV 		DEBIAN_FRONTEND noninteractive
ENV 		LANG fr_FR.UTF-8
ENV 		LC_ALL C.UTF-8
ENV 		LANGUAGE fr_FR.UTF-8


RUN 		apt-get -q update
 		apt-get -qy --force-yes dist-upgrade && \
		apt-get install -qy --force-yes --no-install-recommends curl && \
		echo "deb http://shell.ninthgate.se/packages/debian plexpass main" >> /etc/apt/sources.list.d/plex.list && \
		{curl http://shell.ninthgate.se/packages/shell-ninthgate-se-keyring.key | apt-key add -} && \
		apt-get -q update && \
		apt-get install -qy --force-yes plexmediaserver

RUN 		apt-get clean &&\
  		rm -rf /var/lib/apt/lists/* &&\
  		rm -rf /tmp/*

ADD		/rootfs		/
RUN		chmod u+x /root/start.sh

EXPOSE 		32400
VOLUME 		["/config", "/data"]
CMD 		["/start.sh"]
