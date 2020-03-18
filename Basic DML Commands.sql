use campus_prepartion
show tables;
DESC ddltable;
/* Learning DML COMMANDS : INSERT, UPDATE,DELETE,SELECT*/
--1st way 
INSERT INTO ddltable(id,sname,DOB,Salary,GENDER,Mobileno)
VALUES(1,'SUCHI','24-JAN-2019',4000.0,'F',920193821);
--2ND WAY
INSERT INTO ddltable VALUES(2,'RUCHI','2019-08-01',2000.00,'F',911829101);
--3rd  way
INSERT INTO ddltable VALUES (3,'Tanu',CURRENT_DATE(),6000,'O',927839292);

--YOU CAN ALSO PROVIDE VALUE TO SOME SELECTED COLUMNS
INSERT INTO ddltable(sname,Salary) VALUES('RASHMI',4000);
 
--using default value insertion 
--DDL 
Create table fork(
id int(20),
fname varchar(50),
salary tinyint  NOT NULL  DEFAULT 2,
PRIMARY KEY (id));

--using multiple rows 
INSERT INTO fork VALUES(1, 'wilson',DEFAULT),(2,'anil',DEFAULT),(3,'sumit',DEFAULT);

SELECT * FROM fork;
select * from ddltable; --to diplay all the content of the table
SHOW VARIABLES LIKE 'max_allowed_packet'; --when MySQL server receives the INSERT statement whose size is bigger than max_allowed_packet, 
--it will issue a packet too large error and terminates the connection. HERE MAX_VALUE IS 1048576
--SET GLOBAL max_allowed_packet=size; can be used to set max value


--INSERT INTO SELECT  Beside using row values in the VALUES clause, you can use the result of a SELECT statement as the data source for the INSERT statement.
/* The INSERT INTO SELECT statement is very useful when you want to copy data from other tables to a table or to summary data from multiple tables into a table.*/
 SELECT * FROM ddltable;

INSERT INTO fork (fname,salary) SELECT sname,Salary FROM ddltable where sname = 'RASHMI';

--dultipate key error 
--UPDATE COMMAND TO UPDATE THE DATA

insert into fork (id,salary) VALUES (4,4) ON DUPLICATE KEY UPDATE id =2; --it create another row 
insert into fork (id,salary) VALUES (2,4) ON DUPLICATE KEY UPDATE id =4; --Error Code : 1062
----Duplicate entry '4' for key 'PRIMARY'

/*if you use the INSERT IGNORE statement, the rows with invalid data that cause the error are ignored and the rows with valid data are inserted into the table.*/
INSERT IGNORE INTO fork (id, salary) values (2,4); --values is not inserted nor any error is generated
show warnings;
select * from fork;


----UPDATE 
UPDATE  fork set fname ='azad' where id=4;
select * from fork;

---update with replace 
update fork set fname = replace(fname,'azad','anuj') ; ---anuj is updated in place of azad

update fork set fname = 'sumraj' where id =3;  ---working same as above



---Delete (4th command of dml :Insert,update,delete,select)

DELETE FROM FORK WHERE id =3;

select * FROM FORK;   --HENCE ID =3 DELETED
SELECT *FROM ddltable;
DELETE FROM DDLTABLE WHERE id=3; --this will delete  id 3 data  from ddltable

--delete and limit by 
--MYSQL IS CASE INSENSITIVE

DELETE FROM DDLTABLE 
ORDER BY sname
LIMIT 2;
SELECT *FROM DDLTABLE;
---DELETES THE FIRST 2 ELEMENTS


--USING DELETE CASCADE WHICH IS USED FOR REFERENTIAL ACTION FOR FOREIGN KEY TO DELETE FROM MUTIPLE TABLES
DESC CATEGORIES;
DESC PRODUCTS;  
 select *from categories;
INSERT INTO 
--IN ABOVE TABLES CATEGORYID WAS THE FOREIGN KEY


--Constraints
--unique constraint
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT,
    sname VARCHAR(255) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    PRIMARY KEY (supplier_id),
    CONSTRAINT uc_name_address UNIQUE (sname , address)
);


INSERT INTO suppliers VALUES(1,'aman','98239392','gyan ganga'),
(2,'human','819191112','sagar'),(3,'farhat','2728919112','delhi');
SELECT *FROM suppliers
--checking unique constrint
INSERT INTO  SUPPLIERS VALUES(4,'suman','98291101829','delhi'); /*delhi approved*/
--entering same phone no 
INSERT INTO  SUPPLIERS VALUES(5,'arshit','98239392','mumbai');/*Error Code : 1062
Duplicate entry '98239392' for key 'phone'*/
select *from suppliers;

INSERT INTO SUPPLIERS VALUES(6,'suman','929209495','jaipur');
	
SHOW CREATE TABLE suppliers;
SHOW INDEX FROM suppliers; --shows associated index
--droping unique constraint

DROP INDEX uc_name_address on suppliers;
desc suppliers;


ALTER TABLE suppliers
ADD CONSTRAINT uc_name_address 
UNIQUE (sname,address);

desc ddltable;
select * from ddltable;
INSERT INTO ddltable VALUES (2,'AMAN','2019-09-19',2000,'M',0292899291);
INSERT INTO ddltable VALUES (3,'Naman','2019-08-29',1000,'M',09823829291),(4,'Alex','2012-04-29',3000,'M',8293829291),
(5,'suprit','2019-01-12',200,'F',322222243);
select * from ddltable;


----CHECK CONSTRAINT : THIS IS DOMAIN INTEGRITY CONSTRAINT
CREATE TABLE checkconstraint(
    part_no int(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10,2 ) NOT NULL CHECK (cost >= 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0), 
    CONSTRAINT parts_chk_price_gt_cost 
        CHECK(price >= cost)
);



Insert into checkconstraint values(1,'frequency',829.91,0);
select *from checkconstraint;

---sucessful now trying to enter value less than 0
Insert into checkconstraint values(2,'tear',-1,-2,); ---error 
--checking one more time 
CREATE TABLE checkconstraint2(
    part_no int(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10,2 ) NOT NULL CHECK (cost > 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >8), 
    CONSTRAINT parts_chk_price_gt_cost 
        CHECK(price >= cost)
);
Insert into checkconstraint2  VALUES(2,'FAST',200.00,59);
SELECT *FROM CHECKCONSTRAINT2;
--now putting dissimmilar value for check constraint
INSERT INTO Checkconstraint2 VALUES(3,'SPEED',1.00,5);  --successful
alter table  checkconstraint2 modify price int (20);
DESC CHECKCONSTRAINT2;


ALTER TABLE CHECKCONSTRAINT2
ADD CONSTRAINT uc_name_address 
CHECK  (price>6) ;

Insert into checkconstraint2  VALUES(5,'FAST',200.00,5);
select * from checkconstraint2;

drop table checkconstraint2;
CREATE TABLE lasttable(
    part_no int(18) PRIMARY KEY,
    description VARCHAR(40),
    cost int  NOT NULL CHECK (cost > 0),
    price int CHECK (price > 8), 
    CONSTRAINT parts_chk_price_gt_cost 
        CHECK(price >= cost)
);
Insert into lasttable values(3,'flag',35,0); --working
Insert into lasttable values(2,'flag',3,4);---working
Insert into lasttable values(4,'flag',-2,-1);
select* from lasttable where (part_no <4 AND part_no >2);

/*It is a good practice to use the SELECT * for the ad-hoc queries only. If you embed the SELECT statement
in the code such as PHP, Java, Python, Node.js, you should explicitly specify the name of columns from which you want to get data */
---basic ddl and dml completed 
