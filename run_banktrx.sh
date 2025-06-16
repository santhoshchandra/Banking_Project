#!/bin/bash

# Define input and output file names
INPUT_FILE="TRANSACTIONS.DAT"
OUTPUT_FILE="CUSTOMER_REPORT.DAT"
INDEXED_FILE="indexed_accounts.txt"

# Compile the COBOL program
cobc -x -o ADMTXUP ADMTXUP.cbl

# Check if compilation succeeded
if [ $? -eq 0 ]; then
    echo "Compilation successful. Running program..."
    
    # Run the COBOL program
    ./ADMTXUP

    # Check if the program executed successfully
    if [ $? -eq 0 ]; then
        echo "Program executed successfully. Output written to $OUTPUT_FILE."
    else
        echo "Program execution failed."
    fi
else
    echo "Compilation failed. Please check your COBOL code."
fi