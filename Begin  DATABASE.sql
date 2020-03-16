/* Working On SQLyog **** Start MYSQL FOR Campus Prepartion *** you need Xamp Server

DBMS is an interface between Database application and database
DBMS IN CHRONOLOGICAL ORDER OF THEIR EVOLUTION : Hierarchical, Network, Relational and NoSql
rows - tuples , columns - attribute , cardinality -no of rows(tuples), Degree -no of columns(attribute)
Integrity constraints :- Entity(enforced by primary key) , Domain(enforced by data type & CHECK CONSTRAINT),Referential Integrity(enforced by foreign key)
PRIMARY KEY, CANDIDATE KEY, FOREIGN KEY ,COMPOSITE PRIMARY KEY ,CROW FOOT NOTATION
DDL , DML , TCL , DCL

"Let's Begin"*/ 
SHOW DATABASES ;
SELECT       /* to see all users*/
   user 
FROM 
   mysql.user;
SHOW TABLES;
CREATE DATABASE dbms_practise;
USE campus_prepartion;

Drop  Database dbms_practise; /*Deleting database*/
/*DDL*/


/* Practising Create command*/
CREATE TABLE firsttable(
ID INTEGER(30) AUTO_INCREMENT PRIMARY KEY, /*Column Constraint*/
Ename VARCHAR(29),
DOB DATE,
title VARCHAR(255) NOT NULL,
priority TINYINT NOT NULL,
description TEXT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);


DESC firsttable;                           /* To display the table*/
/* DDL 2ND COMMAND*/
DROP Table firsttable;                   /* Deleting Table*/

/*Create table 2 Create table command will fail if tabke already exists   ||  Space is created as not null  */

CREATE TABLE thirdtable(
Id INTEGER(30), 
Ename Varchar(20),
DOB Date ,
Salary FLOAT,
PRIMARY KEY (Id));   /*table level constraint     Creating primary key which has unique value and not null always*/

DESC thirdtable;

/*DDL Third Command ALTER  : used with drop,add,modify, rename    . you can also change datatype with this if column value are empty*/ 

ALTER TABLE thirdtable ADD AGE INTEGER(130) AFTER DOB;
ALTER TABLE thirdtable ADD GENDER CHAR(1) ;
ALTER TABLE thirdtable ADD (Course varchar(20),Mobileno INT(10));

ALTER TABLE thirdtable MODIFY AGE CHAR(29); /* ALTER COMMAND TO MODIFY data types*/
DESC thirdtable;                            /*DISPLAY TABLE*/




ALTER TABLE thirdtable DROP AGE;         /*ALTER COMMAND TO DELETE A COLUMN BOTH MENTIONED WAYS ARE CORRECT*/
ALTER TABLE thirdtable DROP COLUMN Course;


ALTER TABLE thirdtable Change  Column  Ename sname VARCHAR(20) ; /*Change use to change column name , rename cannot do so*/
ALTER TABLE thirdtable change column Id id int(20);

ALTER TABLE DDTABLE RENAME  DDLTABLE; /*RENAME COMMAND USED TO CHANGE TABLE NAME  . YOU CAN USE RENAME TO OR JUST RENAME TO DO THIS*/

DESC DDLTABLE;

 
/*DDL 4th Command : TRUNCATE : is used when you want to delete the complete data from a table without removing the table structure.*/

TRUNCATE TABLE DDLTABLE;

DESC DDLTABLE;

/*Creating Foreign key concept
 A table can have more than one foreign key where each foreign key references to a primary key of the different parent tables.
A foreign key is a column or group of columns in a table that links to a column or group of columns in another table. 
The foreign key places constraints on data in the related tables, which allows MySQL to maintain referential integrity.
  
Self-referencing foreign key
Sometimes, the child and parent tables may refer to the same table. In this case, the foreign key references back to the primary key within the same table.
BY DEFAULT ,RESTRICT CONSTRAINT IS CALLED 
*/
CREATE TABLE PRODUCT(
PID INT(30),
PDETAILS  VARCHAR(70),
ID INT,
CONSTRAINT FOREIGN KEY(ID) REFERENCES firsttable(ID)); /*FOREIGN KEY REFERENCES FROM firsttable we created earlier*/


/*Because of the RESTRICT option, you cannot delete or update categoryId 1 since it is referenced by the productId 1 in the products table.*/


DROP TABLE PRODUCT;

CREATE TABLE categories(
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(100) NOT NULL
);
 
CREATE TABLE products(
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName varchar(100) not null,
    categoryId INT,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId) 
        REFERENCES categories(categoryId)
        ON UPDATE SET NULL     #on update  cascade (delete)
        ON DELETE SET NULL 
);
DROP table categories;   /*Error Code : 1451
Cannot delete or update a parent row: a foreign key constraint fails*/
DESC categories ;
DESC products;

ALTER TABLE products
DROP FOREIGN KEY fk_category;
  

/* IF table is deleted or misspelled : Error Code : 1146
Table 'campus_prepartion.product' doesn't exist
(0 ms taken)*

*********              you can also add foreign key cnstraint using alter command


ALTER TABLE tbl_name
    ADD [CONSTRAINT [symbol]] FOREIGN KEY
    [index_name] (col_name, ...)
    REFERENCES tbl_name (col_name,...)
    [ON DELETE reference_option]
    [ON UPDATE reference_option]*/

--UNIQUE CONSTRAINT  ****************************************************************************************************>>>>>>>>>

CREATE TABLE CART(
ID INT(60) UNIQUE ,
Pname varchar(60) ,
mobnumber INT(10),
CONSTRAINT uc_name UNIQUE (Pname ,mobnumber));

DESC CART;

DROP INDEX uc_name ON CART; --to drop the constraint


#KEY is the synonym for INDEX. 
#You use the KEY when you want to create an index for a column or a set of columns that is not the part of a primary key or unique key.



--CHECK    &  NOT NULL CONSTRAINT ****************************************************************************************************************************
CREATE TABLE parts (
    part_no VARCHAR(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10,2 ) NOT NULL CHECK (cost >= 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    CONSTRAINT parts_chk_price_gt_cost 
        CHECK(price >= cost)
);
/* 
It’s a good practice to have the NOT NULL constraint in every column of a table unless you have a good reason not to do so.

Generally, the NULL value makes your queries more complicated because you have to use functions such as ISNULL(), IFNULL(), and NULLIF() for handling NULL.

SEQUENCE : AUTO_INCREMENT ATTRIBUTE IS USED TO GENERATE LIST IN ASCENDING ORDER
*/




