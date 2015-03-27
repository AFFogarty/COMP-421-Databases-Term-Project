import helpers.Ascii;
import procedures.*;
import util.CommandPrompt;
import util.Database;

import java.io.IOException;
import java.sql.SQLException;


public class Main {

    public static void main(String[] args) {
        // Set up the program
        Database db = setUp();

        // Menu options
        int menuSelection;
        String[] test = {
                "Add staff to database",
                "Order equipment for doctors",
                "View staff in department",
                "Register or update patient",
                "Assign illness to patient",
                "Assign specialist to treat patient",
                "View patients with illnesses",
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
                        // Run the InsertSTaffProcedure
                        InsertStaffProcedure.execute(db);
                    } catch (IOException e) {
                        e.printStackTrace();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    System.out.println("\nStaff insertion procedure complete.  Returning to main menu...");
                    System.out.println(Ascii.singleSeparator);
                    break;
                case 2:
                    try {
                        StockDoctorEquipmentProcedure.execute(db);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    System.out.println("\nEquipment order procedure complete.  Returning to main menu...");
                    System.out.println(Ascii.singleSeparator);
                    break;
                case 3:
                    try {
                        ViewDepartmentStaffProcedure.execute(db);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    System.out.println("\nStaff view procedure complete.  Returning to main menu...");
                    System.out.println(Ascii.singleSeparator);
                    break;
                case 4:
                    try {
                        InsertPatientProcedure.execute(db);
                    } catch (IOException e) {
                        e.printStackTrace();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    System.out.println("\nRegister patient procedure complete.  Returning to main menu...");
                    System.out.println(Ascii.singleSeparator);
                    break;
                case 5:
                    try {
                        AssignIllnessProcedure.execute(db);
                    } catch (IOException e) {
                        e.printStackTrace();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    System.out.println("\nAssign illness procedure complete.  Returning to main menu...");
                    System.out.println(Ascii.singleSeparator);
                    break;
                case 6:
                    try {
                        AssignSpecialistProcedure.execute(db);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    System.out.println("\nAssign specialist procedure complete.  Returning to main menu...");
                    System.out.println(Ascii.singleSeparator);
                    break;
                case 7:
                    try {
                        ViewPatientsWithIllnessProcedure.execute(db);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    System.out.println("\nView patient procedure complete.  Returning to main menu...");
                    System.out.println(Ascii.singleSeparator);
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
