#!/bin/sh
docker kill $(docker ps|grep slims|awk '{split($0,a," "); print a[1]}')
