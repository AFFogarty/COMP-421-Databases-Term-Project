package procedures;

import util.CommandPrompt;
import util.Database;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class ViewPatientsWithIllnessProcedure {

    /**
     * Select an illness and view which patients have that illness.
     *
     * @param db
     * @throws SQLException
     * @throws IOException
     */
    public static void execute(Database db) throws SQLException, IOException {
        // Select the illness
        // Get the equipment types
        ResultSet illnesses = db.executeQuery("SELECT * FROM Illness");
        ArrayList<String> illnessNames = new ArrayList<String>();
        ArrayList<String> illnessIds = new ArrayList<String>();
        // Read in the equipment names and ids
        while (illnesses.next()) {
            illnessNames.add(illnesses.getString("ill_name"));
            illnessIds.add(illnesses.getString("ill_id"));
        }
        // Get the array index of the desired equipment
        int illnessIndex = CommandPrompt.getMenuSelection(illnessNames.toArray(new String[illnessNames.size()])) - 1;
        // Get the desired eqpt_id
        String ill_id = illnessIds.get(illnessIndex);
        String ill_name = illnessNames.get(illnessIndex);
        // Close the illnesses query
        illnesses.close();

        // Get the patients
        ResultSet patientResultSet = db.executeQuery("SELECT P.patient_id, P.first_name, P.last_name, P.date_of_birth, P.care_cost FROM Patient P, SufferingFrom S WHERE S.patient_id = P.patient_id AND S.ill_id='" + ill_id + "';");

        // Handle no case
        if (!patientResultSet.next()) {
            System.out.println("\nNo patients suffer from " + ill_name + ".\n");
            patientResultSet.close();
            return;
        }

        System.out.println("\nPatients suffering from " + ill_name + ":\n");

        // Print the patient data
        do {
            System.out.println(".......................................................");
            System.out.println("patient_id:    " + patientResultSet.getInt("patient_id"));
            System.out.println("first_name:    " + patientResultSet.getString("first_name"));
            System.out.println("last_name:     " + patientResultSet.getString("last_name"));
            System.out.println("date_of_birth: " + patientResultSet.getString("date_of_birth"));
            System.out.println("care_cost:     " + patientResultSet.getString("care_cost"));
        } while(patientResultSet.next());

        // Close the results
        patientResultSet.close();
    }
}
