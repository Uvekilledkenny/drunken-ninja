FROM 		debian:jessie

ENV		DEBIAN_FRONTEND noninteractive
ENV 		NODE_ENV production

RUN		apt-get update -qq && \
		apt-get install -qy --no-install-recommends \
		nodejs bsdtar npm wget && \
		ln -s /usr/bin/nodejs /usr/bin/node && \
		mkdir -p /ghost

WORKDIR		/ghost

RUN		( wget -qO- https://ghost.org/zip/ghost-latest.zip --no-check-certificate | bsdtar -xvf- ) && \
  		npm install --production && \
  		sed 's/127.0.0.1/0.0.0.0/' /ghost/config.example.js > /ghost/config.js && \
		useradd ghost --home /ghost

ADD 		/rootfs	/

RUN		chmod +x /root/*.sh

EXPOSE 		2368
VOLUME 		["/data", "/ghost-override"]
CMD 		["/root/start.sh"]
