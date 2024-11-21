GO
USE SP_HR

GO
CREATE TABLE Countries
(
[Id] INT PRIMARY KEY,
[Name] NVARCHAR (50) NOT NULL UNIQUE
)

SELECT * FROM Countries ORDER BY Id


--GO
--INSERT INTO Countries VALUES (1,N'Azərbaycan')
--INSERT INTO Countries VALUES (2,N'Rusiya')
--INSERT INTO Countries VALUES (3,N'Gürcüstan')
--INSERT INTO Countries VALUES (5,N'Türkiyə')
--INSERT INTO Countries VALUES (21,N'Yaponiya')
--INSERT INTO Countries VALUES (41,N'İran')
--INSERT INTO Countries VALUES (61,N'İtaliya')
--INSERT INTO Countries VALUES (81,N'BƏƏ')
--INSERT INTO Countries VALUES (121,N'Rumıniya Respublikası')

--SELECT * INTO Temp
--FROM Countries;

--DROP TABLE Countries

--GO
--CREATE TABLE Countries
--(
--[Id] INT PRIMARY KEY IDENTITY(122,1),
--[Name] NVARCHAR (50) NOT NULL UNIQUE
--)

--SET IDENTITY_INSERT Countries ON;


--INSERT INTO Countries (
--    [Id], [Name]
--)
--SELECT * FROM Temp;

--SET IDENTITY_INSERT Countries OFF;

--DROP TABLE Temp


SELECT * FROM Countries ORDER BY ID DESC

GO
CREATE PROC GetCountries
AS
BEGIN
    SET NOCOUNT ON; -- Prevents extra result sets from interfering with SELECT statements

    SELECT
        [Id],
        [Name]
    FROM Countries
    ORDER BY [Name];
END







GO
CREATE PROC AddCountry
    @Name NVARCHAR(50) -- Input parameter for country name
AS
BEGIN
    SET NOCOUNT ON; -- Prevent extra result sets

    BEGIN TRY
        BEGIN TRANSACTION; -- Start transaction

        -- Insert the new country into the Countries table
        INSERT INTO Countries ([Name])
        VALUES (@Name);

        COMMIT TRANSACTION; -- Commit the transaction if successful
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if there is an error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        -- Capture error details
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Handle specific error for unique constraint violation
        IF ERROR_NUMBER() = 2627 -- Unique constraint violation error number
        BEGIN
            RAISERROR('The country name "%s" already exists. Please choose a different name.', 16, 1, @Name);
        END
        ELSE
        BEGIN
            -- Raise a generic error message for other errors
            RAISERROR('An error occurred while adding the country: %s', @ErrorSeverity, @ErrorState, @ErrorMessage);
        END
    END CATCH
END





GO
CREATE PROC UpdateCountry
    @Id INT,          -- Input parameter for the country ID
    @Name NVARCHAR(50) -- Input parameter for the new country name
AS
BEGIN
    SET NOCOUNT ON; -- Prevent extra result sets

    BEGIN TRY
        BEGIN TRANSACTION; -- Start transaction

        -- Update the country name in the Countries table
        UPDATE Countries
        SET [Name] = @Name
        WHERE [Id] = @Id;

        COMMIT TRANSACTION; -- Commit the transaction if successful
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if there is an error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        -- Capture error details
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Handle specific error for unique constraint violation
        IF ERROR_NUMBER() = 2627 -- Unique constraint violation error number
        BEGIN
            RAISERROR('The country name "%s" already exists. Please choose a different name.', 16, 1, @Name);
        END
        ELSE
        BEGIN
            -- Raise a generic error message for other errors
            RAISERROR('An error occurred while updating the country: %s', @ErrorSeverity, @ErrorState, @ErrorMessage);
        END
    END CATCH
END



GO
CREATE PROC DeleteCountry
    @Id INT -- Input parameter for the country ID to delete
AS
BEGIN
    SET NOCOUNT ON; -- Prevent extra result sets

    BEGIN TRY
        BEGIN TRANSACTION; -- Start transaction

        -- Check if there are any cities associated with the country
        DECLARE @CityCount INT;
        SELECT @CityCount = COUNT(*) 
        FROM Cities 
        WHERE CountryId = @Id;

        IF @CityCount > 0
        BEGIN
            -- If there are cities, raise an error and prevent deletion
            RAISERROR('Cannot delete the country with ID %d because it has associated cities.', 16, 1, @Id);
            RETURN; -- Exit the procedure
        END

        -- If no associated cities, proceed to delete the country
        DELETE FROM Countries
        WHERE Id = @Id;

        COMMIT TRANSACTION; -- Commit the transaction if successful
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if there is an error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        -- Capture error details
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Raise a generic error message for other errors
        RAISERROR('An error occurred while deleting the country: %s', @ErrorSeverity, @ErrorState, @ErrorMessage);
    END CATCH
END