import util.CommandPrompt;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;


public class Main {

    public static void main(String[] args) {

        String[] test = {"First", "Second", "Third"};
        int t = -1;
        try {
            t = CommandPrompt.getMenuSelection(test);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(t);

        Database db;
        try {
            db = new Database();
            ResultSet resultSet = db.executeQuery("SELECT * FROM PRODUCTS");
            db.printResultSet(resultSet);
            db.disconnect();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

}
