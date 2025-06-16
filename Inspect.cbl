       IDENTIFICATION DIVISION.
       PROGRAM-ID. string-revrsal.

       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 WS-STRING PIC X(50) VALUE "I am a Mainframe Developer.".
         01 WS-CNT1   PIC 99 VALUE 0.
         01 WS-CNT2   PIC 99 VALUE 0.
         01 WS-CNT3   PIC 99 VALUE 0.

       PROCEDURE DIVISION.
           DISPLAY 'Enter a string to reverse: '.
           ACCEPT WS-STRING.
           INSPECT WS-STRING TALLYING WS-CNT1 FOR ALL CHARACTERS.
           DISPLAY "Length of string field: " WS-CNT1.
           INSPECT WS-STRING TALLYING WS-CNT2 FOR 
                  ALL 'A' 'E' 'I' 'O' 'U' 'a' 'e' 'i' 'o' 'u'.
           DISPLAY "NUMBER OF VOWELS : " WS-CNT2.
           INSPECT WS-STRING TALLYING WS-CNT3 FOR ALL SPACES.
           DISPLAY 'NUMBER OF SPACES IN THE STRING :' WS-CNT3.
           STOP RUN.
           
           