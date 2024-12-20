GO
USE SP_HR



GO 
CREATE Table BusinessTrips (
Id INT PRIMARY KEY,
Purpose NVARCHAR(255) NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
DocumentNumber NVARCHAR(50) NULL,
DocumentDate DATE NULL,
TripCardGivenAt DATE NULL,
TripCardNumber NVARCHAR(50) NULL,
OrganizationInCharge NVARCHAR(100) NULL,
Note NVARCHAR(300) NULL
)

ALTER TABLE BusinessTrips
ALTER COLUMN Purpose NVARCHAR(MAX) NULL;

 

GO 
CREATE TABLE TripCities(
Id INT PRIMARY KEY IDENTITY,
TripId INT FOREIGN KEY REFERENCES  BusinessTrips(Id),
CityId INT FOREIGN KEY REFERENCES Cities(Id),
DestinationPoint NVARCHAR(255) NULL
)



GO
CREATE INDEX IX_TripEmployees_TripId ON TripEmployees(TripId);
CREATE INDEX IX_TripCities_TripId ON TripCities(TripId);
CREATE INDEX IX_Employees_Id ON Employees(Id);
CREATE INDEX IX_Cities_Id ON Cities(Id);
CREATE INDEX IX_Countries_Id ON Countries(Id);


----IDENTITIES NOT SET

GO
CREATE PROCEDURE AddBusinessTripWithDetails
	@Purpose NVARCHAR(255),
	@StartDate DATE,
	@EndDate DATE,
	@EmployeeIds NVARCHAR(MAX),          -- Comma-separated Employee IDs
	@CityIds NVARCHAR(MAX),              -- Comma-separated City IDs
	@DestinationPoints NVARCHAR(MAX) = NULL,  -- Comma-separated Destination Points (nullable)
	@DocumentNumber NVARCHAR(50) = NULL,
	@DocumentDate DATE = NULL,
	@TripCardGivenAt DATE,
	@TripCardNumber NVARCHAR(50) = NULL,
	@OrganizationInCharge NVARCHAR(100) = NULL,
	@Note NVARCHAR(300) = NULL
AS
BEGIN
    BEGIN TRY
        -- Start the transaction
        BEGIN TRANSACTION;

        DECLARE @NewTripId INT;

        -- Insert the business trip
        INSERT INTO BusinessTrips ( Purpose, StartDate, EndDate, DocumentNumber, DocumentDate, TripCardGivenAt, TripCardNumber, OrganizationInCharge, Note)
        VALUES ( @Purpose, @StartDate, @EndDate, @DocumentNumber, @DocumentDate, @TripCardGivenAt, @TripCardNumber, @OrganizationInCharge, @Note);

        SET @NewTripId = SCOPE_IDENTITY();

        -- Convert EmployeeIds, CityIds, and DestinationPoints into tables using STRING_SPLIT
        DECLARE @EmployeeIdTable TABLE (EmployeeId INT);
        INSERT INTO @EmployeeIdTable (EmployeeId)
        SELECT value FROM STRING_SPLIT(@EmployeeIds, ',');

        DECLARE @CityIdTable TABLE (CityId INT, RowNum INT IDENTITY(1,1));
        INSERT INTO @CityIdTable (CityId)
        SELECT value FROM STRING_SPLIT(@CityIds, ',');

        DECLARE @DestinationPointTable TABLE (DestinationPoint NVARCHAR(255), RowNum INT IDENTITY(1,1));
        IF @DestinationPoints IS NOT NULL
        BEGIN
            INSERT INTO @DestinationPointTable (DestinationPoint)
            SELECT value FROM STRING_SPLIT(@DestinationPoints, ',');
        END

        -- Ensure the number of DestinationPoints is not greater than CityIds
        IF (SELECT COUNT(*) FROM @DestinationPointTable) > (SELECT COUNT(*) FROM @CityIdTable)
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50002, 'The number of DestinationPoints exceeds the number of CityIds.', 1;
        END

        -- Validate EmployeeIds
        IF EXISTS (
            SELECT 1
            FROM @EmployeeIdTable eit
            LEFT JOIN Employees e ON eit.EmployeeId = e.Id
            WHERE e.Id IS NULL
        )
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50000, 'One or more Employee IDs are invalid.', 1;
        END

        -- Validate CityIds
        IF EXISTS (
            SELECT 1
            FROM @CityIdTable cit
            LEFT JOIN Cities c ON cit.CityId = c.Id
            WHERE c.Id IS NULL
        )
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50001, 'One or more City IDs are invalid.', 1;
        END

        -- Insert into TripEmployees
        INSERT INTO TripEmployees (TripId, EmployeeId)
        SELECT @NewTripId, EmployeeId
        FROM @EmployeeIdTable;

        -- Insert into TripCities with corresponding DestinationPoints
        -- Use NULL for DestinationPoint if not enough values are provided
        INSERT INTO TripCities (TripId, CityId, DestinationPoint)
        SELECT @NewTripId, cit.CityId, COALESCE(dp.DestinationPoint, NULL)
        FROM @CityIdTable cit
        LEFT JOIN @DestinationPointTable dp ON cit.RowNum = dp.RowNum;

        -- Commit transaction if everything is successful
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback transaction if an error occurs and there's an active transaction
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        -- Re-throw the error
        THROW;
    END CATCH
