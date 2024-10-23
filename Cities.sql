GO
USE SP_HR

GO
CREATE TABLE Cities
(
[Id] INT PRIMARY KEY,
[CountryId] INT FOREIGN KEY REFERENCES Countries(Id),
[Name] NVARCHAR(100) NOT NULL UNIQUE
)

--GO
--SELECT * INTO Temp 
--FROM Cities;

--DROP TABLE Cities

--GO
--CREATE TABLE Cities
--(
--[Id] INT PRIMARY KEY IDENTITY (644,1),
--[CountryId] INT FOREIGN KEY REFERENCES Countries(Id),
--[Name] NVARCHAR(100) NOT NULL UNIQUE
--)

--SET IDENTITY_INSERT Cities ON


--INSERT INTO Cities(
--    [Id], [CountryId], [Name]
--)
--SELECT * FROM Temp;


--SET IDENTITY_INSERT Cities OFF

--DROP TABLE Temp




--GO
--CREATE PROC GetCities 
--    @Skip INT = 0,   
--    @Take INT = 50
--AS
--BEGIN
--    -- Return the total number of records
--    SELECT COUNT(*) AS TotalCount
--    FROM Cities;

--    -- Return the paginated result
--    SELECT 
--        Cities.Id,
--        Cities.Name AS [City],
--        Countries.Name AS [Country]
--    FROM Cities
--    LEFT JOIN Countries ON Cities.CountryId = Countries.Id
--    ORDER BY Countries.Id ASC, Cities.Name ASC  
--    OFFSET @Skip ROWS FETCH NEXT @Take ROWS ONLY;
--END



--GO
--CREATE PROCEDURE AddCity
--    @CountryId INT,
--    @CityName NVARCHAR(100)
--AS
--BEGIN
--    BEGIN TRY
--        BEGIN TRANSACTION; -- Start the transaction

--        -- Insert the new city
--        INSERT INTO Cities (CountryId, Name)
--        VALUES (@CountryId, @CityName);

--        -- If everything is successful, commit the transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- If an error occurs, rollback the transaction
--        IF @@TRANCOUNT > 0
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END

--        -- Return the error details
--        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
--        SELECT 
--            @ErrorMessage = ERROR_MESSAGE(),
--            @ErrorSeverity = ERROR_SEVERITY(),
--            @ErrorState = ERROR_STATE();

--        -- Re-throw the error to be caught by the calling code (like the app)
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END



--GO
--CREATE PROCEDURE UpdateCity
--    @Id INT,                  -- ID of the city to update
--    @CountryId INT,               -- Updated country ID
--    @CityName NVARCHAR(100)       -- Updated city name
--AS
--BEGIN
--    BEGIN TRY
--        BEGIN TRANSACTION;  -- Start the transaction

--        -- Update the city record
--        UPDATE Cities
--        SET 
--            CountryId = @CountryId,
--            Name = @CityName
--        WHERE Id = @Id;

      
--        -- If everything is successful, commit the transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback the transaction if an error occurs
--        IF @@TRANCOUNT > 0
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END

--        -- Return the error details
--        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
--        SELECT 
--            @ErrorMessage = ERROR_MESSAGE(),
--            @ErrorSeverity = ERROR_SEVERITY(),
--            @ErrorState = ERROR_STATE();

--        -- Re-throw the error with RAISERROR
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END
--GO



--GO
--CREATE PROCEDURE DeleteCity
--    @Id INT   -- ID of the city to delete
--AS
--BEGIN
--    BEGIN TRY
--        BEGIN TRANSACTION;  -- Start the transaction

--        -- Delete the city record
--        DELETE FROM Cities
--        WHERE Id = @Id;

      

--        -- If everything is successful, commit the transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback the transaction if an error occurs
--        IF @@TRANCOUNT > 0
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END

--        -- Return the error details
--        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
--        SELECT 
--            @ErrorMessage = ERROR_MESSAGE(),
--            @ErrorSeverity = ERROR_SEVERITY(),
--            @ErrorState = ERROR_STATE();

--        -- Re-throw the error with RAISERROR
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END
--GO

