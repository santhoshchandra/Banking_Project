# Banking_Project
Introduction

COBOL (Common Business-Oriented Language) is a programming language that has been widely used in business, finance, and administrative systems for decades. With the advent of Windows Subsystem for Linux (WSL), developers can now run Linux distributions directly on Windows, making it easier to work with languages like COBOL. In this article, we will walk through the steps to execute a simple COBOL program using WSL, including how to handle common issues related to file formats when using Windows text editors.

Prerequisites

Before we begin, ensure you have the following:

Windows 10 or later with WSL enabled.

GnuCOBOL installed in your WSL environment.

A basic understanding of COBOL programming.

Step 1: Install WSL and GnuCOBOL

Enable WSL: Open PowerShell as an administrator and run:

wsl --install

This command installs the default Linux distribution (usually Ubuntu).

Open WSL: After installation, open your WSL terminal (search for "Ubuntu" in the Start menu).

Install GnuCOBOL: In the WSL terminal, run the following commands to update the package list and install GnuCOBOL:

sudo apt update
sudo apt install gnucobol

Step 2: Create a Simple COBOL Program

Open a Text Editor: You can use a text editor like nano or vim in WSL. For example, to create a file named hello.cbl, run:

nano hello.cbl

Write the COBOL Code: Enter the following simple COBOL program:

IDENTIFICATION DIVISION.
PROGRAM-ID. HELLO.
PROCEDURE DIVISION.
    DISPLAY "Hello, World from COBOL!".
    STOP RUN.

Save and Exit: In nano, press CTRL + O to save, then Enter, and CTRL + X to exit.

Step 3: Create a Shell Script to Compile and Run the Program

Create a Shell Script: Create a new shell script named run_cobol.sh:

nano run_cobol.sh

Add the Following Code:

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

Save and Exit: Save and exit the script as you did before.

Step 4: Make the Shell Script Executable

Run the following command to make your script executable:

chmod +x run_cobol.sh

Step 5: Handling Windows Notepad File Issues

If you created or edited your COBOL program or shell script using Windows Notepad, you might encounter issues when running the script in WSL. This is due to Windows-style line endings (CRLF) that are not compatible with Unix/Linux systems.

Converting Line Endings

Install dos2unix: If you haven't already, install dos2unix to convert line endings:

sudo apt install dos2unix

Convert the Script: Convert your shell script to Unix format:

dos2unix run_cobol.sh

Step 6: Run the Shell Script

Now you can run your shell script to compile and execute your COBOL program:

./run_cobol.sh

If everything is set up correctly, you should see the output:

Compilation successful. Running program...
Hello, World from COBOL!

Conclusion

In this article, we demonstrated how to execute a simple COBOL program using WSL and shell scripting. We also addressed common issues related to file formats when using Windows text editors. By following these steps, you can easily develop and run COBOL programs in a Linux environment on your Windows machine.

Certainly! Below is a structured article that outlines the steps to push files to a GitHub repository, including the necessary Git commands and configurations.

---

# How to Push Files to GitHub: A Step-by-Step Guide

## Prerequisites

Before you begin, ensure you have the following:

1. **Git installed** on your machine.
2. A **GitHub account**.
3. A **repository created** on GitHub (you can create one through the GitHub website).

## Step 1: Configure Git

Before using Git, you need to set up your user information. This is a one-time setup.

1. **Open your terminal** (or WSL if you are using Windows).
2. **Set your username**:
   ```bash
   git config --global user.name "Your Name"
   ```
3. **Set your email**:
   ```bash
   git config --global user.email "your_email@example.com"
   ```

You can verify your configuration by running:
```bash
git config --global --list
```

## Step 2: Initialize a Git Repository

1. **Navigate to your project directory**:
   Use the `cd` command to change to the directory where your project files are located:
   ```bash
   cd /path/to/your/project
   ```

2. **Initialize a new Git repository**:
   Run the following command to create a new Git repository in your project directory:
   ```bash
   git init
   ```

## Step 3: Add Remote Repository

1. **Link your local repository to the remote GitHub repository**:
   Replace `<USERNAME>` with your GitHub username and `<REPO_NAME>` with the name of your repository:
   ```bash
   git remote add origin https://github.com/<USERNAME>/<REPO_NAME>.git
   ```

## Step 4: Add Files to the Staging Area

1. **Add files to the staging area**:
   Use the following command to add all your project files to the staging area:
   ```bash
   git add .
   ```
   Alternatively, you can add specific files by replacing `.` with the file names.

## Step 5: Commit Your Changes

1. **Commit the changes**:
   After adding files to the staging area, commit your changes with a descriptive message:
   ```bash
   git commit -m "Initial commit: Add project files"
   ```

## Step 6: Push Your Changes to GitHub

1. **Push your changes to the remote repository**:
   Use the following command to push your local commits to the GitHub repository:
   ```bash
   git push -u origin main
   ```
   If your default branch is `master`, replace `main` with `master`.

   You may be prompted to enter your GitHub username and password (or Personal Access Token if you have enabled two-factor authentication).

## Step 7: Verify Your Repository on GitHub

1. **Check your GitHub repository**:
   Go to your GitHub account and navigate to the repository you just pushed to. You should see all your project files uploaded.

## Conclusion

In this article, we covered the essential steps to push files to a GitHub repository using Git. By following these steps, you can easily manage your code and collaborate with others. If you have any questions or need further assistance, feel free to ask!

