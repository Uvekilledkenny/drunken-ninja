FROM 		debian:jessie

RUN 		apt-get update -qq \
 &&		apt-get install -qy --no-install-recommends \ 
		supervisor logrotate locales nginx rubygems \
		openssh-server postgresql-client redis-tools \ 
    	   	git-core ruby2.1 python2.7 python-docutils \
 	      	nodejs libpq5 zlib1g libyaml-0-2 libssl1.0.0 \
      		libgdbm3 libreadline6 libncurses5 libffi6 \
 	     	libxml2 libxslt1.1 libcurl3 libicu52 sudo \
 && 		update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \
 && 		locale-gen fr_FR.UTF-8 \
 && 		dpkg-reconfigure locales \
 && 		gem install --no-document bundler \
 && 		rm -rf /var/lib/apt/lists/*

ADD		rootfs	/

RUN 		chmod +x /app/setup/install \
 && 		/app/setup/install \
 && 		chmod +x /app/init

WORKDIR		/home/git/gitlab

EXPOSE 		22 80 443
VOLUME 		["/home/git/data"]
CMD 		["/app/init", "app:start"]
