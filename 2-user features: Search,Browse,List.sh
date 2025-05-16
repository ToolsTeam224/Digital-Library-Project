# Search books by title, author, or content
search_books() {
    clear
    echo ""
    echo "╔═══════════════════╗"
    echo "║ 🔍 Search Books   ║"
    echo "╚═══════════════════╝"
    echo ""
    echo "1️⃣  Search by Title"       # Search using book title
    echo "2️⃣  Search by Author"      # Search using author name
    echo "3️⃣  Search in Content"     # Search inside the text of book files
    echo "4️⃣  Back to User Menu"     # Go back to user menu
    echo ""
    read -p "Choose option [1-4]: " choice  # Take user input

    case $choice in
        1) read -p "Enter title: " term;	# Ask for title keyword
           echo "";
           grep -i "$term" "$DB_FILE"		# Search (case-insensitive) in database for title
           ;;
        2) read -p "Enter author: " term;	# Ask for author name
           echo "";
           grep -i "$term" "$DB_FILE"		# Search in the database
           ;;
        3) read -p "Search in content: " term	# Ask for keyword to search inside books
           echo -e "\nMatching books:"
           grep -il "$term" "$BOOKS_DIR"/*.txt 2>/dev/null | while read -r file; do
           basename "${file%.*}" # Show file name without path and extension
           done
           ;;
        4) user_menu ;;				# Go back to user menu
        *) echo -e "\n❌ Invalid option"; sleep 1; search_books ;;# Invalid input
    esac
    echo ""
    echo "📘 Do you want to view a book's content?" # Ask if the user wants to open the book
    read -p "Enter y/n: " viewChoice	# Read the user response
    if [[ "$viewChoice" =~ ^[Yy]$ ]]; then # iF User type y or Y, proceed to read the book
        read_book; # If yes, call the function to read the book
    fi 
    echo ""
    read -p "🔁 Press Enter to return to the menu..." dummy # Wait for Enter to return
    user_menu	# Back to user menu
}

# Browse books by category
browse_category() {
    clear  # Clear the screen
    echo ""
    echo "╔═════════════════════╗"
    echo "║ 📚 Categories List  ║"
    echo "╚═════════════════════╝"
    echo ""
    
    # Show unique categories from the database
    cut -d',' -f3 "$DB_FILE" | sort | uniq
    # cut -d',' -f3: extract the 3rd column (category) using comma as separator
    # sort: sort the list
    # uniq: remove duplicates (only show unique category names)

    echo ""
    read -p "Enter category name: " category		# Ask user to enter a category
    echo -e "\n📗 Books in '$category':"
    grep -i "$category" "$DB_FILE"			# Show all books that match the category (case-insensitive)

    echo ""
    echo "📘 Do you want to view a book's content?"	# Ask if they want to open a book
    read -p "Enter y/n: " viewChoice
    if [[ "$viewChoice" =~ ^[Yy]$ ]]; then
        read_book;  # Call the read_book function if answer is yes
    fi 
    echo ""
    read -p "🔁 Press Enter to return to the menu..." dummy	# Pause before returning
    user_menu	# Go back to the user menu
}
