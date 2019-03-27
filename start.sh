#!/bin/sh
wget https://raw.githubusercontent.com/senatanton/test_task/master/docker-compose.yml
mkdir grafana
wget https://raw.githubusercontent.com/senatanton/test_task/master/grafana.ini
docker-compose up -d
#проверка запущенного DB
id_mysql=$( docker ps | grep db_senatskiy_ao | awk '{ print $1 }')
#наполнение базы
docker exec -i -t $id_mysql mysql -c -u test -ptest test_db -e "CREATE TABLE Cusers (row1 INT, row2 INT);"
for n in {1..1000}; do docker exec -i -t $id_mysql mysql -c -u test -ptest test_db -e "INSERT INTO Customers SET row1 = FLOOR(1000*RAND()), row2 = FLOOR(9999*RAND());";done > /dev/null
