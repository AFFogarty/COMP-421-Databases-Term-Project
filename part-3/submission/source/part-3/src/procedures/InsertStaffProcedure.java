package procedures;

import helpers.QueryProcessing;
import util.CommandPrompt;
import util.Database;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;


public class InsertStaffProcedure {

    /**
     * Add a Staff to the util.Database
     *
     * @param db
     */
    public static void execute(Database db) throws IOException, SQLException {
        System.out.println("Creating Staff record...");

        String first_name = CommandPrompt.getString("first name");
        String last_name = CommandPrompt.getString("last name");

        // Query the DB for the list of depts, then grab from the list
        String[] departmentNames = getDepartmentNames(db);
        String dept_name = CommandPrompt.getSelectionFromStringArray("department", departmentNames);

        String wages = CommandPrompt.getMoneyString("wages");
        String salary = CommandPrompt.getMoneyString("salary");
        String shift_to = CommandPrompt.getTimeString("shift to time");
        String shift_from = CommandPrompt.getTimeString("shift from time");
        String over_time = CommandPrompt.getNumberString("number of overtime hours");
        String contract_from = CommandPrompt.getDateString("contract from");
        String contract_until = CommandPrompt.getDateString("contract until");
        String contact = CommandPrompt.getString("contact information");

        // Auto create a staff id.
        ResultSet staffIdResultSet = db.executeQuery("SELECT MAX(staff_id) FROM Staff");
        // Advance to the first
        staffIdResultSet.next();
        int staff_id = staffIdResultSet.getInt("max") + 1;

        // Build the staff query from all the values
        String insertStaffQuery = "INSERT INTO Staff VALUES ("+ staff_id + ", '" + dept_name + "', '" + wages + "', '" + salary + "', '" + shift_to + "', '" + shift_from + "', '" + over_time + "', '" + contract_from + "', '" + contract_until + "', '" + contact + "', '" + first_name + "', '" + last_name  +"');";

        // Execute the query
        db.executeInsertUpdateDestroy(insertStaffQuery);

        System.out.println("SUCCESS: Staff " + last_name + ", " + first_name + " created with id: " + staff_id + " created.\n\n");

        System.out.println("Does " + first_name + " " + last_name + " have a special job?\n");
        String[] jobs = {"Doctor", "Nurse", "Admin", "No"};
        int jobSelection = CommandPrompt.getMenuSelection(jobs);

        switch(jobSelection) {
            case 1:
                // Handle doctor case
                System.out.println("Doctor selected.");
                String rank = CommandPrompt.getString("rank");
                String board_certification = CommandPrompt.getString("board certification");
                // Query the db to save the doctor
                String insertDoctorQuery = "INSERT INTO Doctor VALUES ('" + staff_id + "', '" + rank + "', '" + board_certification + "')";
                db.executeInsertUpdateDestroy(insertDoctorQuery);
                System.out.println(first_name + " " + last_name + " is now a doctor.");
                break;
            case 2:
                // Handle nurse case
                System.out.println("Nurse selected.");
                String certified_skills = CommandPrompt.getString("certified skills");
                // Query the db to save the doctor
                String insertNurseQuery = "INSERT INTO Nurse VALUES ('" + staff_id + "', '" + certified_skills + "')";
                db.executeInsertUpdateDestroy(insertNurseQuery);
                System.out.println(first_name + " " + last_name + " is now a nurse.");
                break;
            case 3:
                // Handle admin case
                System.out.println("Admin selected.");
                String admin_responsibilities = CommandPrompt.getString("admin responsibilities");
                // Query the db to save the doctor
                String insertAdminQuery = "INSERT INTO Admin VALUES ('" + staff_id + "', '" + admin_responsibilities + "')";
                db.executeInsertUpdateDestroy(insertAdminQuery);
                System.out.println(first_name + " " + last_name + " is now an admin.");
                break;
            default:
                System.out.println("No special job selected.");
                break;
        }
    }

    /**
     * Get the list of the names of departments.
     *
     * @param db the database
     * @return
     * @throws SQLException
     */
    public static String[] getDepartmentNames(Database db) throws SQLException {
        ResultSet departmentResults = db.executeQuery("SELECT dept_name FROM Department");
        String[] departmentNames = QueryProcessing.getResultSetColumnArray(departmentResults, "dept_name");
        departmentResults.close();
        return departmentNames;
    }
}
