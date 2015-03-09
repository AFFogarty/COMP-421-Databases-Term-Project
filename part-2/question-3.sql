-- Question 3 5 queries
INSERT INTO Illness VALUES ('i0023358','unclassified disorders of the trigeminal nerves', TRUE, '635.90');
INSERT INTO Illness VALUES ('i0023359','unspecified type of hypertension complicating pregnancy', FALSE, '642.09');
INSERT INTO Illness VALUES ('i0023361','complication due to diabetes mellitus of the mother', FALSE, '648.03');
INSERT INTO Illness VALUES ('i0023362','antepartum condition or complication due to triplet pregnancy', FALSE, '651.13');
INSERT INTO Illness VALUES ('i0023363','unclassified disorders of the hand joints', FALSE, '719.84');


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
    (1014, 'Penicillin', 'Big Pharma Ic.', '9.99', TRUE),
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
    ('Infectious Diseases', 1017, 10, 0),
    ('Infectious Diseases', 1010, NULL, 400),
    ('Infectious Diseases', 1011, 75, 75),
    ('Cardiology', 1020, 10, 50),
    ('Psychiatry', 1016, 2000, 2000),
    ('Oncology', 1015, 2000, 2000);

