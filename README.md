# Library Management System

## Description
This Library Management System is a terminal-based application built using **Python** and **MS SQL Server**. It provides a database-driven system for managing books in a library, with two user roles:
- **Admin**: Can add, delete, and search books.
- **Client (User)**: Can view available books, borrow books, and return books.

## Features
- **User Authentication**: Secure login and registration system with hashed passwords.
- **Admin Functionalities**:
  - Add new books to the library.
  - Remove books from the system.
  - Search books by title, author, or genre.
- **Client Functionalities**:
  - View available books.
  - Borrow books.
  - Return books.

## Technologies Used
- **Backend**: MS SQL Server (Stored Procedures for database operations)
- **Frontend**: Python (Terminal-based interface)
- **Libraries Used**:
  - `pyodbc` for database connection
  - `hashlib` for password hashing
  - `os` for environment variable management

## Installation
### Prerequisites
- Python 3.8+
- MS SQL Server installed and running
- Required Python packages:
  ```sh
  pip install pyodbc
  ```

### Database Setup
1. Create a new database in MS SQL Server.
2. Run the provided SQL script (`library_management.sql`) to create tables and stored procedures.
3. Update the `config.py` file with your database credentials.

### Running the Application
1. Clone the repository:
   ```sh
   git clone https://github.com/xalizade/library-management-system.git
   ```
2. Navigate to the project folder:
   ```sh
   cd library-management-system
   ```
3. Run the application:
   ```sh
   python main.py
   ```

## Usage
- **Admins** can log in with their credentials and manage books.
- **Clients** can sign up, log in, and borrow/return books.

## Future Enhancements
- Implement a GUI version using Tkinter or PyQt.
- Add email notifications for due dates.
- Improve security with role-based access control.

## Contributing
If you want to contribute, feel free to fork the repository and submit a pull request!


