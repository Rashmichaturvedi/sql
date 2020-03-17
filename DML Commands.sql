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