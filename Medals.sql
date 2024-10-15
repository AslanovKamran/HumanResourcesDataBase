GO
USE SP_HR

GO
CREATE TABLE Medals 
(
[Id] INT PRIMARY KEY,
[OrderDate] DATE NULL,
[OrderNumber] NVARCHAR (100) NULL,
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
[Note] NVARCHAR(255) NULL,
[MedalTypeId] INT FOREIGN KEY REFERENCES MedalTypes(Id)
)

SELECT Employees.Surname FROM Medals 
JOIN Employees ON Medals.EmployeeId = Employees.Id

-- BULK HERE

--SELECT * INTO Temp
--FROM Medals;

--DROP TABLE Medals

--GO
--CREATE TABLE Medals 
--(
--[Id] INT PRIMARY KEY IDENTITY(2222,1),
--[OrderDate] DATE NULL,
--[OrderNumber] NVARCHAR (100) NULL,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
--[Note] NVARCHAR(255) NULL,
--[MedalTypeId] INT FOREIGN KEY REFERENCES MedalTypes(Id)
--)

--SET IDENTITY_INSERT Medals ON


--INSERT INTO Medals (
--    [Id], [OrderDate], [OrderNumber], [EmployeeId], [Note], [MedalTypeId]
--)
--SELECT * FROM Temp;


--SET IDENTITY_INSERT Medals OFF

--DROP TABLE Temp





---- 1. Add a new non-nullable column `NewId`
--ALTER TABLE Medals ADD NewId INT NOT NULL DEFAULT 0;

------ 2. Copy values from `Id` to `NewId`
--UPDATE Medals SET NewId = Id;

------ 3. Drop PK Constraint 
--ALTER TABLE Medals
--DROP CONSTRAINT PK__Medals__3214EC070C8C4890;

------ 4. Drop the original nullable `Id` column
--ALTER TABLE Medals DROP COLUMN Id;


------ 5. Rename `NewId` to `Id`
--EXEC sp_rename 'Medals.NewId', 'Id', 'COLUMN';

------ 6. Add the primary key constraint to `Id`
--ALTER TABLE Medals ADD CONSTRAINT PK_Medals_Id PRIMARY KEY (Id);



--GO
--CREATE PROC GetMedals
--    @EmployeeId INT
--AS
--BEGIN
--    SELECT 
--        Medals.Id, 
--        Medals.OrderDate, 
--        MedalTypes.Type AS MedalType,
--        Medals.OrderNumber,
--        Medals.Note,
--        Medals.EmployeeId
--    FROM Medals
--    JOIN MedalTypes ON MedalTypes.Id = Medals.MedalTypeId
--    WHERE Medals.EmployeeId = @EmployeeId
--    ORDER BY Medals.OrderDate ASC;
--END;


--GO
--CREATE PROC AddMedal
--    @Id INT,
--    @OrderDate DATE = NULL,
--    @OrderNumber NVARCHAR(100) = NULL,
--    @EmployeeId INT,
--    @Note NVARCHAR(255) = NULL,
--    @MedalTypeId INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Insert the new medal record
--        INSERT INTO Medals (Id, OrderDate, OrderNumber, EmployeeId, Note, MedalTypeId)
--        VALUES (@Id, @OrderDate, @OrderNumber, @EmployeeId, @Note, @MedalTypeId);

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
--CREATE PROC UpdateMedal
--    @Id INT,
--    @OrderDate DATE = NULL,
--    @MedalTypeId INT,
--    @OrderNumber NVARCHAR(100) = NULL,
--    @Note NVARCHAR(255) = NULL
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Update the medal record with specified fields
--        UPDATE Medals
--        SET 
--            OrderDate = @OrderDate,
--            MedalTypeId = @MedalTypeId,
--            OrderNumber = @OrderNumber,
--            Note = @Note
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
--CREATE PROC DeleteMedal
--    @Id INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Delete the medal record by Id
--        DELETE FROM Medals
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
