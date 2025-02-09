Use LibraryDB
GO
CREATE TRIGGER trg_BookIssued
ON Transactions
AFTER INSERT
AS
BEGIN
    DECLARE @BookID INT;

    SELECT @BookID = BookID
    FROM inserted;

    UPDATE Books
    SET CopiesAvailable = CopiesAvailable - 1
    WHERE BookID = @BookID;
END;
GO
