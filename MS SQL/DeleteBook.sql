CREATE PROCEDURE DeleteBook
    @BookID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the book exists
        IF NOT EXISTS (SELECT 1 FROM Books WHERE BookID = @BookID)
        BEGIN
            PRINT 'The book with the specified ID does not exist.';
            RETURN;  -- Exit the procedure if the book does not exist
        END

        -- Begin a transaction to ensure atomicity
        BEGIN TRANSACTION;

        -- Delete the book
        DELETE FROM Books WHERE BookID = @BookID;

        -- Commit the transaction
        COMMIT;

        PRINT 'The book has been successfully deleted.';
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if there is an error
        ROLLBACK;

        -- Handle the error and print a message
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
