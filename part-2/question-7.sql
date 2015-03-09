/*
(10 Pts) Create two views on top of your database schema. Turn in an informal description what data each of the views represents, 
show your CREATE VIEW statements and the response of the system. Also, show a query involving each view and the system response 
(but truncate the response if there are more than a few tuples produced).
*/

--Selects every equipment's name, cost, and manufacturer that has a unit price
--greater than the average unit price.
CREATE VIEW ExpensiveEquipment AS
SELECT eqpt_name, cost, manufacturer
FROM Equipment
WHERE cost > (SELECT avg(cost) FROM Equipment);