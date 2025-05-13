# User menu function
user_menu() {
    clear    # Clear the screen
    echo ""
    echo "╔════════════════╗"
    echo "║ 👤 User Menu   ║"
    echo "╚════════════════╝"
    echo ""
    echo "1️⃣  Search Books"          # Option to search books
    echo "2️⃣  Browse by Category"    # Option to list books by category
    echo "3️⃣  List All Books"        # Option to show all books
    echo "4️⃣  Back to Main Menu"     # Option to return to the main menu
    echo ""
    read -p "Choose option [1-4]: " choice  # Ask user to pick an option

    case $choice in
        1) search_books ;;            # Call the search_books function
        2) browse_category ;;         # Call the browse_category function
        3) list_books ;;              # Call the list_books function
        4) main_menu ;;               # Return to the main menu
        *) echo -e "\n❌ Invalid option"; sleep 1; user_menu ;;  # Handle invalid input
    esac
}
