       IDENTIFICATION DIVISION.
       PROGRAM-ID. string-revrsal.

       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 WS-STRING PIC X(50) VALUE "Hello".
         01 WS-UPPER  PIC X(50) VALUE SPACES.
         01 WS-LOWER  PIC X(50) VALUE SPACES.
         01 WS-LENGTH PIC 9(2) VALUE 0.
         01 WS-COUNT PIC 9(2) VALUE 1.
         01 WS-OUTPUT PIC X(50) VALUE SPACES.

       PROCEDURE DIVISION.
           DISPLAY 'Enter a string to reverse: '.
           ACCEPT WS-STRING.
           MOVE FUNCTION LENGTH (FUNCTION TRIM(WS-STRING)) TO WS-LENGTH.
           DISPLAY "Length of string (using FUNCTION): " WS-LENGTH.
           MOVE FUNCTION UPPER-CASE(WS-STRING) TO WS-UPPER.
           MOVE FUNCTION LOWER-CASE(WS-STRING) TO WS-LOWER.
           IF WS-UPPER = WS-STRING
              DISPLAY 'YOU ENTERED A STRING IN UPPER CASE '
           ELSE 
            IF WS-LOWER = WS-STRING
              DISPLAY 'YOU ENTERED STRING IN LOWER CASE '
            ELSE
              DISPLAY 'YOU ENTERED STRING IN MIXED CASE '
            END-IF
           END-IF
            
           PERFORM VARYING WS-COUNT FROM 1 BY 1 UNTIL 
                                         WS-COUNT> WS-LENGTH
                 MOVE WS-STRING(((WS-LENGTH) - (WS-COUNT)+ 1) : 1) TO 
                               WS-OUTPUT(WS-COUNT:1)
           END-PERFORM.
           DISPLAY "Reversed string: " WS-OUTPUT.
           STOP RUN.

           