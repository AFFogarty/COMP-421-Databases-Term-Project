/* Query 1 */

-- Get first name, last name from patients who have gastroenteritis and had norovirus before and recovered
SELECT first_name, last_name
FROM Patient
WHERE patient_id IN (SELECT patient_id
                    FROM SufferingFrom INNER JOIN Illness
                    ON SufferingFrom.ill_id = Illness.ill_id
                    WHERE ill_name LIKE '%Gastroenteritis%'
                    INTERSECT 
                    SELECT patient_id
                    FROM SufferingFrom INNER JOIN Illness
                    ON SufferingFrom.ill_id = Illness.ill_id
                    WHERE ill_name LIKE '%Norovirus%' AND ill_until IS NOT NULL);


/* Query 2 */

-- select staff_id, first_name, last_name of doctors and nurses from the oncology department working between midnight and 3am

SELECT S.staff_id, first_name, last_name
FROM Staff S INNER JOIN Doctor D
ON S.staff_id = D.staff_id
    FULL OUTER JOIN Nurse N
    ON S.staff_id = N.staff_id
WHERE S.dept_name LIKE '%Oncology%'
    AND (
        shift_from <= '03:00:00' -- Shift ends between midnight and 3am
        OR shift_to <='03:00:00' -- Shift begins between midnight and 3am
        OR (shift_to > '03:00:00' AND shift_from > shift_to)  -- Shift begins before midnight and ends after 3am
    );


/* Query 3 */
-- Get the department, equipment, manufacturer, and total cost to restock for departments needing pieces 
-- of equipment, and the total cost of restocking all equipment is less than their budget
SELECT Department.dept_name, eqpt_name, manufacturer, cost*amount_needed AS total_cost
FROM Equipment INNER JOIN DeptHasEqpt
ON Equipment.eqpt_id = DeptHasEqpt.eqpt_id
    INNER JOIN Department
    ON DeptHasEqpt.dept_name = Department.dept_name
WHERE amount_needed IS NOT NULL
GROUP BY Department.dept_name, eqpt_name, manufacturer, cost, amount_needed, budget
    HAVING SUM(cost*amount_needed) < budget;


/* Query 4 */
--list patient's first name and last name and the average cost incurred by all patients for patients 
--whose insurance does not fully cover their treatment costs and has been ill since 2012.
SELECT Patient.first_name, Patient.last_name, AVG(Patient.care_cost) AS avg_fee
FROM Patient INNER JOIN SufferingFrom
ON Patient.patient_id = SufferingFrom.patient_id
WHERE Patient.patient_id IN
(
    SELECT SufferingFrom.patient_id
    FROM SufferingFrom
    WHERE treatment_cost > insurance_coverage
    INTERSECT
    SELECT SufferingFrom.patient_id
    FROM SufferingFrom
    WHERE ill_since > '2012-01-01'
)
GROUP BY Patient.last_name;

/* Query 5 */
