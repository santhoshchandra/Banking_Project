       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.

       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 WS-DATE.
            05 WS-YEAR PIC 9(4).
            05 FILLER  PIC X(1).
            05 WS-MONTH PIC 9(2).
            05 FILLER  PIC X(1).
            05 WS-DAY PIC 9(2).
            66 WS-YY-MM  RENAMES WS-YEAR THRU WS-MONTH.
         01 WS-PHONE-NUMBER REDEFINES WS-DATE PIC x(10).
         

         PROCEDURE DIVISION.
           DISPLAY 'enter the date (format: YYYY-MM-DD) :'
           ACCEPT WS-DATE
           DISPLAY 'YEAR & MONTH :' WS-YY-MM.
           MOVE '7093867202' TO WS-PHONE-NUMBER.
           DISPLAY 'Phone Number :' WS-PHONE-NUMBER.
           DISPLAY 'current YEAR & MONTH :' WS-YY-MM.
           DISPLAY 'current date: ' WS-DATE.
           STOP RUN.
           