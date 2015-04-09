FROM 		debian:jessie 
ENV		PG_VERSION 9.4

RUN 		apt-get update -qq && apt-get install -qy --no-install-recommends wget && \
		(wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc --no-check-certificate | apt-key add - ) && \
 		echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
		apt-get update -qq && apt-get install -qy \
		postgresql-${PG_VERSION} postgresql-client-${PG_VERSION} postgresql-contrib-${PG_VERSION} pwgen sudo && \
 		rm -rf /var/lib/postgresql \
 		rm -rf /var/lib/apt/lists/* 

ADD 		rootfs	/
RUN 		chmod +x /root/start.sh

EXPOSE 		5432
VOLUME 		["/var/lib/postgresql"]
CMD 		["/root/start.sh"]
