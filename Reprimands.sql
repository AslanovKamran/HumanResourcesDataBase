GO 
USE SP_HR

--GO
--CREATE TABLE Reprimands (
--    Id INT PRIMARY KEY ,
--    IssuedAt DATE NULL,
--    TakenAt DATE NULL,
--    EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
--    Reason NVARCHAR(MAX) NULL,
--    OrderNumber NVARCHAR(255),
--    TypeId INT FOREIGN KEY REFERENCES ReprimandTypes(Id),
--    Amount NVARCHAR(255) NULL
--);

-- BULK HERE


--SELECT * FROM Reprimands  ORDER BY ID DESC


----SELECT * INTO Temp
----FROM Reprimands;

----DROP TABLE Reprimands

--GO
--CREATE TABLE Reprimands (
--    Id			 INT PRIMARY KEY IDENTITY (6237,1),
--    IssuedAt		 DATE NULL,
--    TakenAt				DATE NULL,
--    EmployeeId			 INT FOREIGN KEY REFERENCES Employees(Id),
--    Reason				NVARCHAR(MAX) NULL,
--    OrderNumber			NVARCHAR(255),
--    TypeId				INT FOREIGN KEY REFERENCES ReprimandTypes(Id),
--    Amount				 NVARCHAR(255) NULL
--);

----SET IDENTITY_INSERT Reprimands ON


--INSERT INTO Reprimands 
--(

-- Id				,
-- IssuedAt	   ,
-- TakenAt		,
-- EmployeeId	   ,
-- Reason		   ,
-- OrderNumber	,
-- TypeId		   ,
-- Amount		

--)
--SELECT * FROM Temp;


--SET IDENTITY_INSERT Reprimands OFF

--DROP TABLE Temp


--SELECT * FROM Reprimands ORDER BY Id DESC

---- 1. Add a new non-nullable column `NewId`
--ALTER TABLE Reprimands ADD NewId INT NOT NULL DEFAULT 0;

------ 2. Copy values from `Id` to `NewId`
--UPDATE Reprimands SET NewId = Id;

------ 3. Drop PK Constraint 
--ALTER TABLE Reprimands
--DROP CONSTRAINT PK__Repriman__3214EC0775732AA8;

------ 4. Drop the original nullable `Id` column
--ALTER TABLE Reprimands DROP COLUMN Id;


------ 5. Rename `NewId` to `Id`
--EXEC sp_rename 'Reprimands.NewId', 'Id', 'COLUMN';

------ 6. Add the primary key constraint to `Id`
--ALTER TABLE Reprimands ADD CONSTRAINT PK_Reprimands_Id PRIMARY KEY (Id);

--GO 
--CREATE PROC GetReprimands 
--@EmployeeId INT

--AS 
--BEGIN
--SELECT 
--[Reprimands].Id,
--[Reprimands].IssuedAt,
--[ReprimandTypes].Type AS [ReprimandType],
--[Reprimands].OrderNumber,
--[Reprimands].Amount,
--[Reprimands].Reason,
--[Reprimands].TakenAt,
--[Reprimands].EmployeeId
--FROM Reprimands
--LEFT JOIN ReprimandTypes ON ReprimandTypes.Id = Reprimands.TypeId 
--WHERE [EmployeeId] = @EmployeeId
--ORDER BY IssuedAt
--END


--GO
--CREATE PROC AddReprimand
--    @Id INT,
--    @IssuedAt DATE = NULL,
--    @TakenAt DATE = NULL,
--    @EmployeeId INT,
--    @Reason NVARCHAR(MAX) = NULL,
--    @OrderNumber NVARCHAR(255),
--    @TypeId INT,
--    @Amount NVARCHAR(255) = NULL
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Insert the new reprimand record, allowing NULL for TakenAt
--        INSERT INTO Reprimands (Id, IssuedAt, TakenAt, EmployeeId, Reason, OrderNumber, TypeId, Amount)
--        VALUES (@Id, @IssuedAt, CASE WHEN @TakenAt IS NOT NULL THEN @TakenAt ELSE NULL END, @EmployeeId, @Reason, @OrderNumber, @TypeId, @Amount);

--        -- Commit the transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Roll back transaction if an error occurs
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Raise an error message with details
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;



--GO
--CREATE PROC UpdateReprimand
--    @Id INT,
--    @IssuedAt DATE = NULL,
--    @TypeId INT,
--    @OrderNumber NVARCHAR(255),
--    @Amount NVARCHAR(255) = NULL,
--    @Reason NVARCHAR(MAX) = NULL,
--    @TakenAt DATE = NULL
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Update the Reprimand record, conditionally setting TakenAt to NULL if needed
--        UPDATE Reprimands
--        SET 
--            IssuedAt = @IssuedAt,
--            TypeId = @TypeId,
--            OrderNumber = @OrderNumber,
--            Amount = @Amount,
--            Reason = @Reason,
--            TakenAt = CASE WHEN @TakenAt IS NOT NULL THEN @TakenAt ELSE NULL END
--        WHERE Id = @Id;

--        -- Commit the transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Roll back transaction if an error occurs
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Raise an error message with details
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;





--GO
--CREATE PROC DeleteReprimand
--    @Id INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Delete the reprimand record by Id
--        DELETE FROM Reprimands
--        WHERE Id = @Id;

--        -- Commit the transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Roll back transaction if an error occurs
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Raise an error message with details
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;


