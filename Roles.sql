--GO
--USE SP_HR

--GO
--CREATE TABLE Roles(
--[Id] INT PRIMARY KEY IDENTITY,
--[Name] NVARCHAR (100) UNIQUE NOT NULL
--)

SELECT * FROM Roles
 
GO
CREATE PROC AddRole @Name NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        -- Ensure @Key and @Name are not NULL
        IF @Name IS NULL
        BEGIN
            THROW 51000, 'Name cannot be NULL.', 1;
        END

        -- Attempt to insert into Rights table
        INSERT INTO Roles ([Name])
        VALUES (@Name);
    END TRY
    BEGIN CATCH
        -- Capture and return error details
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Rethrow the error with original context
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

GO
CREATE PROC GetRolesList 
AS
BEGIN
SELECT * FROM Roles
END




CREATE PROC UpdateRole
    @Id INT,  
    @Name NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        -- Ensure @Key and @Name are not NULL
        IF @Name IS NULL
        BEGIN
            THROW 51000, 'Name cannot be NULL.', 1;
        END

        -- Attempt to update the record
        UPDATE Roles
        SET [Name] = @Name
        WHERE [Id] = @Id;

        -- Check if any row was updated
        IF @@ROWCOUNT = 0
        BEGIN
            THROW 51001, 'No record found with the specified Id.', 1;
        END
    END TRY
    BEGIN CATCH
        -- Capture and return error details
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Rethrow the error with original context
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
