# List all books in the database
list_books() {
    clear							# Clear the screen
    echo ""							# New line
    echo "╔═════════════════════╗"
    echo "║  📚 All Books List  ║"
    echo "╚═════════════════════╝"
    echo ""
    cat "$DB_FILE"			# Print the full database content (title, author, category for each book)
    echo ""
    read -p "🔁 Press Enter to return to the menu..."	        # Wait for Enter to return
    user_menu							# Back to user menu
}

# Second, Admin Access
# Admin login process
admin_login() {
    clear							# Clear the screen
    echo "🔐 Admin Login"
    echo "=============="
    read -sp "Enter admin password: " password			# -s hides input, -p shows the prompt
    echo ""
    stored_pass=$(<"$ADMIN_PASS_FILE")				# < reads the file content directly
    if [ "$password" != "$stored_pass" ]; then			# Check if password is incorrect
        echo -e "\n❌ Access denied!"				# Show error message, -e enables interpretation of escape sequences like \n
        sleep 1							# Pause the script for 1 second
        main_menu						# Go back to the main menu
    else
        admin_menu						# If correct password, go to admin menu
    fi
}

# Admin menu options
admin_menu() {
    clear					# Clear the screen
    echo ""
    echo "╔════════════════╗"
    echo "║ 🔒 Admin Menu  ║"
    echo "╚════════════════╝"
    echo ""
    echo "1️⃣  Add Book"             		# Add a new book
    echo "2️⃣  Delete Book"          		# Remove a book
    echo "3️⃣  View Database"        		# View all book records
    echo "4️⃣  Change Admin Password"		# Change the password in the file
    echo "5️⃣  Back to Main Menu"		# Return to main menu
    echo ""
    read -p "Choose option [1-5]: " choice

    case $choice in
        1) add_book ;;                     	# Call function to add a book
        2) delete_book ;;                	# Call function to delete a book
        3) view_database ;;                 	# Call function to view database
        4) change_admin_password ;;	    	# Call function to change password
        5) main_menu ;;                     	# Return to main menu
        *) echo -e "\n❌ Invalid option"; sleep 1; admin_menu ;;	# Handle wrong input
    esac
}
