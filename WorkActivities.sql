GO
USE SP_HR

SELECT * FROM WorkActivities ORDER BY Id DESC

--GO
--CREATE TABLE WorkActivities
--(
--[Id] INT PRIMARY KEY,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
--[OrderNumber] NVARCHAR (50) NULL,
--[OrderDate] DATE NULL,
--[WorkActivityDate] DATE NOT NULL,
--[WorkActivityReason] NVARCHAR (255) NULL,
--[WorkActivityTypeId] INT FOREIGN KEY REFERENCES WorkActivityTypes(Id) NOT NULL,
--[NewStateTableId] INT FOREIGN KEY REFERENCES StateTables(Id) NULL,
--[WorkShiftTypeId] INT FOREIGN KEY REFERENCES WorkShiftTypes(Id) NULL,
--[WorkShiftStartedAt] DATE NULL,
--[Note] NVARCHAR (255) NULL,
--[WorkDayOffId] INT FOREIGN KEY REFERENCES WorkDayOffTypes(Id) NULL,
--[InsertedBy] NVARCHAR(50) NULL,
--[InsertedAt] DATE NULL,
--[UpdatedBy] NVARCHAR(50) NULL,
--[UpdatedAt] DATE NULL
--)

--Bulk Insert

--CREATE TRIGGER trg_AfterInsert_WorkActivities
--ON WorkActivities
--AFTER INSERT
--AS
--BEGIN
--    -- Update EntryDate when WorkActivityTypeId = 1
--    UPDATE Employees
--    SET EntryDate = i.WorkActivityDate
--    FROM inserted i
--    WHERE i.WorkActivityTypeId = 1
--    AND Employees.Id = i.EmployeeId;

--    -- Update StateTableId when WorkActivityTypeId = 2
--    UPDATE Employees
--    SET StateTableId = i.NewStateTableId
--    FROM inserted i
--    WHERE i.WorkActivityTypeId = 2
--    AND Employees.Id = i.EmployeeId;

--    -- Update IsWorking = 0 when WorkActivityTypeId = 3
--    UPDATE Employees
--    SET IsWorking = 0
--    FROM inserted i
--    WHERE i.WorkActivityTypeId = 3
--    AND Employees.Id = i.EmployeeId;
--END;
--GO

--CREATE INDEX IDX_WorkActivities_EmployeeId ON WorkActivities(EmployeeId);


--CREATE TRIGGER SetUpdatedAtOnWorkActivityUpdate
--ON WorkActivities
--AFTER UPDATE
--AS
--BEGIN
--    -- Update the UpdatedAt column to the current date and time
--    UPDATE WorkActivities
--    SET UpdatedAt = GETDATE()
--    FROM WorkActivities AS wa
--    INNER JOIN inserted AS i ON wa.Id = i.Id;
--END;






--GO
--CREATE PROC GetWorkActivities @EmployeeId INT
--AS
--BEGIN
--SELECT
--WorkActivities.Id,
--WorkActivityTypes.Type AS [WorkActivityType],
--WorkActivities.WorkActivityDate,
--WorkActivities.OrderNumber,
--WorkActivities.WorkActivityReason,
--WorkActivities.Note,
--OrganizationStructures.FullName AS [OrganizationStructureFullName],
--StateTables.Name AS [StateTableName],
--WorkShiftTypes.Type AS [WorkShiftType],
--WorkDayOffTypes.Type AS [WorkDayOffType],
--WorkShiftStartedAt


--FROM WorkActivities 
--LEFT JOIN WorkShiftTypes ON WorkShiftTypes.Id = WorkActivities.WorkShiftTypeId
--LEFT JOIN WorkDayOffTypes ON WorkDayOffTypes.Id = WorkActivities.WorkDayOffId
-- JOIN WorkActivityTypes ON WorkActivityTypes.Id  = WorkActivities.WorkActivityTypeId
--JOIN StateTables ON StateTables.Id = WorkActivities.NewStateTableId
--JOIN OrganizationStructures ON OrganizationStructures.Id = StateTables.OrganizationStructureId
--WHERE WorkActivities.EmployeeId = @EmployeeId
--ORDER BY WorkActivityDate
--END




