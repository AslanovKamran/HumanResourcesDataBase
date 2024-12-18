USE SP_HR
GO
CREATE Table TabelExtraWork
(
[Id] INT PRIMARY KEY,
[Date] DATE NULL,
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
[ExtraWorkHours] INT NULL,
[InsertedUser] NVARCHAR (20) NULL,
[InsertedDate] DATE NULL,
[UpdatedUser] NVARCHAR (20) NULL,
[UpdatedDate] DATE NULL,
[OrderNumber] NVARCHAR (20) NULL,
[ExtraWorkType] INT NOT NULL DEFAULT 1, -- 1 Extra work | 2 - Being Late
[Note] NVARCHAR (255) NULL,
[ExtraWorkNightHours] INT NULL
)

SELECT * FROM TabelExtraWork ORDER BY Id DESC

GO
CREATE PROCEDURE SelectTabelExtraWork
    @EmployeeId INT,
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        [Id], 
        [Date], 
		[EmployeeId],
        [ExtraWorkType], 
        [ExtraWorkHours], 
        [ExtraWorkNightHours], 
        [OrderNumber],
        [Note]
    FROM TabelExtraWork
    WHERE [EmployeeId] = @EmployeeId
      AND YEAR([Date]) = @Year;
END;



GO
CREATE PROCEDURE InsertTabelExtraWork
  
    @Date DATE,
	  @EmployeeId INT,
    @ExtraWorkType INT,
    @ExtraWorkHours INT,
    @ExtraWorkNightHours INT,
    @OrderNumber NVARCHAR(20),
    @Note NVARCHAR(255),
    @InsertedUser NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO TabelExtraWork (
         
            [Date], 
			  [EmployeeId],
            [ExtraWorkType], 
            [ExtraWorkHours], 
            [ExtraWorkNightHours], 
            [OrderNumber], 
            [Note], 
            [InsertedUser], 
            [InsertedDate]
        )
        VALUES (
         
            @Date, 
			  @EmployeeId,
            @ExtraWorkType, 
            @ExtraWorkHours, 
            @ExtraWorkNightHours, 
            @OrderNumber, 
            @Note, 
            @InsertedUser, 
            GETDATE() -- Automatically assigns the current date
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
CREATE PROCEDURE UpdateTabelExtraWork
    @Id INT,
    @Date DATE = NULL,
    @ExtraWorkType INT,
    @ExtraWorkHours INT = NULL,
    @ExtraWorkNightHours INT,
    @OrderNumber NVARCHAR(20) = NULL,
    @Note NVARCHAR(255) = NULL,
    @UpdatedUser NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Update the record in the table
        UPDATE TabelExtraWork
        SET 
            [Date] = @Date,
            [ExtraWorkType] = @ExtraWorkType,
            [ExtraWorkHours] = @ExtraWorkHours,
            [ExtraWorkNightHours] = @ExtraWorkNightHours,
            [OrderNumber] = @OrderNumber,
            [Note] = @Note,
            [UpdatedUser] = @UpdatedUser,
            [UpdatedDate] = GETDATE() -- Automatically assigns the current date
        WHERE [Id] = @Id;

        -- Check if the row was updated
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR ('No record found with the specified Id.', 16, 1);
            RETURN;
        END
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
CREATE PROCEDURE DeleteTabelExtraWork
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Attempt to delete the record
        DELETE FROM TabelExtraWork
        WHERE [Id] = @Id;

        -- Check if the row was deleted
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR ('No record found with the specified Id.', 16, 1);
            RETURN;
        END
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

