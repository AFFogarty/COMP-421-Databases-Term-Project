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
        db.printResultSet(staffSet);
    }
}
