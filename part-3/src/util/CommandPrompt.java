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

    /**
     * Present the user with a list of options and get their choice.
     *
     * @param options
     * @return
     * @throws IOException
     */
    public static int getMenuSelection(String[] options) throws IOException {
        System.out.println("\n\nPlease select one of the following actions:");

        // Print the options
        for (int i = 0; i < options.length; i++) {
            System.out.println((i + 1) + ". " + options[i]);
        }
        // Open reader
        BufferedReader br = new BufferedReader(new InputStreamReader((System.in)));
        int output = -1;
        while (output < 1 || output > options.length) {
            System.out.println("Please enter a number between 1 and " + options.length + ".");
            output = Integer.parseInt(br.readLine());
        }
        System.out.println("Option " + output + ", " + options[output - 1] + ", selected.");
        // Return the number selection
        return output;
    }
}
