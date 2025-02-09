CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    Role NVARCHAR(10) CHECK (Role IN ('Admin', 'Client')) NOT NULL
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255) NOT NULL,
    Author NVARCHAR(255) NOT NULL,
    Genre NVARCHAR(50),
    CopiesAvailable INT CHECK (CopiesAvailable >= 0) NOT NULL
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    BookID INT FOREIGN KEY REFERENCES Books(BookID),
    IssueDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    Status NVARCHAR(10) CHECK (Status IN ('Issued', 'Returned')) NOT NULL
);
