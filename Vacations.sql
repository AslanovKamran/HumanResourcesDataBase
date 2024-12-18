GO
USE SP_HR


GO
CREATE Table Vacations
(
[Id] INT PRIMARY KEY,
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
[DaysWorking]INT ,
[DaysTotal]	 INT ,
[YearStarted]INT,
[YearEnded]	 INT,
[VacationTypeId] INT FOREIGN KEY REFERENCES VacationTypes(Id)
)


--BULK


--GO
--CREATE PROC GetVacations 
--    @EmployeeId INT,
--    @YearStarted INT = NULL,
--    @YearEnded INT = NULL
--AS
--BEGIN
--    SELECT 
--        Vacations.Id,
--        Vacations.YearStarted,
--        Vacations.YearEnded,
--        VacationTypes.Name as [Name],
--        VacationPaymentTypes.Type as [Type],
--        Vacations.DaysTotal,
--        Vacations.DaysWorking
--    FROM Vacations
--    LEFT JOIN VacationTypes ON VacationTypes.Id = Vacations.VacationTypeId
--    LEFT JOIN VacationPaymentTypes ON VacationPaymentTypes.Id = VacationTypes.VacationPaymentTypeId
--    WHERE Vacations.EmployeeId = @EmployeeId
--      AND (@YearStarted IS NULL OR Vacations.YearStarted >= @YearStarted)
--      AND (@YearEnded IS NULL OR Vacations.YearEnded <= @YearEnded)
--    ORDER BY Vacations.YearStarted ASC, Vacations.YearEnded ASC;
--END



GO
CREATE PROC AddVacation 
   
    @EmployeeId INT,
    @DaysWorking INT,
    @DaysTotal INT,
    @YearStarted INT,
    @YearEnded INT,
    @VacationTypeId INT
AS
BEGIN
    -- Start of error handling and transaction block
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert statement with specified column names for clarity and robustness
        INSERT INTO Vacations (EmployeeId, DaysWorking, DaysTotal, YearStarted, YearEnded, VacationTypeId)
        VALUES (@EmployeeId, @DaysWorking, @DaysTotal, @YearStarted, @YearEnded, @VacationTypeId);

        -- Commit transaction if insert is successful
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback transaction if an error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Return error message and state
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


--GO
--CREATE PROC UpdateVacation
--    @Id INT,
--    @DaysWorking INT,
--    @DaysTotal INT,
--    @YearStarted INT,
--    @YearEnded INT,
--    @VacationTypeId INT
--AS
--BEGIN
--    BEGIN TRY
--        BEGIN TRANSACTION;

--        UPDATE Vacations
--        SET 
--            DaysWorking = @DaysWorking,
--            DaysTotal = @DaysTotal,
--            YearStarted = @YearStarted,
--            YearEnded = @YearEnded,
--            VacationTypeId = @VacationTypeId
--        WHERE Id = @Id;

--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction if an error occurs
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Return error message and state
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;


--GO
--CREATE PROC DeleteVacation
--    @Id INT
--AS
--BEGIN
--    BEGIN TRY
--        BEGIN TRANSACTION;

--        DELETE FROM Vacations
--        WHERE Id = @Id;

--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction if an error occurs
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Return error message and state
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;


