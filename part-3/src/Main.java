import helpers.Ascii;
import helpers.RegEx;
import util.CommandPrompt;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;


public class Main {

    public static void main(String[] args) {
        // Set up the program
        Database db = setUp();

        // Menu options
        int menuSelection;
        String[] test = {"Add staff to database", "Second", "Third", "Fourth", "Fifth", "Quit"};
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
                        firstQuery(db);
                    } catch (IOException e) {
                        e.printStackTrace();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    break;
                case 2:
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
     * Add a Staff to the Database
     *
     * @param db
     */
    public static void firstQuery(Database db) throws IOException, SQLException {
        System.out.println("Creating Staff record...");
        // TODO: Auto create a staff id.
        int staff_id = 0;
        String first_name = CommandPrompt.getString("first name");
        String last_name = CommandPrompt.getString("last name");

        // TODO: Query the DB for the list of depts, then grab from the list
        ResultSet departmentResults = db.executeQuery("SELECT dept_name FROM Department");
        String[] deptNames = {"dept1", "dept2", "dept3", "dept4"};
        String dept_name = CommandPrompt.getSelectionFromStringArray("department", deptNames);

        String wages = CommandPrompt.getMoneyString("wages");
        String salary = CommandPrompt.getMoneyString("salary");
        String shift_to = CommandPrompt.getTimeString("shift to time");
        String shift_from = CommandPrompt.getTimeString("shift from time");
        String over_time = "0.0";
        String contract_from = CommandPrompt.getDateString("contract from");
        String contract_until = CommandPrompt.getDateString("contract until");
        String contact = CommandPrompt.getString("contact information");

        // Build the staff query from all the values
        String insertStaffQuery = "INSERT INTO Staff VALUES ("+ staff_id + ", " + dept_name + ", " + wages + ", " + salary + ", " + shift_to + ", " + shift_from + ", " + over_time + ", " + contract_from + ", " + contract_until + ", " + contact + ", " + first_name + ", " + last_name  +");";
        // TODO: Execute the query

        System.out.println("Record created!");
    }

    public static void secondQuery(Database db) {
        // TODO
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
