-- 1)
-- This table keeps records of patients who were treated successfully with the illness, the day 
-- discharged, and the staff member treating the patient.
CREATE TABLE OutPatientTreatment (
    patient_id INTEGER,
    ill_id char(8),
treated_by_staff_id INTEGER,
    ill_until DATE NOT NULL,
    FOREIGN KEY (patient_id)
        REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (ill_id)
        REFERENCES Illness(ill_id),
    FOREIGN KEY (treated_by_staff_id)
        REFERENCES Staff(staff_id) ON DELETE CASCADE,
    PRIMARY KEY (patient_id, ill_id, ill_until)
);

-- Procedure to log outpatient services for cured patient
-- Find most recent staff member to treat patient; note that a patient who hasn’t been treated and
-- has a null ill_until date may not be deleted or considered to be an outpatient.
CREATE OR REPLACE FUNCTION log_out_patient() RETURNS TRIGGER AS $log_out_patient$
BEGIN
    IF old.ill_until IS NULL THEN
        RAISE EXCEPTION 'ill_until cannot be null';
    END IF;

    INSERT
    INTO OutPatientTreatment(patient_id, ill_id, treated_by_staff_id, ill_until)
    SELECT old.patient_id, old.ill_id, staff_id, old.ill_until
    FROM Treats
    WHERE Treats.patient_id = old.patient_id
    ORDER BY Treats.since DESC
    LIMIT 1;
    
    RETURN old;
END;
$log_out_patient$ LANGUAGE 'plpgsql';

-- Response:
CS421=> CREATE OR REPLACE FUNCTION log_out_patient() RETURNS TRIGGER AS $log_out_patient$
CS421$> BEGIN
CS421$>     IF old.ill_until IS NULL THEN
CS421$>         RAISE EXCEPTION 'ill_until cannot be null';
CS421$>     END IF;
CS421$>
CS421$>     INSERT
CS421$>     INTO OutPatientTreatment(patient_id, ill_id, treated_by_staff_id, ill_until)
CS421$>     SELECT old.patient_id, old.ill_id, staff_id, old.ill_until
CS421$>     FROM Treats
CS421$>     WHERE Treats.patient_id = old.patient_id
CS421$>     ORDER BY Treats.since DESC
CS421$>     LIMIT 1;
CS421$>
CS421$>     RETURN old;
CS421$> END;
CS421$> $log_out_patient$ LANGUAGE 'plpgsql';
CREATE TRICREATE FUNCTION


-- Trigger the procedure if we delete a patient
CREATE TRIGGER logOutPatient AFTER DELETE ON SufferingFrom
FOR EACH ROW EXECUTE PROCEDURE log_out_patient();

-- Response 
CS421=> CREATE TRIGGER logOutPatient AFTER DELETE ON SufferingFrom
CS421-> FOR EACH ROW EXECUTE PROCEDURE log_out_patient();
CREATE TRIGGER

-- Examples; insert these if they are missing in the database
INSERT INTO SufferingFrom VALUES (691123, 'i0023325', '2014-05-15', '2014-06-01', 2000.00, 200.00, null);
INSERT INTO SufferingFrom VALUES (690000, 'i0023358', '2013-02-03', null, 60.00, 120.00, null);

-- Will not trigger because of null value
CS421=> DELETE FROM SufferingFrom WHERE patient_id = 690000 AND ill_id = 'i0023358';
ERROR:  ill_until cannot be null

-- Will trigger
CS421=> DELETE FROM SufferingFrom WHERE patient_id = 691123 AND ill_id = 'i0023325';
DELETE 1
CS421=> SELECT * FROM OutPatientTreatment;
 patient_id |  ill_id  | treated_by_staff_id | ill_until
------------+----------+---------------------+------------
     690001 | i0023358 |               34002 | 2013-02-04
     691123 | i0023325 |               34001 | 2014-06-01





