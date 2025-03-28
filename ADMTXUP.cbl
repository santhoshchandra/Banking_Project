       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANKTRANS.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANSFILE ASSIGN TO 'TRANSACTIONS.DAT'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OUTFILE ASSIGN TO 'CUSTOMER_REPORT.DAT'
               ORGANIZATION IS LINE SEQUENTIAL.
       
       DATA DIVISION.
       FILE SECTION.
       FD  TRANSFILE.
       01  TRANS-RECORD.
           05  TRANS-HEADER.
               10  BATCH-DATE      PIC X(10).
           05  TRANS-DATA.
               10  ACCOUNT-NUMBER  PIC X(10).
               10  TRANSACTION-NAME PIC X(30).
               10  TRANSACTION-CODE PIC X(5).
               10  TRANSACTION-AMOUNT PIC 9(7)V99.
               10  CREDIT-DEBIT-IND PIC X(1).
           05  TRANS-TRAILER.
               10  RECORD-COUNT     PIC 9(5).
       
       FD  OUTFILE.
       01  REPORT-RECORD PIC X(200).
       
       WORKING-STORAGE SECTION.
       01  WS-RECORD-COUNT    PIC 9(5) VALUE 0.
       01  WS-LAST-TRANSDATE  PIC X(10).
       01  SQLCODE            PIC S9(9) COMP.
       
       EXEC SQL
           INCLUDE SQLCA
       END-EXEC.
       
       PROCEDURE DIVISION.
       100-MAIN-PROCESSING.
           OPEN INPUT TRANSFILE OUTPUT OUTFILE.
       
       200-READ-TRANSACTIONS.
           READ TRANSFILE INTO TRANS-RECORD
               AT END MOVE 'Y' TO EOF-FLAG.
           
           IF EOF-FLAG = 'N'
               ADD 1 TO WS-RECORD-COUNT
               PERFORM 300-PROCESS-TRANSACTION
               GO TO 200-READ-TRANSACTIONS.
       
       300-PROCESS-TRANSACTION.
           EXEC SQL
               SELECT BALANCE, LAST_TRANS_DATE
               INTO :WS-ACCOUNT-BALANCE, :WS-LAST-TRANSDATE
               FROM ACCOUNT
               WHERE ACCOUNT_NUMBER = :ACCOUNT-NUMBER
           END-EXEC.
       
           IF CREDIT-DEBIT-IND = 'C'
               ADD TRANSACTION-AMOUNT TO WS-ACCOUNT-BALANCE
           ELSE
               SUBTRACT TRANSACTION-AMOUNT FROM WS-ACCOUNT-BALANCE.
       
           MOVE BATCH-DATE TO WS-LAST-TRANSDATE.
       
           EXEC SQL
               UPDATE ACCOUNT
               SET BALANCE = :WS-ACCOUNT-BALANCE,
                   LAST_TRANS_DATE = :WS-LAST-TRANSDATE
               WHERE ACCOUNT_NUMBER = :ACCOUNT-NUMBER
           END-EXEC.
       
           STRING ACCOUNT-NUMBER ' | ' TRANSACTION-NAME ' | ' TRANSACTION-AMOUNT ' | ' CREDIT-DEBIT-IND
               DELIMITED BY SIZE INTO REPORT-RECORD.
           WRITE REPORT-RECORD.
       
       400-END-PROCESSING.
           CLOSE TRANSFILE OUTFILE.
           STOP RUN.
