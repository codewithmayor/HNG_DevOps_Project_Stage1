# HNG_DevOps_Project_Stage1

User Creation Script - DevOps Stage 1
Overview
This repository contains a bash script, create_users.sh, designed to automate the creation of users and groups on a Linux system. This script is particularly useful for SysOps engineers who need to manage multiple user accounts efficiently.

Task Description
As a SysOps engineer, you are tasked with creating a bash script to read a text file containing usernames and groups, create the users and their respective groups, generate random passwords, and log all actions. This script will ensure that each user has a personal group and can belong to multiple specified groups.

Requirements
Each user must have a personal group with the same name as the username.
Users can belong to multiple groups, each group delimited by a comma ",".
Usernames and user groups are separated by a semicolon ";".
Ignore whitespace in the input file.
Example Input File
kotlin
Copy code
light; sudo,dev,www-data
idimma; sudo
mayowa; dev,www-data
Script Functionality
The script performs the following actions:

Reads Input File: Reads a file containing usernames and groups.
Creates Users and Groups: Creates users and their personal groups, assigns additional groups.
Generates Random Passwords: Generates random passwords for each user.
Logs Actions: Logs all actions to /var/log/user_management.log.
Stores Passwords Securely: Stores the generated passwords in /var/secure/user_passwords.csv.
File Structure
create_users.sh: The main script to create users and groups.
users.txt: A sample input file containing usernames and groups.
Prerequisites
Ensure you have root or sudo privileges to execute user and group management commands.
The system should have useradd, usermod, and groupadd commands available.
Usage
1. Clone the Repository
bash
Copy code
git clone https://github.com/yourusername/user-creation-script.git
cd user-creation-script
2. Make the Script Executable
bash
Copy code
chmod +x create_users.sh
3. Prepare the Input File
Create a text file users.txt with the following format:

Copy code
username; group1,group2,group3
4. Run the Script
bash
Copy code
sudo ./create_users.sh users.txt
5. Verify the Logs and Password File
Check the log file at /var/log/user_management.log for a record of actions.
Check the password file at /var/secure/user_passwords.csv for generated passwords.
Script Explanation
Logging Function
Logs messages with timestamps to /var/log/user_management.log.

bash
Copy code
log_action() {
    echo "$(date): $1" | sudo tee -a $LOG_FILE
}
Password Generation
Generates a secure, random 12-character password.

bash
Copy code
generate_password() {
    echo $(< /dev/urandom tr -dc A-Za-z0-9 | head -c12)
}
Adding Users and Groups
Processes each line of the input file, creates users, assigns groups, and sets passwords.

bash
Copy code
add_user_and_groups() {
    IFS=";" read -r username groups <<< "$1"
    username=$(echo $username | xargs)
    groups=$(echo $groups | xargs | sed 's/ //g')

    if id "$username" &>/dev/null; then
        log_action "User $username already exists"
        return
    fi

    sudo useradd -m "$username"
    sudo usermod -aG "$username" "$username"

    IFS="," read -r -a group_array <<< "$groups"
    for group in "${group_array[@]}"; do
        if ! getent group "$group" > /dev/null; then
            sudo groupadd "$group"
        fi
        sudo usermod -aG "$group" "$username"
    done

    password=$(generate_password)
    echo "$username:$password" | sudo tee -a $PASSWORD_FILE
    echo "$username:$password" | sudo chpasswd
    log_action "Created user $username with groups: $groups and password: $password"
}
Error Handling
The script checks for existing users and logs an appropriate message.

Security Considerations
The password file /var/secure/user_passwords.csv is created with restricted permissions to ensure only the root user can read it.
The log file /var/log/user_management.log is created with restricted permissions to ensure only the root user can read it.
Technical Article
Read the detailed technical article explaining the script implementation and logic on My Tech Blog.

Learn More
To learn more about the HNG Internship, visit HNG Internship, HNG Hire, or HNG Premium.

Conclusion
This script provides a robust and efficient way to manage user accounts and groups in a Linux environment, automating tasks that would otherwise be time-consuming and error-prone. By following the instructions and understanding the script's logic, SysOps engineers can ensure secure and consistent user management.