END



GO
CREATE PROCEDURE GetBusinessTripDetails
    @TripId INT
AS
BEGIN
    -- Select from BusinessTrips
    SELECT 
        BusinessTrips.Id,
        BusinessTrips.DocumentNumber,
        BusinessTrips.DocumentDate,
        BusinessTrips.TripCardGivenAt,
        BusinessTrips.TripCardNumber,
        BusinessTrips.StartDate,
        BusinessTrips.EndDate,
        BusinessTrips.Purpose,
        BusinessTrips.OrganizationInCharge,
        BusinessTrips.Note
    FROM BusinessTrips 
    WHERE BusinessTrips.Id = @TripId;

    -- Select from TripEmployees and Employees
    SELECT 
        TripEmployees.Id,
        Employees.Id AS [EmployeeId],
        Employees.Name,
        Employees.Surname
    FROM TripEmployees 
    JOIN Employees ON Employees.Id = TripEmployees.EmployeeId
    WHERE TripEmployees.TripId = @TripId;

    -- Select from TripCities, Cities, and Countries
    SELECT 
        TripCities.Id,
        Countries.Name AS [Country],
        Cities.Name AS [City],
        TripCities.DestinationPoint
    FROM TripCities 
    JOIN Cities ON Cities.Id = TripCities.CityId
    JOIN Countries ON Countries.Id = Cities.CountryId
    WHERE TripCities.TripId = @TripId;
END


GO
CREATE PROC GetBusinessTrips
    @Skip INT = 0, -- Number of rows to skip (default 0)
    @Take INT = 20 -- Number of rows to take (default 20)
AS
BEGIN
    -- Return the total count of entries
    SELECT COUNT(*) AS TotalCount FROM BusinessTrips;

    -- Return the paginated data
    SELECT 
        BusinessTrips.Id,
        BusinessTrips.DocumentNumber,
        BusinessTrips.DocumentDate,
        BusinessTrips.TripCardGivenAt,
        BusinessTrips.TripCardNumber,
        BusinessTrips.StartDate,
        BusinessTrips.EndDate,
        BusinessTrips.Purpose,
        BusinessTrips.OrganizationInCharge,
        BusinessTrips.Note
    FROM BusinessTrips
    ORDER BY BusinessTrips.Id -- Required for OFFSET-FETCH
    OFFSET @Skip ROWS
    FETCH NEXT @Take ROWS ONLY;
END



GO
CREATE PROCEDURE InsertTripEmployee
    @TripId INT,
    @EmployeeId INT
AS
BEGIN
    BEGIN TRY
        -- Check if the TripId exists in the BusinessTrips table
        IF NOT EXISTS (
            SELECT 1
            FROM BusinessTrips
            WHERE Id = @TripId
        )
        BEGIN
            THROW 50001, 'TripId does not exist in the BusinessTrips table.', 1;
        END

        -- Check if the EmployeeId exists in the Employees table
        IF NOT EXISTS (
            SELECT 1
            FROM Employees
            WHERE Id = @EmployeeId
        )
        BEGIN
            THROW 50002, 'EmployeeId does not exist in the Employees table.', 1;
        END

        -- Insert the record into TripEmployees
        INSERT INTO TripEmployees (TripId, EmployeeId)
        VALUES (@TripId, @EmployeeId);
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Re-throw the error with additional details
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;





GO
CREATE PROCEDURE DeleteTripEmployee
    @Id INT
