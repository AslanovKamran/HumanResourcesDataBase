GO
USE SP_HR

GO
CREATE TABLE TabelVacation
(
[Id] INT PRIMARY KEY,
[BeginDate] DATE NOT NULL,
[EndDate] DATE NOT NULL,
[MainDay] INT NULL,
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
[RecalDate] DATE NULL,
[OrderNumber] NVARCHAR (150) NULL,
[OrderDate] DATE NULL,
[InsertedUser] NVARCHAR (20) NULL,
[InsertedDate] DATE NULL,
[UpdatedUser] NVARCHAR (20) NULL,
[UpdatedDate] DATE NULL,
)




GO
CREATE PROCEDURE InsertTabelVacation
   
    @BeginDate DATE,
    @EndDate DATE,
    @MainDay INT = NULL,
    @EmployeeId INT,
    @RecalDate DATE = NULL,
    @OrderNumber NVARCHAR(150) = NULL,
    @OrderDate DATE = NULL,
    @InsertedUser NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO TabelVacation (
    
        [BeginDate],
        [EndDate],
        [MainDay],
        [EmployeeId],
        [RecalDate],
        [OrderNumber],
        [OrderDate],
        [InsertedUser],
        [InsertedDate] -- Automatically set to the current date
    )
    VALUES (
       
        @BeginDate,
        @EndDate,
        @MainDay,
        @EmployeeId,
        @RecalDate,
        @OrderNumber,
        @OrderDate,
        @InsertedUser,
        GETDATE() -- Current date
    );
END;



GO
CREATE PROCEDURE UpdateTabelVacation
    @Id INT,
    @BeginDate DATE = NULL,
    @EndDate DATE = NULL,
    @MainDay INT = NULL,
    @RecalDate DATE = NULL,
    @OrderNumber NVARCHAR(150) = NULL,
    @OrderDate DATE = NULL,
    @UpdatedUser NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE TabelVacation
        SET 
            [BeginDate] = ISNULL(@BeginDate, [BeginDate]),
            [EndDate] = ISNULL(@EndDate, [EndDate]),
            [MainDay] = ISNULL(@MainDay, [MainDay]),
            [RecalDate] = ISNULL(@RecalDate, [RecalDate]),
            [OrderNumber] = ISNULL(@OrderNumber, [OrderNumber]),
            [OrderDate] = ISNULL(@OrderDate, [OrderDate]),
            [UpdatedUser] = @UpdatedUser,
            [UpdatedDate] = GETDATE()
        WHERE [Id] = @Id;

        -- Check if any rows were affected
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No record found with the given Id.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


GO
CREATE PROCEDURE DeleteTabelVacation
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Delete the record with the specified Id
        DELETE FROM TabelVacation
        WHERE [Id] = @Id;

        -- Check if any rows were affected
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No record found with the given Id.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;




GO
CREATE PROCEDURE SelectTabelVacation
    @EmployeeId INT,
    @BeginYear INT,
    @EndYear INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Select records that match the criteria
        SELECT 
            [Id],
            [BeginDate],
            [EndDate],
            [MainDay],
            [RecalDate],
            [OrderNumber],
            [OrderDate]
        FROM TabelVacation
        WHERE 
            [EmployeeId] = @EmployeeId
            AND YEAR([BeginDate]) >= @BeginYear
            AND YEAR([EndDate]) <= @EndYear;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


