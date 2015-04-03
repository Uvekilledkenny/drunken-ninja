FROM 		debian:jessie
MAINTAINER	uvekilledkenny

RUN 		apt-get update -q && apt-get install --no-install-recommends -qy \
		curl build-essential git ca-certificates mercurial

RUN 		curl -s https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz | tar -v -C /usr/local -xz

ENV 		GOPATH /go
ENV 		GOROOT /usr/local/go
ENV 		PATH $PATH:/usr/local/go/bin:/go/bin

RUN 		mkdir -p /go/src/github.com/syncthing && \
		cd /go/src/github.com/syncthing && \
		git clone https://github.com/syncthing/syncthing && \
		cd /go/src/github.com/syncthing/syncthing && \ 
		go run build.go

CMD 		["/bin/true"]
