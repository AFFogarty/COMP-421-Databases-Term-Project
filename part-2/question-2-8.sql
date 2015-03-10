/*
DESCRIPTION:
Lillio Mok 260456786
Andrew Fogarty 260535895
Zheng (Mason) Sun 260464047

-----------------------------------------------------------------------------
|This file contains the sql queries for each question.                      |
|The answers to each question are provided under a heading:                 |
|============ QUESTION N ============                                       |
|Please look for these in this file to find the responses.                  |
|Question 1 is provided in a text file                                      |
-----------------------------------------------------------------------------
*/

-- ============ QUESTION 2 ============                                     

CREATE TABLE Illness (
    ill_id char(8) PRIMARY KEY,
    ill_name VARCHAR(64),
    contagious BOOLEAN,
    average_treatment_cost NUMERIC(15,2)
);

CREATE TABLE Equipment (
    eqpt_id INTEGER PRIMARY KEY,
    eqpt_name VARCHAR(64),
    manufacturer VARCHAR(64),
    cost NUMERIC(15,2),
    consumable BOOLEAN NOT NULL
);

CREATE TABLE Department (
    dept_name VARCHAR(64) PRIMARY KEY,
    address TEXT NOT NULL,
    budget NUMERIC(15,2) NOT NULL,
    other_costs NUMERIC(15,2)
);

CREATE TABLE Staff (
    staff_id INTEGER PRIMARY KEY,
    dept_name VARCHAR(64) NOT NULL,
    wages NUMERIC(15,2),
    salary NUMERIC(15,2) NOT NULL,
    shift_to TIME,
    shift_from TIME,
    over_time FLOAT,
    contract_from DATE NOT NULL,
    contract_until DATE NOT NULL,
    contact VARCHAR(64) NOT NULL,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    FOREIGN KEY (dept_name)
        REFERENCES Department(dept_name) ON DELETE CASCADE
);

CREATE TABLE Doctor (
    staff_id INTEGER PRIMARY KEY,
    rank VARCHAR(32),
    board_certification TEXT,
    FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id) ON DELETE CASCADE
);

CREATE TABLE Nurse (
    staff_id INTEGER PRIMARY KEY,
    certified_skills TEXT,
    FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id) ON DELETE CASCADE
);

CREATE TABLE Admin (
    staff_id INTEGER PRIMARY KEY,
    admin_responsibilities TEXT,
    FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id) ON DELETE CASCADE
);

CREATE TABLE Patient (
    patient_id INTEGER PRIMARY KEY,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    date_of_birth DATE NOT NULL,
    care_cost NUMERIC(15,2)
);

CREATE TABLE SpecializesIn (
    staff_id INTEGER,
    ill_id CHAR(8),
    FOREIGN KEY (staff_id)  
        REFERENCES Staff(staff_id) ON DELETE CASCADE,
    FOREIGN KEY (ill_id)
        REFERENCES Illness(ill_id),
    PRIMARY KEY (staff_id, ill_id)
);

CREATE TABLE SufferingFrom (
    patient_id INTEGER,
    ill_id CHAR(8),
    ill_since DATE NOT NULL,
    ill_until DATE,
    insurance_coverage NUMERIC(15,2),
    treatment_cost NUMERIC(15,2),
    urgency VARCHAR(32),
    FOREIGN KEY (patient_id)
        REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (ill_id)
        REFERENCES Illness(ill_id) ON DELETE CASCADE,
    PRIMARY KEY (patient_id, ill_id)
);

CREATE TABLE Treats (
    staff_id INTEGER,
    patient_id INTEGER,
    since DATE NOT NULL,
    until DATE,
    FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id)
        REFERENCES Patient(patient_id) ON DELETE CASCADE,
    PRIMARY KEY (staff_id, patient_id)
);

