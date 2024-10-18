GO
USE SP_HR


--CREATE PROC GetMilitaryInfo @EmployeeId INT
--AS
--BEGIN

--SELECT 
--[Id],
--[HQBiletNumber] AS [TicketNumber],
--[HQQeydiyyatQrupu] AS [RegistrationGroup],
--[HQQeydiyyatDerecesi] [RegistrationRate],
--[HQTerkibi] AS [Content],
--[HQHerbiRutbesi] AS [Rank],
--[HQXidmetDovru] AS [Period],
--[HQIxtisasi] AS [Specialization],
--[HQNomre] AS [Number],
--[HQYararligi] AS [Fitness],
--[HQKomissarliginAdi] AS [Commissariat],
--[HQXususiUchetdaDurduguNo] AS [SpeacialAccountNumber]

--FROM Employees WHERE Id = @EmployeeId

--END

--GO
--CREATE PROC UpdateMilitaryInfo
--    @Id INT,
--    @TicketNumber NVARCHAR(150),
--    @RegistrationGroup NVARCHAR(150),
--    @RegistrationRate NVARCHAR(150),
--    @Content NVARCHAR(150),
--    @Rank NVARCHAR(150),
--    @Period NVARCHAR(150),
--    @Specialization NVARCHAR(150),
--    @Number NVARCHAR(150),
--    @Fitness NVARCHAR(150),
--    @Commissariat NVARCHAR(150),
--    @SpecialAccountNumber NVARCHAR(150)
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;

--        -- Update only the military information columns for the specified Id
--        UPDATE Employees
--        SET 
--            HQBiletNumber = @TicketNumber,
--            HQQeydiyyatQrupu = @RegistrationGroup,
--            HQQeydiyyatDerecesi = @RegistrationRate,
--            HQTerkibi = @Content,
--            HQHerbiRutbesi = @Rank,
--            HQXidmetDovru = @Period,
--            HQIxtisasi = @Specialization,
--            HQNomre = @Number,
--            HQYararligi = @Fitness,
--            HQKomissarliginAdi = @Commissariat,
--            HQXususiUchetdaDurduguNo = @SpecialAccountNumber
--        WHERE Id = @Id;

--        -- Commit the transaction
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


 