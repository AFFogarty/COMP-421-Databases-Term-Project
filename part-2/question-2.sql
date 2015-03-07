CREATE TABLE Illness (
    ill_name VARCHAR(64),
    contagious BOOLEAN,
    average_treatment_cost MONEY
);

CREATE TABLE Equipment (
    eqpt_name VARCHAR(64),
    cost MONEY,
    consumable BOOLEAN
);

CREATE TABLE Department (
    dept_name VARCHAR(64),
    address TEXT,
    budget MONEY,
    other_costs MONEY
);

CREATE TABLE Staff (
    staff_id INTEGER,
    shift_to TIME,
    shift_from TIME,
    contact VARCHAR(64),
    first_name VARCHAR(32),
    last_name VARCHAR(32)
);

CREATE TABLE Doctor (
    staff_id INTEGER,
    rank VARCHAR(32),
    board_certification TEXT
);

CREATE TABLE Nurse (
    staff_id INTEGER,
    certified_skills TEXT
);

CREATE TABLE Admin (
    staff_id INTEGER,
    admin_responsibilities TEXT
);

CREATE TABLE Patient (
    patient_id INTEGER,
    first_name VARCHAR(32),
    last_name VARCHAR(32),
    date_of_birth DATE,
    care_cost MONEY,
    dept_name VARCHAR(64)
);

CREATE TABLE Has (
    dept_name VARCHAR(64),
    eqpt_name VARCHAR(64),
    amount_needed INTEGER,
    current_stock INTEGER
);

CREATE TABLE InChargeOf (
    patient_id INTEGER,
    dept_name VARCHAR(64),
    since DATE
);

CREATE TABLE SpecializesIn (
    staff_id INTEGER,
    ill_name VARCHAR(64)
);

CREATE TABLE SufferingFrom (
    patient_id INTEGER,
    ill_name VARCHAR(64),
    ill_since DATE,
    ill_until DATE,
    insurance_coverage MONEY,
    treatment_cost MONEY,
    urgency
);

CREATE TABLE Treats (
    staff_id INTEGER,
    patient_id INTEGER,
    since DATE
);

CREATE TABLE WorksFor (
    staff_id INTEGER,
    dept_name VARCHAR(64),
    wages MONEY,
    over_time FLOAT,
    contract_until DATE,
    salary MONEY,
    contract_from DATE
);