-- 2)
-- This function logs high priority patients and recommends doctors to be assigned to each patient
-- It first creates table HighPriorityPatient if it’s not already been created
-- It takes an argument type::VARCHAR(9) that may either be some version of ‘urgency’ or ‘infectious’
-- If urgency is chosen, patients of a high urgency will be considered to be high priority
-- If infectious is chosen, patients with infectious diseases will be considered to be high priority
-- It then polls a cursor created depending on the switches, and inserts the correct patients 
-- It returns an integer of the number of inserted patients

CREATE OR REPLACE FUNCTION log_high_priority_patients(type VARCHAR(9)) RETURNS INTEGER AS $log_high_priority_patients$
DECLARE
-- These are all the variables we need, with patient_id, ill_id, ill_since, urgency renamed
    cur refcursor;
    pat_id INTEGER;
    il_id CHAR(8);
    il_since DATE;
    urge VARCHAR(32);
    count INTEGER := 0;
BEGIN
-- Try to create the new relation, if it exists then move on.
    BEGIN
        CREATE TABLE HighPriorityPatient(
            patient_id INTEGER,
            ill_id char(8),
            ill_since DATE,
            recommended_staff_id INTEGER,
            urgency VARCHAR(32),
            contagious BOOLEAN,
            FOREIGN KEY (patient_id)
                REFERENCES Patient(patient_id) ON DELETE CASCADE,
            FOREIGN KEY (ill_id)
                REFERENCES Illness(ill_id),
            FOREIGN KEY (recommended_staff_id)
                REFERENCES Staff(staff_id),
            PRIMARY KEY (patient_id, ill_id, ill_since)
        );
    EXCEPTION WHEN duplicate_table THEN
    END;
    
    -- Case switches for the choice of high prioritisation based on urgency or infectiousness 
    CASE
        WHEN type like '%urgency%' OR type like '%Urgency%' THEN
            OPEN cur FOR SELECT SufferingFrom.patient_id, SufferingFrom.ill_id, SufferingFrom.ill_since, SufferingFrom.urgency FROM SufferingFrom WHERE (urgency LIKE '%Urgent%' OR urgency like '%urgent%');
        WHEN type like '%infectious%' OR type like '%Infectious%' OR type like '%contagious%' OR type like '%Contagious%' THEN
            OPEN cur FOR SELECT patient_id, Illness.ill_id, ill_since, urgency FROM Illness INNER JOIN SufferingFrom ON Illness.ill_id = SufferingFrom.ill_id WHERE contagious = TRUE;
        ELSE
            RAISE EXCEPTION 'Inapplicable high priority type.';
    END CASE;

    -- Look through the cursor 
    LOOP
        FETCH cur INTO pat_id, il_id, il_since, urge;

        IF NOT FOUND THEN
            EXIT;
        END IF;

        -- Insert the new tuple, but ignore it if it already exists w.r.t. its primary key
        BEGIN
            INSERT INTO HighPriorityPatient
            SELECT pat_id, il_id, il_since, NULL, urge, Illness.contagious
            FROM Illness
            WHERE Illness.ill_id = il_id;

            -- attempt to find a suitable doctor
            UPDATE HighPriorityPatient
            SET recommended_staff_id = SpecializesIn.staff_id
            FROM SpecializesIn
            WHERE SpecializesIn.ill_id = il_id
            AND HighPriorityPatient.patient_id = pat_id
            AND HighPriorityPatient.ill_id = il_id
            AND HighPriorityPatient.ill_since = il_since;

            count = count + 1;
        
        EXCEPTION WHEN unique_violation THEN 
        END;
        
    END LOOP;

    RETURN count;
END;
$log_high_priority_patients$ LANGUAGE 'plpgsql';




CREATE OR REPLACE FUNCTION check_specialists() RETURNS TRIGGER AS $check_specialists$
    print TD["new"]
$check_specialists$ LANGUAGE plperl;


CREATE TRIGGER checkSpecialists 
BEFORE INSERT ON Staff
FOR EACH ROW EXECUTE PROCEDURE check_specialists();







-----==========================
CREATE OR REPLACE FUNCTION log_high_priority_patients(type VARCHAR(9)) RETURNS INTEGER AS $log_high_priority_patients$
DECLARE
-- These are all the variables we need, with patient_id, ill_id, ill_since, urgency renamed
    cur refcursor;
    pat_id INTEGER;
    il_id CHAR(8);
    il_since DATE;
    urge VARCHAR(32);
    count INTEGER := 0;
