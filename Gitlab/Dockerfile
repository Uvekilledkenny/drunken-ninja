FROM		debian:jessie
ENV		DEBIAN_FRONTEND noninteractive
ENV		VER_GITLAB 7.9.2

RUN 		apt-get update -q && \
     		apt-get install -qy --no-install-recommends \
     	 	ca-certificates openssh-server wget

WORKDIR		/tmp

RUN		wget https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_$VER_GITLAB-omnibus-1_amd64.deb && \
		dpkg -i git* && \
		rm -rf /tmp/git*		

RUN 		mkdir -p /opt/gitlab/sv/sshd/supervise && \
    		mkfifo /opt/gitlab/sv/sshd/supervise/ok && \
     		printf "#!/bin/sh\nexec 2>&1\numask 077\nexec /usr/sbin/sshd -D" > /opt/gitlab/sv/sshd/run && \
     		chmod a+x /opt/gitlab/sv/sshd/run && \
     		ln -s /opt/gitlab/sv/sshd /opt/gitlab/service && \
     		mkdir -p /var/run/sshd

ADD		/rootfs	/

RUN		chmod +x /root/*.sh

EXPOSE 		80 22
VOLUME 		["/var/opt/gitlab", "/var/log/gitlab", "/etc/gitlab"]
CMD 		["/root/start.sh"]
