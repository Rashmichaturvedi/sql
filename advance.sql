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


call getcustomer();