BEGIN
-- Try to create the new relation, if it exists then move on.
    BEGIN
        CREATE TABLE HighPriorityPatient(
            patient_id INTEGER,
            ill_id char(8),
            ill_since DATE,
            recommended_staff_id INTEGER,
            urgency VARCHAR(32),
            contagious BOOLEAN,
            FOREIGN KEY (patient_id)
                REFERENCES Patient(patient_id) ON DELETE CASCADE,
            FOREIGN KEY (ill_id)
                REFERENCES Illness(ill_id),
            FOREIGN KEY (recommended_staff_id)
                REFERENCES Staff(staff_id),
            PRIMARY KEY (patient_id, ill_id, ill_since)
        );
    EXCEPTION WHEN duplicate_table THEN
    END;
    
    -- Case switches for the choice of high prioritisation based on urgency or infectiousness 
    CASE
        WHEN type like '%urgency%' OR type like '%Urgency%' THEN
            OPEN cur FOR SELECT SufferingFrom.patient_id, SufferingFrom.ill_id, SufferingFrom.ill_since, SufferingFrom.urgency FROM SufferingFrom WHERE (urgency LIKE '%Urgent%' OR urgency like '%urgent%' AND ill_until IS NULL);
        WHEN type like '%infectious%' OR type like '%Infectious%' OR type like '%contagious%' OR type like '%Contagious%' THEN
            OPEN cur FOR SELECT patient_id, Illness.ill_id, ill_since, urgency FROM Illness INNER JOIN SufferingFrom ON Illness.ill_id = SufferingFrom.ill_id WHERE contagious = TRUE AND ill_until IS NULL;
        ELSE
            RAISE EXCEPTION 'Inapplicable high priority type.';
    END CASE;

    -- Look through the cursor 
    LOOP
        FETCH cur INTO pat_id, il_id, il_since, urge;

        IF NOT FOUND THEN
            EXIT;
        END IF;

        -- Insert the new tuple, but ignore it if it already exists w.r.t. its primary key
        BEGIN
            INSERT INTO HighPriorityPatient
            SELECT pat_id, il_id, il_since, NULL, urge, Illness.contagious
            FROM Illness
            WHERE Illness.ill_id = il_id;

            -- attempt to find a suitable doctor
            UPDATE HighPriorityPatient
            SET recommended_staff_id = SpecializesIn.staff_id
            FROM SpecializesIn
            WHERE SpecializesIn.ill_id = il_id
            AND HighPriorityPatient.patient_id = pat_id
            AND HighPriorityPatient.ill_id = il_id
            AND HighPriorityPatient.ill_since = il_since;

            count = count + 1;
        
        EXCEPTION WHEN unique_violation THEN 
        END;
        
    END LOOP;

    RETURN count;
END;
$log_high_priority_patients$ LANGUAGE 'plpgsql';







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

CREATE INDEX sinceInd on SufferingFrom(ill_since);
CREATE INDEX treatInd on SufferingFrom(treatment_cost);
CREATE INDEX insInd on SufferingFrom(insurance_coverage);
-- These indices are useful as cost and amount_needed as they require equality and
-- range searches, and should shorten the time required for the queries.


SELECT S.staff_id, first_name, last_name
FROM Staff S INNER JOIN Doctor D
ON S.staff_id = D.staff_id
    FULL OUTER JOIN Nurse N
    ON S.staff_id = N.staff_id
WHERE (
        shift_from <= '03:00:00' -- Shift ends between midnight and 3am
        OR shift_to <='03:00:00' -- Shift begins between midnight and 3am
        OR (shift_to > '03:00:00' AND shift_from > shift_to)  -- Shift begins before midnight and ends after 3am
    );

CREATE INDEX fromInd ON Staff(shift_from);
CREATE INDEX toInd ON Staff(shift_to);
-- These indices are useful as cost and amount_needed as they require 
-- range searches, and should shorten the time required for the queries.
DROP INDEX fromInd;
DROP INDEX toInd;