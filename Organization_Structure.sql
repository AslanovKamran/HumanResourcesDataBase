GO
USE SP_HR

GO
Create TABLE OrganizationStructures(
[Id] INT PRIMARY KEY,
[Code] NVARCHAR(10),
[Name] NVARCHAR (100),
[BeginningHistory] DATE,
[ParentId] INT NULL,
[FullName] NVARCHAR (255),
[FirstNumber] NVARCHAR (20),
[SecondNumber] NVARCHAR (20),
[TabelOrganization] INT,
[TabelPriority] INT,
[Canceled] BIT,
[OrderId] INT,
[HeadName] NVARCHAR (200),
[HeadPosition] NVARCHAR (200),
[IsSeaCoef] BIT
)


  

SELECT *
FROM OrganizationStructures
WHERE ParentId IS NOT NULL
AND ParentId NOT IN (SELECT Id FROM OrganizationStructures);
    

UPDATE OrganizationStructures
SET ParentId = NULL
WHERE ParentId NOT IN (SELECT Id FROM OrganizationStructures);


ALTER TABLE OrganizationStructures
ADD CONSTRAINT FK_OrganizationStructures_ParentId
FOREIGN KEY (ParentId) REFERENCES OrganizationStructures(Id);


CREATE TABLE OrganizationStructuresTemp (
    [Id] INT PRIMARY KEY,
    [Code] NVARCHAR(10),
    [Name] NVARCHAR (100),
    [BeginningHistory] DATE,
    [ParentId] INT NULL,
    [FullName] NVARCHAR (255),
    [FirstNumber] NVARCHAR (20),
    [SecondNumber] NVARCHAR (20),
    [TabelOrganization] INT,
    [TabelPriority] INT,
    [Canceled] BIT,
    [OrderId] INT,
    [HeadName] NVARCHAR (200),
    [HeadPosition] NVARCHAR (200),
    [IsSeaCoef] BIT
);

INSERT INTO OrganizationStructuresTemp (Id, Code, Name, BeginningHistory, ParentId, FullName, FirstNumber, SecondNumber, TabelOrganization, TabelPriority, Canceled, OrderId, HeadName, HeadPosition, IsSeaCoef)
SELECT Id, Code, Name, BeginningHistory, ParentId, FullName, FirstNumber, SecondNumber, TabelOrganization, TabelPriority, Canceled, OrderId, HeadName, HeadPosition, IsSeaCoef
FROM OrganizationStructures;



DROP TABLE OrganizationStructures;


CREATE TABLE OrganizationStructures (
    [Id] INT IDENTITY(780, 1) PRIMARY KEY,
    [Code] NVARCHAR(10),
    [Name] NVARCHAR (100),
    [BeginningHistory] DATE,
    [ParentId] INT NULL ,
    [FullName] NVARCHAR (255),
    [FirstNumber] NVARCHAR (20),
    [SecondNumber] NVARCHAR (20),
    [TabelOrganization] INT,
    [TabelPriority] INT,
    [Canceled] BIT,
    [OrderId] INT,
    [HeadName] NVARCHAR (200),
    [HeadPosition] NVARCHAR (200),
    [IsSeaCoef] BIT
);

SET IDENTITY_INSERT OrganizationStructures ON;


INSERT INTO OrganizationStructures (Id, Code, Name, BeginningHistory, ParentId, FullName, FirstNumber, SecondNumber, TabelOrganization, TabelPriority, Canceled, OrderId, HeadName, HeadPosition, IsSeaCoef)
SELECT Id, Code, Name, BeginningHistory, ParentId, FullName, FirstNumber, SecondNumber, TabelOrganization, TabelPriority, Canceled, OrderId, HeadName, HeadPosition, IsSeaCoef
FROM OrganizationStructuresTemp;

SET IDENTITY_INSERT OrganizationStructures OFF;

DROP TABLE OrganizationStructuresTemp;

GO
CREATE TRIGGER trg_StructureFullName
ON OrganizationStructures
AFTER INSERT, UPDATE
AS
BEGIN
    -- Step 1: Update the FullName for the directly inserted or updated rows
    UPDATE os
    SET FullName = 
        CASE	
            -- If the folder has a parent, concatenate the parent's FullName with the current folder's name
            WHEN i.ParentId IS NOT NULL THEN 
                (SELECT FullName FROM OrganizationStructures WHERE Id = i.ParentId) + '/' + i.Name	
            -- If it's a root folder (no parent), set the path as just the folder name
            ELSE '/' + i.Name
        END
    FROM 
        OrganizationStructures os
    INNER JOIN 
        inserted i ON os.Id = i.Id;

    -- Step 2: Recursively update the FullName of all child folders
    WITH RecursiveCTE AS (
        -- Anchor: Start with the rows that were just inserted or updated
        SELECT Id, ParentId, CAST(FullName AS NVARCHAR(255)) AS FullName
        FROM OrganizationStructures
        WHERE Id IN (SELECT Id FROM inserted)
        
        UNION ALL
        
        -- Recursive part: Find all child folders
        SELECT child.Id, child.ParentId, 
               CAST(parent.FullName + '/' + child.Name AS NVARCHAR(255)) AS FullName
        FROM OrganizationStructures child
        INNER JOIN RecursiveCTE parent ON child.ParentId = parent.Id
    )
    -- Perform the recursive update for all children
    UPDATE os
    SET FullName = rcte.FullName
    FROM OrganizationStructures os
    INNER JOIN RecursiveCTE rcte ON os.Id = rcte.Id;
END;

SELECT * FROM OrganizationStructures

GO
CREATE PROC OrganizationStructures_GetOrganizationStructures 
AS
BEGIN
SELECT 
[Id],
[Name],
[FullName],
[ParentId],
[Canceled]
FROM OrganizationStructures ORDER BY ParentId, Id
END


GO
CREATE PROC OrganizationStructures_GetExistingOrganizationStructures 
AS
BEGIN
SELECT 
[Id],
[Name],
[FullName],
[ParentId],
[Canceled]
FROM OrganizationStructures 
WHERE Canceled = 0
ORDER BY ParentId, Id
END

EXEC sp_rename 'OrganizationStructures.TabelOrganization', 'TabelOrganizationId', 'COLUMN';

ALTER TABLE OrganizationStructures
ADD CONSTRAINT FK_OrganizationStructures_TabelOrganizations FOREIGN KEY (TabelOrganizationId) 
REFERENCES TabelOrganizations(Id);


GO
CREATE PROC GetOrganizationStructureById @Id = 25 INT
AS
BEGIN
SELECT 
[Id] ,
[Code] ,
[Name] ,
[BeginningHistory] ,
[ParentId] ,
[FullName] ,
[FirstNumber] ,
[SecondNumber],
[TabelOrganizationId] ,
[TabelPriority] ,
[Canceled],
[HeadName] ,
[HeadPosition],
[IsSeaCoef] 
FROM OrganizationStructures
WHERE Id = @Id
END

SELECT * FROM OrganizationStructures WHERE Code is not null