CREATE TABLE DeptHasEqpt (
    dept_name VARCHAR(64),
    eqpt_id INTEGER,
    amount_needed INTEGER,
    current_stock INTEGER NOT NULL,
    FOREIGN KEY (dept_name)
        REFERENCES Department(dept_name) ON DELETE CASCADE,
    FOREIGN KEY (eqpt_id)
        REFERENCES Equipment(eqpt_id),
    PRIMARY KEY (dept_name, eqpt_id)
);

-- ============ QUESTION 3 ============                                     

-- Question 3 5 queries
INSERT INTO Illness VALUES ('i0023358','unclassified disorders of the trigeminal nerves', TRUE, '635.90');
INSERT INTO Illness VALUES ('i0023359','unspecified type of hypertension complicating pregnancy', FALSE, '642.09');
INSERT INTO Illness VALUES ('i0023361','complication due to diabetes mellitus of the mother', FALSE, '648.03');
INSERT INTO Illness VALUES ('i0023362','antepartum condition or complication due to triplet pregnancy', FALSE, '651.13');
INSERT INTO Illness VALUES ('i0023363','unclassified disorders of the hand joints', FALSE, '719.84');


-- ============ QUESTION 4 ============                                     
-- Question 4 population of database
INSERT INTO Illness VALUES
    ('i0023364','unspecified type of goiter', TRUE, '240.90'),
    ('i0023366','schizophrenic disorders', FALSE, '295.00'),
    ('i0023378','cancer arising from a poorly defined location', FALSE, '195.00'),
    ('i0023379','unclassified emotional disturbances', TRUE, '313.89'),
    ('i0023382','reflex sympathetic dystrophy of the lower limb', FALSE, '337.22'),
    ('i0023313', 'Gastroenteritis', TRUE, '80.50'),
    ('i0023325', 'Norovirus', TRUE, '120');

INSERT INTO Equipment VALUES
    (1011, 'Scalpel', 'Scalpel Co. Inc.', '29.99', FALSE),
    (1012, 'Buzzsaw', 'Venosta Saw Corp.', '129.99', FALSE),
    (1013, 'Calipers', 'E.T. & Company', '29.99', FALSE),
    (1014, 'Penicillin', 'Big Pharma Inc.', '9.99', TRUE),
    (1015, 'Advil', 'Big Pharma Inc.', '8.99', TRUE),
    (1016, 'Placebo', 'Big Pharma Inc.', '0.99', TRUE),
    (1017, 'Stethoscope', 'Stethoscopes Inc.', '39.99', FALSE),
    (1010, 'Syringe', 'Bayer', '2.50', TRUE),
    (1020, 'Defibrillator', 'Heart Co. Ltd. Inc.', '2500', TRUE);

INSERT INTO Department VALUES
    ('Oncology', '321 Rue Universite Montreal H2H 3P5', '7000000.00', '45000'),
    ('Psychiatry', '321 Rue Universite Montreal H2H 3P5', '3000000.00', '25000'),
    ('Pediatrics', '321 Rue Universite Montreal H2H 3P5', '5000000.00', '35000'),
    ('Gynecology', '321 Rue Universite Montreal H2H 3P5', '1000000.00', '65000'),
    ('Dermatology', '321 Rue Universite Montreal H2H 3P5', '500000.00', '15000'),
    ('Endocrinology', '321 Rue Universite Montreal H2H 3P5', '400000.00', '25000'),
    ('Genetics', '321 Rue Universite Montreal H2H 3P5', '900000.00', '20000'),
    ('Cardiology', '321 Rue Universite Montreal H2H 3P5', '9000000.00', '30000'),
    ('Infectious Diseases', '321 Rue Universite Montreal H2H 3P5', '7000000.33', '45000');

