FROM 		debian:jessie
MAINTAINER	uvekilledkenny


RUN 		apt-get update && apt-get install -y \
		--no-install-recommends \
		ca-certificates \
		curl \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/*

RUN 		curl -sSL http://build.syncthing.net/job/discosrv/lastSuccessfulBuild/artifact/discosrv-linux-amd64.tar.gz \
		| tar -v -C /usr/local -xz

RUN             groupadd -r discosrv && useradd -r -m -g discosrv discosrv

USER 		discosrv

EXPOSE  	22026/udp

CMD 		["/usr/local/discosrv-linux-amd64/discosrv", \
			"-limit-avg", "10", \
			"-limit-cache", "25000", \
			"-db-dir", "/home/discosrv/db", \
			"-stats-file", "/home/discosrv/stats", \
			"-stats-intv", "300" \
		]
