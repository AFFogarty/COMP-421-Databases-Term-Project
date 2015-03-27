package procedures;

import util.CommandPrompt;
import util.Database;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;


public class ViewDepartmentStaffProcedure {

    public static void execute(Database db) throws SQLException, IOException {
        String[] departmentNames = InsertStaffProcedure.getDepartmentNames(db);
        String dept_name = CommandPrompt.getSelectionFromStringArray("department", departmentNames);

        // Get the set of staff in the department
        ResultSet staffSet = db.executeQuery("SELECT * FROM Staff WHERE dept_name = '" + dept_name + "'");

        // Print the results

        // Handle no case
        if (!staffSet.next()) {
            System.out.println("\nNo staff in " + dept_name + " department.\n");
            staffSet.close();
            return;
        }

        System.out.println("\nStaff in " + dept_name + " department:");

        // Print the patient data
        do {
            System.out.println(".......................................................");
            System.out.println("staff_id:        " + staffSet.getInt("staff_id"));
            System.out.println("first_name:      " + staffSet.getString("first_name"));
            System.out.println("last_name:       " + staffSet.getString("last_name"));
            System.out.println("wages:           " + staffSet.getString("wages"));
            System.out.println("salary:          " + staffSet.getString("salary"));
            System.out.println("shift_from:      " + staffSet.getString("shift_from"));
            System.out.println("shift_to:        " + staffSet.getString("shift_to"));
            System.out.println("over_time:       " + staffSet.getString("over_time"));
            System.out.println("contract_from:   " + staffSet.getString("contract_from"));
            System.out.println("contract_until:  " + staffSet.getString("contract_until"));
            System.out.println("contact:         " + staffSet.getString("contact"));
        } while(staffSet.next());
    }
}
