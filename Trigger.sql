/*Trigger :a trigger is a stored program invoked automatically in response to an event such as insert, update, or delete that occurs in the associated table. For example, you can define a trigger that is invoked automatically
 before a new row is inserted into a table.
2 types of trigger are invoked
MySQL supports only row-level triggers. It doesn’t support statement-level triggers.
*/

--Create Trigger
/*CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE| DELETE }
ON table_name FOR EACH ROW
trigger_body*/
