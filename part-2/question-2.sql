CREATE TABLE Illness (
    ill_name,
    contagious,
    average_treatment_cost
);

CREATE TABLE Equipment (
    eqpt_name,
    cost,
    consumable
);

CREATE TABLE Department (
    dept_name,
    address,
    budget,
    other_costs
);

CREATE TABLE Staff (
    staff_id,
    shift_to,
    shift_from,
    contact,
    first_name,
    last_name
);

CREATE TABLE Doctor (
    staff_id,
    rank,
    board_certification
);

CREATE TABLE Nurse (
    staff_id,
    certified_skills
);

CREATE TABLE Admin (
    staff_id,
    admin_responsibilities
);

CREATE TABLE Patient (
    patient_id,
    first_name,
    last_name,
    date_of_birth,
    care_cost,
    dept_name
);

CREATE TABLE Has (
    dept_name,
    eqpt_name,
    amount_needed,
    current_stock
);

CREATE TABLE InChargeOf (
    patient_id,
    dept_name,
    since
);

CREATE TABLE SpecializesIn (
    staff_id,
    ill_name 
);

CREATE TABLE SufferingFrom (
    patient_id,
    ill_name,
    ill_since,
    ill_until,
    insurance_coverage,
    treatment_cost,
    urgency
);

CREATE TABLE Treats (
    staff_id,
    patient_id,
    since
);

CREATE TABLE WorksFor (
    staff_id,
    dept_name,
    wages,
    over_time,
    contract_until,
    salary,
    contract_from
);