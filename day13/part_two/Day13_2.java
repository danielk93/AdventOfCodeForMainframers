package com.test;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Day13_2 {

	public static String[] reverseArray(String[] array) {
		List<String> list = Arrays.asList(array);
		Collections.reverse(list);
		return list.toArray(new String[0]);
	}

	public static int findMirror(String[] grid) {
		for (int r = 1; r < grid.length; r++) {

			// Assume r is the mirror line , find the grid above and below it
			String[] above = Arrays.copyOfRange(grid, 0, r);
			String[] below = Arrays.copyOfRange(grid, r, grid.length);
			// Reverse the above array
			String[] reversedAboveArray = reverseArray(above);
			// Consider only the minimum length of the above and below array to find perfect
			// reflection
			int len = Math.min(reversedAboveArray.length, below.length);
			reversedAboveArray = Arrays.copyOfRange(reversedAboveArray, 0, len);
			below = Arrays.copyOfRange(below, 0, len);
			// Check if the above and below array are equal
			if (Arrays.equals(reversedAboveArray, below)) {
				return r;
			}
		}
		// Return 0 if after trying all rows , mirror line cant be found
		return 0;
	}

	public static int findMirror2(String[] grid) {
		for (int r = 1; r < grid.length; r++) {

			String[] above = Arrays.copyOfRange(grid, 0, r);
			String[] below = Arrays.copyOfRange(grid, r, grid.length);
			// Reverse the above array
			String[] reversedAboveArray = reverseArray(above);
			if (countDifferences(reversedAboveArray, below) == 1) {
				return r;
			}
		}
		return 0;
	}

	public static int countDifferences(String[] above, String[] below) {
		int count = 0;
		for (int i = 0; i < above.length && i < below.length; i++) {
			for (int j = 0; j < above[i].length(); j++) {
				if (above[i].charAt(j) != below[i].charAt(j)) {
					count++;
				}
			}
		}
		return count;
	}
	
	public static String readFile(String input) throws IOException {
		BufferedReader rdr = new BufferedReader(new FileReader(input));
		try {
			StringBuilder sb = new StringBuilder();

			String line;
			while ((line = rdr.readLine()) != null) {
				sb.append(line);
				sb.append("\n");
			}
			return sb.toString();
		} finally {
			rdr.close();
		}
	}

	public static void main(String[] args) {
		int total = 0;

		/* Sample data */
//		String input_data = """
//				#.##..##.
//				..#.##.#.
//				##......#
//				##......#
//				..#.##.#.
//				..##..##.
//				#.#.##.#.
//
//				#...##..#
//				#....#..#
//				..##..###
//				#####.##.
//				#####.##.
//				..##..###
//				#....#..#
//			              """;
		
		String input_data = "";
		try {
			input_data = Day13_2.readFile("input13.txt");
		} catch (IOException e) {
			e.printStackTrace();
		}

		total = 0;

		for (String block : input_data.split("\n\n")) {
			String[] grid = block.split("\n");
			// First find horizontal symmetry
			int row = findMirror2(grid);
			total += row * 100;
			// Transpose the grid to find vertical symmetry
			// By transposing the grid, we can reuse same function to find symmetry line
			String[] transposedGrid = new String[grid[0].length()];
			for (int i = 0; i < grid[0].length(); i++) {
				transposedGrid[i] = "";
				for (String rowStr : grid) {
					transposedGrid[i] += rowStr.charAt(i);
				}
			}

			int col = findMirror2(transposedGrid);
			total += col;
		}
		System.out.println("Total for Part 2: " + total);
	}
}