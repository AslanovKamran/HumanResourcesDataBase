GO
USE SP_HR

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

