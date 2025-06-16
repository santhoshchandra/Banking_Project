       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANKTRANS.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANSFILE ASSIGN TO 'TRANSACTIONS.DAT'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS TF-FILE-STATUS.
           SELECT OUTFILE ASSIGN TO 'CUSTOMER_REPORT.DAT'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS OF-FILE-STATUS.

           SELECT ACCOUNTFILE ASSIGN TO 'accounts_index.txt'
                ORGANIZATION IS SEQUENTIAL
                ACCESS MODE IS SEQUENTIAL
                FILE STATUS IS AF-FILE-STATUS.


       DATA DIVISION.
       FILE SECTION.
       FD  TRANSFILE.
       01  TRANS-RECORD.
           05  TRANS-HEADER.
               10  TH-RECORD-TYPE     PIC X(3).
               10  TH-BATCH-DATE      PIC X(08).
               10  FILLER             PIC X(44).

           05  TRANS-DATA REDEFINES TRANS-HEADER.
               10  TF-ACCOUNT-NUMBER  PIC X(10).
               10  TF-TRANSACTION-NAME PIC X(30).
               10  TF-TRANSACTION-CODE PIC X(5).
               10  TF-TRANSACTION-AMOUNT PIC 9(7)V99.
               10  TF-CREDIT-DEBIT-IND PIC X(1).

           05  TRANS-TRAILER REDEFINES TRANS-HEADER.
               10  TT-RECORD-TYPE     PIC X(3).
               10  TT-RECORD-COUNT    PIC 9(5).
               10  FILLER             PIC X(47).

       FD  OUTFILE.
       01  REPORT-RECORD PIC X(200).

       FD  ACCOUNTFILE.
       01  ACCOUNT-RECORD.
           05  AF-ACCOUNT-NUMBER  PIC X(10).
           05  FILLER             PIC X(1).
           05  AF-ACCOUNT-BALANCE  PIC 9(7)V99.
           05  FILLER             PIC X(1).
           05  AF-LAST-TRANS-DATE  PIC X(10).

       WORKING-STORAGE SECTION.
       01  WS-RECORD-COUNT    PIC 9(5) VALUE 0.
       01  WS-COUNT1          PIC 9(5) VALUE 0.
       01  WS-ACCOUNT-NUMBER   PIC X(10).
       01  WS-LAST-TRANSDATE  PIC X(10).
       01  WS-ACCOUNT-BALANCE  PIC 9(7)V99.
       01  EOF-FLAG           PIC X(1) VALUE 'N'.
       01  EOF-FLAG1          PIC X(1) VALUE 'N'.
       01  TF-FILE-STATUS    PIC XX.
       01  OF-FILE-STATUS    PIC XX.
       01  AF-FILE-STATUS    PIC XX.

       PROCEDURE DIVISION.

       100-INITILIZE.
           INITIALIZE   TRANS-RECORD
                        ACCOUNT-RECORD
                        REPORT-RECORD
                        WS-ACCOUNT-NUMBER
                        WS-LAST-TRANSDATE
                        WS-ACCOUNT-BALANCE.
           PERFORM 100-MAIN-PROCESSING THRU 100-MAIN-PROCESSING-EXIT.
           PERFORM 200-READ-TRANSACTIONS THRU 200-READ-EXIT UNTIL
                   EOF-FLAG = 'Y'.
       100-INITILIZE-EXIT.
           EXIT.

       100-MAIN-PROCESSING.
           OPEN INPUT TRANSFILE OUTPUT OUTFILE.
           OPEN I-O ACCOUNTFILE.

           IF AF-FILE-STATUS NOT = '00'
               DISPLAY 'Error opening ACCOUNTFILE :' AF-FILE-STATUS
               OPEN OUTPUT ACCOUNTFILE
               CLOSE ACCOUNTFILE
               OPEN I-O ACCOUNTFILE
           END-IF.

           IF OF-FILE-STATUS NOT = '00'
               DISPLAY 'Error opening Output File: ' OF-FILE-STATUS
               CLOSE OUTFILE
           END-IF.

           IF TF-FILE-STATUS NOT = '00'
               DISPLAY 'Error opening TransFile: ' TF-FILE-STATUS
               CLOSE TRANSFILE
           END-IF.
       100-MAIN-PROCESSING-EXIT.
           EXIT.

       200-READ-TRANSACTIONS.
           READ TRANSFILE INTO TRANS-RECORD
               AT END MOVE 'Y' TO EOF-FLAG
               NOT AT END 
                      PERFORM 300-PROCESS-TRANSACTION THRU 
                              300-PROCESS-EXIT UNTIL EOF-FLAG1 = 'Y'
           END-READ.
       200-READ-EXIT.
           EXIT.

       300-PROCESS-TRANSACTION.
           READ ACCOUNTFILE INTO ACCOUNT-RECORD
                AT END MOVE 'Y' TO EOF-FLAG1
                NOT AT END 
                      IF TH-RECORD-TYPE = 'HDR'
                          MOVE TH-BATCH-DATE(1:4) TO 
                               WS-LAST-TRANSDATE(1:4)
                          MOVE '-' TO WS-LAST-TRANSDATE(5:1)
                          MOVE TH-BATCH-DATE(5:2) TO 
                               WS-LAST-TRANSDATE(6:2)
                          MOVE '-' TO WS-LAST-TRANSDATE(8:1)
                          MOVE TH-BATCH-DATE(7:2) TO 
                               WS-LAST-TRANSDATE(9:2)
                        ELSE
                           IF TT-RECORD-TYPE = 'TRL'
                                 MOVE TT-RECORD-COUNT TO WS-RECORD-COUNT
                            ELSE
                              ADD 1 TO WS-COUNT1
                              DISPLAY 'AF-ACCOUNT-NUMBER :' 
                                      AF-ACCOUNT-NUMBER   
                              DISPLAY 'AF-ACCOUNT-BALANCE #0:' 
                                      AF-ACCOUNT-BALANCE    
                              IF TF-ACCOUNT-NUMBER = AF-ACCOUNT-BALANCE
                                  PERFORM UPDATE-BALANCE THRU
                                          UPDATE-BALANCE-EXIT
                              END-IF
                           END-IF
                        END-IF
           END-READ.
       300-PROCESS-EXIT.
           EXIT.
       
       UPDATE-BALANCE.
           DISPLAY 'TF-ACCOUNT-NUMBER : ' TF-ACCOUNT-NUMBER
           DISPLAY 'TF-TRANSACTION-NAME : ' TF-TRANSACTION-NAME
           DISPLAY 'TF-TRANSACTION-CODE : ' TF-TRANSACTION-CODE
           DISPLAY 'TF-TRANSACTION-AMOUNT : ' TF-TRANSACTION-AMOUNT
           DISPLAY 'AF-ACCOUNT-NUMBER : ' AF-ACCOUNT-NUMBER
           DISPLAY 'AF-ACCOUNT-BALANCE #1:' AF-ACCOUNT-BALANCE
           IF TF-CREDIT-DEBIT-IND = 'C'
               ADD TF-TRANSACTION-AMOUNT TO AF-ACCOUNT-BALANCE
           ELSE
               SUBTRACT TF-TRANSACTION-AMOUNT FROM AF-ACCOUNT-BALANCE
           END-IF.

           DISPLAY 'AF-ACCOUNT-BALANCE #2:' AF-ACCOUNT-BALANCE

           REWRITE ACCOUNT-RECORD.

           STRING TF-ACCOUNT-NUMBER ' | ' TF-TRANSACTION-NAME ' | ' 
           TF-TRANSACTION-AMOUNT ' | ' TF-CREDIT-DEBIT-IND
               DELIMITED BY SIZE INTO REPORT-RECORD.
           WRITE REPORT-RECORD.
       UPDATE-BALANCE-EXIT.
           EXIT.

       400-END-PROCESSING.
           IF WS-RECORD-COUNT <> WS-COUNT1
              DISPLAY 'COUNT MISMATCH IN TRANSFILE AND '
                      'BALANCE UPDATE ACCOUNTS'
           END-IF.

           CLOSE TRANSFILE.
           CLOSE OUTFILE.
           CLOSE ACCOUNTFILE.

           STOP RUN.