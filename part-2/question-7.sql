/*
(10 Pts) Create two views on top of your database schema. Turn in an informal description what data each of the views represents, 
show your CREATE VIEW statements and the response of the system. Also, show a query involving each view and the system response 
(but truncate the response if there are more than a few tuples produced).
*/

--Selects every equipment's name, cost, and manufacturer that has a unit price greater than the 
--average unit price.
CREATE VIEW ExpensiveEquipment AS
SELECT eqpt_name, cost, manufacturer
FROM Equipment
WHERE cost > (SELECT avg(cost) FROM Equipment);

--Selects those patients that have illnesses identified as contagious to not only prioritize treatments 
--but also limit the possible spread of the disease throughout the hospital.
CREATE VIEW PossibleQuarantine AS
SELECT SufferingFrom.patient_id, Illness.ill_name
FROM SufferingFrom 
INNER JOIN Illness
ON SufferingFrom.ill_id = Illness.ill_id
WHERE contagious IS NOT NULL AND contagious = 't';

DROP VIEW ExpensiveEquipment;
DROP VIEW PossibleQuarantine;