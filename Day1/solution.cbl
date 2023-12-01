       IDENTIFICATION DIVISION.
       PROGRAM-ID. D1.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 FileText PIC X(10000).
       01 OpenBracket PIC 9(4) VALUE ZERO.
       01 ClosedBracket PIC 9(4) VALUE ZERO.
       01 Result PIC -9(4) VALUE ZERO.
       PROCEDURE DIVISION.
           ACCEPT FileText.
           INSPECT FileText TALLYING OpenBracket FOR ALL "(".
           INSPECT FileText TALLYING ClosedBracket FOR ALL ")".
          
           SUBTRACT ClosedBracket FROM OpenBracket GIVING Result.
          
           DISPLAY "Santa is in floor: " Result.
           STOP RUN.