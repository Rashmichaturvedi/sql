---Advanced Sql :stored procedure
/* you want to save this query on the database server for execution later,
 one way to do it is to use a stored procedure.*/
use campus_prepartion
select * from customers
DELIMITER $$ /* redefine the delimiter temporarily so that you can pass the whole stored procedure to the server as a single statement.*/
 
CREATE PROCEDURE GetCustomer()
BEGIN
    SELECT 
        branchid,
        firstname,
        lastname,
ammount
    FROM
        customers
    ORDER BY firstname;    
END$$
DELIMITER ;


call getcustomer();   --to invoke the stored procedure

--create new stored procedure
DELIMITER //
 
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT *  FROM customers;
END //
 
DELIMITER ;

/*The first and last DELIMITER commands are not a part of the stored procedure. The first DELIMITER command changes the default delimiter to // and the last DELIMITER command changes the delimiter 
back to the default one which is semicolon (;).*/

--you can also initalise parameters inside stored procedure inside the paranthese

DELIMITER $$
 
CREATE PROCEDURE GetEmployees()
BEGIN
    SELECT 
        fname, 
        f.id, 
        salary 
        
    FROM fork f
    INNER JOIN ddltable  d using (salary);
    
END$$
 
DELIMITER ;
call getemployees();
/*Removing stored procedure*/

drop procedure getemployees;
SHOW WARNINGS;
/*MySQL does not have any statement that allows you
 to directly modify the parameters and body of the stored procedure.*/
--Listing  procedure
-- SHOW PROCEDURE STATUS [LIKE 'pattern' | WHERE search_condition]
SHOW PROCEDURE STATUS;

SHOW PROCEDURE STATUS LIKE '%salary%'
-- Listing stored procedures using the data dictionary
SELECT 
    routine_name
FROM
    information_schema.routines
WHERE
    routine_type = 'PROCEDURE'
        AND routine_schema = 'campus_prepartion';
-- variables
DECLARE totalSale DEC(10,2) DEFAULT 0.0;
DECLARE x, y INT DEFAULT 0;   --error

SET totalsale = 10.0;

---putting all together

DELIMITER $$
 
CREATE PROCEDURE GetTotalOrder()
BEGIN
    DECLARE totalOrder INT DEFAULT 0;
    
    SELECT COUNT(*) 
    INTO totalOrder
    FROM fork;
    
    SELECT totalOrder;
END$$
 
DELIMITER ;
USE CAMPUS_PREPARTION
SELECT * FROM BANK
--CASE



call gettotalorder();
-- parameters :stored procedures 
-- with parameters including IN, OUT, and INTOUT parameters.:
DELIMITER //
 
CREATE PROCEDURE GetOfficeByCountry(IN countryName VARCHAR(255) )
BEGIN
    SELECT * 
     FROM fork
    WHERE fname= countryName;
END //
 
DELIMITER ;
call getofficebycountry('Anuj'); --calling parameter 
select * from bank;
DELIMITER $$
 
CREATE PROCEDURE GetOrderCountByStatus (
    IN  orderStatus VARCHAR(25),
    OUT total INT
)
BEGIN
    SELECT COUNT(branchid)
    INTO total
    FROM bank
    WHERE Country = orderStatus;
END$$
 
DELIMITER ;
CALL GetOrderCountByStatus('usa',@total);
SELECT @total;    /* pass a session variable ( @total ) to receive the return value.*/
/* INOUT */
DELIMITER $$
 
CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END$$
 
DELIMITER ;
SET @counter = 1;
CALL SetCounter(@counter,1); -- 2
CALL SetCounter(@counter,1); -- 3
CALL SetCounter(@counter,5); -- 8
SELECT @counter;
select * from bank;
/* IF THEN */
DELIMITER $$
 
