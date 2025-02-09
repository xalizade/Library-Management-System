import os
import pyodbc
import hashlib

# Database connection details
DB_DRIVER = os.getenv('DB_DRIVER', '{SQL Server}')
DB_SERVER = os.getenv('DB_SERVER', 'DESKTOP-R59TVT0')
DB_NAME = os.getenv('DB_NAME', 'LibraryDB')

conn = pyodbc.connect(f'DRIVER={DB_DRIVER};SERVER={DB_SERVER};DATABASE={DB_NAME};')
cursor = conn.cursor()
def register_user():
    """Register a new user."""
    name = input("Enter your name: ").strip()
    email = input("Enter your email: ").strip()
    password = input("Enter your password: ").strip()
    role = input("Enter role (Admin/Client): ").strip()

    if not (name and email and password and role):
        print("All fields are required.")
        return

    if role not in ["Admin", "Client"]:
        print("Invalid role. Please enter 'Admin' or 'Client'.")
        return

    hashed_password = hashlib.sha256(password.encode()).hexdigest()
    try:
        cursor.execute("EXEC RegisterUser ?, ?, ?, ?", name, email, hashed_password, role)
        conn.commit()
        print("Registration successful!")
    except pyodbc.Error as e:
        print(f"Error during registration: {e}")

def login_user():
    """Log in an existing user."""
    email = input("Enter your email: ").strip()
    password = input("Enter your password: ").strip()

    if not (email and password):
        print("Both email and password are required.")
        return None, None

    hashed_password = hashlib.sha256(password.encode()).hexdigest()
    try:
        cursor.execute("EXEC LoginUser ?, ?", email, hashed_password)
        result = cursor.fetchone()
        if result:
            user_id, name, role = result
            print(f"Welcome {name}! You are logged in as {role}.")
            return user_id, role
        else:
            print("Invalid email or password.")
    except pyodbc.Error as e:
        print(f"Error during login: {e}")
    return None, None

def add_book():
    """Add a new book to the library."""
    title = input("Enter the book title: ").strip()
    author = input("Enter the book author: ").strip()
    genre = input("Enter the book genre: ").strip()
    copies_available = input("Enter the number of copies available: ").strip()

    if not (title and author and genre and copies_available):
        print("All fields are required.")
        return

    try:
        copies_available = int(copies_available)
        cursor.execute("EXEC AddBook ?, ?, ?, ?", title, author, genre, copies_available)
        conn.commit()
        print("Book added successfully!")
    except ValueError:
        print("Copies available must be a number.")
    except pyodbc.Error as e:
        print(f"Error while adding a book: {e}")

def delete_book():
    """Delete a book from the library."""
    book_id = input("Enter the Book ID to delete: ").strip()

    if not book_id.isdigit():
        print("Invalid Book ID.")
        return

    try:
        cursor.execute("EXEC DeleteBook ?", int(book_id))
        conn.commit()
        print("Book deleted successfully!")
    except pyodbc.Error as e:
        print(f"Error while deleting a book: {e}")

def search_book():
    keyword = input("Enter a keyword to search for books: ").strip()
    
    # Modify the query to use the newly created function `fn_SearchBooks`
    query = "SELECT * FROM fn_SearchBooks(?)"
    
    # Execute the query with the keyword parameter
    cursor.execute(query, (keyword,))
    
    # Fetch and display the results
    books = cursor.fetchall()
    
    if books:
        print("\nSearch Results:")
        print(f"{'Book ID':<10} {'Title':<40} {'Author':<30} {'Genre':<20} {'Copies Available':<15}")
        print("-" * 115)
        
        for book in books:
            book_id, title, author, genre, copies_available = book
            print(f"{book_id:<10} {title:<40} {author:<30} {genre:<20} {copies_available:<15}")
    else:
        print("No books found matching the keyword.")


def view_books():
    """View all available books."""
    try:
        cursor.execute("EXEC ViewBooks")
        
        books = cursor.fetchall()
        
        
        if books:
            print("\nAvailable Books:")
            for book in books:
                print(f"{book[0]:<10} {book[1]:<30} {book[2]:<20} {book[3]:<15} {book[4]:<15}")
        else:
            print("No books available.")
    except pyodbc.Error as e:
        print(f"Error while viewing books: {e}")

def view_user_transactions(user_id):
    """
    View transaction history for a specific user.
    """
    try:
        # Call the stored procedure
        cursor.execute("EXEC GetUserTransactions @UserID = ?", user_id)
       
        transactions = cursor.fetchall()

        # Check if there are any transactions
        if transactions:
            print("\nYour Transaction History:")
            print(f"{'Transaction ID':<15} {'Book Title':<30} {'Issue Date':<15} {'Due Date':<15} {'Return Date':<15} {'Status':<10}")
            print("-" * 100)

            # Display each transaction
            for transaction in transactions:
                transaction_id, book_title, issue_date, due_date, return_date, status = transaction
                print(f"{transaction_id:<15} {book_title:<30} {issue_date:<15} {due_date:<15} {return_date or 'Not Returned':<15} {status:<10}")
        else:
            print("\nNo transactions found.")
    except Exception as e:
        print(f"An error occurred while fetching transactions: {e}")


