package helpers;

import org.junit.Test;

import static org.junit.Assert.*;

public class RegExTest {

    @Test
    public void testMatchesMoney() throws Exception {
        // True
        assertTrue(RegEx.matchesMoney("1727244.99"));
        assertTrue(RegEx.matchesMoney("0.01"));
        // False
        assertFalse(RegEx.matchesMoney("ajfsjfs"));
        assertFalse(RegEx.matchesMoney(".00"));
        assertFalse(RegEx.matchesMoney("0.001"));
    }

    @Test
    public void testMatchesDate() throws Exception {
        assertTrue(RegEx.matchesDate("1995-01-31"));
        assertTrue(RegEx.matchesDate("2097-11-05"));

        assertFalse(RegEx.matchesDate("209-11-05"));
        assertFalse(RegEx.matchesDate("209-11-05"));
        assertFalse(RegEx.matchesDate("1993-22-05"));
    }

    @Test
    public void testMatchesTime() throws Exception {
        assertTrue(RegEx.matchesTime("23:07:19"));
        assertTrue(RegEx.matchesTime("01:59:29"));

        assertFalse(RegEx.matchesTime("209-11-05"));
        assertFalse(RegEx.matchesTime("26:00:00"));
        assertFalse(RegEx.matchesTime("23:00:1"));
    }
}