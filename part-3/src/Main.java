import art.Ascii;
import util.CommandPrompt;
import java.io.IOException;
import java.sql.SQLException;


public class Main {

    public static void main(String[] args) {
        // Set up the program
        Database db = setUp();

        // Menu options
        int menuSelection;
        String[] test = {"First", "Second", "Third", "Fourth", "Fifth", "Quit"};
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
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // If this happens, then something has gone wrong.
        return null;
    }

    public static void firstQuery(Database db) {
        // TODO
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
