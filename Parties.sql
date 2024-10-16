GO
USE SP_HR

GO
CREATE Table Parties
(
[Id] INT PRIMARY KEY,
[Surname]	NVARCHAR(100) NOT NULL,
[Name]		NVARCHAR(100) NOT NULL,
[FatherName]NVARCHAR(100) NOT NULL,
[EntryDate] DATE NULL,
[CardNumber] NVARCHAR (100) NULL,
[BirhtDate] DATE NULL
)
-- BULK HERE


--DROP TABLE Parties;

--GO
--CREATE Table Parties
--(
--[Id]			INT PRIMARY KEY IDENTITY (1069,1),
--[Surname]			NVARCHAR(100) NOT NULL,
--[Name]				NVARCHAR(100) NOT NULL,
--[FatherName]		NVARCHAR(100) NOT NULL,
--[EntryDate]			DATE NULL,
--[CardNumber]		 NVARCHAR (100) NULL,
--[BirhtDate]			DATE NULL
--)

--SET IDENTITY_INSERT Parties ON

--INSERT INTO Parties (
--[Id]		,
--[Surname]	,
--[Name]		,
--[FatherName],
--[EntryDate]	,
--[CardNumber],
--[BirhtDate]	)
--SELECT * FROM Temp


--SET IDENTITY_INSERT Parties OFF

--DROP TABLE Temp



--GO
--CREATE PROC GetPoliticalParty 
--    @Id INT
--AS
--BEGIN
--    SELECT 
--        Id, 
--        PoliticalParty, 
--        PartyMembershipNumber, 
--        PartyEntranceDate, 
--        PartyCardGivenDate, 
--        PartyOrganizationRegion
--    FROM Employees
--    WHERE Id = @Id
--END;


--GO
--CREATE PROC UpdatePoliticalParty
--    @Id INT,
--    @PoliticalParty NVARCHAR(255) = NULL,
--    @PartyMembershipNumber NVARCHAR(255) = NULL,
--    @PartyEntranceDate DATE = NULL,
--    @PartyCardGivenDate DATE = NULL,
--    @PartyOrganizationRegion NVARCHAR(255) = NULL
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Update the political party information for the employee
--        UPDATE Employees
--        SET 
--            PoliticalParty = @PoliticalParty,
--            PartyMembershipNumber = @PartyMembershipNumber,
--            PartyEntranceDate = @PartyEntranceDate,
--            PartyCardGivenDate = @PartyCardGivenDate,
--            PartyOrganizationRegion = @PartyOrganizationRegion
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


