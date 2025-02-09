CREATE PROCEDURE IssueBook
    @UserID INT,
    @BookID INT,
    @IssueDate DATE,
    @DueDate DATE
AS
BEGIN
    BEGIN TRY
        -- Check if the book is available
        IF EXISTS (SELECT 1 FROM Books WHERE BookID = @BookID AND CopiesAvailable > 0)
        BEGIN
            -- Begin the transaction to ensure atomicity
            BEGIN TRANSACTION;

            -- Insert the transaction into the Transactions table
            INSERT INTO Transactions (UserID, BookID, IssueDate, DueDate, Status)
            VALUES (@UserID, @BookID, @IssueDate, @DueDate, 'Issued');

            -- Update the Books table to reduce the number of available copies
            UPDATE Books SET CopiesAvailable = CopiesAvailable - 1 WHERE BookID = @BookID;

            -- Commit the transaction
            COMMIT;

            PRINT 'The book has been successfully issued.';
        END
        ELSE
        BEGIN
            PRINT 'The book is not available for issuing.';
        END
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if there is an error
        ROLLBACK;

        -- Handle the error and print a message
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
