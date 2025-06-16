#!/bin/bash

# Define the input and output files
INPUT_FILE="accounts.txt"
INDEXED_FILE="accounts_index.txt"

# Step 1: Create a sample data file with account information
echo "Creating sample data file: $INPUT_FILE"
cat <<EOL > $INPUT_FILE
1234567890,1000.00,2023-10-01
0987654321,2000.00,2023-10-02
1234567892,1500.00,2023-10-03
1234567891,2500.00,2023-10-04
EOL

echo "Sample data file created."

# Step 2: Create or clear the indexed file
> $INDEXED_FILE
echo "Cleared or created indexed file: $INDEXED_FILE"

# Check if the input file exists
if [[ ! -f $INPUT_FILE ]]; then
    echo "Input file $INPUT_FILE does not exist."
    exit 1
fi

# Read the input file and create an indexed file
while IFS=',' read -r ACCOUNT_NUMBER BALANCE LAST_TRANS_DATE; do
    # Write to the indexed file
    echo "$ACCOUNT_NUMBER,$BALANCE,$LAST_TRANS_DATE" >> $INDEXED_FILE
done < "$INPUT_FILE"

echo "Data written to indexed file."

# Sort the indexed file by account number
sort -t',' -k1,1 $INDEXED_FILE -o $INDEXED_FILE
echo "Indexed file sorted."

echo "Indexed file created: $INDEXED_FILE"