       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.

       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 WS-STRING PIC X(50) VALUE SPACES.
         01 WS-CASE PIC X(1) VALUE SPACES.

       PROCEDURE DIVISION.
           DISPLAY 'enter the string :'
           ACCEPT WS-STRING
           DISPLAY 'Which case you want to convert(U/L) ?'
           ACCEPT WS-CASE
           IF WS-CASE = 'U' OR WS-CASE = 'u'
               INSPECT WS-STRING CONVERTING 'abcdefghijklmnopqrstuvwxyz' 
                   TO 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
           ELSE IF WS-CASE = 'L' OR WS-CASE = 'l'
               INSPECT WS-STRING CONVERTING 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 
                   TO 'abcdefghijklmnopqrstuvwxyz'
           END-IF.
           DISPLAY WS-STRING.
           STOP RUN.
           