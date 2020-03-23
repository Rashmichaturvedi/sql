/*functions in mysql*/
use campus_prepartion;
Numeric functions :
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


