--GO
--CREATE PROC UpdateWorkActivity
--    @Id INT,
--    @WorkActivityTypeId INT,
--    @WorkActivityDate DATE,
--    @OrderNumber NVARCHAR(50),
--    @WorkActivityReason NVARCHAR(255),
--    @Note NVARCHAR(255),
--    @NewStateTableId INT,
--    @WorkShiftTypeId INT,
--    @WorkDayOffId INT,
--    @WorkShiftStartedAt DATE
--AS
--BEGIN
--    -- Begin transaction
--    BEGIN TRANSACTION

--    BEGIN TRY
--        -- Check if NewStateTableId exists in StateTables
--        IF NOT EXISTS (SELECT 1 FROM StateTables WHERE Id = @NewStateTableId)
--        BEGIN
--            -- Return a message indicating the issue and rollback the transaction
--            RAISERROR ('The specified NewStateTableId does not exist in StateTables.', 16, 1);
--            ROLLBACK TRANSACTION;
--            RETURN;
--        END

--        -- Proceed with update if validation passes
--        UPDATE WorkActivities
--        SET 
--            WorkActivityTypeId = @WorkActivityTypeId,
--            WorkActivityDate = @WorkActivityDate,
--            OrderNumber = @OrderNumber,
--            WorkActivityReason = @WorkActivityReason,
--            Note = @Note,
--            NewStateTableId = @NewStateTableId,
--            WorkShiftTypeId = @WorkShiftTypeId,
--            WorkDayOffId = @WorkDayOffId,
--            WorkShiftStartedAt = @WorkShiftStartedAt,
--            UpdatedAt = GETDATE()
--        WHERE Id = @Id;

--        -- Check if the row was updated
--        IF @@ROWCOUNT = 0
--        BEGIN
--            THROW 50001, 'No rows affected. The record with the specified Id was not found.', 1;
--        END

--        -- Commit transaction if successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction if there is an error
--        ROLLBACK TRANSACTION;

--        -- Rethrow the error for further handling
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END


--GO
--CREATE PROC DeleteWorkActivity
--    @Id INT
--AS
--BEGIN
--    -- Begin transaction
--    BEGIN TRANSACTION

--    BEGIN TRY
--        DELETE FROM WorkActivities
--        WHERE Id = @Id;

--        -- Check if any row was deleted
--        IF @@ROWCOUNT = 0
--        BEGIN
--            THROW 50002, 'No work activity found with the specified Id.', 1;
--        END

--        -- Commit transaction if successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction if there is an error
--        ROLLBACK TRANSACTION;

--        -- Rethrow the error for further handling
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END


--GO
--CREATE PROC AddWorkActivity

--    @EmployeeId INT,
--    @WorkActivityTypeId INT,
--    @WorkActivityDate DATE,
--    @OrderNumber NVARCHAR(50),
--    @WorkActivityReason NVARCHAR(255),
--    @NewStateTableId INT,
--    @WorkShiftTypeId INT,
--    @WorkDayOffId INT,
--    @WorkShiftStartedAt DATE,
--    @Note NVARCHAR(255)
--AS
--BEGIN
--    -- Begin transaction
--    BEGIN TRANSACTION

--    BEGIN TRY
--        -- Insert new record into WorkActivities table
--        INSERT INTO WorkActivities (
--           EmployeeId, WorkActivityTypeId, WorkActivityDate, OrderNumber,
--            WorkActivityReason, NewStateTableId, WorkShiftTypeId,
--            WorkDayOffId, WorkShiftStartedAt, Note, InsertedAt
--        )
--        VALUES (
--           @EmployeeId, @WorkActivityTypeId, @WorkActivityDate, @OrderNumber,
--            @WorkActivityReason, @NewStateTableId, @WorkShiftTypeId,
--            @WorkDayOffId, @WorkShiftStartedAt, @Note, GETDATE()
--        );

--        -- Commit transaction if successful
--        COMMIT TRANSACTION;
--    END TRY
--    BEGIN CATCH
--        -- Rollback transaction if an error occurs
--        ROLLBACK TRANSACTION;

--        -- Rethrow the error for further handling
--        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
--        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
--        DECLARE @ErrorState INT = ERROR_STATE();
--        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
--    END CATCH
--END

SELECT * FROM WorkNorms
