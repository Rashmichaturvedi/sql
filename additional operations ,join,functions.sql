--Operations In mysql
use campus_prepartion;
show tables;
select * from fork;


--using order by clause  by default it gives ascending order
select fname,salary from fork ORDER BY SALARY;  

--WORKED CORRECT AND RESULT IS SALARY IN ASCENDING ORDER 
SELECT fname , salary from fork ORDER BY SALARY DESC;    ----WORKED CORRECT

/*MULTIPLE ROWS */
SELECT FNAME,SALARY FROM FORK ORDER BY FNAME ASC ,SALARY DESC ;

/*order by using expressions;*/
desc fork;

select id,fname,salary , id*salary from fork order by id*salary desc;

SELECT 
    id
    status
FROM
    fork
ORDER BY 
    FIELD(status,
        'In Process',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');


/*WHILE  - WHILE WITH BETWEEN*/
SELECT ID FROM FORK WHERE ID BETWEEN 1 AND 3;   --DISPLAYS ID 1 AND 2 ONLY

/*Using MySQL WHERE with the LIKE operator example USING WILDCARD % */

SELECT FNAME FROM FORK WHERE FNAME LIKE '%MI';  --RETURNS NAME
/*  The % wildcard matches any string of zero or more characters while the _ wildcard matches any single character.*/
 SELECT * FROM FORK;
/* the WHERE clause with the IN operator*/
SELECT ID,FNAME,SALARY FROM  FORK WHERE ID IN(1,2,4) ; ---ONLY SELECTS ID OF 1,2,ND 4

--WHERE WITH IS NULL
SELECT ID ,FNAME,SALARY FROM FORK WHERE ID IS NULL;
 
/*WHERE WITH COMPARSION OPERATOR   
=	Equal to. You can use it with almost any data types.
<> or !=	Not equal to
<	Less than. You typically use it with numeric and date/time data types.
>	Greater than.
<=	Less than or equal to
>=	Greater than or equal to*/
SELECT ID ,FNAME, SALARY FROM FORK WHERE SALARY <>4; --USING NOT EQUAL TO 4



---OR 
SELECT ID FROM FORK WHERE ID  = 1 OR 2;
---Distinct :removes duplicate value
select distinct salary from fork order by fname;
select distinct salary, id from fork where id is not null;  --multiple rows in distinct 



--LIMIT TOP 3 SELECTED 
SELECT ID FROM FORK LIMIT 3;
/* Using MySQL LIMIT to get the nth highest or lowest value

SELECT select_list
FROM table_name
ORDER BY sort_expression
LIMIT n-1, 1; */
/* Alias for columns
MySQL alias to improve the readability of the queries.
to assign an alias to a column, you use the AS keyword followed by the alias.
 If the alias contains spaces, you must quote it as the following:
*/

--using concatenate function to combine or merge two columns
select 
concat_ws(',',fname,salary) AS 'FSALARY'
FROM FORK; 
--RESULTS found
/*. You assign a table an alias by using 
the AS keyword as the following syntax and can 
use column name through it */


select e.fname,e.id from fork e;

-------------------------Join ---------
/*Inner join, right join, left join and cross join , self Join
SELECT column_list
FROM table_1
INNER JOIN table_2 ON join_condition;

SELECT column_list
FROM table_1
INNER JOIN table_2 USING (column_name);
*/
use campus_prepartion;
show tables;
select * from fork;
select * from ddltable;

select f.id ,f.fname , d.id ,d.sname ,f.salary, d.salary 
from fork f INNER JOIN ddltable d on f.id=d.id;

select f.id ,f.fname , d.id ,d.sname ,f.salary, d.salary 
from fork f INNER JOIN ddltable d using (name);

 

select * from cart;
------TESTING RIGHT JOIN
select f.id ,f.fname, d.id, d.sname,f.salary,d.salary from fork f RIGHT JOIN ddltable d on f.id=d.id;
-----------TESTING OUTER JOIN 
select f.id ,f.fname, d.id, d.sname from fork f OUTER JOIN ddltable d on f.id=d.id; --doesnot work in mysql


-------LEFT JOIN
select f.id,f.fname,d.id,d.sname,f.salary,d.salary from fork f LEFT JOIN  ddltable d on f.id= d.id;
select f.id,f.fname,d.id,d.sname,f.salary,d.salary from fork f LEFT JOIN ddltable d using (Salary);  --since salary is common in both

---Self Join :The self join is often used to query hierarchical data or to compare a row with other rows within the same table.


SELECT 
    CONCAT(m.fname, ', ', m.id) AS Manager,
    CONCAT(e.fname, ', ', e.id) AS 'Direct report'
FROM
    fork m
INNER JOIN fork e ON 
   m.salary = e.id;
---query success
 --other ways of inner join are :
/*
left join
SELECT 
    IFNULL(CONCAT(m.lastname, ', ', m.firstname),
            'Top Manager') AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report'
FROM
    employees e
LEFT JOIN employees m ON 
    m.employeeNumber = e.reportsto
ORDER BY 
    manager DESC;

By using the MySQL self join, you can display a list of customers who locate in the same city by joining the customers table to itself.
SELECT 
    c1.city, 
    c1.customerName, 
    c2.customerName
FROM
    customers c1
INNER JOIN customers c2 ON 
    c1.city = c2.city
    AND c1.customername > c2.customerName
ORDER BY 
    c1.city;




c1.city = c2.city  makes sure that both customers have the same city.
c.customerName > c2.customerName ensures that no same customer is included. */
--Cross  join :  returns the Cartesian product of rows from the joined tables.
drop table products;
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(13,2 )
);
 
