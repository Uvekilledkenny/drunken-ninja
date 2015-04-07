FROM		debian:jessie

ENV             DEBIAN_FRONTEND noninteractive

RUN 		apt-get update -qq && \
 		apt-get install -qy --no-install-recommends \
 		python python-openssl wget telnet python-pam \ 
		python-kerberos python-imaging dtach openssh-client \
		python-support python-pip gcc python-dev

RUN		pip install tornado==2.4.1

WORKDIR		/tmp

RUN		(wget -qO- https://github.com/downloads/liftoff/GateOne/gateone-1.1.tar.gz --no-check-certificate | tar -zxvf -) && \
		cd GateOne/ && \
		python setup.py install && \
		rm -rf /tmp/*

WORKDIR 	/opt/gateone

EXPOSE		8080
ENTRYPOINT	["python", "/opt/gateone/gateone.py", "--port=8080", "--disable_ssl"]

