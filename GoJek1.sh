#/bin/sh
sudo docker images jayadut/rediswithmysql
sudo docker run -itd -p 8080:8080 -p 6379:6379 jayadut/rediswithmysql  

