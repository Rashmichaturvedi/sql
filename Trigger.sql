/*Trigger :a trigger is a stored program invoked automatically in response to an event such as insert, update, or delete that occurs in the associated table. For example, you can define a trigger that is invoked automatically
 before a new row is inserted into a table.
2 types of trigger are invoked
MySQL supports only row-level triggers. It doesnÃ¢â‚¬â„¢t support statement-level triggers.
*/

--Create Trigger
/*CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE| DELETE }
ON table_name FOR EACH ROW
trigger_body*/
use campus_prepartion;
CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

--------------
CREATE TRIGGER before_employee_update
    BEFORE UPDATE ON customers
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'update',
     id = OLD.branchid,
     lastname = OLD.lastname,
     changedat = NOW();

---------
SHOW TRIGGERS;

select * from customers
UPDATE customers
SET 
    lastName = 'Phan'
WHERE
   branchid =7;
=======================================================================================================================
CREATE TABLE billings (
    billingNo INT AUTO_INCREMENT,
    customerNo INT,
    billingDate DATE,
    amount DEC(10 , 2 ),
    PRIMARY KEY (billingNo)
);

DELIMITER $$
CREATE TRIGGER before_billing_update
    BEFORE UPDATE 
    ON billings FOR EACH ROW
BEGIN
    IF new.amount > old.amount * 10 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'New amount cannot be 10 times greater than the current amount.';
    END IF;
END$$    
DELIMITER ;
-----------
SELECT * FROM billings

SHOW TRIGGERS;
 --- Drop Triggers
DROP TRIGGER before_employee_update;

-- MySQL BEFORE INSERT Trigger
CREATE TABLE WorkCenters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL
);


CREATE TABLE WorkCenterStats(
    totalCapacity INT NOT NULL
);
-----------------------------------------------------

DELIMITER $$
 
CREATE TRIGGER before_workcenters_insert
BEFORE INSERT
ON WorkCenters FOR EACH ROW
BEGIN
    DECLARE rowcount INT;
    SELECT COUNT(*) 
    INTO rowcount
    FROM WorkCenterStats;
    
    IF rowcount > 0 THEN
        UPDATE WorkCenterStats
        SET totalCapacity = totalCapacity + new.capacity;
    ELSE
        INSERT INTO WorkCenterStats(totalCapacity)
        VALUES(new.capacity);
    END IF; 
END $$
DELIMITER ;
-- Testing Trigger
INSERT INTO WorkCenters(name, capacity)
VALUES('Mold Machine',100);
------------------------
	
SELECT * FROM WorkCenterStats;  


INSERT INTO WorkCenters(name, capacity)
VALUES('Packing',200);
SELECT * FROM WorkCenterStats;   -- trigger action have done total ans 300

------------------- After Trigger
DROP TABLE IF EXISTS members;
 
