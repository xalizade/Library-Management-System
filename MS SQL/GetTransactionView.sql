CREATE VIEW vw_AllTransactions AS
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
JOIN Books B ON T.BookID = B.BookID;
GO
