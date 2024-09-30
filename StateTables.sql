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


SELECT * FROM StateTables

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

ALTER TABLE StateTables
ADD CONSTRAINT [FK_StateTables_StateWorkTypes] FOREIGN KEY (WorkTypeId)
REFERENCES [StateWorkTypes] (Id);












------Data needed to display
--SELECT 
--OS.FullName, 
--st.Name, 
--st.Degree, 
--st.UnitCount, 
--st.MonthlySalaryFrom, 
--st.HourlySalary, 
--st.MonthlySalaryExtra,
--st.OccupiedPostCount, 
--st.DocumentNumber, 
--st.DocumentDate,
--SWT.Type,
--st.HarmfulnessCoefficient,
--st.WorkHours,
--st.WorkHoursSaturday,
--st.TabelPriority,
--st.TabelPosition,
--st.IsCanceled 
--FROM StateTables AS ST
--LEFT JOIN OrganizationStructures AS OS ON ST.OrganizationStructureId = OS.Id
--LEFT JOIN StateWorkTypes AS SWT ON ST.WorkTypeId = SWT.Id
--WHERE OS.Id = 384
--ORDER BY st.Degree DESC


--CREATE PROCEDURE GetStateTablesWithCount
--    @ShowOnlyActive BIT = 1,    -- If 1, show only active state tables; if 0, show all
--    @Skip INT = 0,              -- Number of records to skip (OFFSET)
--    @Take INT = 30              -- Number of records to take (FETCH)
--AS
--BEGIN
--    -- Return total count of state tables
--    SELECT COUNT(*) AS TotalCount
--    FROM StateTables
--    WHERE (@ShowOnlyActive = 0 OR IsCanceled = 0);

--    -- Return paginated data
--    SELECT 
--        st.*, 
--        os.*, 
--        swt.*
--    FROM StateTables AS st
--    LEFT JOIN OrganizationStructures AS os 
--        ON st.OrganizationStructureId = os.Id
--    LEFT JOIN StateWorkTypes AS swt 
--        ON st.WorkTypeId = swt.Id
--    WHERE (@ShowOnlyActive = 0 OR st.IsCanceled = 0)
--    ORDER BY st.Id  -- Order by the Id column to ensure correct pagination
--    OFFSET @Skip ROWS FETCH NEXT @Take ROWS ONLY;
--END;


// NOT CREATED
GO
CREATE PROCEDURE GetStateTablesByOrganizationId
    @OrganizationId INT,      
    @ShowOnlyActive BIT = 1   
AS
BEGIN
    SELECT 
        st.*, 
        os.*, 
        swt.*
    FROM StateTables AS st
    LEFT JOIN OrganizationStructures AS os 
        ON st.OrganizationStructureId = os.Id
    LEFT JOIN StateWorkTypes AS swt 
        ON st.WorkTypeId = swt.Id
    WHERE st.OrganizationStructureId = @OrganizationId
    AND (@ShowOnlyActive = 0 OR st.IsCanceled = 0);  -- Conditionally filter by IsCanceled
END;



