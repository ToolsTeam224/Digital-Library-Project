#!/bin/bash  

# Database file name
DB_FILE="library_db.txt"  # file where book records (title, author, category) are saved

# Folder to store the actual book content
BOOKS_DIR="books"  # directory where book content files will be stored

# Create the folder and file if they don't exist
mkdir -p "$BOOKS_DIR"  # Creates the "books" directory if it doesn't already exist (-p prevents errors)
touch "$DB_FILE"  # Creates an empty database file if it doesn't already exist

# Main menu function
main_menu() {           
    clear                      # Clear the terminal screen for a clean menu view
    echo ""               
    echo "╔════════════════════════════════════╗"
    echo "║   📖  Digital Library System       ║"
    echo "╚════════════════════════════════════╝"
    echo ""
    echo "1️⃣  User Access"     # Option 1 for normal users
    echo "2️⃣  Admin Access"    # Option 2 for admin login
    echo "3️⃣  Exit"            # Option 3 to exit the program
    echo ""
    read -p "Choose option [1-3]: " choice  # Ask the user to enter a number

    case $choice in         # Start a case statement to check the user's choice
        1) user_menu ;;     # If 1 is chosen, go to the user menu
        2) admin_login ;;   # If 2 is chosen, ask for admin login
        3) exit 0 ;;        # If 3 is chosen, exit the script
        *) echo -e "\n❌ Invalid option"; sleep 1; main_menu ;;  # If anything else is entered, show an error and show the menu again
    esac  # End of the case statement
}
