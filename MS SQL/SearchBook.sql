CREATE PROCEDURE SearchBook
    @Keyword NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        -- Search for books by title, author, or genre
        SELECT * 
        FROM Books
        WHERE Title LIKE '%' + @Keyword + '%'
           OR Author LIKE '%' + @Keyword + '%'
           OR Genre LIKE '%' + @Keyword + '%';

        -- If no rows were returned, provide feedback
        IF @@ROWCOUNT = 0
        BEGIN
            PRINT 'No books found matching the search criteria.';
        END
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
