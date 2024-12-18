GO
USE SP_HR

--GO
--CREATE TABLE IdentityCards
--(
--[Id] INT PRIMARY KEY,
--[Series] NVARCHAR (50) NULL,
--[CardNumber] NVARCHAR (100) NULL,
--[Organization] NVARCHAR (100) NULL,
--[GivenAt] DATE NULL,
--[ValidUntil] DATE NULL,
--[FinCode] NVARCHAR (50) NULL,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
--[PhotoFront] NVARCHAR (255) NULL,
--[PhotoBack] NVARCHAR (255) NULL,
--)



--GO
--CREATE PROC GetIdentityCard @EmployeeId	 INT
--AS
--BEGIN
--SELECT 
--Id,
--Series,
--CardNumber,
--GivenAt,
--FinCode,
--Organization,
--ValidUntil,
--PhotoFront,
--PhotoBack,
--EmployeeId

--FROM IdentityCards WHERE EmployeeId = @EmployeeId
--END


--GO
--CREATE PROC AddIdentityCard

--    @Series NVARCHAR(50),
--    @CardNumber NVARCHAR(100),
--    @Organization NVARCHAR(100),
--    @GivenAt DATE,
--    @ValidUntil DATE,
--    @FinCode NVARCHAR(50),
--    @EmployeeId INT,
--    @PhotoFront NVARCHAR(255),
--    @PhotoBack NVARCHAR(255)
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Insert the new identity card record
--        INSERT INTO IdentityCards ( Series, CardNumber, Organization, GivenAt, ValidUntil, FinCode, EmployeeId, PhotoFront, PhotoBack)
--        VALUES ( @Series, @CardNumber, @Organization, @GivenAt, @ValidUntil, @FinCode, @EmployeeId, @PhotoFront, @PhotoBack);

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
--CREATE PROC UpdateIdentityCard
--    @Id INT,
--    @Series NVARCHAR(50) ,
--    @CardNumber NVARCHAR(100),
--    @Organization NVARCHAR(100) ,
--    @GivenAt DATE,
--    @ValidUntil DATE,
--    @FinCode NVARCHAR(50),
--    @PhotoFront NVARCHAR(255) = NULL,
--    @PhotoBack NVARCHAR(255) = NULL
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Update the identity card record with the specified fields
--        UPDATE IdentityCards
--        SET 
--            Series = @Series,
--            CardNumber = @CardNumber,
--            Organization = @Organization,
--            GivenAt = @GivenAt,
--            ValidUntil = @ValidUntil,
--            FinCode = @FinCode,
--            PhotoFront = @PhotoFront,
--            PhotoBack = @PhotoBack
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

