USE LibraryDB;
GO

CREATE PROCEDURE LoginUser
    @Email NVARCHAR(100),
    @Password NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        SELECT UserID, Name, Role
        FROM Users
        WHERE Email = @Email AND Password = @Password;

        IF @@ROWCOUNT = 0
        BEGIN
            PRINT 'Invalid login credentials.';
        END
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
