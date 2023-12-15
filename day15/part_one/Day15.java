import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Day15 {

	private int totalSum = 0;

	public static void main(String[] args) throws IOException {
		new Day15();
	}

	public Day15() throws IOException {
		String text = Day15.readFile("day15input.txt");		
		String[] textsplitter = text.split(",");		
		for (int i = 0; i < textsplitter.length; i++) {			
			int sum = 0;
			
			for (int j = 0; j < textsplitter[i].length(); j++) {
				int ascii_char = (int) textsplitter[i].charAt(j);		
				sum += ascii_char;
				sum *= 17;
				sum %= 256;

			}
			totalSum += sum;	
			/* OR with method 'hash'
			int sum = 0;
			for (int i = 0; i < textsplitter.length; i++) {
				 sum += hash(textsplitter[i]);
				System.out.println(sum);			
			}
			totalSum += sum;
			System.out.println("total sum=" + totalSum); 			 
			*/			
		}
		System.out.println("Total sum=" + totalSum);
	}

	public static String readFile(String input) throws IOException {
		BufferedReader rdr = new BufferedReader(new FileReader(input));
		try {
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rdr.readLine()) != null) {
				sb.append(line);
			}
			return sb.toString();
		} finally {
			rdr.close();
		}
	}
	
	public static int hash(String s) {
        int currentValue = 0;
        for (char c : s.toCharArray()) {
            // Determine the ASCII code for the current character of the string.
            int ascii = (int) c;
            // Increase the current value by the ASCII code you just determined.
            currentValue += ascii;
            // Multiply the current value by 17.
            currentValue *= 17;
            // Set the current value to the remainder of dividing itself by 256.
            currentValue %= 256;
        }
        // Return the final currentValue as the result of the HASH algorithm.
        return currentValue;
    }
}
