GO
USE SP_HR

CREATE TABLE WorkNorms
(
[Id] INT PRIMARY KEY IDENTITY,
[Year] INT NOT NULL CHECK (Year >=1),
[MonthId] INT FOREIGN KEY REFERENCES Months(Id),
[MonthlyWorkingHours] INT NOT NULL CHECK (MonthlyWorkingHours>0)
)

-- Add unique constraint to ensure one work norm per month per year
ALTER TABLE WorkNorms
ADD CONSTRAINT UC_Year_Month UNIQUE (Year, MonthId);


GO
CREATE PROC GetWorkNorms
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Retrieve WorkNorms with a specific year, or all years if no year is provided
        SELECT 
            WorkNorms.Id,
            WorkNorms.Year,
            Months.Name AS [Month],
            WorkNorms.MonthlyWorkingHours
        FROM WorkNorms
        JOIN Months ON Months.Id = WorkNorms.MonthId
        WHERE WorkNorms.Year = @Year
        ORDER BY WorkNorms.Year, Months.Id;
    END TRY
    BEGIN CATCH
        -- Handle any errors that might occur
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        THROW 50000, @ErrorMessage, 1;  -- Raise a custom error
    END CATCH
END


GO
CREATE PROC AddWorkNorms
    @Year INT,
    @MonthId INT,
    @MonthlyWorkingHours INT
AS
BEGIN
    BEGIN TRY
        -- Start the transaction
        BEGIN TRANSACTION;

        -- Insert into WorkNorms table
        INSERT INTO WorkNorms (Year, MonthId, MonthlyWorkingHours)
        VALUES (@Year, @MonthId, @MonthlyWorkingHours);

        -- Commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Check if the error is due to the unique constraint violation
        IF ERROR_NUMBER() = 2627  -- Error code for unique constraint violation
        BEGIN
            -- Rollback transaction in case of a constraint violation
            IF @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;

            -- Raise a custom error message
            RAISERROR('A work norm for the specified month and year already exists.', 16, 1);
            RETURN;
        END
        
        -- For any other errors, rollback and raise the original error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Raise the original error message
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END


GO
CREATE PROCEDURE UpdateWorkNorm
    @Id INT,
    @Year INT,
    @MonthlyWorkingHours INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Only allow updates to Year and MonthlyWorkingHours, but not MonthId
        UPDATE WorkNorms
        SET
            Year = @Year,
            MonthlyWorkingHours = @MonthlyWorkingHours
        WHERE Id = @Id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END



GO
CREATE PROCEDURE DeleteWorkNorm
    @Id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Delete the work norm by Id
        DELETE FROM WorkNorms
        WHERE Id = @Id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
