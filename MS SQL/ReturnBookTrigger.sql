USE LibraryDB;
GO
CREATE TRIGGER trg_BookReturned
ON Transactions
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Status = 'Returned')
    BEGIN
        DECLARE @BookID INT;

        SELECT @BookID = BookID
        FROM inserted;

        UPDATE Books
        SET CopiesAvailable = CopiesAvailable + 1
        WHERE BookID = @BookID;
    END
END;
GO
