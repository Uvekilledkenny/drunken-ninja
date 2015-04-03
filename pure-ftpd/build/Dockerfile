FROM		ubuntu:utopic
MAINTAINER	uvekilledkenny
ENV 		DEBIAN_FRONTEND noninteractive

RUN		echo "deb http://fr.archive.ubuntu.com/ubuntu/ utopic main restricted universe multiverse\n\
		deb http://fr.archive.ubuntu.com/ubuntu/ utopic-security main restricted universe multiverse\n\ 
		deb http://fr.archive.ubuntu.com/ubuntu/ utopic-updates main restricted universe multiverse\n\ 
                deb-src http://fr.archive.ubuntu.com/ubuntu/ utopic main restricted universe multiverse\n\
		" > /etc/apt/sources.list

RUN 		apt-get -y update && apt-get dist-upgrade -y

RUN 		apt-get -y --force-yes install dpkg-dev debhelper

RUN 		apt-get -y build-dep pure-ftpd

RUN 		mkdir /tmp/pure-ftpd/ && \
		cd /tmp/pure-ftpd/ && \
		apt-get source pure-ftpd && \
		cd pure-ftpd-* && \
		sed -i '/^optflags=/ s/$/ --without-capabilities/g' ./debian/rules && \
		dpkg-buildpackage -b -uc

RUN 		mv /tmp/pure-ftpd/pure-ftpd_*.deb /root/pure-ftpd.deb && \
		mv /tmp/pure-ftpd/pure-ftpd-common_*.deb /root/pure-ftpd-common.deb

CMD 		["/bin/true"]
