--GO
--USE SP_HR



--GO
--CREATE TABLE OrganizationStructures(
--[Id] INT PRIMARY KEY,
--[Code] NVARCHAR(10),
--[Name] NVARCHAR (100),
--[BeginningHistory] DATE,
--[ParentId] INT NULL,
--[FullName] NVARCHAR (255),
--[FirstNumber] NVARCHAR (20),
--[SecondNumber] NVARCHAR (20),
--[TabelOrganizationId] INT FOREIGN KEY REFERENCES TabelOrganizations(Id),
--[TabelPriority] INT,
--[Canceled] BIT,
--[OrderId] INT,
--[HeadName] NVARCHAR (200),
--[HeadPosition] NVARCHAR (200),
--[IsSeaCoef] BIT
--)


  
--SELECT *
--FROM OrganizationStructures
--WHERE ParentId IS NOT NULL
--AND ParentId NOT IN (SELECT Id FROM OrganizationStructures);
    

--UPDATE OrganizationStructures
--SET ParentId = NULL
--WHERE ParentId NOT IN (SELECT Id FROM OrganizationStructures);


ALTER TABLE OrganizationStructures
ADD CONSTRAINT FK_OrganizationStructures_ParentId
FOREIGN KEY (ParentId) REFERENCES OrganizationStructures(Id);

--UPDATE OrganizationStructures SET IsSeaCoef = 0 WHERE IsSeaCoef IS NULL


--CREATE TABLE OrganizationStructuresTemp (
--    [Id] INT PRIMARY KEY,
--    [Code] NVARCHAR(10),
--    [Name] NVARCHAR (100),
--    [BeginningHistory] DATE,
--    [ParentId] INT NULL,
--    [FullName] NVARCHAR (255),
--    [FirstNumber] NVARCHAR (20),
--    [SecondNumber] NVARCHAR (20),
--    [TabelOrganizationId] INT FOREIGN KEY REFERENCES TabelOrganizations(Id),
--    [TabelPriority] INT,
--    [Canceled] BIT,
--    [OrderId] INT,
--    [HeadName] NVARCHAR (200),
--    [HeadPosition] NVARCHAR (200),
--    [IsSeaCoef] BIT
--);

--INSERT INTO OrganizationStructuresTemp (Id, Code, Name, BeginningHistory, ParentId, FullName, FirstNumber, SecondNumber, TabelOrganizationId, TabelPriority, Canceled, OrderId, HeadName, HeadPosition, IsSeaCoef)
--SELECT Id, Code, Name, BeginningHistory, ParentId, FullName, FirstNumber, SecondNumber, TabelOrganizationId, TabelPriority, Canceled, OrderId, HeadName, HeadPosition, IsSeaCoef
--FROM OrganizationStructures;

--SELECT * FROM OrganizationStructuresTemp ORDER BY Id DESC -- The last Id is 779

--DROP TABLE OrganizationStructures;


--CREATE TABLE OrganizationStructures (
--    [Id] INT IDENTITY(780, 1) PRIMARY KEY,
--    [Code] NVARCHAR(10),
--    [Name] NVARCHAR (100),
--    [BeginningHistory] DATE,
--    [ParentId] INT NULL ,
--    [FullName] NVARCHAR (255),
--    [FirstNumber] NVARCHAR (20),
--    [SecondNumber] NVARCHAR (20),
--    [TabelOrganizationId] INT FOREIGN KEY REFERENCES TabelOrganizations(Id),
--    [TabelPriority] INT,
--    [Canceled] BIT,
--    [OrderId] INT,
--    [HeadName] NVARCHAR (200),
--    [HeadPosition] NVARCHAR (200),
--    [IsSeaCoef] BIT
--);

--SET IDENTITY_INSERT OrganizationStructures ON;


--INSERT INTO OrganizationStructures (Id, Code, Name, BeginningHistory, ParentId, FullName, FirstNumber, SecondNumber, TabelOrganizationId, TabelPriority, Canceled, OrderId, HeadName, HeadPosition, IsSeaCoef)
--SELECT Id, Code, Name, BeginningHistory, ParentId, FullName, FirstNumber, SecondNumber, TabelOrganizationId, TabelPriority, Canceled, OrderId, HeadName, HeadPosition, IsSeaCoef
--FROM OrganizationStructuresTemp;

