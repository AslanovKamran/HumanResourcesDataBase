GO
USE SP_HR

GO
CREATE TABLE FamilyMembers
(
[Id]					INT PRIMARY KEY,
[EmployeeId]			INT FOREIGN KEY REFERENCES Employees(Id),
[FamilyMemberTypeId]	INT FOREIGN KEY REFERENCES FamilyMemberTypes(Id),
[BirthYear]				INT,
[Name]					NVARCHAR(50) NOT NULL,
[Surname]				NVARCHAR(50) NOT NULL,
[FatherName]			NVARCHAR(50) NOT NULL
)

CREATE NONCLUSTERED INDEX IX_FamilyMembers_EmployeeId ON FamilyMembers(EmployeeId);
CREATE NONCLUSTERED INDEX IX_FamilyMembers_FamilyMemberTypeId ON FamilyMembers(FamilyMemberTypeId);

-----Bulk Inert Here 

--IDENTITY NOT SET

--CREATE PROC GetFamilyMembers @EmployeeId INT
--AS
--BEGIN
--SELECT 
--FamilyMembers.Id,
--FamilyMemberTypes.Type,
--FamilyMembers.BirthYear,
--FamilyMembers.Surname,
--FamilyMembers.Name,
--FamilyMembers.FatherName,
--FamilyMembers.EmployeeId AS [EmployeeId]
--FROM FamilyMembers
--LEFT JOIN FamilyMemberTypes ON FamilyMemberTypes.Id = FamilyMembers.FamilyMemberTypeId
--WHERE FamilyMembers.EmployeeId = @EmployeeId
--ORDER BY FamilyMembers.BirthYear ASC
--END


CREATE PROC GetAllFamilyMembers 
AS
BEGIN

--Getting the total count (First table)
SELECT COUNT(*) 
FROM FamilyMembers AS [TotalCount]

--Retrieving the other data (Second table)
SELECT 
FamilyMembers.Id,
FamilyMemberTypes.Type,
FamilyMembers.BirthYear,
FamilyMembers.Surname,
FamilyMembers.Name,
FamilyMembers.FatherName,
FamilyMembers.EmployeeId AS [EmployeeId]
FROM FamilyMembers
LEFT JOIN FamilyMemberTypes ON FamilyMemberTypes.Id = FamilyMembers.FamilyMemberTypeId
ORDER BY FamilyMembers.BirthYear ASC
END



--GO
--CREATE PROC AddFamilyMember
--    @EmployeeId INT,
--    @FamilyMemberTypeId INT,
--    @BirthYear INT,
--    @Name NVARCHAR(50),
--    @Surname NVARCHAR(50),
--    @FatherName NVARCHAR(50)
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Insert the new family member record
--        INSERT INTO FamilyMembers (EmployeeId, FamilyMemberTypeId, BirthYear, Name, Surname, FatherName)
--        VALUES (@EmployeeId, @FamilyMemberTypeId, @BirthYear, @Name, @Surname, @FatherName);

--        -- Commit the transaction if successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback the transaction if an error occurs
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
--CREATE PROC UpdateFamilyMember
--    @Id INT,
--    @FamilyMemberTypeId INT,
--    @BirthYear INT,
--    @Name NVARCHAR(50),
--    @Surname NVARCHAR(50),
--    @FatherName NVARCHAR(50)
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Update the family member record with the specified fields
--        UPDATE FamilyMembers
--        SET 
--            FamilyMemberTypeId = @FamilyMemberTypeId,
--            BirthYear = @BirthYear,
--            Name = @Name,
--            Surname = @Surname,
--            FatherName = @FatherName
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



--GO
--CREATE PROC DeleteFamilyMember
--    @Id INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Delete the family member record by Id
--        DELETE FROM FamilyMembers
--        WHERE Id = @Id;

--        -- Commit the transaction if successful
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