INSERT INTO Staff VALUES 
    (34001, 'Infectious Diseases', '80', '310000', '9:00', '19:00', NULL, 
    '2012-01-01', '2016-03-29', '514-001-8223 kuhn@hospital.com', 'Thomas', 'Kuhn'),
    (34002, 'Infectious Diseases', '41', '130050', '9:00', '19:00', NULL, 
    '2012-04-12', '2015-04-20', '514-001-8246 popper@hospital.com', 'Karl', 'Popper'),
    (34003, 'Infectious Diseases', '30', '92030', '10:00', '18:00', NULL, 
    '2011-04-12', '2015-06-21', '514-001-8250 feyerabend@hospital.com', 'Paul', 'Feyerabend'),
    (34004, 'Infectious Diseases', '120', '375000', '8:00', '19:00', NULL, 
    '2012-06-13', '2015-08-20', '514-001-8270 carnap@hospital.com', 'Rudolf', 'Carnap'),
    (34111, 'Genetics', '120.00', '400001.00', '16:00', '02:00', NULL, 
    '2010-02-03', '2014-07-18', '514-001-1344 descartes@hospital.com', 'Rene', 'Descartes'),
    (34112, 'Genetics', '120.00', '400001.00', '16:00', '02:00', NULL, 
    '2010-02-03', '2014-07-18', '514-001-1350 spinoza@hospital.com', 'Baruch', 'Spinoza'),
    (34090, 'Oncology', '99.00', '400000.00', '16:00', '02:00', NULL, 
    '2010-02-03', '2017-07-18', '514-001-1337 kant@hospital.com', 'Immanuel', 'Kant'),
    (34091, 'Oncology', '94.00', '380000.00', '18:00', '00:20', NULL, 
    '2012-01-23', '2015-08-29', '514-001-1824 burke@hospital.com', 'Edmund', 'Burke'),
    (34092, 'Oncology', '82.00', '270000.00', '20:00', '11:30', NULL, 
    '2010-09-12', '2016-01-13', '514-001-9812 hume@hospital.com', 'David', 'Hume'),
    (34093, 'Infectious Diseases', '87.00', '310000.00', '00:30', '5:00', NULL, 
    '2012-05-08', '2016-10-19', '514-001-8245 dasein@hospital.com', 'Martin', 'Heidegger'),
    (34100, 'Dermatology', '20.00', '24000.00', '00:30', '05:00', NULL, 
    '2011-04-12', '2016-04-11', '514-222-8245 amlou@hospital.com', 'Amundson', 'Lou'),
    (34101, 'Dermatology', '20.00', '24000.00', '00:30', '05:00', NULL, 
    '2012-04-12', '2015-04-11', '514-222-8246 kanderson@hospital.com', 'Kyle', 'Anderson'),
    (34102, 'Pediatrics', '50.00', '60000.00', '01:30', '05:30', NULL, 
    '2014-12-01', '2016-11-01', '514-222-8247 jant@hospital.com', 'Joel', 'Anthony'),
    (34103, 'Cardiology', '100.00', '120000.00', '16:30', '08:00', NULL, 
    '2011-06-21', '2017-10-19', '514-223-8248 justholiday@hospital.com', 'Justin', 'Holiday'),
    (34104, 'Cardiology', '100.00', '120000.00', '14:30', '06:00', NULL, 
    '2012-05-08', '2016-01-20', '514-223-8249 jhenson@hospital.com', 'John', 'Henson'),
    (34105, 'Infectious Diseases', '80.00', '96000.00', '18:30', '12:00', NULL, 
    '2013-01-01', '2014-01-01', '514-223-8250 regjackson@hospital.com', 'Reggie', 'Jackson');

INSERT INTO Doctor VALUES
    (34090, 'Top Surgeon', 'Some certifications'),
    (34091, 'Surgeon', 'Some certifications'),
    (34092, 'Surgeon', 'Some certifications'),
    (34093, 'Surgeon', 'Some certifications'),
    (34111, 'Department Head', NULL),
    (34112, 'Head Pathologist', 'Certification'),
    (34001, 'Department Head', NULL),
    (34004, NULL, NULL);

INSERT INTO Nurse VALUES 
    (34002, 'IV'),
    (34100, 'Wound care'),
    (34101, 'Sedation'),
    (34103, 'ACLS');

INSERT INTO Admin VALUES 
    (34003, 'IT Management'),
    (34102, 'Reception'),
    (34104, 'EKG Testing'),
    (34105, 'Biohazardous Waste Management');

