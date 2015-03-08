CREATE TABLE Illness (
    ill_name VARCHAR(64) PRIMARY KEY,
    contagious BOOLEAN,
    average_treatment_cost MONEY
);

CREATE TABLE Equipment (
    eqpt_name VARCHAR(64) PRIMARY KEY,
    cost MONEY,
    consumable BOOLEAN NOT NULL
);

CREATE TABLE Department (
    dept_name VARCHAR(64) PRIMARY KEY,
    address TEXT NOT NULL,
    budget MONEY NOT NULL,
    other_costs MONEY
);

CREATE TABLE Staff (
    staff_id INTEGER PRIMARY KEY,
    dept_name VARCHAR(64) NOT NULL,
    wages MONEY,
    salary MONEY NOT NULL,
    shift_to TIME,
    shift_from TIME,
    over_time FLOAT,
    contract_from DATE NOT NULL,
    contract_until DATE NOT NULL,
    contact VARCHAR(64) NOT NULL,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    FOREIGN KEY (dept_name)
        REFERENCES Department(dept_name)
);

CREATE TABLE Doctor (
    staff_id INTEGER PRIMARY KEY,
    rank VARCHAR(32),
    board_certification TEXT,
    FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
);

CREATE TABLE Nurse (
    staff_id INTEGER PRIMARY KEY,
    certified_skills TEXT,
    FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
);

CREATE TABLE Admin (
    staff_id INTEGER PRIMARY KEY,
    admin_responsibilities TEXT,
    FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
);

CREATE TABLE Patient (
    patient_id INTEGER PRIMARY KEY,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    date_of_birth DATE NOT NULL,
    care_cost MONEY
);

CREATE TABLE DeptHasEqpt (
    dept_name VARCHAR(64),
    eqpt_name VARCHAR(64),
    amount_needed INTEGER,
    current_stock INTEGER NOT NULL,
    FOREIGN KEY (dept_name)
        REFERENCES Department(dept_name),
    FOREIGN KEY (eqpt_name)
        REFERENCES Equipment(eqpt_name),
    PRIMARY KEY (dept_name, eqpt_name)
);

CREATE TABLE InChargeOf (
    patient_id INTEGER PRIMARY KEY REFERENCES Patient(patient_id),
    dept_name VARCHAR(64),
    since DATE
);

CREATE TABLE SpecializesIn (
    staff_id INTEGER,
    ill_name VARCHAR(64),
    FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id),
    FOREIGN KEY (ill_name)
        REFERENCES Illness(ill_name),
    PRIMARY KEY (staff_id, ill_name)
);

CREATE TABLE SufferingFrom (
    patient_id INTEGER,
    ill_name VARCHAR(64),
    ill_since DATE NOT NULL,
    ill_until DATE,
    insurance_coverage MONEY,
    treatment_cost MONEY,
    urgency VARCHAR(32),
    FOREIGN KEY (patient_id)
        REFERENCES Patient(patient_id),
    FOREIGN KEY (ill_name)
        REFERENCES Illness(ill_name),
    PRIMARY KEY (patient_id, ill_name)
);

CREATE TABLE Treats (
    staff_id INTEGER,
    patient_id INTEGER,
    since DATE NOT NULL,
    until DATE,
    FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id),
    FOREIGN KEY (patient_id)
        REFERENCES Patient(patient_id),
    PRIMARY KEY (staff_id, patient_id)
);


-- DROP TABLE Treats;
-- DROP TABLE SufferingFrom;
-- DROP TABLE SpecializesIn;
-- DROP TABLE InChargeOf;
-- DROP TABLE DeptHasEqpt;
-- DROP TABLE Patient;
-- DROP TABLE Admin;
-- DROP TABLE Nurse;
-- DROP TABLE Doctor;
-- DROP TABLE Staff;
-- DROP TABLE Department;
-- DROP TABLE Equipment;
-- DROP TABLE Illness;