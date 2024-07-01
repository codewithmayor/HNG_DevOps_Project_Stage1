# HNG DevOps Stage 1: Linux User Creation Bash Script

## Overview

Welcome to the DevOps Stage 1 task! This project involves creating a bash script called `create_users.sh` to automate the process of user and group creation on a Linux system. The script reads a text file containing employee usernames and group names, creates the users and groups as specified, sets up home directories with appropriate permissions, generates random passwords, and logs all actions.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Setup and Deployment](#setup-and-deployment)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
- [Contact](#contact)
- [License](#license)

## Features

- Automated user and group creation
- Home directory setup with appropriate permissions
- Random password generation
- Logging of all actions
- Secure storage of generated passwords

## Technologies Used

- Bash Script
- Linux (Ubuntu)

## Setup and Deployment

### Prerequisites

- Basic knowledge of Linux command line
- SSH client (e.g., Terminal on macOS, PuTTY on Windows)
- Knowlege of Bash scripting

### Installation

1. **Clone the Repository:**

    ```bash
    git clone https://github.com/codewithmayor/HNG_DevOps_Project_Stage1
    cd HNG_DevOps_Project_Stage1
    ```

2. **Save the Script:** Save the script as `create_users.sh`.

3. **Make the Script Executable:**

    ```bash
    chmod +x create_users.sh
    ```

4. **Prepare the Input File:** Create a file named `users.txt` with the desired content:

    ```txt
    light; sudo,dev,www-data
    idimma; sudo
    mayowa; dev,www-data
    ```

### Usage

1. **Run the Script:**

    ```bash
    sudo ./create_users.sh users.txt
    ```

2. **Check the Log File:** The log file should be located at `/var/log/user_management.log`.

    ```bash
    sudo cat /var/log/user_management.log
    ```

3. **Check the Password File:** The password file should be located at `/var/secure/user_passwords.txt`.

    ```bash
    sudo cat /var/secure/user_passwords.txt
    ```

## Contact

Name: Oluwamayowa Olawumi

Email: codewithmayor@gmail.com
