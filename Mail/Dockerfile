FROM		debian:jessie
ENV		DEBIAN_FRONTEND noninteractive

RUN		apt-get update -qq && \
		apt-get install -qy --no-install-recommends \
		postfix mysql-server mysql-client postfix-mysql dovecot-core \
		dovecot-imapd dovecot-lmtpd dovecot-mysql opendkim opendkim-tools \ 
		supervisor openssl && \
		mkdir -p /config && \
                rm -rf /var/lib/apt/lists/* && rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql

RUN             sed -i -r 's/bind-address.*$/bind-address = 0.0.0.0/' /etc/mysql/my.cnf && \
		sed -i -e "0,/#\(.*smtp\([^s]\).*inet.*n.*smtpd.*\)/s/#\(.*smtp\([^s]\).*inet.*n.*smtpd.*\)/\1/" \
       		-e "s/#\(.*submission.*inet.*n.*\)/\1/" \
      		-e "s/#\(.*syslog_name=postfix\/submission\)/\1/" \
       		-e "s/#\(.*smtpd_tls_security_level=encrypt\)/\1/" \
       		-e "0,/#\(.*smtpd_sasl_auth_enable=yes\)/s/#\(.*smtpd_sasl_auth_enable=yes\)/\1/" \
       		-e "0,/#\(.*smtpd_client_restrictions=.*\)/s/#\(.*smtpd_client_restrictions=.*\)/\1/" /etc/postfix/master.cf

RUN		openssl dhparam -out /etc/postfix/dh2048.pem 2048 && \
		openssl dhparam -out /etc/postfix/dh512.pem 512

RUN		groupadd -g 5000 vmail && \
		useradd -g vmail -u 5000 vmail -d /var/mail && \
		chown -R vmail:vmail /var/mail && \
		chown -R vmail:dovecot /etc/dovecot && \
		chmod -R o-rwx /etc/dovecot

RUN		mkdir -p /etc/opendkim/keys

ADD		/rootfs	/

VOLUME		["/config", "/data"]
EXPOSE		25  587  993  4190  12301
CMD		["supervisord", "-n"]