--SET IDENTITY_INSERT OrganizationStructures OFF;

--DROP TABLE OrganizationStructuresTemp;

--GO
--CREATE TRIGGER trg_StructureFullName
--ON OrganizationStructures
--AFTER INSERT, UPDATE
--AS
--BEGIN
--    -- Step 1: Update the FullName for the directly inserted or updated rows
--    UPDATE os
--    SET FullName = 
--        CASE	
--            -- If the folder has a parent, concatenate the parent's FullName with the current folder's name
--            WHEN i.ParentId IS NOT NULL THEN 
--                (SELECT FullName FROM OrganizationStructures WHERE Id = i.ParentId) + '/' + i.Name	
--            -- If it's a root folder (no parent), set the path as just the folder name
--            ELSE '/' + i.Name
--        END
--    FROM 
--        OrganizationStructures os
--    INNER JOIN 
--        inserted i ON os.Id = i.Id;

--    -- Step 2: Recursively update the FullName of all child folders
--    WITH RecursiveCTE AS (
--        -- Anchor: Start with the rows that were just inserted or updated
--        SELECT Id, ParentId, CAST(FullName AS NVARCHAR(255)) AS FullName
--        FROM OrganizationStructures
--        WHERE Id IN (SELECT Id FROM inserted)
        
--        UNION ALL
        
--        -- Recursive part: Find all child folders
--        SELECT child.Id, child.ParentId, 
--               CAST(parent.FullName + '/' + child.Name AS NVARCHAR(255)) AS FullName
--        FROM OrganizationStructures child
--        INNER JOIN RecursiveCTE parent ON child.ParentId = parent.Id
--    )
--    -- Perform the recursive update for all children
--    UPDATE os
--    SET FullName = rcte.FullName
--    FROM OrganizationStructures os
--    INNER JOIN RecursiveCTE rcte ON os.Id = rcte.Id;
--END;

--SELECT * FROM OrganizationStructures ORDER BY Id DESC

--GO
--CREATE PROC OrganizationStructures_GetOrganizationStructures 
--AS
--BEGIN
--SELECT 
--[Id],
--[Name],
--[FullName],
--[ParentId],
--[Canceled]
--FROM OrganizationStructures ORDER BY ParentId, Id
--END



--GO
--CREATE PROC OrganizationStructures_GetExistingOrganizationStructures 
--AS
--BEGIN
--SELECT 
--[Id],
--[Name],
--[FullName],
--[ParentId],
--[Canceled]
--FROM OrganizationStructures 
--WHERE Canceled = 0
--ORDER BY ParentId, Id
--END


--GO
--CREATE PROC GetOrganizationStructureById @Id  INT
--AS
--BEGIN
--SELECT 
--[Id] ,
--[Code] ,
--[Name] ,
--[BeginningHistory] ,
--[ParentId] ,
--[FullName] ,
--[FirstNumber] ,
--[SecondNumber],
--[TabelOrganizationId],
--[TabelPriority] ,
--[Canceled],
--[HeadName] ,
--[HeadPosition],
--[IsSeaCoef] 
--FROM OrganizationStructures
--WHERE Id = @Id
--END

--GO
--CREATE PROC AddOrganizationStructure
-- @Code NVARCHAR(10),
-- @Name NVARCHAR(100),
-- @BeginningHistory DATE,
-- @FirstNumber NVARCHAR(20),
-- @SecondNumber NVARCHAR(20),
-- @ParentId INT
--AS
--BEGIN
--    BEGIN TRY
--	  -- Start the transaction
--	  BEGIN TRANSACTION;
--        -- Check if required fields are provided
--        IF (@Name IS NULL OR LTRIM(RTRIM(@Name)) = '')
--        BEGIN
--            RAISERROR('Name cannot be NULL', 16, 1)
--            RETURN
--        END