INSERT INTO Patient VALUES
    (690000, 'Arron', 'Afflalo', '1980-10-11', '120'),
    (690001, 'Coles', 'Aldrich', '1981-02-23', '140'),
    (690002, 'Kent', 'Bazemore', '1985-06-17', '160'),
    (690003, 'Blaire', 'DeJuan', '1982-04-08', '140'),
    (690004, 'Coreey', 'Brewer', '1988-03-25', '120'),
    (691123, 'Claude', 'Debussy', '1951-12-23', '200'),
    (691124, 'Maurice', 'Ravel', '1951-12-27', '100'),
    (691125, 'John', 'Cage', '1952-12-27', '200'),
    (691126, 'Philip', 'Glass', '1952-04-03', '200'),
    (691127, 'Karlheinz', 'Stockhausen', '1949-04-13', '200'),
    (691128, 'Anton', 'Webern', '1945-04-23', '200');

INSERT INTO SufferingFrom VALUES
    (690000, 'i0023358', '2013-02-03', NULL, 60, 120, NULL),
    (690001, 'i0023359', '2014-01-02', NULL, 100, 130, NULL),
    (690002, 'i0023361', '2013-07-08', NULL, 100, 140, NULL),
    (690003, 'i0023362', '2014-08-20', NULL, 20, 120, NULL),
    (690004, 'i0023363', '2012-12-14', NULL, 30, 120, NULL),
    (691123, 'i0023313', '2015-03-07', NULL, '2000', 200, NULL),
    (691123, 'i0023325', '2014-05-15', '2014-06-01', '2000', 200, NULL),
    (691124, 'i0023313', '2015-03-07', '2015-03-31', '1000', 200, NULL),
    (691124, 'i0023325', '2014-05-19', '2014-06-04', '1000', 200, NULL),
    (691125, 'i0023313', '2014-12-07', NULL, '1000', 200, NULL),
    (691125, 'i0023325', '2013-09-15', '2013-10-01', '1000', 200, NULL),
    (691126, 'i0023313', '2014-11-08', NULL, '2500', 200, 'Urgent'),
    (691126, 'i0023325', '2013-03-21', '2013-04-01', '2500', 200, NULL),
    (691127, 'i0023313', '2014-12-10', NULL, '2000', 200, 'Minor'),
    (691127, 'i0023325', '2013-06-25', '2013-7-01', '2000', 200, NULL),
    (691128, 'i0023313', '2014-11-23', NULL, '15000', 200, 'Urgent'),
    (691128, 'i0023325', '2013-07-11', '2013-7-28', '15000', 200, NULL);

INSERT INTO SpecializesIn VALUES 
    (34001, 'i0023313'),
    (34001, 'i0023366'),
    (34004, 'i0023313'),
    (34091, 'i0023378'),
    (34091, 'i0023382'),
    (34092, 'i0023378');

INSERT INTO Treats VALUES
    (34002, 690000, '2013-02-03', NULL),
    (34090, 690000, '2013-02-04', NULL),
    (34002, 690001, '2014-01-02', NULL),
    (34091, 690001, '2014-01-02', NULL),
    (34092, 690002, '2013-07-08', NULL),
    (34093, 690003, '2014-08-21', NULL),
    (34001, 691123, '2015-03-07', NULL),
    (34002, 691123, '2015-03-07', NULL);

INSERT INTO DeptHasEqpt VALUES -- Stethoscopes
    ('Oncology', 1017, 10, 10),
    ('Psychiatry', 1017, 12, 10),
    ('Genetics', 1017, 12, 5),
    ('Infectious Diseases', 1010, NULL, 400),
    ('Infectious Diseases', 1011, 75, 75),
    ('Cardiology', 1020, 10, 50),
    ('Psychiatry', 1016, 2000, 2000),
    ('Oncology', 1015, 2000, 2000);


-- ============ QUESTION 5 ============                                     

/* Query 1 */

