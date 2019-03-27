#!/bin/sh
sleep 50
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
