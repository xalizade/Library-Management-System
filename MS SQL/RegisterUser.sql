USE LibraryDB;
GO

CREATE PROCEDURE RegisterUser
    @Name NVARCHAR(100),
    @Email NVARCHAR(100),
    @Password NVARCHAR(255),
    @Role NVARCHAR(10)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = @Email)
    BEGIN
        INSERT INTO Users (Name, Email, Password, Role)
        VALUES (@Name, @Email, @Password, @Role);
    END
END;
GO



