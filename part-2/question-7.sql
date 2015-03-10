/*
(10 Pts) Create two views on top of your database schema. Turn in an informal description what data each of the views represents, 
show your CREATE VIEW statements and the response of the system. Also, show a query involving each view and the system response 
(but truncate the response if there are more than a few tuples produced).
*/

--Creates view with every equipment's name, cost, and manufacturer that has a unit price greater than the 
--average unit price.
CREATE VIEW ExpensiveEquipment AS
SELECT eqpt_id, eqpt_name, cost, manufacturer
FROM Equipment
WHERE cost >= (SELECT avg(cost) FROM Equipment);

-- Find the department with more than 5 units of these pieces of equipment
SELECT dept_name, eqpt_name, current_stock, cost, manufacturer
FROM ExpensiveEquipment INNER JOIN DeptHasEqpt
ON ExpensiveEquipment.eqpt_id = DeptHasEqpt.eqpt_id
WHERE current_stock >= 5;

--Creates view with patients that have illnesses identified as contagious to not only prioritize treatments 
--but also limit the possible spread of the disease throughout the hospital.
CREATE VIEW PossibleQuarantine AS
SELECT SufferingFrom.patient_id, Illness.ill_name
FROM SufferingFrom 
INNER JOIN Illness
ON SufferingFrom.ill_id = Illness.ill_id
WHERE Illness.contagious IS NOT NULL AND Illness.contagious = 't';

-- Find the doctors who are treating these patients, and count these patients
SELECT first_name, last_name, count(PossibleQuarantine.patient_id) as contagious_patients
FROM PossibleQuarantine INNER JOIN Treats
ON Treats.patient_id = PossibleQuarantine.patient_id
    INNER JOIN Staff
    ON Treats.staff_id = Staff.staff_id
GROUP BY Treats.staff_id, first_name, last_name;

DROP VIEW ExpensiveEquipment;
DROP VIEW PossibleQuarantine;