#!/bin/bash

#copy the file inside Docker
#$1 will contain the image
container=`sudo docker ps -a |grep -m1 jaya| awk '$0=$1'`
sudo docker cp GetDriver.tar.gz $container:/
sudo docker exec -it $container /bin/sh


