ALTER PROCEDURE ViewBooks
AS
BEGIN
    BEGIN TRY
        -- Select BookID along with Title, Author, Genre, and CopiesAvailable
        SELECT BookID, Title, Author, Genre, CopiesAvailable
        FROM Books
        WHERE CopiesAvailable > 0;

        -- Provide feedback if no books are available
        IF @@ROWCOUNT = 0
        BEGIN
            PRINT 'No books are currently available for borrowing.';
        END
    END TRY
    BEGIN CATCH
        -- Handle any errors
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
