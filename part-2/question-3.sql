-- Question 4 queries to fill up the database
INSERT INTO Illness VALUES
    ('i0023358','unclassified disorders of the trigeminal nerves', TRUE, '635.90'),
    ('i0023359','unspecified type of hypertension complicating pregnancy', FALSE, '642.09'),
    ('i0023361','complication due to diabetes mellitus of the mother', FALSE, '648.03'),
    ('i0023362','antepartum condition or complication due to triplet pregnancy', FALSE, '651.13'),
    ('i0023363','unclassified disorders of the hand joints', FALSE, '719.84'),
    ('i0023364','unspecified type of goiter', TRUE, '240.90'),
    ('i0023366','schizophrenic disorders', FALSE, '295.00'),
    ('i0023378','cancer arising from a poorly defined location', FALSE, '195.00'),
    ('i0023379','unclassified emotional disturbances', TRUE, '313.89'),
    ('i0023382','reflex sympathetic dystrophy of the lower limb', FALSE, '337.22');

INSERT INTO Equipment VALUES
    (1011, 'Scalpel', 'Scalpel Co. Inc.', '29.99', FALSE),
    (1012, 'Buzzsaw', 'Venosta Saw Corp.', '129.99', FALSE),
    (1013, 'Calipers', 'E.T. & Company', '29.99', FALSE),
    (1014, 'Penicillin', 'Big Pharma Ic.', '9.99', TRUE),
    (1015, 'Advil', 'Big Pharma Inc.', '8.99', TRUE),
    (1016, 'Placebo', 'Big Pharma Inc.', '0.99', TRUE);

INSERT INTO Department VALUES
    ('Oncology', '321 Rue Universite Montreal H2H 3P5', '7000000.00', '45000'),
    ('Psychiatry', '321 Rue Universite Montreal H2H 3P5', '3000000.00', '25000'),
    ('Pediatrics', '321 Rue Universite Montreal H2H 3P5', '5000000.00', '35000'),
    ('Gynecology', '321 Rue Universite Montreal H2H 3P5', '1000000.00', '65000'),
    ('Cardiology', '321 Rue Universite Montreal H2H 3P5', '9000000.00', '30000');


INSERT INTO Illness VALUES ('i0023313', 'Gastroenteritis', TRUE, '80.50');
INSERT INTO Illness VALUES ('i0023325', 'Norovirus', TRUE, '120');
INSERT INTO Equipment VALUES (1010, 'Syringe', 'Bayer', '2.50', TRUE);
INSERT INTO Department VALUES (
    'Infectious Diseases', '321 Rue Universite Montreal H2H 3P5', '7000000.33', '45000');
INSERT INTO Staff VALUES (
    34001, 'Infectious Diseases', '80', '310000', '9:00', '19:00', NULL, 
    '2012-01-01', '2016-03-29', '514-001-8223 kuhn@hospital.com', 'Thomas', 'Kuhn');
INSERT INTO Staff VALUES (
    34002, 'Infectious Diseases', '41', '130050', '9:00', '19:00', NULL, 
    '2012-04-12', '2015-04-20', '514-001-8246 popper@hospital.com', 'Karl', 'Popper');
INSERT INTO Staff VALUES (
    34003, 'Infectious Diseases', '30', '92030', '10:00', '18:00', NULL, 
    '2011-04-12', '2015-06-21', '514-001-8250 feyerabend@hospital.com', 'Paul', 'Feyerabend');
INSERT INTO Staff VALUES (
    34004, 'Infectious Diseases', '120', '375000', '8:00', '19:00', NULL, 
    '2012-06-13', '2015-08-20', '514-001-8270 carnap@hospital.com', 'Rudolf', 'Carnap');
INSERT INTO Doctor VALUES (34001, '1 Department Head', NULL);
INSERT INTO Nurse VALUES (34002, 'IV');
INSERT INTO Admin VALUES (34003, 'IT Management');
INSERT INTO Patient VALUES (691123, 'Claude', 'Debussy', '1951-12-23', '200');
INSERT INTO SpecializesIn VALUES (34001, 'i0023313');
INSERT INTO SufferingFrom VALUES (691123, 'i0023313', '2015-03-07', NULL, '2000');
INSERT INTO SufferingFrom VALUES (691123, 'i0023325', '2014-05-15', '2014-06-01', '2000');
INSERT INTO Treats VALUES (34001, 691123, '2015-03-07', NULL);
INSERT INTO DeptHasEqpt VALUES ('Infectious Diseases', 1010, NULL, 400);
INSERT INTO DeptHasEqpt VALUES ('Infectious Diseases', 1011, 75, 75);


/* Data for Query 2 */
INSERT INTO Staff VALUES (
    34090, 'Oncology', '99.00', '400000.00', '16:00', '02:00', NULL, 
    '2010-02-03', '2017-07-18', '514-001-1337 kant@hospital.com', 'Immanuel', 'Kant');
INSERT INTO Staff VALUES (
    34091, 'Oncology', '94.00', '380000.00', '18:00', '00:20', NULL, 
    '2012-01-23', '2015-08-29', '514-001-1824 burke@hospital.com', 'Edmund', 'Burke');
INSERT INTO Staff VALUES (
    34092, 'Oncology', '82.00', '270000.00', '20:00', '11:30', NULL, 
    '2010-09-12', '2016-01-13', '514-001-9812 hume@hospital.com', 'David', 'Hume');
INSERT INTO Staff VALUES (
    34093, 'Infectious Diseases', '87.00', '310000.00', '00:30', '5:00', NULL, 
    '2012-05-08', '2016-10-19', '514-001-8245 dasein@hospital.com', 'Martin', 'Heidegger');

INSERT INTO Doctor VALUES
    (34090, 'Top Surgeon', 'Some certifications'),
    (34091, 'Surgeon', 'Some certifications'),
    (34092, 'Surgeon', 'Some certifications'),
    (34093, 'Surgeon', 'Some certifications');


/* Data for Query 4 */
INSERT INTO Patient VALUES
    (690000, 'Arron', 'Afflalo', '1980-10-11', '120'),
    (690001, 'Coles', 'Aldrich', '1981-02-23', '140'),
    (690002, 'Kent', 'Bazemore', '1985-06-17', '160'),
    (690003, 'Blaire', 'DeJuan', '1982-04-08', '140'),
    (690004, 'Coreey', 'Brewer', '1988-03-25', '120');
INSERT INTO SufferingFrom VALUES
    (690000, 'i0023358', '2013-02-03', NULL, 60, 120, NULL),
    (690001, 'i0023359', '2014-01-02', NULL, 100, 130, NULL),
    (690002, 'i0023361', '2013-07-08', NULL, 200, 140, NULL),
    (690003, 'i0023362', '2008-08-20', NULL, 60, 120, NULL),
    (690004, 'i0023363', '2006-12-14', NULL, 80, 120, NULL);