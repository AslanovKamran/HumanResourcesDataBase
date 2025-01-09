GO
USE SP_HR

--GO
--CREATE TABLE Employees(
--[Id] INT PRIMARY KEY,
--[Surname] NVARCHAR (100) NOT NULL,
--[Name] NVARCHAR (100) NOT NULL,
--[FatherName] NVARCHAR (100) NOT NULL,
--[BirthPlace] NVARCHAR (255) NULL,
--[BirthDate] DATE NULL,
--[GenderId] INT FOREIGN KEY REFERENCES Genders(Id), --1 For Male | 2 For Female
--[MaritalStatusId] INT FOREIGN KEY REFERENCES MaritalStatuses(Id), --1 For Married | 2 For Single  
--[SocialInsuranceNumber] NVARCHAR (255) NULL,
--[PhotoUrl] NVARCHAR (255) NULL,

--[EntryDate] DATE NOT NULL DEFAULT SYSDATETIME(),
--[Trainership] INT NULL,
--[LivingAddress] NVARCHAR (255) NULL,
--[MobileNumber] NVARCHAR (255) NULL,
--[TelephoneNumber] NVARCHAR (255) NULL,
--[Email] NVARCHAR (255) NULL,
--[Note] NVARCHAR (255) NULL, --Additional information about an employee
--[IsWorking] BIT NOT NULL DEFAULT 1, 
--[StateTableId] INT FOREIGN KEY REFERENCES StateTables(Id) NOT NULL,
--[TabelNumber] NVARCHAR(255) NULL,

--[TrainershipYear] INT NULL,
--[TrainershipMonth] INT NULL,
--[TrainershipDay] INT NULL,

--[InternalNumber] NVARCHAR (100) NULL,

--[PoliticalParty] NVARCHAR (255) NULL,
--[PartyMembershipNumber] NVARCHAR (255) NULL,
--[PartyEntranceDate] DATE NULL,
--[PartyCardGivenDate] DATE NULL,
--[PartyOrganizationRegion] NVARCHAR(255) NULL,

--[MobileNumber2] NVARCHAR (255) NULL,
--[MobileNumber3] NVARCHAR (255) NULL,
--[BadgeGivenDate] DATE NULL,
--[RegistrationAddress] NVARCHAR(255) NULL,
--[TabelNumberOld] NVARCHAR(255) NULL,
--[NationalityId] INT FOREIGN KEY REFERENCES Nationalities(Id) DEFAULT 1 NOT NULL,
--[IsTradeUnionMember] BIT NOT NULL DEFAULT 1,

--[HQBiletNumber] NVARCHAR(150) NULL,
--[HQQeydiyyatQrupu] NVARCHAR(150) NULL,
--[HQQeydiyyatDerecesi] NVARCHAR(150) NULL,
--[HQTerkibi] NVARCHAR(150) NULL,
--[HQHerbiRutbesi] NVARCHAR (150) NULL,
--[HQXidmetNovu] NVARCHAR (150) NULL,
--[HQIxtisasi] NVARCHAR (150) NULL,
--[HQNomre] NVARCHAR (150) NULL,
--[HQYararligi] NVARCHAR (150) NULL,
--[HQKomissarliginAdi] NVARCHAR (150) NULL,
--[HQXususiUchetdaDurduguNo] NVARCHAR (150) NULL,

--[DisabilityDegree] INT NULL,
--[IsVeteran] BIT DEFAULT 0 NOT NULL,
--[IsRefugee] BIT DEFAULT 0 NOT NULL,
--[AnvisUserId] NVARCHAR(255) NULL,
--[HasDisabledChild] BIT DEFAULT 0 NOT NULL,
--[OrderNumber] INT NULL,
--[HasWarInjury] BIT DEFAULT 0 NOT NULL,
--[IsRefugeeFromAnotherCountry] BIT DEFAULT 0 NOT NULL
--)





----IDENTITY IS NOT SET 

--CREATE PROCEDURE AddEmployee
  
--    @Surname NVARCHAR(100),
--    @Name NVARCHAR(100),
--    @FatherName NVARCHAR(100),
--    @GenderId INT,
--    @MaritalStatusId INT,
--    @EntryDate DATE,
--    @StateTableId INT,
--    @PhotoUrl NVARCHAR(255) = NULL  -- This is optional, so defaulting to NULL
--AS
--BEGIN
--    -- Start the transaction
--    BEGIN TRANSACTION;