--		 DECLARE @InsertedData TABLE (
--            Code  NVARCHAR(10),
--            Name NVARCHAR(100),
--            BeginningHistory DATE,
--            FirstNumber NVARCHAR(20),
--            SecondNumber NVARCHAR(20),
--            ParentId INT
--        );

--        -- Check if ParentId exists in the OrganizationStructures table (if ParentId is not NULL)
--        IF @ParentId IS NOT NULL AND NOT EXISTS (SELECT 1 FROM OrganizationStructures WHERE Id = @ParentId)
--        BEGIN
--            RAISERROR('ParentId does not exist', 16, 1)
--            RETURN
--        END

--        -- Insert new OrganizationStructure
--        INSERT INTO OrganizationStructures (Code, Name, BeginningHistory, FirstNumber, SecondNumber, ParentId)
--		       OUTPUT inserted.Code, inserted.Name, inserted.BeginningHistory, inserted.FirstNumber, inserted.SecondNumber, inserted.ParentId
--			   INTO @InsertedData -- Insert into the table variable
--        VALUES (@Code, @Name, @BeginningHistory, @FirstNumber, @SecondNumber, @ParentId)
--          -- Commit the transaction if all goes well
--        COMMIT TRANSACTION;
--		SELECT * FROM @InsertedData;
--    END TRY
--    BEGIN CATCH

--	  -- Rollback the transaction if an error occurs
--        IF @@TRANCOUNT > 0
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END
--        -- Handle any errors that occur during the execution
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        RAISERROR(@ErrorMessage, 16, 1);
--    END CATCH
--END


--ALTER TABLE OrganizationStructures
--ADD CONSTRAINT [DF_OrganizationStructures_Canceled] DEFAULT 0 FOR Canceled;

--ALTER TABLE OrganizationStructures
--ADD CONSTRAINT [DF_OrganizationStructures_IsSeaCoef] DEFAULT 0 FOR IsSeaCoef;


--SELECT * FROM OrganizationStructures ORDER BY Id Desc

--DELETE FROM OrganizationStructures WHERE Id>=780

--GO
--CREATE PROC UpdateOrganizationStructure 
--@Id INT,
--@Code NVARCHAR(10),
--@Name NVARCHAR (100),
--@BeginningHistory DATE,
--@FirstNumber NVARCHAR (20),
--@SecondNumber NVARCHAR (20),
--@TabelOrganizationId INT,
--@TabelPriority INT,
--@Canceled BIT,
--@HeadName NVARCHAR (200),
--@HeadPosition NVARCHAR (200),
--@IsSeaCoef BIT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Perform the update
--        UPDATE OrganizationStructures
--        SET 
--            [Code] = @Code,
--            [Name] = @Name,
--            [BeginningHistory] = @BeginningHistory,
--            [FirstNumber] = @FirstNumber,
--            [SecondNumber] = @SecondNumber,
--            [TabelOrganizationId] = @TabelOrganizationId,
--            [TabelPriority] = @TabelPriority,
--            [Canceled] = @Canceled,
--            [HeadName] = @HeadName,
--            [HeadPosition] = @HeadPosition,
--            [IsSeaCoef] = @IsSeaCoef
--        WHERE [Id] = @Id;

--        -- Retrieve and return the updated data
--        SELECT 
--            [Id],
--            [Code],
--            [Name],
--            [BeginningHistory],
--            [FirstNumber],
--            [SecondNumber],
--            [TabelOrganizationId],
--            [TabelPriority],
--            [Canceled],
--            [HeadName],
--            [HeadPosition],
--            [IsSeaCoef]
--        FROM OrganizationStructures
--        WHERE [Id] = @Id;

--        -- Commit the transaction if successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction if an error occurs
--        IF @@TRANCOUNT > 0
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END

--        -- Return the error message to the client
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        RAISERROR(@ErrorMessage, 16, 1);
--    END CATCH
--END


----ALTER TABLE StateTables
----ADD CONSTRAINT FK_StateTables_OrganizationStructures
----FOREIGN KEY (OrganizationStructureId) REFERENCES OrganizationStructures(Id);


--DELETE FROM OrganizationStructures WHERE Id >= 780