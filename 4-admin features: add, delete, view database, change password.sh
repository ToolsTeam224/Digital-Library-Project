# Function to add a new book to the system
add_book() {
    clear					# Clear the screen
    echo ""
    echo "➕ Add New Book"
    echo "==============="
    echo ""
    read -p "Title: " title
    read -p "Author: " author
    read -p "Category: " category
    
    # Create book file with title (spaces replaced with underscores)
    book_file="${BOOKS_DIR}/${title// /_}.txt"
    touch "$book_file"
    echo -e "\n✍️  Enter book content (Ctrl+D to save):"
    cat > "$book_file"
    # The user can now type the book content directly into the terminal.
    # Pressing Ctrl+D ends the input and saves it to the file.
    
    # Add book data to the database
    echo "$title,$author,$category" >> "$DB_FILE"
    echo -e "\n✅ Book added successfully!"
    sleep 1
    admin_menu	# Return to the admin menu
}

# Admin deletes a book
delete_book() {
    clear					# Clear the screen
    echo ""
    echo "❌ Delete Book"
    echo "=============="
    echo ""
    read -p "Enter book title to delete: " title
    
    # Remove book entry from the database (if it exists)
    sed -i "/$title/d" "$DB_FILE" 2>/dev/null
    # sed -i: edit the file in-place
    # "/$title/d": delete the line that contains the title
    
    rm -f "${BOOKS_DIR}/${title// /_}.txt" 2>/dev/null
    # -f: force delete without showing error if file doesn't exist
    
    echo -e "\n🗑️  Book deleted if it existed."
    sleep 1
    admin_menu	# Return to admin menu
}

# Admin views the raw database
view_database() {
    clear					# Clear the screen
    echo ""
    echo "📋 Database Contents"
    echo "===================="
    echo ""
    cat "$DB_FILE"				# Show all lines in the database (one line per book)
    echo ""
    read -p "🔁 Press Enter to return to the menu..." dummy
    admin_menu		# Return to admin menu
}

# Function to display the content of a specific book
read_book() {
    clear					# Clear the screen
    echo ""
    echo "📖 Read a Book"
    echo "=============="
    echo ""
    
    # Ask the user for the book title
    read -p "Enter title: " title
    
    # Create the file path based on the title (spaces replaced with underscores)
    book_file="${BOOKS_DIR}/${title// /_}.txt"
    if [ -f "$book_file" ]; then
        echo ""
        echo "➡️  Use ↑ ↓ or PgUp/PgDn to scroll."
        echo "➡️  Press 'q' to stop reading and return."
        sleep 2
        
        # Display the book content using the "less" command (for easy scrolling)
        less "$book_file"
    else
    	# If the book file doesn't exist, show an error message
        echo -e "\n❌ Book not found!"
        sleep 1
    fi
    echo ""
    read -p "🔁 Press Enter to return to the menu..." dummy
    user_menu	# Return to user menu
}

# Change the admin password
change_admin_password() {
    echo ""
    read -sp "Enter current password: " current
    echo ""
    stored_pass=$(<"$ADMIN_PASS_FILE")
    if [ "$current" != "$stored_pass" ]; then
        echo "❌ Incorrect current password."
    else
        read -sp "Enter new password: " newpass
        echo ""
        echo "$newpass" > "$ADMIN_PASS_FILE"
        echo "✅ Password changed successfully."
    fi
    sleep 1.5
    admin_menu
}
# Load all required scrips
source ./'1-main menu & user menu.sh'
source ./'2-user features: Search,Browse,List.sh'
source ./'3-admin login & admin menu.sh'

# Start the program
main_menu