CREATE PROCEDURE GetCustomerLe(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL(10,2) DEFAULT 0;
 
    SELECT branchid
    INTO credit
    FROM bank
    WHERE branchid = pCustomerNumber;
 
    IF branchid > 121 THEN
        SET pCustomerLevel = 'PLATINUM';
    END IF;
END$$
 
DELIMITER ;

CALL GetCustomerLe(121, @level);
SELECT @level;
select * from bank;


--If then else

DELIMITER $$
 
CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL DEFAULT 0;
 
    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;
 
    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSE
        SET pCustomerLevel = 'NOT PLATINUM';
    END IF;
END$$
 
DELIMITER ;

/*MySQL IF-THEN-ELSEIF-ELSE statement*/

DELIMITER $$
 
CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL DEFAULT 0;
 
    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;
 
    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSEIF credit <= 50000 AND credit > 10000 THEN
        SET pCustomerLevel = 'GOLD';
    ELSE
        SET pCustomerLevel = 'SILVER';
    END IF;
END $$
 
DELIMITER ;
--CASE STATEMENT
DELIMITER $$
 
CREATE PROCEDURE GetCustomerShipping(
    IN  pCustomerNUmber INT, 
    OUT pShipping       VARCHAR(50)
)
BEGIN
    DECLARE customerCountry VARCHAR(100);
 
SELECT 
    country
INTO customerCountry FROM
    BANK
WHERE
    branchid = pCustomerNUmber;
 
    CASE customerCountry
        WHEN  'USA' THEN
           SET pShipping = '2-day Shipping';
        WHEN 'Canada' THEN
           SET pShipping = '3-day Shipping';
        ELSE
           SET pShipping = '5-day Shipping';
    END CASE;
END$$
 
DELIMITER ;


	
CALL GetCustomerShipping(121,@shipping);

	
SELECT @shipping;   /*else condition gets executed*/
 
-- Searched CASE statement

DELIMITER $$
 
CREATE PROCEDURE GetDeliveryStatus(
    IN pOrderNumber INT,
    OUT pDeliveryStatus VARCHAR(100)
)
BEGIN
    DECLARE waitingDay INT DEFAULT 0;
    SELECT 
        DATEDIFF(requiredDate, shippedDate)
    INTO waitingDay
    FROM orders
    WHERE orderNumber = pOrderNumber;
    
    CASE 
        WHEN waitingDay = 0 THEN 
            SET pDeliveryStatus = 'On Time';
        WHEN waitingDay >= 1 AND waitingDay < 5 THEN
            SET pDeliveryStatus = 'Late';
        WHEN waitingDay >= 5 THEN
            SET pDeliveryStatus = 'Very Late';
        ELSE
            SET pDeliveryStatus = 'No Information';
    END CASE;    
END$$
DELIMITER ;



/* LOOP IN STORED PROCEDURE*/ -- LEAVE & ITERATE
-- GENERATE TABLE OF 2
DELIMITER $$
CREATE PROCEDURE LoopDemo2()
BEGIN
    DECLARE x  INT;
    DECLARE str  VARCHAR(255);
        
    SET x = 1;
    SET str =  '';
        
    loop_label:  LOOP
        IF  x > 20 THEN
            LEAVE  loop_label;
        END  IF;
            
        SET  x = x + 1;
        IF  (x mod 2) THEN
            ITERATE  loop_label;
        ELSE
            SET  str = CONCAT(str,x,',');
        END  IF;
    END LOOP;
    SELECT str;
END$$
 
DELIMITER ;




/*CALLLING LOOP */	
CALL LoopDemo2();

-- WHILE STATEMENT -PRETEST LOOP
CREATE TABLE calendars(
    id INT AUTO_INCREMENT,
    fulldate DATE UNIQUE,
    day TINYINT NOT NULL,
    month TINYINT NOT NULL,
    quarter TINYINT NOT NULL,
    year INT NOT NULL,
    PRIMARY KEY(id)
);
------------------------------------- To insert values
DELIMITER $$
 
CREATE PROCEDURE InsertCalendar(dt DATE)
BEGIN
    INSERT INTO calendars(
        fulldate,
        day,
        month,
        quarter,
        year
    )
    VALUES(
        dt, 
        EXTRACT(DAY FROM dt),
        EXTRACT(MONTH FROM dt),
        EXTRACT(QUARTER FROM dt),
        EXTRACT(YEAR FROM dt)
    );
END$$
 
DELIMITER ;

----------------------------------
DELIMITER $$
 
CREATE PROCEDURE LoadCalendars(
    startDate DATE, 
    day INT
)
BEGIN
    
    DECLARE counter INT DEFAULT 1;
    DECLARE dt DATE DEFAULT startDate;
 
    WHILE counter <= day DO
        CALL InsertCalendar(dt);
        SET counter = counter + 1;
        SET dt = DATE_ADD(dt,INTERVAL 1 day);
    END WHILE;
 
END$$
 
DELIMITER ;


call loadcalendars('2019-01-01',31);
-- Repeat :The REPEAT checks the search_condition after the execution of statement, therefore, the statement always executes at least once. This is why the REPEAT is also known as a post-test loop.

Delimiter $$
Create procedure repeatpro()
BEGIN
Declare  counter int  default 1;
declare result varchar(100) default '';
REPEAT 
SET RESULT = CONCAT(result , counter ,',');
SET COUNTER =COUNTER +1;
UNTIL COUNTER >=10
END REPEAT;

SELECT RESULT;
END$$
DELIMITER ;
select * from bank;

CALL REPEATPRO();
-- PRINTS 1,2,3, UPTO 9

/* LEAVE :  LEAVE statement to exit a stored program or terminate a loop.*/

DELIMITER $$
CREATE PROCEDURE TESTLEAVE3( IN CUST INT)
SP: BEGIN
DECLARE CUSTCOUNT INT ;

SELECT COUNT(*) INTO CUSTCOUNT FROM  BANK WHERE branchid = cust ;
 select * from bank;
if custcount = 2 then leave  sp ;
 end if ; 
end$$ 
DELIMITER ;

call testleave3(182);

--Leave with while
DELIMITER $$
 
CREATE PROCEDURE LeaveDemo(OUT result VARCHAR(100))
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE times INT;
    -- generate a random integer between 4 and 10
    SET times  = FLOOR(RAND()*(10-4+1)+4);
    SET result = '';
    disp: LOOP
        -- concatenate counters into the result
        SET result = concat(result,counter,',');
        
        -- exit the loop if counter equals times
        IF counter = times THEN
            LEAVE disp; 
        END IF;
        SET counter = counter + 1;
    END LOOP;
END$$
 use campus_prepartion;
DELIMITER ;
CALL LeaveDemo(@result);
SELECT @result;
 show tables;
use campus_prepartion;
select * from customers;
alter table customers add email varchar(10);
Insert into customers value(7,'raj','singh',300,'r@gmail.com'),(9,'farhan','khan',200,'f@gmail.com');
--Cursor : declare , open , fetch
/* develop a stored procedure that creates an email list of all employees in the employees table in the sample database.*/

---------------------------------
DELIMITER $$
CREATE PROCEDURE createEmail (
    INOUT emailList varchar(4000)
)
BEGIN
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE emailAddress varchar(100) DEFAULT "";
 
    -- declare cursor for employee email
    DEClARE curEmail 
        CURSOR FOR 
            SELECT email FROM customers;
 
    -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
 
    OPEN curEmail;
 
    getEmail: LOOP
        FETCH curEmail INTO emailAddress;
        IF finished = 1 THEN 
            LEAVE getEmail;
        END IF;
        -- build email list
        SET emailList = CONCAT(emailAddress,";",emailList);
    END LOOP getEmail;
    CLOSE curEmail;
 
END$$
DELIMITER ;



SET @emailList = ""; 
CALL createEmail(@emailList); 
SELECT @emailList;
--Handling errors
--SIGNAL & Resignal
DELIMITER $$
 
CREATE PROCEDURE Divide(IN numerator INT, IN denominator INT, OUT result double)
BEGIN
    DECLARE division_by_zero CONDITION FOR SQLSTATE '22012';
 
    DECLARE CONTINUE HANDLER FOR division_by_zero 
    RESIGNAL SET MESSAGE_TEXT = 'Division by zero / Denominator cannot be zero';
    -- 
    IF denominator = 0 THEN
        SIGNAL division_by_zero;
    ELSE
        SET result := numerator / denominator;
    END IF;
END
CALL Divide(10,0,@result);
--stored functions
delimiter $$
create function cleverboy( height int (20))
returns varchar(25)
DETERMINISTIC
BEGIN 
declare person varchar(20);
if  height <4 then 
set person = "short";
elseif height <6 then
set person ="medium";
elseif height <10  then 
set  person="tall";
end if ;
return (person);
end $$;
DELIMITER $$;
--
SHOW FUNCTION STATUS 
WHERE db = 'campus_prepartion';

-- calling stored function in sql

SELECT 
    customerName, 
    CustomerLevel(creditLimit)
FROM
    customers
ORDER BY 
    customerName;
-- REMOVING FUNCTIONS
DROP FUNCTION IF  EXISTS CLEVERBOY;
SHOW WARNINGS;

-- LISTING SQL FUCTION FROM DATA DICTIONARY
SELECT 
    routine_name
FROM
    information_schema.routines
WHERE
    routine_type = 'FUNCTION'
        AND routine_schema = 'campus_prepartion';

show FUNCTION  status











