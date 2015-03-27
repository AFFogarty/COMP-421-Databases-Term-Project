package procedures;

import util.CommandPrompt;
import util.Database;
import helpers.RegEx;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;


public class InsertPatientProcedure {
    public static void execute(Database db) throws IOException, SQLException {
        System.out.println("Creating Patient record...");
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

        // Check if the patient already exists
        ResultSet existing = getPatient(first_name, last_name, db);
        if(existing.next()){
            System.out.println("A patient with that first and last name already exists. Aborting.");
            return;
        } else {
            System.out.println("Patient " + last_name + ", " + first_name + " does not exist in the database.  Creating new record...");
            // The patient doesn't exist, so we will create them.
            String date_of_birth = CommandPrompt.getDateString("date of birth");
            String care_cost = CommandPrompt.getNumberString("initial care cost");
            // Construct the query that generates its own id
            String insert_query = "INSERT INTO Patient VALUES((SELECT MAX(patient_id) + 1 FROM Patient), '"
                    + first_name + "', '" + last_name + "', '" + date_of_birth + "', '" + care_cost + "')";
            // Run the insert query
            db.executeInsertUpdateDestroy(insert_query);

            // It worked, so get the id number
            ResultSet successfulPatientSet = db.executeQuery("SELECT patient_id FROM Patient WHERE first_name='"
                    + first_name + "' AND last_name='" + last_name + "' AND date_of_birth='" + date_of_birth + "'");
            successfulPatientSet.next();
            int patient_id = successfulPatientSet.getInt("patient_id");
            System.out.println("Patient " + last_name + ", " + first_name + " record created with id: " + patient_id + ".");
        }
    }

    public static ResultSet getPatient(String first_name, String last_name, Database db) throws SQLException {
        return db.executeQuery("SELECT * FROM Patient WHERE first_name like '"
                + first_name + "' AND last_name like '" + last_name + "'");
    }
}
