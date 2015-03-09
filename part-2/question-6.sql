/*
(12 Pts) Write four data modification commands for your application. Most of these commands should be \interesting," in the sense that 
they involve some complex feature, such as inserting the result of a query, updating several tuples at once, or deleting a set of tuples 
that is more than one but less than all the tuples in a relation.
Turn in a description of all the relations that you use in your modifications but are not described so far. Provide a short description 
of what each of your statements is supposed to do, the SQL statements themselves and a script or screenshot that shows your modification 
commands running in a convincing fashion.
*/

--Increase the price of all equipments produced by Big Pharma Inc by 10% to reflect recent increases 
--in trade tariffs experienced by this company (updating multiple tuples).
UPDATE Equipment
SET cost = cost*1.1
WHERE manufacturer = 'Big Pharma Inc.';

-- Assign doctor 34004 to patients suffering from Gastroenteritis that are not being currently treated
-- and are still ill
INSERT INTO Treats (staff_id, patient_id, since, until)
SELECT 34004 as staff_id, patient_id, ill_since, ill_until
FROM SufferingFrom
WHERE ill_id = (SELECT ill_id 
                FROM Illness
                WHERE ill_name like '%Gastroenteritis%')
AND patient_id NOT IN (SELECT patient_id
                            FROM Treats)
AND ill_until IS NULL;


-- Delete doctors who earn more than 400000 per annum and are treating fewer than 10 patients
DELETE FROM Staff
WHERE EXISTS (SELECT *
                FROM Doctor
                WHERE Doctor.staff_id = Staff.staff_id)
AND (SELECT COUNT(*) 
            FROM Treats
            WHERE Treats.staff_id = Staff.staff_id) <= 10
AND salary >= 400000;


-- For every department that doesn't have any stethoscopes, buy as many stethoscopes as there are doctors in the department

INSERT INTO DeptHasEqpt (dept_name, eqpt_id, amount_needed, current_stock)
SELECT Dep.dept_name, 1017, count(S.staff_id), count(S.staff_id)
FROM Department Dep, Staff S, Doctor Doc
WHERE 
    S.staff_id = Doc.staff_id
    AND S.dept_name = Dep.dept_name
    AND Dep.dept_name IN (
        SELECT dept_name FROM Department  -- Exclude departments that already have stethoscopes
        EXCEPT
        SELECT dept_name FROM DeptHasEqpt
        WHERE eqpt_id = 1017
    )
GROUP BY Dep.dept_name;
