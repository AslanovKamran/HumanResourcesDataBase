GO
USE SP_HR


--SELECT * FROM EducationKinds

--GO
--CREATE TABLE Educations 
--(
--[Id] INT PRIMARY KEY,
--[Speciality] NVARCHAR (255) NULL,
--[Institution] NVARCHAR (255) NULL,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
--[EducationTypeId] INT FOREIGN KEY REFERENCES EducationTypes(Id) NULL,
--[DiplomaTypeId] INT FOREIGN KEY REFERENCES DiplomaTypes(Id) NULL,
--[DiplomaNumber] NVARCHAR (255) NULL,
--[EducationKindId] INT FOREIGN KEY REFERENCES EducationKinds(Id),
--[EducationStartedAt] DATE NULL,
--[EducationEndedAt] DATE NULL
--)

-- Bulk insert here

--Identity Not Set


--GO
--CREATE PROC GetEmployeesEducation @EmployeeId INT
--AS
--BEGIN
--SELECT 
--edu.Id,
--et.Type AS [EducationType],
--edu.Institution, 
--edu.Speciality,
--ek.Kind AS [EducationKind],
--edu.EducationStartedAt,
--edu.EducationEndedAt,
--edu.DiplomaNumber,
--dt.Type AS [DiplomaType], 
--edu.EmployeeId
--FROM Educations as edu
--JOIN DiplomaTypes dt on dt.Id	= edu.DiplomaTypeId
--JOIN EducationKinds ek on ek.id = edu.EducationKindId
--JOIN EducationTypes et on et.Id = edu.EducationTypeId
--where edu.EmployeeId = @EmployeeId
--ORDER BY edu.EducationStartedAt ASC
--END


--GO
--CREATE PROC UpdateEmployeesEducation
--    @Id INT,
--    @EducationTypeId INT,
--    @Institution NVARCHAR(255),
--    @Speciality NVARCHAR(255),
--    @EducationKindId INT,
--    @EducationStartedAt DATE,
--    @EducationEndedAt DATE,
--    @DiplomaTypeId INT,
--    @DiplomaNumber NVARCHAR(255)
--AS
--BEGIN
--    BEGIN TRY
--        BEGIN TRANSACTION;

--        -- Ensure that EducationEndedAt is after EducationStartedAt
--        IF @EducationEndedAt < @EducationStartedAt
--        BEGIN
--            RAISERROR ('Education end date must be after the start date', 16, 1);
--            ROLLBACK TRANSACTION;
--            RETURN;
--        END

--        -- Check if the record with @Id exists
--        IF NOT EXISTS (SELECT 1 FROM Educations WHERE Id = @Id)
--        BEGIN
--            RAISERROR ('Education record with the specified Id does not exist', 16, 1);
--            ROLLBACK TRANSACTION;
--            RETURN;
--        END

--        -- Update the education record
--        UPDATE Educations 
--        SET 
--            EducationTypeId = @EducationTypeId,
--            Institution = @Institution,
--            Speciality = @Speciality,
--            EducationKindId = @EducationKindId,
--            EducationStartedAt = @EducationStartedAt,
--            EducationEndedAt = @EducationEndedAt,
--            DiplomaTypeId = @DiplomaTypeId,
--            DiplomaNumber = @DiplomaNumber
--        WHERE Id = @Id;

--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction and return error message
--        IF XACT_STATE() <> 0 
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END

--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();

--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;



--GO
--CREATE PROCEDURE AddEmloyeesEducation
--    @EducationTypeId INT,
--    @Institution NVARCHAR(255),
--    @Speciality NVARCHAR(255),
--    @EducationKindId INT,
--    @EducationStartedAt DATE,
--    @EducationEndedAt DATE,
--    @DiplomaTypeId INT,
--    @DiplomaNumber NVARCHAR(255),
--    @EmployeeId INT
--AS
--BEGIN
--    BEGIN TRY
--        BEGIN TRANSACTION;

--        -- Ensure that EducationEndedAt is after EducationStartedAt
--        IF @EducationEndedAt < @EducationStartedAt
--        BEGIN
--            RAISERROR ('Education end date must be after the start date', 16, 1);
--            ROLLBACK TRANSACTION;
--            RETURN;
--        END

--        -- Insert new education record with explicit Id value
--        INSERT INTO Educations (
--            EducationTypeId,
--            Institution,
--            Speciality,
--            EducationKindId,
--            EducationStartedAt,
--            EducationEndedAt,
--            DiplomaTypeId,
--            DiplomaNumber,
--            EmployeeId
--        )
--        VALUES (
--            @EducationTypeId,
--            @Institution,
--            @Speciality,
--            @EducationKindId,
--            @EducationStartedAt,
--            @EducationEndedAt,
--            @DiplomaTypeId,
--            @DiplomaNumber,
--            @EmployeeId
--        );

--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction in case of error
--        ROLLBACK TRANSACTION;

--        -- Raise the error with the original details
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
        
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;


--GO
--CREATE PROCEDURE DeleteEmployeesEducation
--    @Id INT
--AS
--BEGIN
--    BEGIN TRY
--        BEGIN TRANSACTION;

--        -- Check if the record exists
--        IF NOT EXISTS (SELECT 1 FROM Educations WHERE Id = @Id)
--        BEGIN
--            RAISERROR ('Education record with the specified Id does not exist', 16, 1);
--            ROLLBACK TRANSACTION;
--            RETURN;
--        END

--        -- Delete the education record
--        DELETE FROM Educations WHERE Id = @Id;

--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction in case of error
--        ROLLBACK TRANSACTION;

--        -- Raise the error with the original details
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
        
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;

