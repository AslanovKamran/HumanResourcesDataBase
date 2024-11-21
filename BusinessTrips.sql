GO
USE SP_HR

SELECT * FROM BusinessTrips

GO 
CREATE Table BusinessTrips (
Id INT PRIMARY KEY IDENTITY,
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

GO 
CREATE TABLE TripEmployees(
Id INT PRIMARY KEY IDENTITY,
TripId INT FOREIGN KEY REFERENCES  BusinessTrips(Id),
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id)
)

GO 
CREATE TABLE TripCities(
Id INT PRIMARY KEY IDENTITY,
TripId INT FOREIGN KEY REFERENCES  BusinessTrips(Id),
CityId INT FOREIGN KEY REFERENCES Cities(Id)
)

GO
ALTER TABLE TripCities
ADD DestinationPoint NVARCHAR(255) NULL;

GO
CREATE INDEX IX_TripEmployees_TripId ON TripEmployees(TripId);
CREATE INDEX IX_TripCities_TripId ON TripCities(TripId);
CREATE INDEX IX_Employees_Id ON Employees(Id);
CREATE INDEX IX_Cities_Id ON Cities(Id);
CREATE INDEX IX_Countries_Id ON Countries(Id);


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
        INSERT INTO BusinessTrips (Purpose, StartDate, EndDate, DocumentNumber, DocumentDate, TripCardGivenAt, TripCardNumber, OrganizationInCharge, Note)
        VALUES (@Purpose, @StartDate, @EndDate, @DocumentNumber, @DocumentDate, @TripCardGivenAt, @TripCardNumber, @OrganizationInCharge, @Note);

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
AS
BEGIN
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
 END

 --BULK INSERTS NEED TO BE DONE