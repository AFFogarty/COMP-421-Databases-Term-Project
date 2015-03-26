import helpers.Ascii;
import helpers.QueryProcessing;
import util.CommandPrompt;
import util.Database;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class Main {

    public static void main(String[] args) {
        // Set up the program
        Database db = setUp();

        // Menu options
        int menuSelection;
        String[] test = {
                "Add staff to database",
                "Order equipment for doctors",
                "Third",
                "Fourth",
                "Fifth",
                "Quit"
        };
        boolean running = true;
        while (running) {
            menuSelection = -1;
            try {
                menuSelection = CommandPrompt.getMenuSelection(test);
            } catch (IOException e) {
                e.printStackTrace();
            }

            switch (menuSelection) {
                case 1:
                    try {
                        insertStaffProcedure(db);
                    } catch (IOException e) {
                        e.printStackTrace();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    System.out.println("\n Staff insertion procedure complete.  Returning to main menu...");
                    System.out.println(Ascii.singleSeparator);
                    break;
                case 2:
                    try {
                        stockDoctorEquipmentProcedure(db);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    System.out.println("\n Equipment order procedure complete.  Returning to main menu...");
                    System.out.println(Ascii.singleSeparator);
                    break;
                case 3:
                    break;
                case 4:
                    break;
                case 5:
                    break;
                default:
                    // End the program loop
                    running = false;
                    break;
            }
        }

        // Quit the program
        quit(db);
    }

    /**
     * Start up the program.
     *
     * @return the database that we will work with.
     */
    public static Database setUp() {
        // Print the welcome message
        System.out.println(Ascii.doubleSeparator);
        System.out.println(Ascii.programName);
        System.out.println(Ascii.singleSeparator + "\n");
        System.out.println(Ascii.copyRight + "\n");
        System.out.println(Ascii.doubleSeparator + "\n");

        try {
            return new Database();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.exit(-1);
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(-1);
        } catch (SQLException e) {
            e.printStackTrace();
            System.exit(-1);
        }
        // If this happens, then something has gone wrong.
        return null;
    }

    /**
     * Add a Staff to the util.Database
     *
     * @param db
     */
    public static void insertStaffProcedure(Database db) throws IOException, SQLException {
        System.out.println("Creating Staff record...");

        String first_name = CommandPrompt.getString("first name");
        String last_name = CommandPrompt.getString("last name");

        // Query the DB for the list of depts, then grab from the list
        ResultSet departmentResults = db.executeQuery("SELECT dept_name FROM Department");
        String[] departmentNames = QueryProcessing.getResultSetColumnArray(departmentResults, "dept_name");
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
        System.out.println(insertStaffQuery);
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

    public static void stockDoctorEquipmentProcedure(Database db) throws SQLException, IOException {
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

    public static void thirdQuery(Database db) {
        // TODO
    }

    public static void fourthQuery(Database db) {
        // TODO
    }

    public static void fifthQuery(Database db) {
        // TODO
    }

    /**
     * Disconnect the DB and print a goodbye message.
     * @param db
     */
    public static void quit(Database db) {
        // Disconnect the db
        try {
            db.disconnect();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("Terminating program.\n\n");
        System.out.println(Ascii.goodBye);
    }

}
