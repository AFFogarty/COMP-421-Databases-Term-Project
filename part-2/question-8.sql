/* Add two CHECK constraints to relations of your database schema.
Turn in the revised schema, its successful declaration, and the response of
DB2 to modifications (insert/update) that violate the constraints. */

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