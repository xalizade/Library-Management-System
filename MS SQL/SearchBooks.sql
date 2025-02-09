CREATE FUNCTION fn_SearchBooks (@Keyword NVARCHAR(255))
RETURNS TABLE
AS
RETURN
(
    SELECT BookID, Title, Author, Genre, CopiesAvailable
    FROM Books
    WHERE Title LIKE '%' + @Keyword + '%'
       OR Author LIKE '%' + @Keyword + '%'
       OR Genre LIKE '%' + @Keyword + '%'
);
GO
