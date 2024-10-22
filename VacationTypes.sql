GO
USE SP_HR


--GO
--CREATE TABLE VacationTypes 
--(
--[Id] INT PRIMARY KEY,
--[VacationPaymentTypeId] INT FOREIGN KEY REFERENCES  VacationPaymentTypes(Id) NULL,
--[Name] NVARCHAR (255) NOT NULL
--)

--INSERT INTO VacationTypes VALUES (921,	1,	N'Dövlət təltifi ilə təltif olunduğuna görə verilən əlavə məzuniyyət')
--INSERT INTO VacationTypes VALUES (901,	1,	N'Ödənişli məzuniyyət')
--INSERT INTO VacationTypes VALUES (881,	1,	N'"Azərbaycan Bayrağı" ordeni')
--INSERT INTO VacationTypes VALUES (861,	1,	N'Əmək məzuniyyətinin başqa vaxta keçirilməsi')
--INSERT INTO VacationTypes VALUES (841,	1,	N'Əlavə məzuniyyət')
--INSERT INTO VacationTypes VALUES (802,	1,	N'Çox uşağa görə')
--INSERT INTO VacationTypes VALUES (801,	1,	N'Əlilliyə görə')
--INSERT INTO VacationTypes VALUES (781,	1,	N'Kollektiv müqaviləyə əsasən verilən məzuniyyət')
--INSERT INTO VacationTypes VALUES (761,	1,	N'Əmək məzuniyyətinin başqa vaxta keçirilməsi')
--INSERT INTO VacationTypes VALUES (721,	1,	N'Hamiləliyə və doğuşa görə məzuniyyətin ödənilməsi haqqında')
--INSERT INTO VacationTypes VALUES (441,	1,	N'Kompensasiya')
--INSERT INTO VacationTypes VALUES (322,	1,	N'Çətin doğuşa görə əlavə məzuniyyət')
--INSERT INTO VacationTypes VALUES (181,	1,	N'Hamiləliyə və doğuşa görə məzuniyyət')
--INSERT INTO VacationTypes VALUES (141,	1,	N'Uşağa qulluğa görə sosial məzuniyyət')
--INSERT INTO VacationTypes VALUES (122,	1,	N'Təhsil məzuniyəti')
--INSERT INTO VacationTypes VALUES (121,	2,	N'Ödənişsiz məzuniyyət')
--INSERT INTO VacationTypes VALUES (61,		1,	N'Əmək məzuniyyəti')



--GO
--CREATE PROC GetVacationTypes
--AS
--BEGIN
--    SELECT 
--        VacationTypes.Id,
--        VacationTypes.Name AS [Name],
--        VacationPaymentTypes.Type AS [Type]
--    FROM VacationTypes
--    LEFT JOIN VacationPaymentTypes 
--        ON VacationPaymentTypes.Id = VacationTypes.VacationPaymentTypeId 
--    ORDER BY 
--        VacationPaymentTypes.Type, 
--        VacationTypes.Name;
--END


--GO
--CREATE PROC AddVacationType
--    @Id INT,
--    @VacationPaymentTypeId INT,
--    @Name NVARCHAR(255)
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;
        
--        -- Insert new vacation type record
--        INSERT INTO VacationTypes (Id, VacationPaymentTypeId, Name)
--        VALUES (@Id, @VacationPaymentTypeId, @Name);

--        -- Commit transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction in case of an error
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;
        
--        -- Raise the error message
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END


--GO
--CREATE PROC UpdateVacationType
--    @Id INT,
--    @VacationPaymentTypeId INT,
--    @Name NVARCHAR(255)
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;
        
--        -- Update the existing vacation type record
--        UPDATE VacationTypes
--        SET 
--            VacationPaymentTypeId = @VacationPaymentTypeId,
--            Name = @Name
--        WHERE Id = @Id;

--        -- Commit transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction in case of an error
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;
        
--        -- Raise the error message
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END



--GO
--CREATE PROC DeleteVacationType
--    @Id INT
--AS
--BEGIN
--    BEGIN TRY
--        -- Start a transaction
--        BEGIN TRANSACTION;
        
--        -- Delete the vacation type record
--        DELETE FROM VacationTypes
--        WHERE Id = @Id;

--        -- Commit transaction
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction in case of an error
--        IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION;

--        -- Raise the error message
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END

