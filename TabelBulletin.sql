USE SP_HR

GO
CREATE TABLE TabelBulletin
(
[Id] INT PRIMARY KEY,
[Serial] NVARCHAR (20) NULL,
[Number] NVARCHAR(20) NULL,
[Date] DATE NULL,
[InvalidityBeginDate] DATE NOT NULL,
[InvalidityEndDate] DATE NOT NULL,
[Note] NVARCHAR (255) NULL,
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
[InvalidityContinues] BIT DEFAULT  0,
[InsertedUser] NVARCHAR (20) NULL,
[InsertedDate] DATE NULL,
[UpdatedUser] NVARCHAR (20) NULL,
[UpdatedDate] DATE NULL,
)




-- Proc that gets bulluten by id and date boundary 
--Id, Serial, Number, Date, [InvalidityBeginDate], [InvalidityEndDate], [InvalidityContinues], [Note]

GO
CREATE PROCEDURE SelectTabelBulletin
    @EmployeeId INT,
    @BeginYear INT,
    @EndYear INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Calculate date range from year integers
    DECLARE @BeginDate DATE = DATEFROMPARTS(@BeginYear, 1, 1);
    DECLARE @EndDate DATE = DATEFROMPARTS(@EndYear, 12, 31);

    SELECT 
        [Id],
        [Serial],
        [Number],
        [Date],
        [InvalidityBeginDate],
        [InvalidityEndDate],
        [InvalidityContinues],
        [Note]
    FROM 
        TabelBulletin
    WHERE 
        [EmployeeId] = @EmployeeId
        AND [InvalidityBeginDate] >= @BeginDate
        AND [InvalidityEndDate] <= @EndDate;
END;
GO



GO
CREATE PROCEDURE AddTabelBulletin

    @EmployeeId INT,
    @Serial NVARCHAR(20),
    @Number NVARCHAR(20),
    @Date DATE,
    @InvalidityBeginDate DATE,
    @InvalidityEndDate DATE,
    @Note NVARCHAR(255),
    @InvalidityContinues BIT,
    @InsertedUser NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO TabelBulletin (

            [EmployeeId],
            [Serial],
            [Number],
            [Date],
            [InvalidityBeginDate],
            [InvalidityEndDate],
            [Note],
            [InvalidityContinues],
            [InsertedUser],
            [InsertedDate]
        )
        VALUES (
 
            @EmployeeId,
            @Serial,
            @Number,
            @Date,
            @InvalidityBeginDate,
            @InvalidityEndDate,
            @Note,
            @InvalidityContinues,
            @InsertedUser,
            GETDATE() -- Automatically sets the current date and time
        );

     
    END TRY
    BEGIN CATCH
        -- Error handling
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (
            'Error occurred while inserting record: %s', 
            @ErrorSeverity, 
            @ErrorState, 
            @ErrorMessage
        );

        RETURN; -- Exit the procedure on error
    END CATCH
END;
GO


GO
CREATE PROCEDURE UpdateTabelBulletin
    @Id INT,
    @Serial NVARCHAR(20),
    @Number NVARCHAR(20),
    @Date DATE,
    @InvalidityBeginDate DATE,
    @InvalidityEndDate DATE,
    @Note NVARCHAR(255),
    @InvalidityContinues BIT,
    @UpdatedUser NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE TabelBulletin
        SET
            [Serial] = @Serial,
            [Number] = @Number,
            [Date] = @Date,
            [InvalidityBeginDate] = @InvalidityBeginDate,
            [InvalidityEndDate] = @InvalidityEndDate,
            [Note] = @Note,
            [InvalidityContinues] = @InvalidityContinues,
            [UpdatedUser] = @UpdatedUser,
            [UpdatedDate] = GETDATE() -- Automatically sets the current date and time
        WHERE 
            [Id] = @Id;

        -- Check if any row was updated
        IF @@ROWCOUNT = 0
        BEGIN
            PRINT 'No record found with the specified Id.';
            RETURN;
        END

        PRINT 'Record updated successfully.';
    END TRY
    BEGIN CATCH
        -- Error handling
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (
            'Error occurred while updating record: %s', 
            @ErrorSeverity, 
            @ErrorState, 
            @ErrorMessage
        );

        RETURN; -- Exit the procedure on error
    END CATCH
END;
GO


GO
CREATE PROCEDURE DeleteTabelBulletin
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM TabelBulletin
        WHERE [Id] = @Id;

        -- Check if any row was deleted
        IF @@ROWCOUNT = 0
        BEGIN
            PRINT 'No record found with the specified Id.';
            RETURN;
        END

        PRINT 'Record deleted successfully.';
    END TRY
    BEGIN CATCH
        -- Error handling
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (
            'Error occurred while deleting record: %s', 
            @ErrorSeverity, 
            @ErrorState, 
            @ErrorMessage
        );

        RETURN; -- Exit the procedure on error
    END CATCH
END;
GO


SELECT * FROM TabelBulletin ORDER BY id DESC