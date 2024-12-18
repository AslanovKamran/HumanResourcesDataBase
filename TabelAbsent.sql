GO
USE SP_HR

GO
CREATE TABLE TabelAbsent
(
[Id] INT PRIMARY KEY,
[Date] DATE NOT NULL,
[Cause] NVARCHAR (255) NULL,
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
[Bulletin] INT NULL, --0 - Icazesiz, 1 - Icazeli, 2 - Donor
[InsertedUser] NVARCHAR (20) NULL,
[InsertedDate] DATE NULL,
[UpdatedUser] NVARCHAR (20) NULL,
[UpdatedDate] DATE NULL
)



GO
CREATE PROCEDURE InsertTabelAbsent

    @Date DATE,
    @Cause NVARCHAR(255) = NULL,
    @EmployeeId INT,
    @Bulletin INT = NULL,
    @InsertedUser NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO TabelAbsent ([Date], [Cause], [EmployeeId], [Bulletin], [InsertedUser], [InsertedDate])
        VALUES (@Date, @Cause, @EmployeeId, @Bulletin, @InsertedUser, GETDATE());
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

SELECT * FROM TabelAbsent

GO
CREATE PROCEDURE SelectTabelAbsentByEmployeeAndYear
    @EmployeeId INT,
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT [Id], [Date], [Cause], [EmployeeId], [Bulletin], [InsertedUser], [InsertedDate], [UpdatedUser], [UpdatedDate]
        FROM TabelAbsent
        WHERE [EmployeeId] = @EmployeeId
          AND YEAR([Date]) = @Year;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


GO
CREATE PROCEDURE DeleteTabelAbsentById
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM TabelAbsent
        WHERE [Id] = @Id;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


GO
CREATE PROCEDURE UpdateTabelAbsent
    @Id INT,
    @Date DATE,
    @Cause NVARCHAR(255) = NULL,
    @Bulletin INT = NULL,
    @UpdatedUser NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE TabelAbsent
        SET [Date] = @Date,
            [Cause] = @Cause,
            [Bulletin] = @Bulletin,
            [UpdatedUser] = @UpdatedUser,
            [UpdatedDate] = GETDATE()
        WHERE [Id] = @Id;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