CREATE TABLE stores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100)
);
 
CREATE TABLE sales (
    product_id INT,
    store_id INT,
    quantity DECIMAL(13 , 2 ) NOT NULL,
    sales_date DATE NOT NULL,
    PRIMARY KEY (product_id , store_id),
    FOREIGN KEY (product_id)
        REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (store_id)
        REFERENCES stores (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 INSERT INTO products(product_name, price)
VALUES('iPhone', 699),
      ('iPad',599),
      ('Macbook Pro',1299);
 
INSERT INTO stores(store_name)
VALUES('North'),
      ('South');
 
INSERT INTO sales(store_id,product_id,quantity,sales_date)
VALUES(1,1,20,'2017-01-02'),
      (1,2,15,'2017-01-05'),
      (1,3,25,'2017-01-05'),
      (2,1,30,'2017-01-02'),
      (2,2,35,'2017-01-05');


SELECT 
    store_name,
    product_name,
    SUM(quantity * price) AS revenue
FROM
    sales
        INNER JOIN
    products ON products.id = sales.product_id
        INNER JOIN
    stores ON stores.id = sales.store_id
GROUP BY store_name , product_name; 
---using cross join
SELECT 
    store_name, product_name
FROM
    stores AS a
        CROSS JOIN
    products AS b;
-------------Group By:  it reduces the number of rows in the result set.

select  id from fork  group by id;   
--Using MySQL GROUP BY with aggregate functions
select salary ,count(*) from fork group by salary;
---making use of aggregrate functions
select f.id ,sum(f.id* d.salary) as mount
from fork f inner join ddltable  d using (salary)
Group by id;
--group by with expression

SELECT 
    YEAR(orderDate) AS year,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orders
INNER JOIN orderdetails 
    USING (orderNumber)
WHERE
    status = 'Shipped'
GROUP BY 
    YEAR(orderDate);



-----------group by with having
select id from fork group by id  having id >3;
/*Having 
 SELECT 
    select_list
FROM 
    table_name
WHERE 
    search_condition
GROUP BY 
    group_by_expression
HAVING 
    group_condition;   

used to filter data
SELECT 
    a.ordernumber, 
    status, 
    SUM(priceeach*quantityOrdered) total
FROM
    orderdetails a
INNER JOIN orders b 
    ON b.ordernumber = a.ordernumber
GROUP BY  
    ordernumber, 
    status
HAVING 
    status = 'Shipped' AND 
    total > 1500;






 */
--ROLLUP clause to generate subtotals and grand totals.

SELECT 
    salary, 
    SUM(salary) totalOrderValue
FROM
    fork
GROUP BY 
    salary 
UNION ALL
SELECT 
    NULL, 
    SUM(id) totalOrderValue
FROM
   fork ;

----WITH ROLLUP
SELECT salary , sum(id) sumofid from fork
group by salary with rollup;
--he ROLLUP clause generates not only the subtotals but also the grand total of the order values.
--it generates null in col1 and  generates total in sumofid  = 7
select id , fname from fork 
group by id, fname with rollup ;

---generates null with grand total
/*
GROUPING() function
To check whether NULL in the result 
set represents the subtotals or grand total
 you use the GROUPING() function*/


select id , salary , sum(fname) total, grouping(id),
grouping(salary) from fork group by id , salary  with rollup;




--------------Subquery :INNER QUERY || OUTER QUERY
SHOW TABLES;

CREATE TABLE BANK(
branchid int (30) PRIMARY KEY ,
branchname varchar(20),
country varchar(30));
INSERT INTO BANK VALUES( 121,'RAMPUR','INDIA'),(182,'RANJHI','USA'),(123,'GORAKHPUR','ENGLAND');

SELECT * FROM BANK
Create table Customers(
branchid int (30) primary key,
firstname varchar(20) , lastname varchar(20),
ammount int(100));

INSERT INTO CUSTOMERS VALUE (123,'RAM','KAPOOR',2000),(182,'RAJAT','YADAV',200),(121,'FARHAT','JAHAN',1000);

---MAKING USE OF SUBQUERY
SELECT firstname , lastname ,AMMOUNT  from customers where branchid IN (select branchid from bank
where country ='USA');


--SUCCESSFUL RESULT RAJAT
SELECT FIRSTNAME , LASTNAME ,AMMOUNT FROM CUSTOMERS WHERE AMMOUNT >(SELECT AVG(AMMOUNT) FROM CUSTOMERS);

---SUCCESFUL
/* SELECT 
    MAX(items), 
    MIN(items), 
    FLOOR(AVG(items))
FROM
    (SELECT 
        orderNumber, COUNT(orderNumber) AS items
    FROM
        orderdetails
    GROUP BY orderNumber) AS lineitems; */
/*Derived table  : A derived table is a virtual table returned from a SELECT statement. A derived table is 
similar to a temporary table, but using a derived table in the SELECT
 statement is much simpler than a temporary table because it does not require steps of creating the temporary table.

Suppose you have to classify the customers  who bought products in 2003 into 3 groups: platinum, gold, and silver. And you need to know the number of customers in each group with the following conditions:

Platinum customers who have orders with the volume greater than 100K
Gold customers who have orders with the volume between 10K and 100K
Silver customers who have orders with the volume less than 10K
To construct this query, you first need to put each customer into the respective group using CASE expression and GROUP BY clause as follows:

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
SELECT 
    customerNumber,
    ROUND(SUM(quantityOrdered * priceEach)) sales,
    (CASE
        WHEN SUM(quantityOrdered * priceEach) < 10000 THEN 'Silver'
        WHEN SUM(quantityOrdered * priceEach) BETWEEN 10000 AND 100000 THEN 'Gold'
        WHEN SUM(quantityOrdered * priceEach) > 100000 THEN 'Platinum'
    END) customerGroup
FROM
    orderdetails
        INNER JOIN
    orders USING (orderNumber)
WHERE
    YEAR(shippedDate) = 2003
GROUP BY customerNumber*/





SELECT FIRSTNAME , SUM(AMMOUNT * BRANCHID) sales,
(CASE 
   WHEN SUM(AMMOUNT * BRANCHID)>800 THEN 'GOLD'
  WHEN SUM(AMMOUNT * BRANCHID) BETWEEN 1000 AND 3000 THEN 'PLATINUM' END )CUSTOMERGROUP
 FROM CUSTOMERS INNER JOIN BANK USING (BRANCHID);

---QUERY SUCCESSFUL
DROP TABLE IF EXISTS FIRSTTABLE;
SHOW TABLES ;


DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
 -------UNION AND INTERSECT OPERAT0R
CREATE TABLE t1 (
    id INT PRIMARY KEY
);
 
CREATE TABLE t2 (
    id INT PRIMARY KEY
);
 
INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (2),(3),(4);

SELECT id
FROM t1
UNION
SELECT id
FROM t2;  /* RESULT IS 1,2,3,4*/
--UNION ALL
SELECT id
FROM t1
UNION ALL
SELECT id
FROM t2;  /* RESULT IS 1 2 3 2 3 4    UNION ALL IS FASTER THAN UNION DISTINCT
/* ppose that you want to combine the first name and last name of employees and customers into a single result set, you can use the UNION operator as follows:


SELECT 
    firstName, 
    lastName
FROM
    employees 
UNION 
SELECT 
    contactFirstName, 
    contactLastName
FROM
    customerS;*/
 
--INTERSECTS MYSQL DOESNOT SUPPORT THIS
USE CAMPUS_PREPARTION;
SHOW TABLES;

SELECT id FROM t1
MINUS
SELECT id FROM t2; 


---ERROR :MYSQL DOESNOT SUPPORT MINUS OPERATOR HENCE  WE USE LEFT JOIN WHERE T2 IS NULL
SELECT 
    id
FROM
    t1
LEFT JOIN
    t2 USING (id)
WHERE
    t2.id IS NULL;