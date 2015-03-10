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
-- The three tuples that satisfy this are:
--  (1014, 'Penicillin', 'Big Pharma Inc.', '9.99', TRUE),
--  (1015, 'Advil', 'Big Pharma Inc.', '8.99', TRUE),
--  (1016, 'Placebo', 'Big Pharma Inc.', '0.99', TRUE),
UPDATE Equipment
SET cost = cost*1.1
WHERE manufacturer = 'Big Pharma Inc.';

-- Assign doctor 34004 to patients suffering from Gastroenteritis that are not being currently treated
-- and are still ill
-- The four patients satisfying this are in SufferingFrom: (i0023325 is Gastroenteritis)
-- (691125, 'i0023313', '2014-12-07', NULL, '1000', 200, NULL),
-- (691126, 'i0023313', '2014-11-08', NULL, '2500', 200, 'Urgent'),
-- (691127, 'i0023313', '2014-12-10', NULL, '2000', 200, 'Minor'),
-- (691128, 'i0023313', '2014-11-23', NULL, '15000', 200, 'Urgent'),
-- None of these are being treated
INSERT INTO Treats (staff_id, patient_id, since, until)
SELECT 34004 as staff_id, patient_id, ill_since, ill_until
FROM SufferingFrom
WHERE ill_id = (SELECT ill_id 
                FROM Illness
                WHERE ill_name like '%Gastroenteritis%')
AND patient_id NOT IN (SELECT patient_id
                            FROM Treats)
AND ill_until IS NULL;

-- Delete doctors who have treated fewer than 10 patients and had a salary of more than 400000 
-- and whose contract is up (assume that the time now is march 9th 2015)
-- This can be e.g. due to a new regulation against relatively useless doctors being hired
-- The two tuples satifying this are
-- (34111, 'Genetics', '120.00', '400001.00', '16:00', '02:00', NULL, 
-- '2010-02-03', '2014-07-18', '514-001-1344 descartes@hospital.com', 'Rene', 'Descartes'),
-- (34112, 'Genetics', '120.00', '400001.00', '16:00', '02:00', NULL, 
-- '2010-02-03', '2014-07-18', '514-001-1350 spinoza@hospital.com', 'Baruch', 'Spinoza'),
DELETE FROM Staff
WHERE EXISTS (SELECT *
                FROM Doctor
                WHERE Doctor.staff_id = Staff.staff_id)
AND (SELECT COUNT(*) 
            FROM Treats
            WHERE Treats.staff_id = Staff.staff_id) <= 10
AND contract_until <= '2015-03-09'
AND salary >= 400000;


-- For every department that doesn't have any stethoscopes, buy as many stethoscopes as there are doctors in the department
-- The department that needs this is Infectious Diseases
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
        WHERE eqpt_id = 1017 -- stethoscope id from Stethoscopes Inc.
    )
GROUP BY Dep.dept_name;

-- Verify Here:
-- Infectious Diseases has 3 new stethoscopes
SELECT Department.dept_name, eqpt_name, current_stock, COUNT(Staff.staff_id) as doctor_count
FROM Department INNER JOIN DeptHasEqpt
ON Department.dept_name = DeptHasEqpt.dept_name
    INNER JOIN Staff
    ON Staff.dept_name = Department.dept_name
        INNER JOIN Equipment
        ON DeptHasEqpt.eqpt_id = Equipment.eqpt_id
WHERE EXISTS (SELECT *
                FROM Doctor
                WHERE Doctor.staff_id = Staff.staff_id)
AND eqpt_name LIKE '%Stethoscope%' -- stethoscope id
GROUP BY Department.dept_name, Equipment.eqpt_id, eqpt_name, current_stock;
