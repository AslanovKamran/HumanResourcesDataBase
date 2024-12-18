GO
USE SP_HR

CREATE TABLE Substitutes (
    [Id] INT PRIMARY KEY,
    [WhoId] INT REFERENCES Employees(Id) ,
    [WhomId] INT REFERENCES Employees(Id),
    [Note] NVARCHAR(255) NULL,
    [TabelVacationId] INT FOREIGN KEY REFERENCES TabelVacation(Id) NULL,
    [InsertedUser] NVARCHAR(20) NULL,
    [InsertedDate] DATE NULL,
    [UpdatedUser] NVARCHAR(20) NULL,
    [UpdatedDate] DATE NULL,
    [SubStartDate] DATE NULL,
    [SubEndDate] DATE NULL,
    [BulletinId] INT FOREIGN KEY REFERENCES TabelBulletin(Id) NULL
);

GO
CREATE PROCEDURE SelectSubstitutesByVacation
    @WhomId INT,
    @TabelVacationId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        s.[Id], 
        s.[WhoId], 
        CONCAT(eWho.[Name], ' ', eWho.[Surname]) AS WhoName,
        s.[WhomId], 
        CONCAT(eWhom.[Name], ' ', eWhom.[Surname]) AS WhomName,
        s.[TabelVacationId], 
        s.[SubStartDate], 
        s.[SubEndDate], 
        s.[Note]
    FROM Substitutes AS s
    LEFT JOIN Employees AS eWho
        ON s.[WhoId] = eWho.[Id]
    LEFT JOIN Employees AS eWhom
        ON s.[WhomId] = eWhom.[Id]
    WHERE s.[WhomId] = @WhomId
      AND s.[TabelVacationId] = @TabelVacationId;
END;


GO
CREATE PROCEDURE SelectSubstitutesByBulletin
    @WhomId INT,
    @BulletinId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        s.[Id], 
        s.[WhoId], 
        CONCAT(eWho.[Name], ' ', eWho.[Surname]) AS WhoName,
        s.[WhomId], 
        CONCAT(eWhom.[Name], ' ', eWhom.[Surname]) AS WhomName,
        s.[BulletinId], 
        s.[SubStartDate], 
        s.[SubEndDate], 
        s.[Note]
    FROM Substitutes AS s
    LEFT JOIN Employees AS eWho
        ON s.[WhoId] = eWho.[Id]
    LEFT JOIN Employees AS eWhom
        ON s.[WhomId] = eWhom.[Id]
    WHERE s.[WhomId] = @WhomId
      AND s.[BulletinId] = @BulletinId;
END;



GO
CREATE PROCEDURE InsertSubstitute
   
    @WhoId INT,
    @WhomId INT,
    @TabelVacationId INT = NULL,
    @BulletinId INT = NULL,
    @SubStartDate DATE,
    @SubEndDate DATE,
    @Note NVARCHAR(255),
    @InsertedUser NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validate that only one or the other is provided, but not both null or both not null
        IF (@TabelVacationId IS NOT NULL AND @BulletinId IS NOT NULL)
        BEGIN
            RAISERROR ('Only one of TabelVacationId or BulletinId can be provided.', 16, 1);
            RETURN;
        END

        IF (@TabelVacationId IS NULL AND @BulletinId IS NULL)
        BEGIN
            RAISERROR ('One of TabelVacationId or BulletinId must be provided.', 16, 1);
            RETURN;
        END

        INSERT INTO Substitutes (
          
            [WhoId],
            [WhomId],
            [TabelVacationId],
            [BulletinId],
            [SubStartDate],
            [SubEndDate],
            [Note],
            [InsertedUser],
            [InsertedDate]
        )
        VALUES (
          
            @WhoId,
            @WhomId,
            @TabelVacationId,
            @BulletinId,
            @SubStartDate,
            @SubEndDate,
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
CREATE PROCEDURE UpdateSubstitute
    @Id INT,
    @WhoId INT,
    @SubStartDate DATE,
    @SubEndDate DATE,
    @Note NVARCHAR(255),
    @UpdatedUser NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Update the record in the table
        UPDATE Substitutes
        SET 
            [WhoId] = @WhoId,
            [SubStartDate] = @SubStartDate,
            [SubEndDate] = @SubEndDate,
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
CREATE PROCEDURE DeleteSubstitute
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Attempt to delete the record
        DELETE FROM Substitutes
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