AS
BEGIN
    BEGIN TRY
        -- Check if the record with the given Id exists
        IF NOT EXISTS (
            SELECT 1
            FROM TripEmployees
            WHERE Id = @Id
        )
        BEGIN
            THROW 50003, 'Record with the specified Id does not exist.', 1;
        END

        -- Delete the record
        DELETE FROM TripEmployees
        WHERE Id = @Id;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Re-throw the error with additional details
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

SELECT * FROM TripCities WHERE TripId = 82

SELECT * FROM Cities

CREATE PROCEDURE InsertTripCity
    @TripId INT,
    @CityId INT,
    @DestinationPoint NVARCHAR(255) = NULL
AS
BEGIN
    BEGIN TRY
        -- Check if the TripId exists in the BusinessTrips table
        IF NOT EXISTS (
            SELECT 1
            FROM BusinessTrips
            WHERE Id = @TripId
        )
        BEGIN
            THROW 50001, 'TripId does not exist in the BusinessTrips table.', 1;
        END

        -- Check if the CityId exists in the Cities table
        IF NOT EXISTS (
            SELECT 1
            FROM Cities
            WHERE Id = @CityId
        )
        BEGIN
            THROW 50002, 'CityId does not exist in the Cities table.', 1;
        END

        -- Insert the record into TripCities
        INSERT INTO TripCities (TripId, CityId, DestinationPoint)
        VALUES (@TripId, @CityId, @DestinationPoint);

        -- Return success message (optional)
        PRINT 'Record successfully inserted.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Re-throw the error with additional details
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;




GO
CREATE PROCEDURE DeleteTripCity
    @Id INT
AS
BEGIN
    BEGIN TRY
        -- Check if the record with the given Id exists
        IF NOT EXISTS (
            SELECT 1
            FROM TripCities
            WHERE Id = @Id
        )
        BEGIN
            THROW 50003, 'Record with the specified Id does not exist.', 1;
        END

        -- Delete the record
        DELETE FROM TripCities
        WHERE Id = @Id;

        -- Return success message (optional)
        PRINT 'Record successfully deleted.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Re-throw the error with additional details
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;





GO
CREATE PROCEDURE UpdateTripCity
    @Id INT,
    @CityId INT,
    @DestinationPoint NVARCHAR(255) = NULL
AS
BEGIN
    BEGIN TRY
        -- Check if the record with the given Id exists
        IF NOT EXISTS (
            SELECT 1
            FROM TripCities
            WHERE Id = @Id
        )
        BEGIN
            THROW 50004, 'Record with the specified Id does not exist.', 1;
        END

        -- Check if the CityId exists in the Cities table
        IF NOT EXISTS (
            SELECT 1
            FROM Cities
            WHERE Id = @CityId
        )
        BEGIN
            THROW 50005, 'CityId does not exist in the Cities table.', 1;
        END

        -- Update the record
        UPDATE TripCities
        SET
            CityId = @CityId,
            DestinationPoint = @DestinationPoint
        WHERE Id = @Id;

        -- Return success message (optional)
        PRINT 'Record successfully updated.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Re-throw the error with additional details
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


GO
CREATE PROCEDURE UpdateBusinessTrip
    @Id INT,
    @Purpose NVARCHAR(255),
    @StartDate DATE,
    @EndDate DATE,
    @DocumentNumber NVARCHAR(50) = NULL,
    @DocumentDate DATE = NULL,
    @TripCardGivenAt DATE = NULL,
    @TripCardNumber NVARCHAR(50) = NULL,
    @OrganizationInCharge NVARCHAR(100) = NULL,
    @Note NVARCHAR(300) = NULL
AS
BEGIN
    BEGIN TRY
        -- Check if the record with the given Id exists
        IF NOT EXISTS (
            SELECT 1
            FROM BusinessTrips
            WHERE Id = @Id
        )
        BEGIN
            THROW 50006, 'Record with the specified Id does not exist.', 1;
        END

        -- Update the record
        UPDATE BusinessTrips
        SET
            Purpose = @Purpose,
            StartDate = @StartDate,
            EndDate = @EndDate,
            DocumentNumber = @DocumentNumber,
            DocumentDate = @DocumentDate,
            TripCardGivenAt = @TripCardGivenAt,
            TripCardNumber = @TripCardNumber,
            OrganizationInCharge = @OrganizationInCharge,
            Note = @Note
        WHERE Id = @Id;

        -- Return success message (optional)
        PRINT 'Record successfully updated.';
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Re-throw the error with additional details
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;