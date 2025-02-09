USE LibraryDB;
GO
CREATE PROCEDURE AddBook
    @Title NVARCHAR(255),
    @Author NVARCHAR(255),
    @Genre NVARCHAR(50),
    @CopiesAvailable INT
AS
BEGIN
    BEGIN TRY
        -- Check if the book already exists
        IF EXISTS (
            SELECT 1
            FROM Books
            WHERE Title = @Title AND Author = @Author
        )
        BEGIN
            PRINT 'The book already exists in the database.';
            RETURN; -- Exit the procedure if the book exists
        END

        -- Insert the book into the database
        INSERT INTO Books (Title, Author, Genre, CopiesAvailable)
        VALUES (@Title, @Author, @Genre, @CopiesAvailable);

        PRINT 'The book has been successfully added.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
