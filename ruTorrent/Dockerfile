FROM 		debian:jessie

ENV 		VER_LIBTORRENT 	0.13.4
ENV 		VER_RTORRENT 	0.9.4
ENV		TERM 		dumb
ENV		DEBIAN_FRONTEND noninteractive

WORKDIR 	/usr/local/src

RUN		build_deps="automake build-essential ca-certificates libc-ares-dev libcppunit-dev libtool git"; \
    		build_deps="${build_deps} libssl-dev libxml2-dev libncurses5-dev pkg-config subversion wget"; \
   		set -x && \
    		apt-get update && apt-get install -q -y --no-install-recommends ${build_deps} && \
   		wget http://curl.haxx.se/download/curl-7.39.0.tar.gz && \
    		tar xzvfp curl-7.39.0.tar.gz && \
    		cd curl-7.39.0 && \
    		./configure --enable-ares --enable-tls-srp --enable-gnu-tls --with-zlib --with-ssl && \
    		make && \
    		make install && \
    		cd .. && \
    		rm -rf curl-* && \
    		ldconfig && \
    		svn --trust-server-cert checkout https://svn.code.sf.net/p/xmlrpc-c/code/stable/ xmlrpc-c && \
    		cd xmlrpc-c && \
    		./configure --enable-libxml2-backend --disable-abyss-server --disable-cgi-server && \
    		make && \
    		make install && \
    		cd .. && \
    		rm -rf xmlrpc-c && \
    		ldconfig && \
    		wget http://libtorrent.rakshasa.no/downloads/libtorrent-$VER_LIBTORRENT.tar.gz && \
    		tar xzf libtorrent-$VER_LIBTORRENT.tar.gz && \
    		cd libtorrent-$VER_LIBTORRENT && \
    		./autogen.sh && \
    		./configure --with-posix-fallocate && \
   		 make && \
    		make install && \
    		cd .. && \
    		rm -rf libtorrent-* && \
    		ldconfig && \
    		wget http://libtorrent.rakshasa.no/downloads/rtorrent-$VER_RTORRENT.tar.gz && \
    		tar xzf rtorrent-$VER_RTORRENT.tar.gz && \
    		cd rtorrent-$VER_RTORRENT && \
    		./autogen.sh && \
    		./configure --with-xmlrpc-c --with-ncurses && \
    		make && \
    		make install && \
    		cd .. && \
    		rm -rf rtorrent-* && \
    		ldconfig && \
		mkdir -p /usr/share/nginx/html && \
		git clone https://github.com/Novik/ruTorrent.git /usr/share/nginx/html/rutorrent && \
		git clone https://github.com/Gyran/rutorrent-ratiocolor.git /usr/share/nginx/html/rutorrent/plugins/ratiocolor && \
                git clone https://github.com/Cakebox/linkcakebox.git /usr/share/nginx/html/rutorrent/plugins/linkcakebox && \               
		git clone https://github.com/xombiemp/rutorrentMobile.git /usr/share/nginx/html/rutorrent/plugins/mobile && \
		git clone https://github.com/Cakebox/Cakebox-light.git /usr/share/nginx/html/cakebox && \
		cd /usr/share/nginx/html/rutorrent/plugins && \
		svn checkout http://rutorrent-pausewebui.googlecode.com/svn/trunk/ pausewebui && \
		svn checkout http://svn.rutorrent.org/svn/filemanager/trunk/filemanager && \
		wget http://rutorrent-tadd-labels.googlecode.com/files/lbll-suite_0.8.1.tar.gz && \
		tar --verbose --gzip --extract --file lbll-suite_0.8.1.tar.gz && \
		rm lbll-suite_0.8.1.tar.gz && \
		apt-get purge -y --auto-remove ${build_deps} && \
    		apt-get autoremove -y

RUN 		apt-get update && apt-get install -q -y --no-install-recommends \
    		apache2-utils libc-ares2 nginx php5-cli php5-fpm php5-curl php5-geoip supervisor

RUN 		apt-get update && apt-get install -q -y --no-install-recommends \
    		mediainfo  buildtorrent git

RUN		echo "deb http://ftp.fr.debian.org/debian testing non-free" >> /etc/apt/sources.list && \
		apt-get update -qq  && apt-get install -q -y --force-yes --no-install-recommends \
                rar zip unrar unzip bzip2 

RUN		echo "deb http://www.deb-multimedia.org jessie main" >> /etc/apt/sources.list && \
		apt-get update -qq  && apt-get install -q -y --force-yes --no-install-recommends \
    		ffmpeg

RUN		apt-get update && apt-get install -q -y --no-install-recommends \
                nodejs npm && \
		ln -s /usr/bin/nodejs /usr/bin/node && \
		cd /tmp && \
		curl -s http://getcomposer.org/installer | php && \                                                                                             
                mv /tmp/composer.phar /usr/bin/composer && \
                chmod +x /usr/bin/composer && \
                npm install -g bower

RUN             cd /usr/share/nginx/html/cakebox && \
                composer install && \
                bower install --allow-root

RUN		chown --recursive www-data:www-data /usr/share/nginx/html/ && \
		echo "daemon off;" >> /etc/nginx/nginx.conf && \
	        sed -i "s/2M/10M/g;" /etc/php5/fpm/php.ini && \
                sed -i "s/8M/10M/g;" /etc/php5/fpm/php.ini && \
                sed -i "s/expose_php = On/expose_php = Off/g;" /etc/php5/fpm/php.ini && \
                sed -i "s/^;date.timezone =/date.timezone = Europe\/Paris/g;" /etc/php5/fpm/php.ini && \
                sed -i "s/^;listen.mode = 0660/listen.mode = 0660/g;" /etc/php5/fpm/pool.d/www.conf

RUN             apt-get update && apt-get install -q -y --no-install-recommends \
                openssl && \
                mkdir /etc/nginx/ssl && \
                openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj '/CN=localhost/O=ruTorrent 4 Ever./C=FR'

RUN		apt-get update && apt-get install -q -y --no-install-recommends \
                locales && \
		locale-gen fr_FR.UTF-8

ENV             LANG            fr_FR.UTF-8

ADD             /rootfs         /

WORKDIR		/root

RUN 		chmod +x /root/*.sh

RUN		apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

VOLUME          ["/rtorrent", "/var/log"]
EXPOSE 		80 	443
CMD		["/root/start.sh"]