--    BEGIN TRY
--        -- Insert the new employee
--        INSERT INTO Employees (
         
--            Surname, 
--            Name, 
--            FatherName, 
--            GenderId, 
--            MaritalStatusId, 
--            EntryDate, 
--            StateTableId, 
--            PhotoUrl
--        )
--        VALUES (
           
--            @Surname, 
--            @Name, 
--            @FatherName, 
--            @GenderId, 
--            @MaritalStatusId, 
--            @EntryDate, 
--            @StateTableId, 
--            @PhotoUrl
--        );

--        -- If everything is successful, commit the transaction
--        COMMIT TRANSACTION;

--    END TRY
--    BEGIN CATCH
--        -- If an error occurs, rollback the transaction
--        ROLLBACK TRANSACTION;

--        -- Return the error message and details
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();

--        -- Return error information
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH;
--END;



--CREATE PROCEDURE GetEmployeesInChunks
--    @Skip INT = 0,
--    @Take INT = 10,
--    @Surname NVARCHAR(100) = NULL,
--    @Name NVARCHAR(100) = NULL,
--    @FatherName NVARCHAR(100) = NULL,
--    @BirthDateStart DATE = NULL,
--    @BirthDateEnd DATE = NULL,
--    @OrganizationFullName NVARCHAR(255) = NULL,
--    @EntryDateStart DATE = NULL,
--    @EntryDateEnd DATE = NULL,
--    @GenderId INT = NULL,
--    @MaritalStatusId INT = NULL,
--    @HasPoliticalParty BIT = NULL,
--    @HasSocialInsuranceNumber BIT = NULL,
--    @TabelNumber NVARCHAR(255) = NULL,
--    @AnvisUserId NVARCHAR(255) = NULL,
--    @IsWorking BIT = NULL
--AS
--BEGIN
--    -- Return the total count of employees (including filters)
--    SELECT COUNT(*) AS TotalCount
--    FROM Employees
--    JOIN StateTables ON StateTables.Id = Employees.StateTableId
--    JOIN OrganizationStructures ON OrganizationStructures.Id = StateTables.OrganizationStructureId
--    WHERE (IsWorking = @IsWorking OR @IsWorking IS NULL)
--         AND (@Surname IS NULL OR Employees.Surname LIKE '%' + @Surname + '%')
--        AND (@Name IS NULL OR Employees.Name LIKE '%' + @Name + '%')
--      AND (@FatherName IS NULL OR Employees.FatherName = @FatherName)
--      AND (@BirthDateStart IS NULL OR Employees.BirthDate >= @BirthDateStart)
--      AND (@BirthDateEnd IS NULL OR Employees.BirthDate <= @BirthDateEnd)
--      AND (@EntryDateStart IS NULL OR Employees.EntryDate >= @EntryDateStart)
--      AND (@EntryDateEnd IS NULL OR Employees.EntryDate <= @EntryDateEnd)
--      AND (@GenderId IS NULL OR Employees.GenderId = @GenderId)
--      AND (@MaritalStatusId IS NULL OR Employees.MaritalStatusId = @MaritalStatusId)
--      AND (@HasPoliticalParty IS NULL OR (@HasPoliticalParty = 1 AND Employees.PoliticalParty IS NOT NULL) OR (@HasPoliticalParty = 0 AND Employees.PoliticalParty IS NULL))
--      AND (@HasSocialInsuranceNumber IS NULL OR (@HasSocialInsuranceNumber = 1 AND Employees.SocialInsuranceNumber IS NOT NULL) OR (@HasSocialInsuranceNumber = 0 AND Employees.SocialInsuranceNumber IS NULL))
--      AND (@TabelNumber IS NULL OR Employees.TabelNumber = @TabelNumber)
--      AND (@AnvisUserId IS NULL OR Employees.AnvisUserId = @AnvisUserId)
--AND (@OrganizationFullName IS NULL OR OrganizationStructures.FullName LIKE '%' + @OrganizationFullName + '%')

