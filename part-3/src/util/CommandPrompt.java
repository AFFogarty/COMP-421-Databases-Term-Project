package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;


public class CommandPrompt {

    /**
     * Prompt the user to enter a string
     *
     * @param name name of the variable
     * @return the value
     * @throws IOException
     */
    public static String getString(String name) throws IOException {
        // Prompt the user
        System.out.print("Please enter " + name + ": ");
        // Open the reader
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        // Return the value
        return br.readLine();
    }
}
