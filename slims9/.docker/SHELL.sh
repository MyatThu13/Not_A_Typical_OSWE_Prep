#!/bin/sh
docker exec -it $(docker ps|grep slims|awk '{split($0,a," "); print a[1]}') bash
