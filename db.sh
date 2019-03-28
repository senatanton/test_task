#!/bin/sh
until nc -z -v -w30 localhost 3306
do
  echo "Waiting for database connection..."
  # wait for 5 seconds before check again
  sleep 5
done
mysql_upgrade -uroot -p123456 && mysql --user=root -p123456 < /home/my2.sql
sleep 20
mysql -u test -ptest test_db <<MY_QUERY
CREATE TABLE Customers (row1 INT, row2 INT);
MY_QUERY
sleep 10
for step in $(seq 0 1000)
do
   mysql -u test -ptest test_db -e <<MY_QUERY1
   INSERT INTO Customers SET row1 = FLOOR(1000*RAND()), row2 = FLOOR(9999*RAND());
   MY_QUERY1
done
