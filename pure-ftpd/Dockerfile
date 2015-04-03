FROM		ubuntu:utopic
MAINTAINER	uvekilledkenny

ADD             /rootfs         /

RUN		apt-get update -qq && apt-get install -q -y --no-install-recommends \
		openbsd-inetd libssl1.0.0 supervisor && \
		dpkg -i /tmp/pure-ftpd-common.deb && \
		dpkg -i /tmp/pure-ftpd.deb && \
		apt-get autoremove -y && apt-get clean -y && \
		rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
		
RUN		groupadd ftpgroup && \
		useradd -g ftpgroup -d /dev/null -s /etc ftpuser && \
		mkdir -p /media

RUN 		echo yes > /etc/pure-ftpd/conf/ChrootEveryone && \
 		echo "40000 40050" > /etc/pure-ftpd/conf/PassivePortRange && \
		echo no > /etc/pure-ftpd/conf/Daemonize && \
		echo yes > /etc/pure-ftpd/conf/NoAnonymous && \
		ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/PureDB && \
		ln -s /etc/pure-ftpd/pureftpd.passwd /etc/pureftpd.passwd && \
		ln -s /etc/pure-ftpd/pureftpd.pdb /etc/pureftpd.pdb

VOLUME 		["/media"]
EXPOSE		20	21	40000-40050
CMD		["supervisord", "-n"]