--    -- Return the actual paginated data with filters
--    SELECT 
--		Employees.Id,
--        Employees.PhotoUrl,
--        Employees.Surname,
--        Employees.Name,
--        Employees.FatherName,
--        Employees.BirthDate,
--        Genders.Type AS GenderType,
--        MaritalStatuses.Status AS MaritalStatus,
--        Employees.SocialInsuranceNumber,
--        Employees.TabelNumber,
--        Employees.EntryDate,
--		  -- Logic to calculate QuitDate
--          CASE 
--              WHEN Employees.IsWorking = 1 THEN NULL
--              ELSE (
--                  SELECT TOP 1 WorkActivityDate 
--                  FROM WorkActivities 
--                  WHERE EmployeeId = Employees.Id AND WorkActivityTypeId = 3 
--                  ORDER BY WorkActivityDate DESC
--              )
--          END AS QuitDate,
--        Employees.TrainershipYear,
--        Employees.TrainershipMonth,
--        Employees.TrainershipDay,
--        OrganizationStructures.FullName AS OrganizationStructureName,
--        StateTables.Name AS StateTableName,
--        StateTables.Degree AS StateTableDegree,
--        Employees.IsWorking
--    FROM Employees
--    JOIN Genders ON Genders.Id = Employees.GenderId
--    JOIN MaritalStatuses ON MaritalStatuses.Id = Employees.MaritalStatusId
--    JOIN StateTables ON StateTables.Id = Employees.StateTableId
--    JOIN OrganizationStructures ON OrganizationStructures.Id = StateTables.OrganizationStructureId
--    WHERE (Employees.IsWorking = @IsWorking OR @IsWorking IS NULL)
--      AND (@Surname IS NULL OR Employees.Surname LIKE '%' + @Surname + '%')
--      AND (@Name IS NULL OR Employees.Name LIKE '%' + @Name + '%')
--      AND (@FatherName IS NULL OR Employees.FatherName = @FatherName)
--      AND (@BirthDateStart IS NULL OR Employees.BirthDate >= @BirthDateStart)
--      AND (@BirthDateEnd IS NULL OR Employees.BirthDate <= @BirthDateEnd)
--      AND (@EntryDateStart IS NULL OR Employees.EntryDate >= @EntryDateStart)
--      AND (@EntryDateEnd IS NULL OR Employees.EntryDate <= @EntryDateEnd)
--      AND (@GenderId IS NULL OR Employees.GenderId = @GenderId)
--      AND (@MaritalStatusId IS NULL OR Employees.MaritalStatusId = @MaritalStatusId)
--      AND (@HasPoliticalParty IS NULL OR (@HasPoliticalParty = 1 AND Employees.PoliticalParty IS NOT NULL) OR (@HasPoliticalParty = 0 AND Employees.PoliticalParty IS NULL))
--      AND (@HasSocialInsuranceNumber IS NULL OR (@HasSocialInsuranceNumber = 1 AND Employees.SocialInsuranceNumber IS NOT NULL) OR (@HasSocialInsuranceNumber = 0 AND Employees.SocialInsuranceNumber IS NULL))
--      AND (@TabelNumber IS NULL OR Employees.TabelNumber = @TabelNumber)
--      AND (@AnvisUserId IS NULL OR Employees.AnvisUserId = @AnvisUserId)
--AND (@OrganizationFullName IS NULL OR OrganizationStructures.FullName LIKE '%' + @OrganizationFullName + '%')

--    ORDER BY Employees.EntryDate
--    OFFSET @Skip ROWS
--    FETCH NEXT @Take ROWS ONLY;
--END;


--GO
--CREATE PROC GetEmployeeGeneralInfo @Id INT
--AS
--BEGIN
--    SELECT 
--        Employees.Id,
--        Employees.Surname,
--        Employees.Name,
--        Employees.FatherName,
--		Employees.PhotoUrl,
--        Employees.BirthDate,
--        Nationalities.Name AS [Nationality],
--        Genders.Type AS [Gender],
--        MaritalStatuses.Status AS [MaritalStatus],
--        Employees.SocialInsuranceNumber,
--        Employees.TabelNumber,
--        Employees.AnvisUserId,
--        Employees.EntryDate,

--        -- Logic to add the QuitDate column
--        CASE 
--            WHEN Employees.IsWorking = 1 THEN NULL
--            ELSE (SELECT TOP 1 WorkActivityDate 
--                  FROM WorkActivities 
--                  WHERE EmployeeId = Employees.Id AND WorkActivityTypeId = 3 
--                  ORDER BY WorkActivityDate DESC) -- QuitDate is the most recent WorkActivityDate for fired employees
--        END AS QuitDate,

--        Employees.TrainershipYear,
--        Employees.TrainershipMonth,
--        Employees.TrainershipDay,

--        Employees.RegistrationAddress,
--        Employees.LivingAddress,

