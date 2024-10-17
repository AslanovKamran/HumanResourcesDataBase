GO
USE SP_HR

--GO 
--CREATE TABLE PreviousNames
--(
--[Id] INT PRIMARY KEY,
--[Surname] NVARCHAR (50) NOT NULL,
--[Name] NVARCHAR (50) NOT NULL,
--[FatherName] NVARCHAR (50) NOT NULL,
--[ChangedAt] DATE NULL,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id)
--)


--BULK HERE

--CREATE NONCLUSTERED INDEX IX_PreviousNames_EmployeeId ON PreviousNames(EmployeeId);

--SELECT * INTO Temp
--FROM PreviousNames;

--DROP TABLE PreviousNames

--GO 
--CREATE TABLE PreviousNames
--(
--[Id]				INT PRIMARY KEY IDENTITY(283,1),
--[Surname]			 NVARCHAR (50) NOT NULL,
--[Name]			NVARCHAR (50) NOT NULL,
--[FatherName]		 NVARCHAR (50) NOT NULL,
--[ChangedAt]		 DATE NULL,
--[EmployeeId]		INT FOREIGN KEY REFERENCES Employees(Id)
--)

--SET IDENTITY_INSERT PreviousNames ON


--INSERT INTO PreviousNames 
--(
--[Id]	,		
--[Surname]	,	
--[Name]	,	
--[FatherName],	
--[ChangedAt]	,
--[EmployeeId]	
--)
--SELECT * FROM Temp;


--SET IDENTITY_INSERT PreviousNames OFF

--DROP TABLE Temp


----DROPPING Identity

---- 1. Add a new non-nullable column `NewId`
--ALTER TABLE PreviousNames ADD NewId INT NOT NULL DEFAULT 0;

---- 2. Copy values from `Id` to `NewId`
--UPDATE PreviousNames SET NewId = Id;

---- 3. Drop the PK Constraint

--ALTER TABLE PreviousNames DROP CONSTRAINT PK__Previous__3214EC0778786F23

---- 4. Drop the original nullable `Id` column
--ALTER TABLE PreviousNames DROP COLUMN Id;

---- 5. Rename `NewId` to `Id`
--EXEC sp_rename 'PreviousNames.NewId', 'Id', 'COLUMN';

---- 6. Add the primary key constraint to `Id`
--ALTER TABLE PreviousNames ADD CONSTRAINT PK_PreviousuNames_Id PRIMARY KEY (Id);


--GO 
--CREATE PROC GetPreviousName @EmployeeId INT
--AS
--BEGIN
--SELECT 
--PreviousNames.Id,
--PreviousNames.Surname,
--PreviousNames.Name,
--PreviousNames.FatherName,
--PreviousNames.ChangedAt,
--PreviousNames.EmployeeId
--FROM PreviousNames
--WHERE PreviousNames.EmployeeId = @EmployeeId
-- ORDER BY PreviousNames.ChangedAt DESC;
--END

--GO
--CREATE PROC AddPreviousName
--    @Id INT,
--    @Surname NVARCHAR(50),
--    @Name NVARCHAR(50),
--    @FatherName NVARCHAR(50),
--    @ChangedAt DATE,
--    @EmployeeId INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Insert the new previous name record
--        INSERT INTO PreviousNames (Id, Surname, Name, FatherName, ChangedAt, EmployeeId)
--        VALUES (@Id, @Surname, @Name, @FatherName, @ChangedAt, @EmployeeId);

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
--CREATE PROC UpdatePreviousName
--    @Id INT,
--    @Surname NVARCHAR(50),
--    @Name NVARCHAR(50),
--    @FatherName NVARCHAR(50),
--    @ChangedAt DATE
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Update the previous name record with the specified fields
--        UPDATE PreviousNames
--        SET 
--            Surname = @Surname,
--            Name = @Name,
--            FatherName = @FatherName,
--            ChangedAt = @ChangedAt
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
--CREATE PROC DeletePreviousName
--    @Id INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Delete the previous name record by Id
--        DELETE FROM PreviousNames
--        WHERE Id = @Id;

--        -- Commit the transaction if successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback the transaction if an error occurs
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Raise an error message with details
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;



