#!/bin/bash
# user_management.sh - Automates user creation, deletion, and password reset
# Usage: sudo ./user_management.sh

function create_user() {
    read -p "Enter username to create: " USERNAME
    sudo adduser "$USERNAME"
}

function delete_user() {
    read -p "Enter username to delete: " USERNAME
    sudo deluser "$USERNAME"
}

function reset_password() {
    read -p "Enter username to reset password: " USERNAME
    sudo passwd "$USERNAME"
}

while true; do
    echo "User Management Menu:"
    echo "1) Create User"
    echo "2) Delete User"
    echo "3) Reset Password"
    echo "4) Exit"
    read -p "Choose an option: " CHOICE
    case $CHOICE in
        1) create_user ;;
        2) delete_user ;;
        3) reset_password ;;
        4) exit 0 ;;
        *) echo "Invalid option." ;;
    esac
done 