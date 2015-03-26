package procedures;

import helpers.QueryProcessing;
import util.CommandPrompt;
import util.Database;
import helpers.RegEx;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;


public class InsertPatientProcedure {
    public static void execute(Database db) throws IOException, SQLException {
        System.out.println("Creating Patient record...");
        boolean validated = false;
        String first_name;
        String last_name;
        do {
            first_name = CommandPrompt.getString("first name");
            last_name = CommandPrompt.getString("last name");
            if(RegEx.matchesFirstName(first_name) && RegEx.matchesLastName(last_name)){
                validated = true;
            }
            else{
                System.out.println("The name you entered doesn't seem to be valid. Did you capitalise the name properly?");
            }
        } while(!validated);

        ResultSet existing = db.executeQuery("SELECT * FROM Patient WHERE first_name like " + first_name + "last_name like " + last_name);
        if(existing.next()){
            System.out.println("A patient with that first and last name already exists. Aborting.");
            return;
        }

        

    }
}
