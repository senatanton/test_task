#!/bin/sh
sleep 50
mysql -u test -ptest test_db -e "CREATE TABLE Customers (row1 INT, row2 INT);"
sleep 10
for step in $(seq 0 1000)
do
   mysql -u test -ptest test_db -e "INSERT INTO Customers SET row1 = FLOOR(1000*RAND()), row2 = FLOOR(9999*RAND());"
done
