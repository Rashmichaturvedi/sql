/*Index in Mysql*/
--Custered index
use campus_prepartion;

show Index from customers;
CREATE TABLE t(
   c1 INT PRIMARY KEY,
   c2 INT NOT NULL,
   c3 INT NOT NULL,
   c4 VARCHAR(10),
   INDEX (c2,c3) 
);

CREATE INDEX idx_c4 ON t(c4);
/* default, MySQL creates the B-Tree index if you don’t specify the index type.
 The following shows the permissible index type based on the storage engine of the table:*/
--Difference between select and Explain select 

SELECT 
    branchid,
    lastName, 
    firstName
FROM
    Customers
WHERE
   ammount>100

==============================================


EXPLAIN SELECT 
     branchid,
    lastName, 
    firstName
FROM
    Customers
WHERE
   ammount>100
-------------Unique key index
CREATE TABLE table_name(
...
   UNIQUE KEY(index_column_,index_column_2,...) 
);

-----------------prefix

EXPLAIN SELECT 
    productName, 
    buyPrice, 
    msrp
FROM
    products
WHERE
    productName LIKE '1970%';
SELECT
   COUNT(*)
FROM
   products;

----clustered index
/*clustered index, on the other hand, is actually the table. It is an index that enforces the ordering on the rows of the table physically.

Once a clustered index is created, all rows in the table will be stored according to the key columns used to create the clustered index.

Because a clustered index store the rows in sorted order, each table have only one clustered index.*/


-- Descending index


DROP TABLE t;
 
CREATE TABLE t (
    a INT,
    b INT,
    INDEX a_asc_b_asc (a ASC , b ASC),
    INDEX a_asc_b_desc (a ASC , b DESC),
    INDEX a_desc_b_asc (a DESC , b ASC),
    INDEX a_desc_b_desc (a DESC , b DESC)
);




EXPLAIN SELECT 
    *
FROM
    t
ORDER BY a , b; -- use index a_asc_b_asc
