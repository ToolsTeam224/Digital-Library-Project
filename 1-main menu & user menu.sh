#!/bin/bash

# Define database and resource file paths
DB_FILE="library_db.txt" # file where book records (title, author, category) are saved
BOOKS_DIR="books" # directory where book content files will be stored
USERS_FILE="users.txt" # file where users information (user name, passward) are saved
ADMIN_PASS_FILE="admin_pass.txt" # file where admin updated passward is saved

# Ensure the necessary files and directories exist
mkdir -p "$BOOKS_DIR" # Creates the "books" directory if it doesn't already exist (-p prevents errors)
touch "$DB_FILE" # Creates an empty database file if it doesn't already exist
touch "$USERS_FILE" # Creates an empty database file if it doesn't already exist
[[ ! -f "$ADMIN_PASS_FILE" ]] && echo "admin123" > "$ADMIN_PASS_FILE"  # Default admin password file initialization if missing

# Displays the main menu to the user
main_menu() {
    clear      # Clear the terminal screen for a clean menu view
    echo ""
    echo "╔════════════════════════════════════╗"
    echo "║   📖  Digital Library System       ║"
    echo "╚════════════════════════════════════╝"
    echo ""
    echo "1️⃣  User Login / Sign Up"  # Option 1 for users
    echo "2️⃣  Admin Access"   # Option 2 for admin login
    echo "3️⃣  Exit"    # Option 3 to exit the script/program
    echo ""
    read -p "Choose option [1-3]: " choice # Prompt user to select an option

    case $choice in
        1)
            echo ""
            echo "1. Login"   # User selects login
            echo "2. Create Account"  # User selects account creation
            read -p "Choose option [1-2]: " opt 
            if [ "$opt" = "1" ]; then
                user_login    # Call user login function if option 1 chosen
            else
                create_account   # Call create account function if option 2 chosen
            fi
            ;;
        2) admin_login ;;   # Call admin login function (assumed implemented elsewhere)
        3) exit 0 ;;        # Exit the script with status 0 (successful exit)
        *) echo -e "\n❌ Invalid option"; sleep 1; main_menu ;;  # Handle invalid input by retrying
    esac
}


# User login process
user_login() {
    clear     # Clear the screen for a fresh login prompt
    echo "🔐 User Login"   
    echo "=============="
    read -p "Username: " username  # Read the username input
    read -sp "Password: " password  # Read the password input silently (no echo)
    echo ""
    if grep -q "^$username:$password$" "$USERS_FILE"; then  # Check if username and password match in users file
        echo "✅ Login successful!"
        sleep 1
        user_menu   # Proceed to user menu after successful login
    else
        echo "❌ Invalid credentials!"   # Notify user of wrong login
        sleep 1
        main_menu   # Return to main menu for retry or other actions
    fi
}

# Create a new user account
create_account() {
    clear
    echo "🆕 Create Account"
    echo "================="
    read -p "Choose username: " username   # Ask for new username
    if grep -q "^$username:" "$USERS_FILE"; then  # Check if username already exists
        echo "❌ Username already exists!"
        sleep 1
        main_menu    # Return to main menu if username is taken
        return
    fi
    read -sp "Choose password: " password   # Ask for new password silently
    echo ""
    echo "$username:$password" >> "$USERS_FILE"   # Append new user credentials to users file
    echo "✅ Account created!"
    sleep 1
    main_menu   # Return to main menu after successful account creation
}

# User menu options
user_menu() {
    clear     # Clear the screen to show user menu
    echo ""
    echo "╔════════════════╗"
    echo "║ 👤 User Menu   ║"
    echo "╚════════════════╝"
    echo ""
    echo "1️⃣  Search Books"   # Option to search for books by title or author
    echo "2️⃣  Browse by Category"  # Option to browse books filtered by category
    echo "3️⃣  List All Books"   # Option to display all books in the database
    echo "4️⃣  Logout (Back to Main Menu)" # Option to logout and return to main menu
    echo ""
    read -p "Choose option [1-4]: " choice   # Prompt user to select an option

    case $choice in
        1) search_books ;;   # Call function to search books (assumed implemented)
        2) browse_category ;;   # Call function to browse by category (assumed implemented)
        3) list_books ;;   # Call function to list all books (assumed implemented)
        4) main_menu ;;    # Logout and return to main menu
        *) echo -e "\n❌ Invalid option"; sleep 1; user_menu ;; # Handle invalid input and retry
    esac
}
