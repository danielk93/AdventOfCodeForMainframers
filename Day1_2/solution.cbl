      * Used JDoodle for Cobol and stdin inputs with <EOF> in last line to execute program //remove this line if not working in JDoodle     
       IDENTIFICATION DIVISION.
       PROGRAM-ID. D1T2.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       01 EOF-FLAG              PIC X VALUE 'N'.
       01 INPUT-LINE            PIC X(100).
       01 FIRST-DIGIT           PIC 9.
       01 LAST-DIGIT            PIC 9.
       01 TWO-DIGIT-NUMBER      PIC 99.
       01 TOTAL-SUM             PIC 9(5) VALUE ZERO.
       01 DISPLAY-SUM           PIC ZZZZZ.
       01 I                     PIC 9(3) VALUE ZERO.
       01 J                     PIC 9(3) VALUE ZERO.

       PROCEDURE DIVISION.
       BEGIN.
           PERFORM UNTIL EOF-FLAG = 'Y'
               ACCEPT INPUT-LINE
               IF INPUT-LINE = '<EOF>' THEN
                   MOVE 'Y' TO EOF-FLAG
               ELSE
                   PERFORM PROCESS-LINE
               END-IF
           END-PERFORM
           MOVE TOTAL-SUM TO DISPLAY-SUM
           DISPLAY 'Total Sum: ' DISPLAY-SUM
           STOP RUN.

       PROCESS-LINE.
           MOVE ZERO TO I
           MOVE ZERO TO J
           PERFORM VARYING I FROM 1 BY 1 
           UNTIL I > LENGTH OF INPUT-LINE
               IF INPUT-LINE (I:1) IS NUMERIC THEN
                   MOVE INPUT-LINE (I:1) TO FIRST-DIGIT
                   EXIT PERFORM
               ELSE
                   EVALUATE TRUE
                       WHEN INPUT-LINE (I:3) = 'one'
                       MOVE 1 TO FIRST-DIGIT
                       EXIT PERFORM
                   WHEN INPUT-LINE (I:3) = 'two'
                       MOVE 2 TO FIRST-DIGIT
                       EXIT PERFORM
                   WHEN INPUT-LINE (I:5) = 'three'
                       MOVE 3 TO FIRST-DIGIT
                       EXIT PERFORM
                   WHEN INPUT-LINE (I:4) = 'four'
                       MOVE 4 TO FIRST-DIGIT
                       EXIT PERFORM
                   WHEN INPUT-LINE (I:4) = 'five'
                       MOVE 5 TO FIRST-DIGIT
                       EXIT PERFORM
                   WHEN INPUT-LINE (I:3) = 'six'
                       MOVE 6 TO FIRST-DIGIT
                       EXIT PERFORM
                   WHEN INPUT-LINE (I:5) = 'seven'
                       MOVE 7 TO FIRST-DIGIT
                       EXIT PERFORM
                   WHEN INPUT-LINE (I:5) = 'eight'
                       MOVE 8 TO FIRST-DIGIT
                       EXIT PERFORM
                   WHEN INPUT-LINE (I:4) = 'nine'
                       MOVE 9 TO FIRST-DIGIT
                       EXIT PERFORM
                   WHEN INPUT-LINE (I:4) = 'zero'
                       MOVE 0 TO FIRST-DIGIT
                       EXIT PERFORM
               END-EVALUATE

               END-IF
           END-PERFORM

           PERFORM VARYING J FROM LENGTH OF INPUT-LINE BY -1
           UNTIL J < 1
               IF INPUT-LINE (J:1) IS NUMERIC THEN
                   MOVE INPUT-LINE (J:1) TO LAST-DIGIT
                   EXIT PERFORM
               ELSE
                   EVALUATE TRUE
                       WHEN INPUT-LINE (J:3) = 'one'
                           MOVE 1 TO LAST-DIGIT
                           EXIT PERFORM
                       WHEN INPUT-LINE (J:3) = 'two'
                           MOVE 2 TO LAST-DIGIT
                           EXIT PERFORM
                       WHEN INPUT-LINE (J:5) = 'three'
                           MOVE 3 TO LAST-DIGIT
                           EXIT PERFORM
                       WHEN INPUT-LINE (J:4) = 'four'
                           MOVE 4 TO LAST-DIGIT
                           EXIT PERFORM
                       WHEN INPUT-LINE (J:4) = 'five'
                           MOVE 5 TO LAST-DIGIT
                           EXIT PERFORM
                       WHEN INPUT-LINE (J:3) = 'six'
                           MOVE 6 TO LAST-DIGIT
                           EXIT PERFORM
                       WHEN INPUT-LINE (J:5) = 'seven'
                           MOVE 7 TO LAST-DIGIT
                           EXIT PERFORM
                       WHEN INPUT-LINE (J:5) = 'eight'
                           MOVE 8 TO LAST-DIGIT
                           EXIT PERFORM
                       WHEN INPUT-LINE (J:4) = 'nine'
                           MOVE 9 TO LAST-DIGIT
                           EXIT PERFORM
                       WHEN INPUT-LINE (J:4) = 'zero'
                           MOVE 0 TO LAST-DIGIT
                           EXIT PERFORM
                   END-EVALUATE
               END-IF
           END-PERFORM

           STRING FIRST-DIGIT DELIMITED BY SIZE
                 LAST-DIGIT DELIMITED BY SIZE
                 INTO TWO-DIGIT-NUMBER
           ADD TWO-DIGIT-NUMBER TO TOTAL-SUM.
