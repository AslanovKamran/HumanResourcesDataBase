GO
CREATE TABLE Rights
(
[Id] INT PRIMARY KEY IDENTITY,
[Key] NVARCHAR (200) UNIQUE NOT NULL,
[Name] NVARCHAR (200) NOT NULL
)



SELECT * FROM Rights

GO
CREATE PROC AddRight @Key NVARCHAR (200), @Name NVARCHAR(200)
AS
BEGIN
    BEGIN TRY
        -- Ensure @Key and @Name are not NULL
        IF @Key IS NULL OR @Name IS NULL
        BEGIN
            THROW 51000, 'Key and Name cannot be NULL.', 1;
        END

        -- Attempt to insert into Rights table
        INSERT INTO Rights ([Key], [Name])
        VALUES (@Key, @Name);
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
CREATE PROC GetRightsList
AS
BEGIN
SELECT * FROM Rights
END


GO
CREATE PROC GetRightById @Id INT
AS
BEGIN
SELECT * FROM Rights WHERE Rights.Id = @Id
END


CREATE PROC UpdateRight 
    @Id INT, 
    @Key NVARCHAR(200), 
    @Name NVARCHAR(200)
AS
BEGIN
    BEGIN TRY
        -- Ensure @Key and @Name are not NULL
        IF @Key IS NULL OR @Name IS NULL
        BEGIN
            THROW 51000, 'Key and Name cannot be NULL.', 1;
        END

        -- Attempt to update the record
        UPDATE Rights
        SET [Key] = @Key, [Name] = @Name
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
