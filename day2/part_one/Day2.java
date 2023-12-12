import java.io.BufferedReader;
import java.io.FileReader;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Day2 {

    // Variablen für die verfügbare Anzahl von Würfeln jeder Farbe
    private static final Map<String, Integer> availableCubes = new HashMap<>();
   
    static {
        // Initialisieren Sie die verfügbaren Würfel hier
        availableCubes.put("red", 12);
        availableCubes.put("green", 13);
        availableCubes.put("blue", 14);
    }

    public static void main(String[] args) {
        // Pfad zur input.txt Datei
        String filePath = "input.txt";
        int sumOfGameIds = 0; // Variable zum Speichern der summierten Spiel-IDs

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String game;
            int gameIndex = 1;

            while ((game = reader.readLine()) != null) {
                Map<String, Integer> cubeCounts = new HashMap<>();
                cubeCounts.put("red", 0);
                cubeCounts.put("green", 0);
                cubeCounts.put("blue", 0);

                Pattern pattern = Pattern.compile("(\\d+) (red|green|blue)");
                Matcher matcher = pattern.matcher(game);

                while (matcher.find()) {
                    String color = matcher.group(2);
                    int count = Integer.parseInt(matcher.group(1));
                    cubeCounts.put(color, Math.max(cubeCounts.get(color), count));
                }
                
                boolean isPossible = true;
                for (Map.Entry<String, Integer> entry : cubeCounts.entrySet()) {
                    if (entry.getValue() > availableCubes.get(entry.getKey())) {
                        isPossible = false;
                        break; // Keine weiteren Überprüfungen notwendig, das Spiel ist nicht möglich
                    }
                }

                // Wenn das Spiel möglich ist, aktualisiere die Summe der Spiel-IDs
                if (isPossible) {
                    sumOfGameIds += gameIndex;
                }
                // Inkrementiere die Spielnummer für das nächste Spiel
                gameIndex++;
            }

            // Gib die Gesamtsumme der IDs möglicher Spiele aus
            System.out.println("Sum of game IDs for possible games: " + sumOfGameIds);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}