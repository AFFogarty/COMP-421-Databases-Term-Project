package helpers;


import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegEx {
    public static boolean matchesMoney(String input) {
        Pattern p = Pattern.compile("\\d{1,13}.\\d{2}");
        Matcher m = p.matcher(input);
        return m.matches();
    }

    public static boolean matchesDate(String input) {
        Pattern p = Pattern.compile("\\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])");
        Matcher m = p.matcher(input);
        return m.matches();
    }

    public static boolean matchesTime(String input) {
        Pattern p = Pattern.compile("([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]");
        Matcher m = p.matcher(input);
        return m.matches();
    }
}