--        Employees.MobileNumber,
--        Employees.MobileNumber2,
--        Employees.MobileNumber3,
--        Employees.TelephoneNumber,
--        Employees.InternalNumber,
--        Employees.Email,
--        OrganizationStructures.FullName AS [OrganizationStructureName],
--        StateTables.Name AS [StateTableName],
--        StateTables.Degree AS [StateTableDegree],
--        Employees.IsTradeUnionMember,
--        Employees.IsVeteran,
--        Employees.HasWarInjury,
--        Employees.DisabilityDegree,
--        Employees.HasDisabledChild,
--        Employees.IsRefugee, --Məcburi köçkün
--        Employees.IsRefugeeFromAnotherCountry -- Qaçqın

--    FROM Employees
--    LEFT JOIN Nationalities ON Nationalities.Id = Employees.NationalityId
--    LEFT JOIN Genders ON Genders.Id = Employees.GenderId
--    LEFT JOIN MaritalStatuses ON MaritalStatuses.Id = Employees.MaritalStatusId
--    LEFT JOIN StateTables ON StateTables.Id = Employees.StateTableId
--    LEFT JOIN OrganizationStructures ON OrganizationStructures.Id = StateTables.OrganizationStructureId
--    WHERE Employees.Id = @Id 
--END;






--GO
--CREATE PROC UpdateEmployeeGeneralInfo
--    @Id INT,
--    @Surname NVARCHAR(100),
--    @Name NVARCHAR(100),
--    @FatherName NVARCHAR(100),
--    @PhotoUrl NVARCHAR(255),
--    @BirthDate DATE,
--    @BirthPlace NVARCHAR(255),
--    @NationalityId INT,
--    @GenderId INT,
--    @MaritalStatusId INT,
--    @SocialInsuranceNumber NVARCHAR(255),
--    @TabelNumber NVARCHAR(255),
--    @AnvisUserId NVARCHAR(255),
--    @TrainershipYear INT,
--    @TrainershipMonth INT,
--    @TrainershipDay INT,
--    @RegistrationAddress NVARCHAR(255),
--    @LivingAddress NVARCHAR(255),
--    @MobileNumber NVARCHAR(255),
--    @MobileNumber2 NVARCHAR(255),
--    @MobileNumber3 NVARCHAR(255),
--    @TelephoneNumber NVARCHAR(255),
--    @InternalNumber NVARCHAR(100),
--    @Email NVARCHAR(255),
--    @IsTradeUnionMember BIT,
--    @IsVeteran BIT,
--    @HasWarInjury BIT,
--    @DisabilityDegree INT,
--    @HasDisabledChild BIT,
--    @IsRefugeeFromAnotherCountry BIT,
--    @IsRefugee BIT
--AS
--BEGIN
--    BEGIN TRY
--        BEGIN TRANSACTION;

--        UPDATE Employees
--        SET 
--            Surname = @Surname,
--            Name = @Name,
--            FatherName = @FatherName,
--            PhotoUrl = @PhotoUrl,
--            BirthDate = @BirthDate,
--            BirthPlace = @BirthPlace,
--            NationalityId = @NationalityId,
--            GenderId = @GenderId,
--            MaritalStatusId = @MaritalStatusId,
--            SocialInsuranceNumber = @SocialInsuranceNumber,
--            TabelNumber = @TabelNumber,
--            AnvisUserId = @AnvisUserId,
--            TrainershipYear = @TrainershipYear,
--            TrainershipMonth = @TrainershipMonth,
--            TrainershipDay = @TrainershipDay,
--            RegistrationAddress = @RegistrationAddress,
--            LivingAddress = @LivingAddress,
--            MobileNumber = @MobileNumber,
--            MobileNumber2 = @MobileNumber2,
--            MobileNumber3 = @MobileNumber3,
--            TelephoneNumber = @TelephoneNumber,
--            InternalNumber = @InternalNumber,
--            Email = @Email,
--            IsTradeUnionMember = @IsTradeUnionMember,
--            IsVeteran = @IsVeteran,
--            HasWarInjury = @HasWarInjury,
--            DisabilityDegree = @DisabilityDegree,
--            HasDisabledChild = @HasDisabledChild,
--            IsRefugeeFromAnotherCountry = @IsRefugeeFromAnotherCountry,
--            IsRefugee = @IsRefugee
--        WHERE Id = @Id;

--        -- Commit the transaction if the update succeeds
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback the transaction if an error occurs
--        ROLLBACK TRANSACTION;

--        -- Return the error information
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
        
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;


--CREATE PROCEDURE DeleteEmployee
--    @Id INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Update the IsWorking column to 0 instead of deleting the record
--        UPDATE Employees
--        SET IsWorking = 0
--        WHERE Id = @Id;

--        -- Check if the update affected any rows
--        IF @@ROWCOUNT = 0
--        BEGIN
--            THROW 50001, 'Employee not found or already inactive.', 1;
--        END

