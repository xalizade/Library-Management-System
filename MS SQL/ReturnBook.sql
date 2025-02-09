CREATE PROCEDURE ReturnBook
    @TransactionID INT,
    @ReturnDate DATE
AS
BEGIN
    BEGIN TRY
        -- Check if the transaction exists and is not already returned
        IF EXISTS (SELECT 1 FROM Transactions WHERE TransactionID = @TransactionID AND Status != 'Returned')
        BEGIN
            -- Update the return date and change the status to 'Returned'
            UPDATE Transactions 
            SET ReturnDate = @ReturnDate, Status = 'Returned'
            WHERE TransactionID = @TransactionID;

            -- Declare variable to store BookID
            DECLARE @BookID INT;
            SELECT @BookID = BookID FROM Transactions WHERE TransactionID = @TransactionID;

            -- Update the Books table to increase available copies
            UPDATE Books 
            SET CopiesAvailable = CopiesAvailable + 1 
            WHERE BookID = @BookID;

            PRINT 'The book has been successfully returned.';
        END
        ELSE
        BEGIN
            PRINT 'Transaction not found or the book has already been returned.';
        END
    END TRY
    BEGIN CATCH
        -- Rollback and catch any errors
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
