package helpers;


import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegEx {
    public static boolean matchesMoney(String input) {
        return stringMatchesRegex("\\d{1,13}.\\d{2}", input);
    }

    public static boolean matchesDate(String input) {
        return stringMatchesRegex("\\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])", input);
    }

    public static boolean matchesTime(String input) {
        return stringMatchesRegex("([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]", input);
    }

    public static boolean matchesFirstName(String input) {
        return stringMatchesRegex("[A-Z][a-zA-Z]*", input);
    }

    public static boolean matchesLastName(String input) {
        return stringMatchesRegex( "[a-zA-z]+([ '-][a-zA-Z]+)*", input);
    }

    public static boolean matchesNaturalNumber(String input) {
        return stringMatchesRegex("[0-9]+", input);
    }

    public static boolean matchesNumber(String input) {
        return stringMatchesRegex("\\d*\\.\\d{1,}|\\d{1,}", input);
    }

    /**
     *  Check if a string matches a regex.
     *
     * @param regex Regular expression
     * @param input String to be matched
     * @return true if input matches regex
     */
    private static boolean stringMatchesRegex(String regex, String input) {
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(input);
        return m.matches();
    }

}
