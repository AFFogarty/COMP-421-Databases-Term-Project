package procedures;


import helpers.RegEx;
import util.CommandPrompt;
import util.Database;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AssignIllnessProcedure {
    public static void execute(Database db) throws IOException, SQLException {
        // Grab the patient name
        boolean validated = false;
        String first_name;
        String last_name;
        do {
            first_name = CommandPrompt.getString("first name");
            last_name = CommandPrompt.getString("last name");
            if(RegEx.matchesFirstName(first_name) && RegEx.matchesLastName(last_name)){
                validated = true;
            }
            else{
                System.out.println("The name you entered doesn't seem to be valid. Did you capitalise the name properly?");
            }
        } while(!validated);

        // Get the patient id from the first and last names
        ResultSet patientResultSet = InsertPatientProcedure.getPatient(first_name, last_name, db);

        // If the patient doesn't exist, then return
        if (!patientResultSet.next()) {
            System.out.println("Patient " + last_name + ", " + first_name + " does not exist in database.  Terminating procedure.");
            patientResultSet.close();
            return;
        }

        // The patient exists, so get their id
        int patient_id = patientResultSet.getInt("patient_id");
        patientResultSet.close();

        // Select the illness
        // Get the equipment types
        ResultSet illnesses = db.executeQuery("SELECT * FROM Illness");
        ArrayList<String> illnessNames = new ArrayList<String>();
        ArrayList<String> illnessIds = new ArrayList<String>();
        ArrayList<String> illnessAvgCosts = new ArrayList<String>();
        // Read in the equipment names and ids
        while (illnesses.next()) {
            illnessNames.add(illnesses.getString("ill_name"));
            illnessIds.add(illnesses.getString("ill_id"));
            illnessAvgCosts.add(illnesses.getString("average_treatment_cost"));
        }
        // Get the array index of the desired equipment
        int equipmentIndex = CommandPrompt.getMenuSelection(illnessNames.toArray(new String[illnessNames.size()])) - 1;
        // Get the desired eqpt_id
        String ill_id = illnessIds.get(equipmentIndex);
        String ill_name = illnessNames.get(equipmentIndex);
        String average_treatment_cost = illnessAvgCosts.get(equipmentIndex);
        illnesses.close();

        // See if record already exists
        ResultSet existingSuffering = db.executeQuery("SELECT * FROM SufferingFrom WHERE patient_id=" + patient_id + " AND ill_id='" + ill_id + "'");
        if (existingSuffering.next()) {
            // The record already exists, so quit
            System.out.println("Record already exists of " + last_name + ", " + first_name + " suffering from " + ill_name + ".");
            existingSuffering.close();
            return;
        }

        // Prompt more info
        String ill_since = CommandPrompt.getDateString("the date when the illness began");
        String ill_until = null;
        String urgency = CommandPrompt.getString("urgency");

        // Find out about treatment
        String insurance_coverage = CommandPrompt.getMoneyString("insurance coverage");
        String treatment_cost = CommandPrompt.getMoneyString("treatment cost (average $" + average_treatment_cost + " for " + ill_name + ")");

        // Build the query
        String insertQuery = "INSERT INTO SufferingFrom VALUES (" + patient_id + ", '" + ill_id + "', '" + ill_since + "', "
                + ill_until + ", '" + insurance_coverage + "', '" + treatment_cost + "', '" + urgency + "') ";
        System.out.println(insertQuery);
        db.executeInsertUpdateDestroy(insertQuery);

        System.out.println("Record created that " + last_name + ", " + first_name + " suffers from " + ill_name + ".");
    }
}
