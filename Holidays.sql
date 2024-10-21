GO
USE SP_HR

CREATE TABLE Holidays 
(
[Id] INT PRIMARY KEY IDENTITY,
[Date] DATE NOT NULL,
[Note] NVARCHAR (100) NULL,
[HolidayTypeId] INT FOREIGN KEY REFERENCES HolidayTypes(Id) NOT NULL,
[HolidayForShiftId] INT FOREIGN KEY REFERENCES HolidaysForShifts(Id) NULL
)


--GO
--CREATE PROC GetHolidays  
--    @Date INT 

--AS
--BEGIN
--    SELECT 
--        Holidays.Id,
--        Holidays.Date,
--        HolidayTypes.Type AS [Type],
--        HolidaysForShifts.Shift AS [Shift],
--        [Note]
--    FROM Holidays
--    LEFT JOIN HolidayTypes ON HolidayTypes.Id = Holidays.HolidayTypeId
--    LEFT JOIN HolidaysForShifts ON HolidaysForShifts.Id = Holidays.HolidayForShiftId
--    WHERE Holidays.Date BETWEEN CONVERT(DATE, CONVERT(VARCHAR, @Date) + '-01-01') 
--        AND CONVERT(DATE, CONVERT(VARCHAR, @Date) + '-12-31')
--    ORDER BY Holidays.Date ASC
--END


----GO
----CREATE PROC AddHoliday
----    @Date DATE,
----    @Note NVARCHAR(100),
----    @HolidayTypeId INT,
----    @HolidayForShiftId INT NULL
----AS
----BEGIN
----    BEGIN TRY
----        -- Start the transaction
----        BEGIN TRANSACTION;

----        -- Insert into Holidays table with column names explicitly defined
----        INSERT INTO Holidays (Date, Note, HolidayTypeId, HolidayForShiftId) 
----        VALUES (@Date, @Note, @HolidayTypeId, @HolidayForShiftId);

----        -- Commit the transaction if everything is successful
----        COMMIT TRANSACTION;
----    END TRY
----    BEGIN CATCH
----        -- Rollback the transaction in case of an error
----        IF @@TRANCOUNT > 0
----        BEGIN
----            ROLLBACK TRANSACTION;
----        END
        
----        --Raise an error message with details
----        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
----        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
----        DECLARE @ErrorState INT = ERROR_STATE();
----        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
----    END CATCH
----END


----GO
----CREATE PROC DeleteHoliday 
----    @Id INT
----AS
----BEGIN
----    BEGIN TRY
----        -- Start a transaction
----        BEGIN TRANSACTION;
----        BEGIN
----            -- Delete the holiday if it exists
----            DELETE FROM Holidays WHERE Id = @Id;

----            -- Commit the transaction
----            COMMIT TRANSACTION;
----        END
----    END TRY
----    BEGIN CATCH
----        -- Rollback the transaction in case of an error
----        IF @@TRANCOUNT > 0
----        BEGIN
----            ROLLBACK TRANSACTION;
----        END

----        -- Capture and return the error message
----        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
----        RAISERROR(@ErrorMessage, 16, 1);
----    END CATCH
----END


--GO
--CREATE PROC UpdateHoliday
--    @Id INT,
--    @Date DATE,
--    @Note NVARCHAR(100),
--    @HolidayTypeId INT,
--    @HolidayForShiftId INT NULL
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Check if the holiday exists
--        IF EXISTS (SELECT 1 FROM Holidays WHERE Id = @Id)
--        BEGIN
--            -- Perform the update if the record exists
--            UPDATE Holidays
--            SET 
--                Date = @Date,
--                Note = @Note,
--                HolidayTypeId = @HolidayTypeId,
--                HolidayForShiftId = @HolidayForShiftId
--            WHERE Id = @Id;

--            -- Commit the transaction
--            COMMIT TRANSACTION;
--        END
--        ELSE
--        BEGIN
--            -- If the holiday does not exist, rollback the transaction and raise an error
--            ROLLBACK TRANSACTION;
--            RAISERROR('Holiday with Id = %d does not exist.', 16, 1, @Id);
--        END
--    END TRY
--    BEGIN CATCH
--        -- Rollback the transaction in case of an error
--        IF @@TRANCOUNT > 0
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END

--        -- Capture and return the error message
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        RAISERROR(@ErrorMessage, 16, 1);
--    END CATCH
--END



