GO
USE SP_HR

--GO 
--CREATE TABLE Awards 
--(
--[Id] INT PRIMARY KEY,
--[OrderDate] DATETIME,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
--[Note] NVARCHAR (1000) NULL,
--[TypeId] INT ,
--[OrderNumber] NVARCHAR (255),
--[Amount] NVARCHAR (255)
--)

--ALTER TABLE Awards
--ADD CONSTRAINT FK_AWARD_TYPES
--FOREIGN KEY (TypeId)
--REFERENCES AwardTypes(Id);

--IDENTITY NOT SET

------DROPPING Identity
---- 1. Add a new non-nullable column `NewId`
--ALTER TABLE Awards ADD NewId INT NOT NULL DEFAULT 0;

---- 2. Copy values from `Id` to `NewId`
--UPDATE Awards SET NewId = Id;

---- 3. Drop the original nullable `Id` column
--ALTER TABLE Awards DROP COLUMN Id;

---- 4. Rename `NewId` to `Id`
--EXEC sp_rename 'Awards.NewId', 'Id', 'COLUMN';

---- 5. Add the primary key constraint to `Id`
--ALTER TABLE Awards ADD CONSTRAINT PK_Awards_Id PRIMARY KEY (Id);



--GO
--CREATE PROC GetAwards 
--    @EmployeeId  INT
--AS
--BEGIN
--    IF @EmployeeId IS NULL
--    BEGIN
--        RAISERROR('EmployeeId cannot be null', 16, 1);
--        RETURN;
--    END

--    SELECT 
--        Awards.Id, 
--        Awards.OrderDate,
--        AwardTypes.Description AS AwardTypeDescription,
--        Awards.OrderNumber,
--        Awards.Amount,
--        Awards.Note,
--		  Awards.EmployeeId
--    FROM Awards 
--    LEFT JOIN AwardTypes ON AwardTypes.Id = Awards.TypeId
--    WHERE Awards.EmployeeId = @EmployeeId
--    ORDER BY Awards.OrderDate ASC;
--END;


 

--GO
--CREATE PROC UpdateAward
--    @Id INT,
--    @OrderDate DATETIME,
--    @Note NVARCHAR(1000),
--    @TypeId INT,
--    @OrderNumber NVARCHAR(255),
--    @Amount NVARCHAR(255)
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Update the Awards record
--        UPDATE Awards
--        SET 
--            OrderDate = @OrderDate,
--            Note = @Note,
--            TypeId = @TypeId,
--            OrderNumber = @OrderNumber,
--            Amount = @Amount
--        WHERE Id = @Id;

--        -- Commit the transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Roll back transaction if an error occurs
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Raise an error message
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;


--GO
--CREATE PROC AddAward
--    @OrderDate DATETIME,
--    @EmployeeId INT,
--    @Note NVARCHAR(1000),
--    @TypeId INT,
--    @OrderNumber NVARCHAR(255),
--    @Amount NVARCHAR(255)
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Insert the new Award record with manually specified Id
--        INSERT INTO Awards ( OrderDate, EmployeeId, Note, TypeId, OrderNumber, Amount)
--        VALUES ( @OrderDate, @EmployeeId, @Note, @TypeId, @OrderNumber, @Amount);

--        -- Commit the transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Roll back transaction if an error occurs
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Raise an error message
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;


--GO
--CREATE PROC DeleteAward
--    @Id INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Delete the award record by Id
--        DELETE FROM Awards
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
