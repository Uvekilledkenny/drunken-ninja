#!/bin/bash

docker build -t syncthing_build ./build
docker run --name syncthing_build_run syncthing_build
docker cp syncthing_build_run:/go/src/github.com/syncthing/syncthing/bin/syncthing ./rootfs/usr/local/bin
docker rm -f syncthing_build_run
docker rmi -f syncthing_build

docker build -t syncthing .
