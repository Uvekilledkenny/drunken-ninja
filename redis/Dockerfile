
FROM 		debian:jessie

RUN 		apt-get update -q \
 &&		apt-get install -qy --no-install-recommends redis-server \
 &&		rm -rf /var/lib/apt/lists/*

RUN 		sed 's/^daemonize yes/daemonize no/' -i /etc/redis/redis.conf \
 && 		sed 's/^bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis/redis.conf \
 && 		sed 's/^# unixsocket /unixsocket /' -i /etc/redis/redis.conf \
 && 		sed 's/^# unixsocketperm 755/unixsocketperm 777/' -i /etc/redis/redis.conf \
 &&		sed '/^logfile/d' -i /etc/redis/redis.conf

ADD		rootfs	/
RUN		chmod +x /root/start.sh

EXPOSE 		6379
VOLUME 		["/var/lib/redis"]
CMD 		["/root/start.sh"]
