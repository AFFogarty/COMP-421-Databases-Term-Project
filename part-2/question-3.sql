INSERT INTO Illness VALUES ('Gastroenteritis', TRUE, '80.50');
INSERT INTO Illness VALUES ('Norovirus', TRUE, '120');
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
INSERT INTO SpecializesIn VALUES (34001, 'Gastroenteritis');
INSERT INTO SufferingFrom VALUES (691123, 'Gastroenteritis', '2015-03-07', NULL, '2000');
INSERT INTO SufferingFrom VALUES (691123, 'Norovirus', '2014-05-15', '2014-06-01', '2000');
INSERT INTO Treats VALUES (34001, 691123, '2015-03-07', NULL);
INSERT INTO DeptHasEqpt VALUES ('Infectious Diseases', 1010, NULL, '400');


-- Question 4 queries to fill up the database

INSERT INTO Illness VALUES
    ('unclassified disorders of the trigeminal nerves', FALSE, 635.90),
    ('unspecified type of hypertension complicating pregnancy', FALSE, 642.09),
    ('complication due to diabetes mellitus of the mother', FALSE, 648.03),
    ('antepartum condition or complication due to triplet pregnancy', FALSE, 651.13),
    ('unclassified disorders of the hand joints', FALSE, 719.84),
    ('unspecified type of goiter', FALSE, 240.90),
    ('schizophrenic disorders', FALSE, 295.00),
    ('cancer arising from a poorly defined location', FALSE, 195.00),
    ('unclassified emotional disturbances', FALSE, 313.89),
    ('reflex sympathetic dystrophy of the lower limb', FALSE, 337.22);


