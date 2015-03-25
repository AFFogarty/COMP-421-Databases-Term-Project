import config.Auth;
import config.DatabaseConfig;

import java.io.IOException;
import java.sql.*;
import java.util.HashMap;

public class Database {

    private static String userName;
    private static String passWord;
    private Connection connection = null;
    private HashMap<ResultSet, Statement> statementHashMap;

    public Database() throws ClassNotFoundException, IOException, SQLException {
        // If we don't register the driver then things get messed up
        Class.forName("org.postgresql.Driver");

        System.out.println("Establishing DB connection...");
        this.connection = DriverManager.getConnection(DatabaseConfig.url, Auth.userName, Auth.passWord);

        // Create hash sets and maps
        this.statementHashMap = new HashMap<ResultSet, Statement>();
    }

    public ResultSet executeQuery(String query) throws SQLException {
        // The statement runs the query
        Statement statement = this.connection.createStatement();
        // Run the query on the statement
        ResultSet resultSet = statement.executeQuery(query);
        // Store the statement and result set to be closed later
        this.statementHashMap.put(resultSet, statement);
        // Return the results
        return resultSet;
    }

    /**
     * Insert, Update, or Destroy query handler.
     *
     * @param query the query to run
     * @return number of rows affected
     * @throws SQLException
     */
    public int executeInsertUpdateDestroy(String query) throws SQLException {
        // The statement runs the query
        Statement statement = this.connection.createStatement();
        // Run the query on the statement
        int output = statement.executeUpdate(query);
        // Close the statement
        statement.close();
        return output;
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
        // Close the statements and hash maps.
        for (ResultSet current : this.statementHashMap.keySet()) {
            this.closeResultSet(current);
        }

        if (this.isConnected()) {
            this.connection.close();
            System.out.println("Disconnected from Db.");
            // Set as null so that isConnected returns false
            this.connection = null;
        } else {
            System.out.println("Db already disconnected.");
        }
    }

    public void closeResultSet(ResultSet resultSet) throws SQLException {
        // Close the Statement
        this.statementHashMap.get(resultSet).close();
        // Remove the statement from the map
        this.statementHashMap.remove(resultSet);
        // Close resultSet
        resultSet.close();
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

    /**
     * Print out a result set.
     *
     * @param resultSet
     * @throws SQLException
     */
    public void printResultSet(ResultSet resultSet) throws SQLException {
        ResultSetMetaData metaData = resultSet.getMetaData();
        int numColumns = metaData.getColumnCount();
        System.out.println("Printing result set:");
        // Iterate through the result set
        int counter = 1;
        while (resultSet.next()) {
            System.out.print(counter + ". [");
            for (int i = 1; i <= numColumns; i++) {
                if (i > 1) {
                    // Print the comma to separate the values
                    System.out.print(",  ");
                }
                System.out.print(metaData.getColumnName(i) + ": " + resultSet.getString(i));
            }
            System.out.println("]");
            counter++;
        }
    }
}
