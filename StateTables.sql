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

--ALTER TABLE StateTables
--ADD CONSTRAINT [FK_StateTables_StateWorkTypes] FOREIGN KEY (WorkTypeId)
--REFERENCES [StateWorkTypes] (Id);



----Data needed to display
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
--st.IsCanceled,
--st.ExcludeBankomat
--FROM StateTables AS ST
--LEFT JOIN OrganizationStructures AS OS ON ST.OrganizationStructureId = OS.Id
--LEFT JOIN StateWorkTypes AS SWT ON ST.WorkTypeId = SWT.Id
--WHERE st.ExcludeBankomat IS NOT NULL
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

--    -- Return paginated data including OccupiedPostCount calculation
--    SELECT 
--        st.Id,
--        st.Name,
--        st.UnitCount,
--        st.MonthlySalaryFrom,
--        st.MonthlySalaryTo,
--        -- Use the dynamically calculated OccupiedPostCount
--        (SELECT COUNT(*)
--         FROM Employees 
--         WHERE Employees.StateTableId = st.Id AND Employees.IsWorking = 1) AS OccupiedPostCount,
--        st.DocumentNumber,
--        st.DocumentDate,
--        st.WorkTypeId,
--        st.OrganizationStructureId,
--        st.WorkHours,
--        st.WorkHoursSaturday,
--        st.TabelPosition,
--        st.TabelPriority,
--        st.ExcludeBankomat,
--        -- Fetch the Degree column as-is (no COALESCE)
--        st.Degree,  -- Make sure we are correctly retrieving the Degree value
--        st.HourlySalary,
--        st.IsCanceled,
--        st.WorkingHoursSpecial,
--        st.MonthlySalaryExtra,
--        st.HarmfulnessCoefficient,
--        -- All columns from OrganizationStructures
--        os.Id,
--        os.Code,
--        os.Name,
--        os.BeginningHistory,
--        os.ParentId,
--        os.FullName,
--        os.FirstNumber,
--        os.SecondNumber,
--        os.TabelOrganizationId,
--        os.TabelPriority,
--        os.Canceled,
--        os.OrderId,
--        os.HeadName,
--        os.HeadPosition,
--        os.IsSeaCoef,
--        -- All columns from StateWorkTypes
--        swt.Id,
--        swt.Type
--    FROM StateTables AS st
--    LEFT JOIN OrganizationStructures AS os 
--        ON st.OrganizationStructureId = os.Id
--    LEFT JOIN StateWorkTypes AS swt 
--        ON st.WorkTypeId = swt.Id
--    WHERE (@ShowOnlyActive = 0 OR st.IsCanceled = 0)
--    ORDER BY st.Id  -- Order by the Id column to ensure correct pagination
--    OFFSET @Skip ROWS FETCH NEXT @Take ROWS ONLY;
--END;



--CREATE PROCEDURE GetStateTablesByOrganizationId
--    @OrganizationId INT,      
--    @ShowOnlyActive BIT = 1   
--AS
--BEGIN
--    SELECT 
--        st.Id,
--        st.Name,
--        st.UnitCount,
--        st.MonthlySalaryFrom,
--        st.MonthlySalaryTo,
--        -- Use the dynamically calculated OccupiedPostCount
--        (SELECT COUNT(*)
--         FROM Employees 
--         WHERE Employees.StateTableId = st.Id AND Employees.IsWorking = 1) AS OccupiedPostCount,
--        st.DocumentNumber,
--        st.DocumentDate,
--        st.WorkTypeId,
--        st.OrganizationStructureId,
--        st.WorkHours,
--        st.WorkHoursSaturday,
--        st.TabelPosition,
--        st.TabelPriority,
--        st.ExcludeBankomat,
--        -- Fetch the Degree column as-is (no COALESCE)
--        st.Degree,  -- Make sure we are correctly retrieving the Degree value
--        st.HourlySalary,
--        st.IsCanceled,
--        st.WorkingHoursSpecial,
--        st.MonthlySalaryExtra,
--        st.HarmfulnessCoefficient,
--        -- All columns from OrganizationStructures
--        os.Id,
--        os.Code,
--        os.Name,
--        os.BeginningHistory,
--        os.ParentId,
--        os.FullName,
--        os.FirstNumber,
--        os.SecondNumber,
--        os.TabelOrganizationId,
--        os.TabelPriority,
--        os.Canceled,
--        os.OrderId,
--        os.HeadName,
--        os.HeadPosition,
--        os.IsSeaCoef,
--        -- All columns from StateWorkTypes
--        swt.Id,
--        swt.Type
--    FROM StateTables AS st
--    LEFT JOIN OrganizationStructures AS os 
--        ON st.OrganizationStructureId = os.Id
--    LEFT JOIN StateWorkTypes AS swt 
--        ON st.WorkTypeId = swt.Id
--   WHERE st.OrganizationStructureId = @OrganizationId
--    AND (@ShowOnlyActive = 0 OR st.IsCanceled = 0)  -- Conditionally filter by IsCanceled
--    ORDER BY st.Id  -- Order by the Id column to ensure correct pagination
--END;









