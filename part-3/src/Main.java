import config.Database;
import util.CommandPrompt;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class Main {

    public static void main(String[] args) {
        try {
            connectToDatabase();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void connectToDatabase() throws IOException, ClassNotFoundException, SQLException {
        //  Ask user for the database username and password
        final String userName = CommandPrompt.getString("user name");
        final String passWord = CommandPrompt.getString("password");

        // If we don't register the driver then things get messed up
        Class.forName("org.postgresql.Driver");

        System.out.println("Establishing DB connection...");
        Connection connection = DriverManager.getConnection(Database.url, userName, passWord);

        // The statement runs the query
        System.out.println("Creating statement...");
        Statement statement = connection.createStatement();

        // Build the query
        String sqlQuery;
        sqlQuery = "SELECT * FROM products";
        // Run the query on the statement
        ResultSet resultSet = statement.executeQuery(sqlQuery);

        // Loop through set of results
        while(resultSet.next()){
            // Get values from result set
            int pid  = resultSet.getInt("pid");
            int type = resultSet.getInt("type");
            int producer = resultSet.getInt("producer");

            // Print them
            System.out.println("pid: " + pid + ", type: " + type + ", producer: " + producer);
        }

        // We have to close everything
        resultSet.close();
        statement.close();
        connection.close();

        System.out.println("Disconnected from Db.");
    }
}
