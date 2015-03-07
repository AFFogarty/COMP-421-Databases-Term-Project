Entities:
    Illness(ill_name, contagious, average_treatment_cost)
    Equipment(eqpt_name, cost, consumable)
    Department(dept_name, address, budget, other_costs)
    Staff(staff_id, shift_to, shift_from, contact, first_name, last_name)
    Doctor(staff_id, rank, board_certification)
    Nurse(staff_id, certified_skills)
    Admin(staff_id, admin_responsibilities)

Relations:
    Has(dept_name, eqpt_name, amount_needed, current_stock)
    InChargeOf(patient_id, dept_name, since)
    SpecializesIn(staff_id, ill_name )
    SufferingFrom(patient_id, ill_name, ill_since, ill_until, insurance_coverage, treatment_cost, urgency)
    Treats(staff_id, patient_id, since)
    WorksFor(staff_id, dept_name, wages, over_time, contract_until, salary, contract_from)