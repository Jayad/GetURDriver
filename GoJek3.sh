#!/bin/bash

#Restart Mysql
sudo /etc/init.d/mysql stop
sudo /etc/init.d/mysql start

#restart redis Server
sudo /etc/init.d/redis_6379 stop
sudo /etc/init.d/redis_6379 start
redis-server /etc/redis/6379.conf

#redis-cli

#GEOADD location  -0.1276250  51.5033640 "KasturiNagar" -0.3189 57.115556 "HRBR"
#GEOADD location  -0.3276250  57.033640 "KalyanNagar" -0.61389 77.115556 "HBR"
#GEOADD location  -23.3276250  -57.033640 "IndiraNagar" -10.61389 77.115556 "NGEF"

#if
mysql -u'root' -p'jaya' Records < ~/Records.sql
#exit;


tar -vxf GetDriver.tar.gz
cd home/justdial/GetDriver/
cd GoJekDriverAssignment/
sudo java -jar target/GoJekDriverAssignment-0.0.1-SNAPSHOT.jar
