#!/bin/sh
wget https://raw.githubusercontent.com/senatanton/test_task/master/docker-compose.yml
mkdir grafana mysql 
mkdir ./mysql/conf/
mkdir ./mysql/backup/
wget -P ./mysql/backup/ https://raw.githubusercontent.com/senatanton/test_task/master/my2.sql
wget -P ./mysql/conf/ https://raw.githubusercontent.com/senatanton/test_task/master/addco.conf
wget https://raw.githubusercontent.com/senatanton/test_task/master/grafana.ini
docker-compose up -d
#проверка запущенного DB
id_mysql=$( docker ps | grep db_senatskiy_ao | awk '{ print $1 }')
#наполнение базы
sleep 20 && docker exec -i -t $id_mysql bash -c "mysql_upgrade -uroot -p123456" && docker exec -i -t $id_mysql bash -c "mysql --user=root -p123456 < /home/my2.sql"
sleep 20
docker exec -i -t $id_mysql mysql -c -u test -ptest test_db -e "CREATE TABLE Customers (row1 INT, row2 INT);"
for step in $(seq 0 1000)
do
      docker exec -i -t $id_mysql mysql -c -u test -ptest test_db -e "INSERT INTO Customers SET row1 = FLOOR(1000*RAND()), row2 = FLOOR(9999*RAND());"
done
