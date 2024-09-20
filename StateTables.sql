--GO
--USE SP_HR

--GO 
--CREATE TABLE StateTables(
--[Id] INT PRIMARY KEY,
--[Name] NVARCHAR (100),
--[UnitCount] INT,
--[MonthlySalaryFrom] INT NULL,
--[MonthlySalaryTo] INT NULL,
--[OccupiedPostCount] INT NULL ,
--[DocumentNumber] NVARCHAR(100) NULL,
--[DocumentDate] DATE NULL,
--[OrganizationStructureId] INT FOREIGN KEY REFERENCES OrganizationStructures(Id),
--[WorkTypeId] INT,
--[WorkHours] INT NULL,
--[WorkHoursSaturday] INT NULL,
--[TabelPosition] INT NULL,
--[TabelPriority] INT NULL,
--[ExcludeBankomat] INT NULL,
--[Degree] INT NULL,
--[HourlySalary] DECIMAL (9,2) NULL,
--[IsCanceled] BIT,
--[WorkingHoursSpecial] NVARCHAR(100) NULL,
--[MonthlySalaryExtra] INT NULL,
--[HarmfulnessCoefficient] INT NULL
--)


----Bulk Inser Data



----Adding Identity
--SELECT * INTO StateTables_Temp
--FROM StateTables;

---- Drop foreign key constraints first if any
--ALTER TABLE StateTables DROP CONSTRAINT PK_StateTables_Id;

---- Drop or rename the original table
--DROP TABLE StateTables;


--CREATE TABLE StateTables (
--    [Id] INT IDENTITY(7635,1) PRIMARY KEY,
--    [Name] NVARCHAR (100),
--    [UnitCount] INT,
--    [MonthlySalaryFrom] INT NULL,
--    [MonthlySalaryTo] INT NULL,
--    [OccupiedPostCount] INT NULL,
--    [DocumentNumber] NVARCHAR(100) NULL,
--    [DocumentDate] DATE NULL,
--    [OrganizationStructureId] INT FOREIGN KEY REFERENCES OrganizationStructures(Id),
--    [WorkTypeId] INT,
--    [WorkHours] INT NULL,
--    [WorkHoursSaturday] INT NULL,
--    [TabelPosition] INT NULL,
--    [TabelPriority] INT NULL,
--    [ExcludeBankomat] INT NULL,
--    [Degree] INT NULL,
--    [HourlySalary] DECIMAL (9,2) NULL,
--    [IsCanceled] BIT,
--    [WorkingHoursSpecial] NVARCHAR(100) NULL,
--    [MonthlySalaryExtra] INT NULL,
--    [HarmfulnessCoefficient] INT NULL
--);


--SET IDENTITY_INSERT StateTables ON;

--INSERT INTO StateTables (
--    [Id], [Name], [UnitCount], [MonthlySalaryFrom], [MonthlySalaryTo], 
--    [OccupiedPostCount], [DocumentNumber], [DocumentDate], [OrganizationStructureId], 
--    [WorkTypeId], [WorkHours], [WorkHoursSaturday], [TabelPosition], [TabelPriority], 
--    [ExcludeBankomat], [Degree], [HourlySalary], [IsCanceled], [WorkingHoursSpecial], 
--    [MonthlySalaryExtra], [HarmfulnessCoefficient]
--)
--SELECT * FROM StateTables_Temp;

--SET IDENTITY_INSERT StateTables OFF;

--CREATE INDEX IX_StateTables_Name ON StateTables ([Name]);

--GO 
--CREATE PROC GetStateTablesDemo -- Not created
--AS
--BEGIN
--SELECT 
--OS.FullName,
--ST.Name, 
--ST.Degree, 
--ST.UnitCount,
--ST.MonthlySalaryFrom, 
--ST.HourlySalary,
--ST.MonthlySalaryExtra,
--ST.OccupiedPostCount,
--ST.DocumentNumber,
--ST.DocumentDate,
--SWT.Type,
--ST.HarmfulnessCoefficient,
--ST.WorkHours,
--ST.WorkHoursSaturday,
--ST.TabelPriority,
--ST.TabelPosition
--FROM StateTables as ST 
--JOIN OrganizationStructures AS OS ON OS.Id = ST.OrganizationStructureId
--JOIN StateWorkTypes AS SWT ON ST.WorkTypeId = SWT.Id
--WHERE Type IS NOT  NULL
--ORDER BY OS.FullName
--END