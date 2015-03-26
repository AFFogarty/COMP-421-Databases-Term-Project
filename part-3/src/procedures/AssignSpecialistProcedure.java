package procedures;


import util.CommandPrompt;
import util.Database;

import javax.xml.transform.Result;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AssignSpecialistProcedure {

    public static void execute(Database db) throws SQLException, IOException {
        System.out.println("Querying for patients with illnesses...");
        ResultSet patients = db.executeQuery("SELECT P.patient_id, P.first_name, P.last_name, I.ill_name, I.ill_id FROM Patient P, Illness I, SufferingFrom S WHERE\n" +
                "S.patient_id = P.patient_id\n" +
                "AND S.ill_id = I.ill_id;");

        // Gather the patient and illness data
        ArrayList<Integer> patientIds = new ArrayList<Integer>();
        ArrayList<String> patientFirstnames = new ArrayList<String>();
        ArrayList<String> patientLastNames = new ArrayList<String>();
        ArrayList<String> illnessNames = new ArrayList<String>();
        ArrayList<String> illnessIds = new ArrayList<String>();

        // Load the data into the array lists
        while (patients.next()) {
            patientIds.add(patients.getInt("patient_id"));
            patientFirstnames.add(patients.getString("first_name"));
            patientLastNames.add(patients.getString("last_name"));
            illnessNames.add(patients.getString("ill_name"));
            illnessIds.add(patients.getString("ill_id"));
        }

        // Close the query
        patients.close();

        // Build a selection list
        String[] patientSelectionMenu = new String[patientIds.size()];
        for (int i = 0; i < patientSelectionMenu.length; i++) {
            patientSelectionMenu[i] = patientLastNames.get(i) + ", " + patientFirstnames.get(i) +  " who suffers from " + illnessNames.get(i);
        }

        // Get the user's selection
        int patientListIndex = CommandPrompt.getMenuSelection(patientSelectionMenu) - 1;

        // From the selection, chose the variables
        int patient_id = patientIds.get(patientListIndex);
        String first_name = patientFirstnames.get(patientListIndex);
        String last_name = patientLastNames.get(patientListIndex);
        String ill_name = illnessNames.get(patientListIndex);
        String ill_id = illnessIds.get(patientListIndex);

        // Now, we must select the doctor to treat the patient
        System.out.println("\n\nPatient selected.  Now, select a doctor who specializes in the chosen illness.\n\nDoctors who already treat the patient are excluded.\n\n");

        String getDoctorsQuery = "SELECT S.staff_id,  S.first_name, S.last_name FROM Doctor D, Staff S, SpecializesIn SI WHERE\n" +
                "D.staff_id = S.staff_id\n" +
                "AND SI.staff_id = D.staff_id\n" +
                "AND SI.ill_id = '" + ill_id + "'" +
                "AND (SELECT COUNT(staff_id) FROM Treats WHERE staff_id = S.staff_id AND patient_id = " + patient_id + ") = 0";
        ResultSet doctors = db.executeQuery(getDoctorsQuery);

        ArrayList<Integer> doctorIds = new ArrayList<Integer>();
        ArrayList<String> doctorFirstNames = new ArrayList<String>();
        ArrayList<String> doctorLastNames = new ArrayList<String>();

        if (!doctors.next()) {
            System.out.println("It appears there are no more available doctors who specialize in " + ill_name + ".");
            doctors.close();
            return;
        }

        // Save the doctor data
        do {
            doctorIds.add(doctors.getInt("staff_id"));
            doctorFirstNames.add(doctors.getString("first_name"));
            doctorLastNames.add(doctors.getString("last_name"));
        } while (doctors.next());

        // Build the list of doctor selections
        String[] doctorMenu = new String[doctorIds.size()];
        for (int i = 0; i < doctorMenu.length; i++) {
            doctorMenu[i] = "Dr. " + doctorFirstNames.get(i) + " " + doctorLastNames.get(i);
        }

        // Select the doctor
        int doctorMenuIndex = CommandPrompt.getMenuSelection(doctorMenu) - 1;
        // Get the doctor params
        int staff_id = doctorIds.get(doctorMenuIndex);
        String doctor_first_name = doctorFirstNames.get(doctorMenuIndex);
        String doctor_last_name = doctorLastNames.get(doctorMenuIndex);

        // Build the query
        String treatsQuery = "INSERT INTO Treats VALUES (" + staff_id + ", " + patient_id + ", current_date, null)";
        System.out.println(treatsQuery);
        // Run it
        db.executeInsertUpdateDestroy(treatsQuery);

        System.out.println("\n\nDr. " + doctor_last_name + " now treats patient " + last_name + ", " + first_name + " for " + ill_name + ".\n\n");
    }
}