-- Get first name, last name from patients who have gastroenteritis and had norovirus before and recovered,
-- Order by last name
SELECT first_name, last_name
FROM Patient
WHERE patient_id IN (SELECT patient_id
                    FROM SufferingFrom INNER JOIN Illness
                    ON SufferingFrom.ill_id = Illness.ill_id
                    WHERE ill_name LIKE '%Gastroenteritis%' AND ill_until IS NULL
                    INTERSECT 
                    SELECT patient_id
                    FROM SufferingFrom INNER JOIN Illness
                    ON SufferingFrom.ill_id = Illness.ill_id
                    WHERE ill_name LIKE '%Norovirus%' AND ill_until IS NOT NULL)
ORDER BY last_name;


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
-- of equipment, and the total cost of restocking all equipment is less than their operating budget
-- I.e. get depts that can afford to restock all of their needed equipment
SELECT Department.dept_name, eqpt_name, manufacturer, cost, amount_needed, cost*amount_needed AS total_cost
FROM Equipment INNER JOIN DeptHasEqpt
ON Equipment.eqpt_id = DeptHasEqpt.eqpt_id
    INNER JOIN Department
    ON DeptHasEqpt.dept_name = Department.dept_name
WHERE amount_needed IS NOT NULL
GROUP BY Department.dept_name, eqpt_name, manufacturer, cost, amount_needed, budget
    HAVING SUM(cost*amount_needed) <= budget
ORDER BY Department.dept_name;


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
GROUP BY Patient.last_name, Patient.first_name;

/* Query 5 */

-- Det dept_name of departments that don't have as many stethoscopes as doctors.

-- Used EXCEPT because it better handles cases where there is no DeptHasEqpt relation.
-- If we didn't use EXCEPT, then there would have to be a lot of nested queries and
-- performance would have been worse.

SELECT dept_name from Department
EXCEPT
SELECT dept_name FROM Department D
WHERE
    (SELECT current_stock FROM DeptHasEqpt
    WHERE DeptHasEqpt.dept_name = D.dept_name
    AND eqpt_id = (SELECT eqpt_id FROM Equipment
                     WHERE eqpt_name LIKE '%Stethoscope%')) -- Number of stethoscopes
    >=
    (SELECT COUNT(*) FROM Doctor, Staff
    WHERE Doctor.staff_id = Staff.staff_id
    AND Staff.dept_name = D.dept_name); -- Number of doctors in the department


-- ============ QUESTION 6 ============                                     

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


-- ============ QUESTION 7 ============                                     

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


-- ============ QUESTION 8 ============                                     

-- Make sure that the contract dates are not nonsensical
ALTER TABLE Staff
ADD CONSTRAINT check_contract_dates CHECK(contract_from < contract_until);

-- Check for simple cases of missing email 
ALTER TABLE Staff
ADD CONSTRAINT check_email_exists CHECK(contact LIKE '%@%.%');

INSERT INTO Staff VALUES (
    34404, 'Infectious Diseases', '87.00', '310000.00', '00:30', '5:00', NULL, 
    '2016-05-08', '2015-10-19', '514-001-8245 bad1@hospital.com', 'Bad1', 'Test1');

INSERT INTO Staff VALUES (
    34405, 'Infectious Diseases', '87.00', '310000.00', '00:30', '5:00', NULL, 
    '2012-05-08', '2016-10-19', '514-001-8245 bad2lololol', 'Bad2', 'Test2');

-- DELETE FROM Staff
-- WHERE staff_id in (34404, 34405);

-- DROP TABLE Treats;
-- DROP TABLE SufferingFrom;
-- DROP TABLE SpecializesIn;
-- DROP TABLE DeptHasEqpt;
-- DROP TABLE Patient CASCADE;
-- DROP TABLE Admin;
-- DROP TABLE Nurse;
-- DROP TABLE Doctor;
-- DROP TABLE Staff;
-- DROP TABLE Department;
-- DROP TABLE Equipment;
-- DROP TABLE Illness;
