import config.DatabaseConfig;
import util.CommandPrompt;

import java.io.IOException;
import java.sql.*;

public class Database {

    private static String userName;
    private static String passWord;

    Connection connection = null;

    public Database() throws ClassNotFoundException, IOException, SQLException {
        //  Ask user for the database username and password
        this.userName = CommandPrompt.getString("user name");
        this.passWord = CommandPrompt.getString("password");

        // If we don't register the driver then things get messed up
        Class.forName("org.postgresql.Driver");

        System.out.println("Establishing DB connection...");
        this.connection = DriverManager.getConnection(DatabaseConfig.url, this.userName, this.passWord);
    }

    public ResultSet executeQuery(String query) throws SQLException {
        // The statement runs the query
        System.out.println("Creating statement...");
        Statement statement = this.connection.createStatement();
        // Run the query on the statement
        ResultSet resultSet = statement.executeQuery(query);
        // Close the statement
        statement.close();
        // Return the results
        return resultSet;
    }

    /**
     * Check if the database is still connected.
     *
     * @return true iff connected
     */
    public boolean isConnected() {
        return this.connection != null;
    }

    /**
     * Disconnect the Database connection.
     *
     * @throws SQLException
     */
    public void disconnect() throws SQLException {
        if (this.isConnected()) {
            this.connection.close();
            System.out.println("Disconnected from Db.");
            // Set as null so that isConnected returns false
            this.connection = null;
        } else {
            System.out.println("Db already disconnected.");
        }
    }

    /**
     * Make sure that the DB disconnects if for some reason it gets finalized before disconnecting.
     */
    public void finalize() {
        try {
            super.finalize();
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
        // Try to disconnect, just in case
        try {
            this.disconnect();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
