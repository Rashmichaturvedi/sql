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

