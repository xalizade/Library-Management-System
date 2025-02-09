Use LibraryDB;
GO

CREATE PROCEDURE GetUserTransactions
    @UserID INT
AS
BEGIN
    SELECT 
        T.TransactionID,
        B.Title AS BookTitle,
        T.IssueDate,
        T.DueDate,
        T.ReturnDate,
        T.Status
    FROM Transactions T
    JOIN Books B ON T.BookID = B.BookID
    WHERE T.UserID = @UserID
    ORDER BY T.IssueDate DESC;
END;
GO