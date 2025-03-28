#!/bin/bash

# Compile the COBOL program
cobc -x -o hello hello.cbl

# Check if compilation succeeded
if [ $? -eq 0 ]; then
    echo "Compilation successful. Running program..."
    ./hello
else
    echo "Compilation failed."
fi
