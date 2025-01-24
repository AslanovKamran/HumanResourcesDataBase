GO
CREATE TABLE Brigades(
[Id] INT PRIMARY KEY IDENTITY,
[FirstDate] DATE NOT NULL,
[SecondDate] DATE NOT NULL,
[WorkingHours] INT NULL
)

GO
ALTER TABLE Brigades
ADD Name NVARCHAR (50) NULL;


-- Add the BrigadeId column to the Employees table
GO
ALTER TABLE Employees
ADD BrigadeId INT NULL;

-- Add a foreign key constraint on the BrigadeId column
GO
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Brigades
FOREIGN KEY (BrigadeId) REFERENCES Brigades(Id);


GO
CREATE PROC GetBrigades 
AS
BEGIN
SELECT Id, Name, FirstDate, SecondDate, WorkingHours FROM Brigades
END


GO
CREATE PROCEDURE GetBrigadeById
    @Id INT
AS
BEGIN
    BEGIN TRY
        -- Retrieve brigade by ID
        SELECT 
            Id,
			Name,
            FirstDate,
            SecondDate,
            WorkingHours
        FROM Brigades
        WHERE Id = @Id;

        -- Optionally, you can check if no record is found
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR ('No brigade found with the provided Id.', 16, 1);
        END
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
CREATE PROCEDURE CreateBrigade
	@Name NVARCHAR (50),
    @FirstDate DATE,
    @SecondDate DATE,
    @WorkingHours INT = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert the new brigade
        INSERT INTO Brigades (Name, FirstDate, SecondDate, WorkingHours)
        VALUES (@Name, @FirstDate, @SecondDate, @WorkingHours);

        -- Commit the transaction if no errors
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Return error information
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


GO
CREATE PROCEDURE UpdateBrigade
    @Id INT,
	@Name NVARCHAR (50),
    @FirstDate DATE,
    @SecondDate DATE,
    @WorkingHours INT = NULL
AS
BEGIN
    BEGIN TRY
        -- Start a transaction
        BEGIN TRANSACTION;

        -- Update the brigade details
        UPDATE Brigades
        SET 
			Name = @Name,
            FirstDate = @FirstDate,
            SecondDate = @SecondDate,
            WorkingHours = @WorkingHours
        WHERE Id = @Id;

        -- Check if the row was affected
        IF @@ROWCOUNT = 0
        BEGIN
            -- Rollback and raise an error if no row matches the given Id
            ROLLBACK TRANSACTION;
            RAISERROR ('No brigade found with the provided Id.', 16, 1);
            RETURN;
        END

        -- Commit the transaction if everything is successful
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

GO
CREATE PROCEDURE DeleteBrigade
    @Id INT
AS
BEGIN
    BEGIN TRY
        -- Start a transaction
        BEGIN TRANSACTION;

        -- Set BrigadeId to NULL for employees associated with this brigade
        UPDATE Employees
        SET BrigadeId = NULL
        WHERE BrigadeId = @Id;

        -- Delete the brigade
        DELETE FROM Brigades
        WHERE Id = @Id;

        -- Check if any row was deleted from Brigades
        IF @@ROWCOUNT = 0
        BEGIN
            -- Rollback and raise an error if no brigade was found with the given Id
            ROLLBACK TRANSACTION;
            RAISERROR ('No brigade found with the provided Id.', 16, 1);
            RETURN;
        END

        -- Commit the transaction if everything is successful
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;




GO
CREATE PROCEDURE AssignNewBrigadeToEmployee
    @EmployeeId INT,
    @BrigadeId INT
AS
BEGIN
    BEGIN TRY
        -- Start a transaction
        BEGIN TRANSACTION;

        -- Update the employee's BrigadeId
        UPDATE Employees
        SET BrigadeId = @BrigadeId
        WHERE Id = @EmployeeId;

        -- Check if the row was affected
        IF @@ROWCOUNT = 0
        BEGIN
            -- Rollback and raise an error if no employee found with the given Id
            ROLLBACK TRANSACTION;
            RAISERROR ('No employee found with the provided Id.', 16, 1);
            RETURN;
        END

        -- Commit the transaction if everything is successful
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


GO
CREATE PROCEDURE DeleteBrigadeFromEmployee
    @EmployeeId INT
AS
BEGIN
    BEGIN TRY
        -- Start a transaction
        BEGIN TRANSACTION;

        -- Update the employee's BrigadeId to NULL
        UPDATE Employees
        SET BrigadeId = NULL
        WHERE Id = @EmployeeId;

        -- Check if the row was affected
        IF @@ROWCOUNT = 0
        BEGIN
            -- Rollback and raise an error if no employee found with the given Id
            ROLLBACK TRANSACTION;
            RAISERROR ('No employee found with the provided Id.', 16, 1);
            RETURN;
        END

        -- Commit the transaction if everything is successful
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

SELECT * FROM OrganizationStructures


GO
CREATE PROC GetEmployeesByBrigadeId  @BrigadeId  INT
AS
BEGIN
SELECT brg.Id as BrigadeId, brg.Name as BrigadeName, (emp.Name + ' '  + emp.Surname + ' ' + emp.FatherName) as EmployeeName,  st.Name as Position, org.FullName as Organization From Employees as emp
JOIN StateTables as st ON st.Id = emp.StateTableId
JOIN OrganizationStructures as org ON st.OrganizationStructureId = org.Id
JOIN Brigades as brg ON brg.Id = emp.BrigadeId
WHERE emp.BrigadeId = @BrigadeId
END

