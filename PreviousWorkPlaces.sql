GO
USE SP_HR

GO CREATE TABLE  PreviousWorkingPlaces(
[Id] INT PRIMARY KEY IDENTITY,
[OrganizationName] NVARCHAR (300) NOT NULL,
[Position] NVARCHAR (300) NOT NULL,
[StartedAt] DATE NOT NULL,
[EndedAt] DATE NOT NULL,
[EmployeeId] INT FOREIGN KEY NOT NULL,
[Reason] NVARCHAR (300) NULL
)




--GO
--CREATE PROC GetPreviousWorkPlacesByEmployeeId
--    @EmployeeId INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Check if EmployeeId exists in the referencing Employees table
--        IF NOT EXISTS (
--            SELECT 1
--            FROM Employees
--            WHERE Id = @EmployeeId
--        )
--        BEGIN
--            THROW 50001, 'EmployeeId does not exist in the Employees table.', 1;
--        END
--        SELECT 
--            [Id], 
--            [OrganizationName], 
--            [Position], 
--            [StartedAt], 
--            [EndedAt], 
--			[EmployeeId],
--            [Reason]
--        FROM PreviousWorkingPlaces
--        WHERE [EmployeeId] = @EmployeeId; 
--    END TRY
--    BEGIN CATCH
--        -- Handle errors
--        DECLARE @ErrorMessage NVARCHAR(4000);
--        DECLARE @ErrorSeverity INT;
--        DECLARE @ErrorState INT;

--        SELECT 
--            @ErrorMessage = ERROR_MESSAGE(),
--            @ErrorSeverity = ERROR_SEVERITY(),
--            @ErrorState = ERROR_STATE();

--        -- Re-throw the error with additional details
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;




--GO
--CREATE PROCEDURE AddPreviousWorkingPlace
--    @EmployeeId INT,
--    @OrganizationName NVARCHAR(300),
--    @Position NVARCHAR(300),
--    @StartedAt DATE,
--    @EndedAt DATE,
--    @Reason NVARCHAR(300) = NULL
--AS
--BEGIN
--    BEGIN TRY
--        -- Check if EmployeeId exists in the referencing Employees table
--        IF NOT EXISTS (
--            SELECT 1
--            FROM Employees
--            WHERE Id = @EmployeeId
--        )
--        BEGIN
--            THROW 50001, 'EmployeeId does not exist in the Employees table.', 1;
--        END

--        -- Insert the new record into the PreviousWorkingPlaces table
--        INSERT INTO PreviousWorkingPlaces (
--            EmployeeId, OrganizationName, Position, StartedAt, EndedAt, Reason
--        )
--        VALUES (
--            @EmployeeId, @OrganizationName, @Position, @StartedAt, @EndedAt, @Reason
--        );
--    END TRY
--    BEGIN CATCH
--        -- Handle errors
--        DECLARE @ErrorMessage NVARCHAR(4000);
--        DECLARE @ErrorSeverity INT;
--        DECLARE @ErrorState INT;

--        SELECT 
--            @ErrorMessage = ERROR_MESSAGE(),
--            @ErrorSeverity = ERROR_SEVERITY(),
--            @ErrorState = ERROR_STATE();

--        -- Re-throw the error with additional details
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;





--CREATE PROCEDURE UpdatePreviousWorkingPlace
--    @Id INT,
--    @OrganizationName NVARCHAR(300),
--    @Position NVARCHAR(300),
--    @StartedAt DATE,
--    @EndedAt DATE,
--    @Reason NVARCHAR(300) = NULL
--AS
--BEGIN
--    BEGIN TRY
--        -- Check if the record with the given Id exists
--        IF NOT EXISTS (
--            SELECT 1
--            FROM PreviousWorkingPlaces
--            WHERE Id = @Id
--        )
--        BEGIN
--            THROW 50002, 'Record with the specified Id does not exist.', 1;
--        END

--        -- Update the record
--        UPDATE PreviousWorkingPlaces
--        SET
--            OrganizationName = @OrganizationName,
--            Position = @Position,
--            StartedAt = @StartedAt,
--            EndedAt = @EndedAt,
--            Reason = @Reason
--        WHERE Id = @Id;

--    END TRY
--    BEGIN CATCH
--        -- Handle errors
--        DECLARE @ErrorMessage NVARCHAR(4000);
--        DECLARE @ErrorSeverity INT;
--        DECLARE @ErrorState INT;

--        SELECT 
--            @ErrorMessage = ERROR_MESSAGE(),
--            @ErrorSeverity = ERROR_SEVERITY(),
--            @ErrorState = ERROR_STATE();

--        -- Re-throw the error with additional details
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;





--GO
--CREATE PROCEDURE DeletePreviousWorkingPlace
--    @Id INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Check if the record with the given Id exists
--        IF NOT EXISTS (
--            SELECT 1
--            FROM PreviousWorkingPlaces
--            WHERE Id = @Id
--        )
--        BEGIN
--            THROW 50003, 'Record with the specified Id does not exist.', 1;
--        END

--        -- Delete the record
--        DELETE FROM PreviousWorkingPlaces
--        WHERE Id = @Id;

--        -- Return success message (optional)
--        PRINT 'Record successfully deleted.';
--    END TRY
--    BEGIN CATCH
--        -- Handle errors
--        DECLARE @ErrorMessage NVARCHAR(4000);
--        DECLARE @ErrorSeverity INT;
--        DECLARE @ErrorState INT;

--        SELECT 
--            @ErrorMessage = ERROR_MESSAGE(),
--            @ErrorSeverity = ERROR_SEVERITY(),
--            @ErrorState = ERROR_STATE();

--        -- Re-throw the error with additional details
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;

SELECT * FROM Employees WHERE Surname Like N'Alcanlı'