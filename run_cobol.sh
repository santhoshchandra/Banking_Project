#!/bin/bash
# This script compiles and runs a COBOL program using the GNU COBOL compiler (cobc).
# Ask the user for the COBOL program name (without extension)
read -p "Enter the COBOL program name (without .cbl): " program_name

# Compile the COBOL program
cobc -x -o "$program_name" "$program_name.cbl"

# Check if compilation succeeded
if [ $? -eq 0 ]; then
    echo "Compilation successful. Running program..."
    ./"$program_name"
else
    echo "Compilation failed."
fi

