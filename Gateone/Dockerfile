FROM		debian:jessie

ENV 		GATEONE_REPO_URL https://github.com/liftoff/GateOne.git
ENV 		DEBIAN_FRONTEND noninteractive

RUN 		apt-get update -qq && \
 		apt-get install -qy \
		python-pip python-imaging python-setuptools \
    		python-mutagen python-pam python-dev git \
    		telnet openssh-client 

RUN 		pip install --upgrade futures tornado cssmin slimit psutil

RUN 		mkdir -p /gateone/logs && \
    		mkdir -p /gateone/users && \
    		mkdir -p /etc/gateone/conf.d && \
    		mkdir -p /etc/gateone/ssl && \
    		cd /gateone && \
    		git clone $GATEONE_REPO_URL && \
    		cd GateOne && \
    		python setup.py install && \
    		cp docker/update_and_run_gateone.py /usr/local/bin/update_and_run_gateone && \
    		cp docker/60docker.conf /etc/gateone/conf.d/60docker.conf

RUN 		/usr/local/bin/gateone --configure \
    		--log_file_prefix="/gateone/logs/gateone.log"

RUN		rm -f /etc/gateone/ssl/key.pem && \
    		rm -f /etc/gateone/ssl/certificate.pem

EXPOSE 		8000
CMD 		["/usr/local/bin/update_and_run_gateone", "--log_file_prefix=/gateone/logs/gateone.log"]
