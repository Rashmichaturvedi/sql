/*functions in mysql*/
use campus_prepartion;
/*Numeric functions :*/
SELECT City, MinTemp, CEIL(MinTemp) AS "Ceiling", FLOOR(MinTemp) AS "Floor", ABS(MinTemp) as "Absolute"  FROM Weather;
SELECT City, MinTemp, ROUND(MinTemp) as "Round", ROUND(MinTemp,1) as "RoundTo1Digit" FROM Weather;
Character functions :
select * from fork;
SELECT fname, LENGTH(fname) "LENGTH",  LOWER(fname) "LOWERCASE", UPPER(fname) "UPPERCASE" FROM fork;

SELECT fname, salary, CONCAT(fname, salary) "CONCAT", fname || salary "ConcatByOperator",
 CONCAT(CONCAT(fname, ', '), salary) "NestedConcat" FROM  fork;

SELECT fname, SUBSTR(fname,1,4) FIRST4, SUBSTR(fname,2,10) TEN_FROM_2, 
SUBSTR(fname,3) ALL_FROM_3, SUBSTR(fname,5, 2) TWO_FROM_7 FROM fork;

conversion functions :
SELECT MinTemp, TO_CHAR(MinTemp) DEF_FORMAT, 
TO_CHAR(MinTemp, '999.99') "FIXED_DIGITS", TO_CHAR(MinTemp, '9,9.99') "COMMA" FROM Weather;


SELECT '1000.98' "ORIG_NOFORMAT",
 TO_NUMBER('1000.98') "CONV_NOFORMAT", '1,000.98' "ORIG_FORMAT",
 TO_NUMBER('1,000.98', '9,999.99') "CONV_FORMAT" FROM DUAL;
 SELECT '01-Jan-2014' DATE_STRING, TO_DATE('01-Jan-2014') CONV_NOFORMAT,
 TO_DATE('01-Jan-2014', 'DD-Mon-YYYY') CONV_FORMAT FROM DUAL

SELECT TO_CHAR(RecordDate) DEF_FORMAT, TO_CHAR(RecordDate, 'DD/MM/CCYY') INDIAN, 
TO_CHAR(RecordDate, 'MM/DD/YY') AMERICAN FROM Weather;
---------------------------Aggregrate funtions 
/*STDEV()	Return the population standard deviation.
STDDEV_POP()	Return the population standard deviation.
STDDEV_SAMP()	Return the sample standard deviation.*/
--avg
select avg(salary) salary_per_total
from fork;

select fname, avg(salary) from fork group by(fname) order by(fname);
--count(*)
select count(*) as total from fork;

---sum :The SUM() function ignores NULL. If no matching row found, the SUM() function returns NULL.

select fname,sum(salary * id) total from fork group by (fname) order by total desc;

--max 
select max(salary) highest_price from fork;
SELECT 
    fname, MAX(salary)
FROM
    fork
GROUP BY fname
ORDER BY MAX(salary) DESC;

--min
select min(salary) min_price from fork;
 /*CONTROL FLOW FUNCTION
MySQL IFNULL function is one of the MySQL control flow functions that accepts two arguments and returns 
the first argument if it is not NULL. Otherwise, the IFNULL function returns the second argument.

NULLIF
CASE :WHEN ELSE THEN
IF

Notice that you should avoid using the IFNULL function in the WHERE clause, because it degrades the performance of the query. If you want to check if a value is

If you want to check if a value is NULL or not, you can use IS NULL or IS NOT NULL in the WHERE clause.*/
--COMPARSION FUNCTION
--COALESCE
--ISNULL
--GREATEST &  LEAST
SELECT GREATEST(10, 20, 30),  -- 30
       LEAST(10, 20, 30);


CREATE TABLE IF NOT EXISTS revenues (
    company_id INT PRIMARY KEY,
    q1 DECIMAL(19 , 2 ),
    q2 DECIMAL(19 , 2 ),
    q3 DECIMAL(19 , 2 ),
    q4 DECIMAL(19 , 2 )
);
INSERT INTO revenues(company_id,q1,q2,q3,q4)
VALUES (1,100,120,110,130),
       (2,250,260,300,310);


SELECT 
    company_id,
    LEAST(q1, q2, q3, q4) low,
    GREATEST(q1, q2, q3, q4) high
FROM
    revenues;

/* you can see, the low and high values of the company id 3 are NULLs.

To avoid this, you can use the IFNULL function as follows:*/
INSERT INTO  revenues  values(3,228,212,45,32);
SELECT 
    company_id,
    LEAST(IFNULL(q1, 0),
            IFNULL(q2, 0),
            IFNULL(q3, 0),
            IFNULL(q4, 0)) low,
    GREATEST(IFNULL(q1, 0),
            IFNULL(q2, 0),
            IFNULL(q3, 0),
            IFNULL(q4, 0)) high
FROM
    revenues;

/*Home 

Function	Description
CURDATE	Returns the current date.
DATEDIFF	Calculates the number of days between two DATE values.
DAY	Gets the day of the month of a specified date.
DATE_ADD	Adds a time value to date value.
DATE_SUB	Subtracts a time value from a date value.
DATE_FORMAT	Formats a date value based on a specified date format.
DAYNAME	Gets the name of a weekday for a specified date.
DAYOFWEEK	Returns the weekday index for a date.
EXTRACT	Extracts a part of a date.
LAST_DAY	Returns the last day of the month of a specified date
NOW	Returns the current date and time at which the statement executed.
MONTH	Returns an integer that represents a month of a specified date.
STR_TO_DATE	Converts a string into a date and time value based on a specified format.
SYSDATE	Returns the current date.
TIMEDIFF	Calculates the difference between two TIME or DATETIME values.
TIMESTAMPDIFF	Calculates the difference between two DATE or DATETIME values.
WEEK	Returns a week number of a date.
WEEKDAY	Returns a weekday index for a date.
YEAR	Return the year for a specified date*/



 SELECT DAYNAME('2012-12-01'), DAYOFWEEK('2012-12-01');

SELECT EXTRACT(DAY FROM '2017-07-14 09:04:44') DAY;
 SELECT EXTRACT(DAY_HOUR FROM '2017-07-14 09:04:44') DAYHOUR;
 SELECT EXTRACT(DAY_MICROSECOND FROM '2017-07-14 09:04:44') DAY_MS;
SELECT EXTRACT(DAY_MINUTE FROM '2017-07-14 09:04:44') DAY_M;
SELECT EXTRACT(HOUR FROM '2017-07-14 09:04:44') HOUR;




----String functions:trim :remove unwnted 
SELECT TRIM(LEADING FROM '    MySQL TRIM Function   ');
SELECT LTRIM('    MySQL TRIM Function   ');

--window function
drop table if exists sales;
CREATE TABLE sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);
 
INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);
 
SELECT * FROM sales;
/*
ow_function_name(expression) 
    OVER (
        [partition_defintion]
        [order_definition]
        [frame_definition]
    )*/
