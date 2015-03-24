package util;

import helpers.RegEx;

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
     * Prompt the user to enter a money value.
     * @param name
     * @return
     * @throws IOException
     */
    public static String getMoneyString(String name) throws IOException {
        // Prompt the user
        System.out.print("Please enter " + name + ": ");
        // Open the reader
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String output = "";
        while (!RegEx.matchesMoney(output)) {
            System.out.println("Please enter a currency value in form '00.00' with no dollar sign.");
            output = br.readLine();
        }
        // Return the value
        return output;
    }

    /**
     * Prompt the user to enter a Date.
     *
     * @param name
     * @return
     * @throws IOException
     */
    public static String getDateString(String name) throws IOException {
        // Prompt the user
        System.out.print("Please enter " + name + ": ");
        // Open the reader
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String output = "";
        while (!RegEx.matchesDate(output)) {
            System.out.println("Please enter a date in the form 'YYYY-MM-DD'.");
            output = br.readLine();
        }
        // Return the value
        return output;
    }

    /**
     * Prompt the user for a time string.
     *
     * @param name
     * @return
     * @throws IOException
     */
    public static String getTimeString(String name) throws IOException {
        // Prompt the user
        System.out.print("Please enter " + name + ": ");
        // Open the reader
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String output = "";
        while (!RegEx.matchesTime(output)) {
            System.out.println("Please enter a time in form '23:59:59'.");
            output = br.readLine();
        }
        // Return the value
        return output;
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
