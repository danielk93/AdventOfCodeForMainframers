import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Day2_2 {

    public static void main(String[] args) {
        try {
            List<String> games = Files.readAllLines(Paths.get("input.txt"));
            long powerSum = games.stream()
                                 .mapToLong(Day2_2::calculateGamePower)
                                 .sum();
            System.out.println("Sum of the power of the sets: " + powerSum);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static long calculateGamePower(String game) {
        Pattern pattern = Pattern.compile("(\\d+) red|(\\d+) green|(\\d+) blue");
        Matcher matcher = pattern.matcher(game);
        
        int maxRed = 0, maxGreen = 0, maxBlue = 0;
        
        while (matcher.find()) {
            if (matcher.group(1) != null) {
                maxRed = Math.max(maxRed, Integer.parseInt(matcher.group(1)));
            }
            if (matcher.group(2) != null) {
                maxGreen = Math.max(maxGreen, Integer.parseInt(matcher.group(2)));
            }
            if (matcher.group(3) != null) {
                maxBlue = Math.max(maxBlue, Integer.parseInt(matcher.group(3)));
            }
        }
        
        long power = (long) maxRed * maxGreen * maxBlue;
        System.out.println("Game ID [" + game.substring(5, game.indexOf(":")) + "] Power: " + power);
        return power;
    }
}