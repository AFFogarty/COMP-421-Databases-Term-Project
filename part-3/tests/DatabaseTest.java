import org.junit.Test;


import java.sql.ResultSet;

import static org.junit.Assert.*;

public class DatabaseTest {

    @Test
    public void testConnection() throws Exception {
        // Connect
        Database db = new Database();
        // Make queries
        ResultSet resultSet = db.executeQuery("SELECT * FROM staff");
        db.executeQuery("SELECT * FROM department");
        // Assert connected
        assertTrue(db.isConnected());
        // Disconnect
        db.disconnect();
        // Assert disconnected
        assertFalse(db.isConnected());
    }

}