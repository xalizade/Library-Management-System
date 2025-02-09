USE LibraryDB;
GO

CREATE PROCEDURE GetAllTransactions
AS
BEGIN
    SELECT 
        T.TransactionID,
        U.Name AS UserName,
        B.Title AS BookTitle,
        T.IssueDate,
        T.DueDate,
        T.ReturnDate,
        T.Status
    FROM Transactions T
    JOIN Users U ON T.UserID = U.UserID
    JOIN Books B ON T.BookID = B.BookID
    ORDER BY T.IssueDate DESC;
END;
GO