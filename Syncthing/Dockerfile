FROM		debian:jessie
MAINTAINER	uvekilledkenny

RUN 		apt-get update && apt-get install -qy --no-install-recommends \
		supervisor ca-certificates

ADD 		/rootfs			/

RUN		chmod +x /root/start.sh

EXPOSE		22000 8080 21025/udp 
CMD 		["/root/start.sh"]
