#!/usr/bin/env bash

LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.txt"
USER_FILE="$1"

# Create log and password files with appropriate permissions 
sudo touch $LOG_FILE
sudo chmod 600 $LOG_FILE
sudo chown root:root $LOG_FILE

sudo mkdir -p /var/secure
sudo touch $PASSWORD_FILE
sudo chmod 600 $PASSWORD_FILE
sudo chown root:root $PASSWORD_FILE

# Log a message
log_action() {
    echo "$(date): $1" | sudo tee -a $LOG_FILE
}

# Generate a random password
generate_password() {
    < /dev/urandom tr -dc A-Za-z0-9 | head -c12
}

# Add user and groups
add_user_and_groups() {
    IFS=";" read -r username groups <<< "$1"
    username=$(echo "$username" | xargs)  # Trim whitespace
    groups=$(echo "$groups" | xargs | sed 's/ //g')  # Trim whitespace and remove spaces between group names

    if id "$username" &>/dev/null; then
        log_action "User $username already exists"
        return
    fi

    sudo useradd -m "$username"
    sudo usermod -aG "$username" "$username"  # Create and add to personal group

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

# Main script
if [ -z "$USER_FILE" ]; then
    echo "Usage: $0 <user_file>"
    exit 1
fi

if [ ! -f "$USER_FILE" ]; then
    echo "File $USER_FILE does not exist."
    exit 1
fi

while IFS= read -r line; do
    if [[ -n "$line" ]]; then
        add_user_and_groups "$line"
    fi
done < "$USER_FILE"

log_action "User creation process completed"