--        -- Commit the transaction if no errors
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction if an error occurs
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Retrieve and return error information
--        DECLARE @ErrorMessage NVARCHAR(4000);
--        DECLARE @ErrorSeverity INT;
--        DECLARE @ErrorState INT;

--        SELECT 
--            @ErrorMessage = ERROR_MESSAGE(),
--            @ErrorSeverity = ERROR_SEVERITY(),
--            @ErrorState = ERROR_STATE();

--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;



--GO
--CREATE PROC UpdateEmployeesPhotoUrl
--    @Id INT,
--    @NewPhotoUrl NVARCHAR(255),
--    @OldPhotoUrl NVARCHAR(255) OUTPUT
--AS
--BEGIN
--    BEGIN TRY
--        BEGIN TRANSACTION;

--        -- Check if the employee exists
--        IF NOT EXISTS (SELECT 1 FROM Employees WHERE Id = @Id)
--        BEGIN
--            ROLLBACK TRANSACTION;
--            RAISERROR('No employee found with the specified Id.', 16, 1);
--            RETURN;
--        END

--        -- Get the old PhotoUrl (it may be NULL if not set)
--        SELECT @OldPhotoUrl = PhotoUrl
--        FROM Employees
--        WHERE Id = @Id;

--        -- Update the PhotoUrl
--        UPDATE Employees
--        SET PhotoUrl = @NewPhotoUrl
--        WHERE Id = @Id;

--        -- Commit the transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction in case of an error
--        IF XACT_STATE() <> 0
--        BEGIN
--            ROLLBACK TRANSACTION;
--        END

--        -- Capture and raise the error
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();

--        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END


--GO
--CREATE PROC GetEmployeesGeneralInfo 
--  @Skip INT = 0,
--  @Take INT = 10

--AS
--BEGIN
--    SET NOCOUNT ON;

--    -- Return the total count of records as the first result set
--    SELECT COUNT(*) AS TotalCount
--    FROM Employees;

--    -- Return the paginated data as the second result set
--    SELECT 
--        Employees.Id,
--        Employees.Surname,
--        Employees.Name,
--        Employees.FatherName,
--        Employees.PhotoUrl,
--        Employees.BirthDate,
--        Nationalities.Name AS [Nationality],
--        Genders.Type AS [Gender],
--        MaritalStatuses.Status AS [MaritalStatus],
--        Employees.SocialInsuranceNumber,
--        Employees.TabelNumber,
--        Employees.AnvisUserId,
--        Employees.EntryDate,

--        -- Logic for QuitDate
--        CASE 
--            WHEN Employees.IsWorking = 1 THEN NULL
--            ELSE (SELECT TOP 1 WorkActivityDate 
--                  FROM WorkActivities 
--                  WHERE EmployeeId = Employees.Id AND WorkActivityTypeId = 3 
--                  ORDER BY WorkActivityDate DESC)
--        END AS QuitDate,

--        Employees.TrainershipYear,
--        Employees.TrainershipMonth,
--        Employees.TrainershipDay,
--        Employees.RegistrationAddress,
--        Employees.LivingAddress,
--        Employees.MobileNumber,
--        Employees.MobileNumber2,
--        Employees.MobileNumber3,
--        Employees.TelephoneNumber,
--        Employees.InternalNumber,
--        Employees.Email,
--        OrganizationStructures.FullName AS [OrganizationStructureName],
--        StateTables.Name AS [StateTableName],
--        StateTables.Degree AS [StateTableDegree],
--        Employees.IsTradeUnionMember,
--        Employees.IsVeteran,
--        Employees.HasWarInjury,
--        Employees.DisabilityDegree,
--        Employees.HasDisabledChild,
--        Employees.IsRefugee,
--        Employees.IsRefugeeFromAnotherCountry

--    FROM Employees
--    LEFT JOIN Nationalities ON Nationalities.Id = Employees.NationalityId
--    LEFT JOIN Genders ON Genders.Id = Employees.GenderId
--    LEFT JOIN MaritalStatuses ON MaritalStatuses.Id = Employees.MaritalStatusId
--    LEFT JOIN StateTables ON StateTables.Id = Employees.StateTableId
--    LEFT JOIN OrganizationStructures ON OrganizationStructures.Id = StateTables.OrganizationStructureId

--    -- Pagination logic
--    ORDER BY Employees.Id
--    OFFSET @Skip ROWS FETCH NEXT @Take ROWS ONLY;
--END;
