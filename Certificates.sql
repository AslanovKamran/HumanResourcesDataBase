--GO 
--USE SP_HR

--GO 
--CREATE TABLE Certificates(
--[Id] INT PRIMARY KEY,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
--[GivenAt] DATE NULL,
--[Name] NVARCHAR (255) NOT NULL,
--[Organization] NVARCHAR (255) NULL,
--[ValidUntil] DATE NULL
--)


--REMOVE Identity

--ALTER TABLE Certificates DROP CONSTRAINT PK__Certific__3214EC07531FDF34;

--ALTER TABLE Certificates ADD NewId INT NOT NULL DEFAULT(0);

--UPDATE Certificates SET NewId = Id;

--ALTER TABLE Certificates DROP COLUMN Id;

--EXEC sp_rename 'Certificates.NewId', 'Id', 'COLUMN';



--CREATE PROC GetEmployeesCerificates @EmployeeId INT
--AS
--BEGIN
--SET NOCOUNT ON;
--SELECT 
--Id,
--EmployeeId,
--GivenAt,
--Name,
--Organization, ValidUntil
--FROM Certificates
--WHERE EmployeeId = @EmployeeId
--ORDER BY GivenAt ASC
--END


--CREATE PROCEDURE AddCertificate
--	@Id INT,
--    @EmployeeId INT,
--    @GivenAt DATE,
--    @Name NVARCHAR(255),
--    @Organization NVARCHAR(255),
--    @ValidUntil DATE
--AS
--BEGIN
--    SET NOCOUNT ON;

--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Check if the EmployeeId exists in the Employees table
--        IF NOT EXISTS (SELECT 1 FROM Employees WHERE Id = @EmployeeId)
--        BEGIN
--            -- Rollback transaction if EmployeeId is invalid
--            RAISERROR ('Invalid EmployeeId. Employee does not exist.', 16, 1);
--            ROLLBACK TRANSACTION;
--            RETURN;
--        END

--        -- Insert the new certificate
--        INSERT INTO Certificates (Id, EmployeeId, GivenAt, Name, Organization, ValidUntil)
--        VALUES (@Id, @EmployeeId, @GivenAt, @Name, @Organization, @ValidUntil);

--        -- Commit transaction if everything is successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction in case of any error
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Return error details
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;


--CREATE PROCEDURE dbo.UpdateCertificate
--    @Id INT,
--    @EmployeeId INT,
--    @GivenAt DATE,
--    @Name NVARCHAR(255),
--    @Organization NVARCHAR(255),
--    @ValidUntil DATE
--AS
--BEGIN
--    SET NOCOUNT ON;

--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Check if the Certificate Id exists in the Certificates table
--        IF NOT EXISTS (SELECT 1 FROM Certificates WHERE Id = @Id)
--        BEGIN
--            -- Rollback transaction if Certificate Id is invalid
--            RAISERROR ('Invalid Certificate Id. Certificate does not exist.', 16, 1);
--            ROLLBACK TRANSACTION;
--            RETURN;
--        END

--        -- Check if the EmployeeId exists in the Employees table
--        IF NOT EXISTS (SELECT 1 FROM Employees WHERE Id = @EmployeeId)
--        BEGIN
--            -- Rollback transaction if EmployeeId is invalid
--            RAISERROR ('Invalid EmployeeId. Employee does not exist.', 16, 1);
--            ROLLBACK TRANSACTION;
--            RETURN;
--        END

--        -- Update the certificate
--        UPDATE Certificates
--        SET
--            EmployeeId = @EmployeeId,
--            GivenAt = @GivenAt,
--            Name = @Name,
--            Organization = @Organization,
--            ValidUntil = @ValidUntil
--        WHERE Id = @Id;

--        -- Commit transaction if everything is successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction in case of any error
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Return error details
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END;



--CREATE PROC DeleteCertificate @Id INT
--AS
--BEGIN
--DELETE FROM Certificates WHERE Id = @Id
--END