--GO
--CREATE PROCEDURE UpdateStateTable
--    @Id INT,
--    @Name NVARCHAR(100),
--    @Degree INT,
--    @UnitCount INT,
--    @MonthlySalaryFrom INT,
--    @HourlySalary DECIMAL(9,2),
--    @MonthlySalaryExtra INT,
--    @OccupiedPostCount INT,
--    @DocumentNumber NVARCHAR(100),
--    @DocumentDate DATE,
--    @WorkTypeId INT,
--    @OrganizationStructureId INT,
--    @HarmfulnessCoefficient INT,
--    @WorkHours INT,
--	@WorkingHoursSpecial NVARCHAR(100),
--    @WorkHoursSaturday INT,
--    @TabelPriority INT,
--    @TabelPosition INT,
--    @IsCanceled BIT
--AS
--BEGIN
--    -- Start a transaction
--    BEGIN TRY
--        BEGIN TRANSACTION;

--        -- Check if the WorkTypeId exists in the StateWorkTypes table
--        IF NOT EXISTS (SELECT 1 FROM StateWorkTypes WHERE Id = @WorkTypeId)
--        BEGIN
--            THROW 50000, 'Invalid Foreign Key: No matching StateWorkType found.', 1;
--        END

--        -- Check if the OrganizationStructureId exists in the OrganizationStructures table
--        IF NOT EXISTS (SELECT 1 FROM OrganizationStructures WHERE Id = @OrganizationStructureId)
--        BEGIN
--            THROW 50001, 'Invalid Foreign Key: No OrganizationStructure found.', 1;
--        END

--        -- Update the StateTable record
--        UPDATE StateTables
--        SET 
--            Name = @Name,
--            Degree = @Degree,
--            UnitCount = @UnitCount,
--            MonthlySalaryFrom = @MonthlySalaryFrom,
--            HourlySalary = @HourlySalary,
--            MonthlySalaryExtra = @MonthlySalaryExtra,
--            OccupiedPostCount = @OccupiedPostCount,
--            DocumentNumber = @DocumentNumber,
--            DocumentDate = @DocumentDate,
--            WorkTypeId = @WorkTypeId,
--            OrganizationStructureId = @OrganizationStructureId,  -- New field added here
--            HarmfulnessCoefficient = @HarmfulnessCoefficient,
--            WorkHours = @WorkHours,
--			WorkingHoursSpecial = @WorkingHoursSpecial,
--            WorkHoursSaturday = @WorkHoursSaturday,
--            TabelPriority = @TabelPriority,
--            TabelPosition = @TabelPosition,
--            IsCanceled = @IsCanceled
--        WHERE Id = @Id;

--        -- Commit the transaction if everything is successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback the transaction in case of an error
--        IF @@TRANCOUNT > 0
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END

--        -- Rethrow the error
--        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
--        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;