CREATE TABLE members (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    birthDate DATE,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS reminders;
 
CREATE TABLE reminders (
    id INT AUTO_INCREMENT,
    memberId INT,
    message VARCHAR(255) NOT NULL,
    PRIMARY KEY (id , memberId)
);
---------------------------------------
DELIMITER $$
 
CREATE TRIGGER after_members_insert
AFTER INSERT
ON members FOR EACH ROW
BEGIN
    IF NEW.birthDate IS NULL THEN
        INSERT INTO reminders(memberId, message)
        VALUES(new.id,CONCAT('Hi ', NEW.name, ', please update your date of birth.'));
    END IF;
END$$
 
DELIMITER ;
-----------------------------------------------------------------------------------------------------------
INSERT INTO members(name, email, birthDate)
VALUES
    ('John Doe', 'john.doe@example.com', NULL),
    ('Jane Doe', 'jane.doe@example.com','2000-01-01');
------------------------------------------------------------------------
SELECT * FROM reminders;  

-- MySQL BEFORE UPDATE Trigger
DROP TABLE IF EXISTS sales;
 
CREATE TABLE sales (
    id INT AUTO_INCREMENT,
    product VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    fiscalYear SMALLINT NOT NULL,
    fiscalMonth TINYINT NOT NULL,
    CHECK(fiscalMonth >= 1 AND fiscalMonth <= 12),
    CHECK(fiscalYear BETWEEN 2000 and 2050),
    CHECK (quantity >=0),
    UNIQUE(product, fiscalYear, fiscalMonth),
    PRIMARY KEY(id)
);

INSERT INTO sales(product, quantity, fiscalYear, fiscalMonth)
VALUES
    ('2003 Harley-Davidson Eagle Drag Bike',120, 2020,1),
    ('1969 Corvair Monza', 150,2020,1),
    ('1970 Plymouth Hemi Cuda', 200,2020,1);
=======================================================================================================================
DELIMITER $$
 
CREATE TRIGGER before_sales_update
BEFORE UPDATE
ON sales FOR EACH ROW
BEGIN
    DECLARE errorMessage VARCHAR(255);
    SET errorMessage = CONCAT('The new quantity ',
                        NEW.quantity,
                        ' cannot be 3 times greater than the current quantity ',
                        OLD.quantity);
                        
    IF new.quantity > old.quantity * 3 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = errorMessage;
    END IF;
END $$
 
DELIMITER ;
============================================================================================================================
UPDATE sales 
SET quantity = 150
WHERE id = 1;

Select * from sales;

SHOW ERRORS;
--  MySQL BEFORE DELETE triggers
DROP TABLE IF EXISTS Salaries;
 
CREATE TABLE Salaries (
    employeeNumber INT PRIMARY KEY,
    validFrom DATE NOT NULL,
    amount DEC(12 , 2 ) NOT NULL DEFAULT 0
   
);


INSERT INTO salaries(employeeNumber,validFrom,amount)
VALUES
    (1002,'2000-01-01',50000),
    (1056,'2000-01-01',60000),
    (1076,'2000-01-01',70000);
==============================================================================================================
DROP TABLE IF EXISTS SalaryArchives;    
 
CREATE TABLE SalaryArchives (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employeeNumber INT ,
    validFrom DATE NOT NULL,
    amount DEC(12 , 2 ) NOT NULL DEFAULT 0,
    deletedAt TIMESTAMP DEFAULT NOW()
);
================== Trigger
DELIMITER $$
 
CREATE TRIGGER before_salaries_delete
BEFORE DELETE
ON salaries FOR EACH ROW
BEGIN
    INSERT INTO SalaryArchives(employeeNumber,validFrom,amount)
    VALUES(OLD.employeeNumber,OLD.validFrom,OLD.amount);
END$$    
 
DELIMITER ;
-------------------------------------
select * from salaries;
select * from salaryarchives;
--------------------------------------------------------------------------------


DELETE FROM salaries 
WHERE employeeNumber = 1002;
-----------------------------------------------------------------------------------------------------------------------------
select * from salaryarchives;

----------------------------------------After Delete
CREATE TRIGGER after_salaries_delete
AFTER DELETE
ON Salaries FOR EACH ROW
UPDATE SalaryBudgets 
SET total = total - old.salary;
----------------------------------------  CREATE MULTIPLE TRIGGERS -----------------------------------------------------------
 DELIMITER $$
 
CREATE TRIGGER trigger_name
{BEFORE|AFTER}{INSERT|UPDATE|DELETE} 
ON table_name FOR EACH ROW 
{FOLLOWS|PRECEDES} existing_trigger_name
BEGIN
    -- statements
END$$
 
DELIMITER ;

----------------------MySQL Scheduled Event
/*MySQL Events can be very useful in many cases such as optimizing database tables, cleaning up logs, archiving data, or generating complex reports during off-peak time.

MySQL event scheduler configuration
MySQL uses a special thread called event scheduler thread to execute 
all scheduled events. You can view the status of the event scheduler thread by executing the SHOW PROCESSLIST command:*/
SHOW PROCESSLIST;
SET GLOBAL event_scheduler = ON;
===================================================================================================
use campus_prepartion;
CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    message VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL
);
CREATE EVENT IF NOT EXISTS test_event_01
ON SCHEDULE AT CURRENT_TIMESTAMP
DO
  INSERT INTO messages(message,created_at)
  VALUES('Test MySQL Event 1',NOW());

	
SELECT * FROM messages;

SHOW EVENTS FROM campus_prepartion





---Modifying events trigger
CREATE EVENT test_event_04
ON SCHEDULE EVERY 1 MINUTE
DO
   INSERT INTO messages(message,created_at)
   VALUES('Test ALTER EVENT statement',NOW());

ALTER EVENT test_event_04
ON SCHEDULE EVERY 2 MINUTE;


ALTER EVENT test_event_04
DO
   INSERT INTO messages(message,created_at)
   VALUES('Message from event',NOW());
--Disable event 
ALTER EVENT test_event_04
DISABLE;


---Drop Event
	
DROP EVENT [IF EXIST] event_name;