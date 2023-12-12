       IDENTIFICATION DIVISION.
       PROGRAM-ID. ReadFile.
 
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT YOUR-FILE ASSIGN TO "INPUT01"
           ORGANIZATION IS LINE SEQUENTIAL.
 
       DATA DIVISION.
       FILE SECTION.
       FD YOUR-FILE.
       01 YOUR-RECORD PIC X(80).

       WORKING-STORAGE SECTION.
       01 EOF-REACHED PIC X VALUE 'N'.
       01 I           PIC 9(4).
       01 CHAR        PIC X.
       01 RESULT      PIC 9(6).
       01 TEN         PIC 9(2).
       01 ONE PIC 9(1).
 
       PROCEDURE DIVISION.
       READ-FILE.
           OPEN INPUT YOUR-FILE.
           PERFORM UNTIL EOF-REACHED = 'Y'
              READ YOUR-FILE
            AT END
                MOVE 'Y' TO EOF-REACHED
            NOT AT END
                PERFORM PROCESS-RECORD
           END-READ
           END-PERFORM.
           CLOSE YOUR-FILE.
           DISPLAY "Result:" RESULT
           STOP RUN.
 
       PROCESS-RECORD.
      *  Process the record here, for example, display it:
             DISPLAY YOUR-RECORD.
             PERFORM VARYING i FROM 1 BY 1 UNTIL i > LENGTH OF 
             YOUR-RECORD
                 MOVE YOUR-RECORD(i:1) TO char
                 IF char >= "0" AND CHAR <= "9"
                   COMPUTE TEN = FUNCTION NUMVAL (CHAR) 
                   MULTIPLY TEN BY 10 GIVING TEN
         
                   MOVE 81 TO i
                 END-IF
             END-PERFORM.

             PERFORM VARYING i FROM LENGTH OF YOUR-RECORD BY -1 UNTIL i 
             < 1 
                 MOVE YOUR-RECORD(i:1) TO char
                 IF char >= "0" AND CHAR <= "9"
                   COMPUTE ONE = FUNCTION NUMVAL (CHAR)
                   MOVE 1 TO i
                 END-IF
             END-PERFORM.
             ADD TEN TO RESULT.
             ADD ONE TO RESULT.