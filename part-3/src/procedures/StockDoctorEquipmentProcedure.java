package procedures;

import helpers.QueryProcessing;
import util.CommandPrompt;
import util.Database;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class StockDoctorEquipmentProcedure {

    /**
     * Select a department, an equipment, and the number to order for each doctor in the department.
     * Update the database to meet that number.
     *
     * @param db
     * @throws SQLException
     * @throws IOException
     */
    public static void execute(Database db) throws SQLException, IOException {
        // Get departments from db
        ResultSet departments = db.executeQuery("SELECT dept_name FROM department");
        String[] departmentNames = QueryProcessing.getResultSetColumnArray(departments, "dept_name");
        // Ask the user what department they want
        String dept_name = CommandPrompt.getSelectionFromStringArray("department", departmentNames);

        // Get the equipment types
        ResultSet equipment = db.executeQuery("SELECT * FROM equipment");
        ArrayList<String> equipmentNames = new ArrayList<String>();
        ArrayList<Integer> equipmentIds = new ArrayList<Integer>();
        // Read in the equipment names and ids
        while (equipment.next()) {
            equipmentNames.add(equipment.getString("eqpt_name"));
            equipmentIds.add(equipment.getInt("eqpt_id"));
        }
        // Get the array index of the desired equipment
        int equipmentIndex = CommandPrompt.getMenuSelection(equipmentNames.toArray(new String[equipmentNames.size()])) - 1;
        // Get the desired eqpt_id
        int eqpt_id = equipmentIds.get(equipmentIndex);
        String eqpt_name = equipmentNames.get(equipmentIndex);

        // How many per doctor?
        int numberPerDoctor = CommandPrompt.getNaturalNumber("number of equipment per doctor");

        // Find out how many doctors in the department
        ResultSet doctorCountSet = db.executeQuery("SELECT count(D.staff_id) FROM Doctor D, Staff S WHERE D.staff_id = S.staff_id AND S.dept_name = '" + dept_name + "'");
        doctorCountSet.next();
        int numberOfDoctors = doctorCountSet.getInt("count");
        int numberToBuy = numberPerDoctor * numberOfDoctors;

        System.out.println(numberOfDoctors + " doctors in " + dept_name + ".  Need " + numberToBuy + " instances of " + eqpt_name + ".");

        // If don't need any, then return
        if (numberToBuy == 0) {
            System.out.println("Don't need to buy any, so terminating procedure.");
            return;
        } else {

        }

        // Check if order already exists.  If it exists, update it.  If it doesn't, then create a new one.
        ResultSet existingEqupmentStock = db.executeQuery("SELECT * FROM DeptHasEqpt WHERE dept_name = '" + dept_name + "' AND eqpt_id = " + eqpt_id);
        if (existingEqupmentStock.next()) {
            // It exists, so we will update if necessary
            int currentStock = existingEqupmentStock.getInt("current_stock");
            String updateQuery;
            if (currentStock >= numberToBuy) {
                numberToBuy = currentStock;
                System.out.println(dept_name + " already has " + currentStock + " in stock, so we will only update number needed.");
                // Create the update query
                updateQuery = "UPDATE DeptHasEqpt SET amount_needed=" + numberToBuy + " WHERE dept_name = '" + dept_name + "' AND eqpt_id = " + eqpt_id;
            } else {
                System.out.println(dept_name + " only has " + currentStock + " of " + eqpt_name + "in stock, so we will increase stock to " + numberToBuy + ".");
                updateQuery = "UPDATE DeptHasEqpt SET amount_needed=" + numberToBuy + ", current_stock=" + numberToBuy + " WHERE dept_name = '" + dept_name + "' AND eqpt_id = " + eqpt_id;
            }
            System.out.println(updateQuery);
            db.executeInsertUpdateDestroy(updateQuery);

        } else {
            // It doesn't exist, so insert
            System.out.println(dept_name + " does not have any " + eqpt_name + " so we will order " + numberToBuy + ".");
            String insertQuery = "INSERT INTO DeptHasEqpt VALUES ('" + dept_name + "', " + eqpt_id + ", " + numberToBuy + ", " + numberToBuy + ")";
            System.out.println(insertQuery);
            db.executeInsertUpdateDestroy(insertQuery);
        }
    }
}
