/*Views is virtual table created by query to open and 
execute  query by joining one or more table*/
-- create view
use campus_prepartion;
CREATE VIEW customerPayments
AS 
SELECT 
    customerName, 
    checkNumber, 
    paymentDate, 
    amount
FROM
    customers
INNER JOIN
    payments USING (customerNumber);

-- show view
SELECT * FROM customerPayments;

--Run the below example
CREATE VIEW daysofweek (day) AS
    SELECT 'Mon' 
    UNION 
    SELECT 'Tue'
    UNION 
    SELECT 'Web'
    UNION 
    SELECT 'Thu'
    UNION 
    SELECT 'Fri'
    UNION 
    SELECT 'Sat'
    UNION 
    SELECT 'Sun';
 ---  to see data

	
SELECT * FROM daysofweek;
/*e combination of input query and the SELECT statement of the view definition into a 
single query is referred to as view resolution.*/
 select * from customers
CREATE ALGORITHM=MERGE VIEW contactPersons(
    customerName, 
    firstName, 
    lastName, 
    phone
) AS
SELECT 
  branchid,
  firstname,
lastname , ammount
FROM customers;
-- to display
SELECT * FROM contactPersons;
--update view
-- temptable cannot be update
CREATE VIEW officeInfo
 AS 
   SELECT firstname , lastname,phone
   FROM contactpersons;
--
select * from officeinfo;


--update view
UPDATE officeInfo 
SET 
    phone = '+33'
WHERE
   firstname = 'raj';

-- to check which table is updatable 
SELECT 
    table_name, 
    is_updatable
FROM
    information_schema.views
WHERE
    table_schema = 'campus_prepartion';

---------deleting and insert in view 


-- create a new table named items
CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(11 , 2 ) NOT NULL
);
 
-- insert data into the items table
INSERT INTO items(name,price) 
VALUES('Laptop',700.56),('Desktop',699.99),('iPad',700.50) ;
 
-- create a view based on items table
CREATE VIEW LuxuryItems AS
    SELECT 
        *
    FROM
        items
    WHERE
        price > 700;
-- query data from the LuxuryItems view
SELECT 
    *
FROM
    LuxuryItems;


--delete

DELETE FROM LuxuryItems 
WHERE
    id = 3;
--check
SELECT 
    *
FROM
    LuxuryItems;
--Rename
RENAME TABLE items 
To productview;
--
SHOW FULL TABLES WHERE table_type = 'VIEW';
--DROP VIEW
Drop view luxuryitems;

---
show create view luxuryitems -- hence this doesnot exist

--display views

SELECT * 
FROM information_schema.tables;


-- This query returns all views from the  database:

SELECT 
    table_name view_name
FROM 
    information_schema.tables 
WHERE 
    table_type   = 'VIEW' AND 
    table_schema = 'campus_prepartion';

--with check option
CREATE OR REPLACE VIEW vps AS
    SELECT 
        employeeNumber,
        lastName,
        firstName,
        jobTitle,
        extension,
        email,
        officeCode,
        reportsTo
    FROM
        employees
    WHERE
        jobTitle LIKE '%VP%' 
WITH CHECK OPTION;

-- MySQL WITH CASCADED CHECK OPTION

CREATE TABLE t3 (
    c INT
);

CREATE OR REPLACE VIEW v1 
AS
    SELECT 
        c
    FROM
        t3
    WHERE
        c > 10;

INSERT INTO v1(c) 
VALUES (5);
-- create a view v2 based on the v1 view with WITH CASCADED CHECK OPTION clause.
CREATE OR REPLACE VIEW v2 
AS
    SELECT c FROM v1 
WITH CASCADED CHECK OPTION;

INSERT INTO v2(c) 
VALUES (5);

--error Error Code : 1369
CHECK OPTION failed 'campus_prepartion.v2'




--Local view
ALTER VIEW v2 AS
    SELECT 
        c
    FROM
        v1 
WITH LOCAL CHECK OPTION;

INSERT INTO v2(c) 
VALUES (5);

--Now v2 is independent of v1
-- Notice that this statement failed in the v2 view created with a WITH CASCADED CHECK OPTION.

