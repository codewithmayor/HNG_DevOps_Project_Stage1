# HNG_DevOps_Project_Stage1


Sure, here's the README content formatted for easy copy-pasting:

DevOps Stage 1: Linux User Creation Bash Script
Overview
Welcome to the DevOps Stage 1 task! This project involves creating a bash script called create_users.sh to automate the process of user and group creation on a Linux system. The script reads a text file containing employee usernames and group names, creates the users and groups as specified, sets up home directories with appropriate permissions, generates random passwords, and logs all actions.

Table of Contents
Overview
Features
Technologies Used
Setup and Deployment
Prerequisites
Installation
Deployment
Contact
License
Features
Automated user and group creation
Home directory setup with appropriate permissions
Random password generation
Logging of all actions
Secure storage of generated passwords
Technologies Used
Bash Script
Linux (Ubuntu)
AWS EC2 (for deployment)
Setup and Deployment
Prerequisites
AWS account
Basic knowledge of Linux command line
SSH client (e.g., Terminal on macOS, PuTTY on Windows)
Installation
Clone the Repository:

bash
Copy code
git clone <repository-url>
cd <repository-directory>
Save the Script: Save the script as create_users.sh.

Make the Script Executable:

bash
Copy code
chmod +x create_users.sh
Prepare the Input File: Create a file named users.txt with the desired content:

txt
Copy code
light; sudo,dev,www-data
idimma; sudo
mayowa; dev,www-data
Deployment
Run the Script:

bash
Copy code
sudo ./create_users.sh users.txt
Check the Log File: The log file should be located at /var/log/user_management.log.

bash
Copy code
sudo cat /var/log/user_management.log
Check the Password File: The password file should be located at /var/secure/user_passwords.csv.

bash
Copy code
sudo cat /var/secure/user_passwords.csv
Contact
Name: Oluwamayowa Olawumi
