CREATE TABLE Illness (
    ill_name VARCHAR(64) PRIMARY KEY,
    contagious BOOLEAN,
    average_treatment_cost MONEY
);

CREATE TABLE Equipment (
    eqpt_name VARCHAR(64) PRIMARY KEY,
    cost MONEY,
    consumable BOOLEAN
);

CREATE TABLE Department (
    dept_name VARCHAR(64) PRIMARY KEY,
    address TEXT,
    budget MONEY,
    other_costs MONEY
);

CREATE TABLE Staff (
    staff_id INTEGER PRIMARY KEY,
    shift_to TIME,
    shift_from TIME,
    contact VARCHAR(64),
    first_name VARCHAR(32),
    last_name VARCHAR(32)
);

CREATE TABLE Doctor (
    staff_id INTEGER PRIMARY KEY REFERENCES Staff(staff_id),
    rank VARCHAR(32),
    board_certification TEXT
);

CREATE TABLE Nurse (
    staff_id INTEGER PRIMARY KEY REFERENCES Staff(staff_id),
    certified_skills TEXT
);

CREATE TABLE Admin (
    staff_id INTEGER PRIMARY KEY REFERENCES Staff(staff_id),
    admin_responsibilities TEXT
);

CREATE TABLE Patient (
    patient_id INTEGER PRIMARY KEY,
    first_name VARCHAR(32),
    last_name VARCHAR(32),
    date_of_birth DATE,
    care_cost MONEY,
    dept_name VARCHAR(64)
);

CREATE TABLE Has (
    dept_name VARCHAR(64) REFERENCES Department(dept_name),
    eqpt_name VARCHAR(64) REFERENCES Equipment(eqpt_name),
    amount_needed INTEGER,
    current_stock INTEGER,
    PRIMARY KEY (dept_name, eqpt_name)
);

CREATE TABLE InChargeOf (
    patient_id INTEGER PRIMARY KEY REFERENCES Patient(patient_id),
    dept_name VARCHAR(64),
    since DATE
);

CREATE TABLE SpecializesIn (
    staff_id INTEGER REFERENCES Staff(staff_id),
    ill_name VARCHAR(64),
    PRIMARY KEY (staff_id, ill_name)
);

CREATE TABLE SufferingFrom (
    patient_id INTEGER REFERENCES Patient(patient_id),
    ill_name VARCHAR(64) REFERENCES Illness(ill_name),
    ill_since DATE,
    ill_until DATE,
    insurance_coverage MONEY,
    treatment_cost MONEY,
    urgency,
    PRIMARY KEY (patient_id, ill_name)
);

CREATE TABLE Treats (
    staff_id INTEGER REFERENCES Staff(staff_id),
    patient_id INTEGER REFERENCES Patient(patient_id),
    since DATE,
    PRIMARY KEY (staff_id, patient_id)
);

CREATE TABLE WorksFor (
    staff_id INTEGER REFERENCES Staff(staff_id),
    dept_name VARCHAR(64) REFERENCES Department(dept_name),
    wages MONEY,
    over_time FLOAT,
    contract_until DATE,
    salary MONEY,
    contract_from DATE,
    PRIMARY KEY (staff_id, dept_name)
);