--GO
--CREATE PROCEDURE AddStateTable
--    @Name NVARCHAR(100),
--    @UnitCount INT,
--    @MonthlySalaryFrom INT,
--    @MonthlySalaryTo INT,
--    @OccupiedPostCount INT,
--    @DocumentNumber NVARCHAR(100),
--    @DocumentDate DATE,
--    @OrganizationStructureId INT,
--    @WorkTypeId INT,
--    @WorkHours INT,
--    @WorkHoursSaturday INT,
--    @TabelPosition INT,
--    @TabelPriority INT,
--    @ExcludeBankomat INT,
--    @Degree INT,
--    @HourlySalary DECIMAL(9,2),
--    @IsCanceled BIT,
--    @WorkingHoursSpecial NVARCHAR(100),
--    @MonthlySalaryExtra INT,
--    @HarmfulnessCoefficient INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start the transaction
--        BEGIN TRANSACTION;

--        -- Check if OrganizationStructureId exists
--        IF NOT EXISTS (SELECT 1 FROM OrganizationStructures WHERE Id = @OrganizationStructureId)
--        BEGIN
--            THROW 50001, 'Invalid OrganizationStructureId', 1;
--        END

--        -- Check if WorkTypeId exists
--        IF NOT EXISTS (SELECT 1 FROM StateWorkTypes WHERE Id = @WorkTypeId)
--        BEGIN
--            THROW 50002, 'Invalid WorkTypeId', 1;
--        END

--        -- Insert new StateTable
--        INSERT INTO StateTables
--        (
--            [Name],
--            [UnitCount],
--            [MonthlySalaryFrom],
--            [MonthlySalaryTo],
--            [OccupiedPostCount],
--            [DocumentNumber],
--            [DocumentDate],
--            [OrganizationStructureId],
--            [WorkTypeId],
--            [WorkHours],
--            [WorkHoursSaturday],
--            [TabelPosition],
--            [TabelPriority],
--            [ExcludeBankomat],
--            [Degree],
--            [HourlySalary],
--            [IsCanceled],
--            [WorkingHoursSpecial],
--            [MonthlySalaryExtra],
--            [HarmfulnessCoefficient]
--        )
--        VALUES
--        (
--            @Name,
--            @UnitCount,
--            @MonthlySalaryFrom,
--            @MonthlySalaryTo,
--            @OccupiedPostCount,
--            @DocumentNumber,
--            @DocumentDate,
--            @OrganizationStructureId,
--            @WorkTypeId,
--            @WorkHours,
--            @WorkHoursSaturday,
--            @TabelPosition,
--            @TabelPriority,
--            @ExcludeBankomat,
--            @Degree,
--            @HourlySalary,
--            @IsCanceled,
--            @WorkingHoursSpecial,
--            @MonthlySalaryExtra,
--            @HarmfulnessCoefficient
--        );

--        -- Commit the transaction if successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback the transaction in case of error
--        IF @@TRANCOUNT > 0
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END;

--        -- Throw the original error (with proper semicolon before THROW)
--        THROW;
--    END CATCH
--END


--GO
--CREATE PROCEDURE SoftDeleteStateTable
--    @Id INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Check if the StateTable with the given Id exists
--        IF NOT EXISTS (SELECT 1 FROM StateTables WHERE Id = @Id)
--        BEGIN
--            THROW 50000, 'No matching StateTable found.', 1;
--        END

--        -- Update the IsCanceled field to true for the given Id
--        UPDATE StateTables
--        SET IsCanceled = 1
--        WHERE Id = @Id;

--        -- Commit the transaction if everything is successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback the transaction in case of an error
--        IF @@TRANCOUNT > 0
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END

--        -- Rethrow the error
--        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
--        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;




--GO
--CREATE PROCEDURE SoftDeleteOrganizationStructure
--    @Id INT
--AS
--BEGIN
--    -- Start a transaction
--    BEGIN TRY
--        BEGIN TRANSACTION;

--        -- Check if the OrganizationStructure exists
--        IF NOT EXISTS (SELECT 1 FROM OrganizationStructures WHERE Id = @Id)
--        BEGIN
--            THROW 50000, 'Invalid OrganizationStructure: No matching record found.', 1;
--        END

--        -- Soft delete by setting the Canceled field to 1
--        UPDATE OrganizationStructures
--        SET Canceled = 1
--        WHERE Id = @Id;

--        -- Commit the transaction if everything is successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback the transaction in case of an error
--        IF @@TRANCOUNT > 0
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END

--        -- Rethrow the error
--        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
--        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;

