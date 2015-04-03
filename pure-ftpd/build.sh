#!/bin/bash

docker build -t pureftpd_build ./build
docker run --name pureftpd_build_run pureftpd_build
docker cp pureftpd_build_run:/root/pure-ftpd.deb ./rootfs/tmp
docker cp pureftpd_build_run:/root/pure-ftpd-common.deb ./rootfs/tmp
docker rm -f pureftpd_build_run
docker rmi -f pureftpd_build

docker build -t pure-ftpd .


