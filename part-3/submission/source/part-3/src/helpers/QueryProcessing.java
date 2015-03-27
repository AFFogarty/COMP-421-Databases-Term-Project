package helpers;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class QueryProcessing {

    public static String[] getResultSetColumnArray(ResultSet resultSet, String columnName) throws SQLException {
        ArrayList<String> output = new ArrayList<String>();
        // Read in the values
        while (resultSet.next()) {
            output.add(resultSet.getString(columnName));
        }
        // Return as array
        return (String[]) output.toArray(new String[output.size()]);
    }
}