def issue_book(user_id):
    """
    Issue a book to a user by their ID.
    """
    try:
        book_id = int(input("Enter the Book ID to issue: "))
        issue_date = input("Enter the issue date (YYYY-MM-DD): ")
        due_date = input("Enter the due date (YYYY-MM-DD): ")

        cursor.execute("EXEC IssueBook ?, ?, ?, ?", user_id, book_id, issue_date, due_date)
        conn.commit()
        print("Book issued successfully.")
    except Exception as e:
        print(f"An error occurred while issuing the book: {e}")


def return_book(user_id):
    """
    Return a book based on a transaction ID.
    """
    try:
        transaction_id = int(input("Enter the Transaction ID to return the book: "))
        return_date = input("Enter the return date (YYYY-MM-DD): ")

        cursor.execute("EXEC ReturnBook ?, ?", transaction_id, return_date)
        conn.commit()
        print("Book returned successfully.")
    except Exception as e:
        print(f"An error occurred while returning the book: {e}")


def view_all_transactions():
    """
    View all transactions in the library system.
    """
    try:
        # Execute the stored procedure
        cursor.execute("SELECT * FROM vw_AllTransactions")
       
        transactions = cursor.fetchall()

        # Check if there are any transactions
        if transactions:
            print("\nAll Transactions:")
            print(f"{'Transaction ID':<15} {'User Name':<20} {'Book Title':<30} {'Issue Date':<15} {'Due Date':<15} {'Return Date':<15} {'Status':<10}")
            print("-" * 120)

            # Display each transaction
            for transaction in transactions:
                transaction_id, user_name, book_title, issue_date, due_date, return_date, status = transaction
                print(f"{transaction_id:<15} {user_name:<20} {book_title:<30} {issue_date:<15} {due_date:<15} {return_date or 'Not Returned':<15} {status:<10}")
        else:
            print("\nNo transactions found.")
    except Exception as e:
        print(f"An error occurred while fetching transactions: {e}")


def admin_menu():
    """Display the admin menu."""
    options = {
        "1": ("Add a Book", lambda: add_book()),
        "2": ("Delete a Book", lambda: delete_book()),
        "3": ("Search for a Book", lambda: search_book()),
        "4": ("View All Books", lambda: view_books()),
        "5": ("View All Transactions", lambda: view_all_transactions()),
        "6": ("Logout", None)
    }
    
    while True:
        print("\nAdmin Menu:")
        for key, (desc, _) in options.items():
            print(f"{key}. {desc}")
        
        choice = input("Enter your choice: ")
        if choice in options:
            if choice == "6":  # Logout
                print("Logging out... Good Bye!")
                break
            options[choice][1]()
        else:
            print("Invalid choice. Please try again.")

def client_menu(user_id):
    """
    Display the client menu and handle user actions.
    """
    while True:
        # Display menu options
        print("\nClient Menu:")
        print("1. View Available Books")
        print("2. Search for a Book")
        print("3. Issue a Book")
        print("4. Return a Book")
        print("5. View My Transactions")
        print("6. Logout")
        
        # Get the user's choice
        choice = input("\nEnter your choice (1-6): ").strip()

        # Process the user's choice
        if choice == "1":
            view_books()  # Call the function to view available books
        elif choice == "2":
            search_book()  # Call the function to search for a book
        elif choice == "3":
            issue_book(user_id)  # Pass user_id to issue a book
        elif choice == "4":
            return_book(user_id)  # Pass user_id to return a book
        elif choice == "5":
            view_user_transactions(user_id)  # Pass user_id and cursor to view transactions
        elif choice == "6":
            print("Logging out... Goodbye!")
            break  # Exit the loop and logout
        else:
            print("Invalid choice. Please try again.")  # Handle invalid input


def main():
    """Main program entry point."""
    try:
        with conn.cursor() as cursor:
            while True:
                print("\nWelcome to the Library System!")
                print("1. Login")
                print("2. Register")
                print("3. Exit")

                choice = input("Enter your choice: ").strip()
                if choice == "1":
                    user_id, role = login_user()
                    if role == "Admin":
                        admin_menu()
                    elif role == "Client":
                        client_menu( user_id)
                elif choice == "2":
                    register_user()
                elif choice == "3":
                    print("Exiting...")
                    break
                else:
                    print("Invalid choice. Please try again.")
    finally:
        conn.close()

if __name__ == "__main__":
    main()
