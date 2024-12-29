-- TripEmployees table
CREATE INDEX IX_TripEmployees_EmployeeId_TripId ON TripEmployees (EmployeeId, TripId);

-- BusinessTrips table
CREATE INDEX IX_BusinessTrips_StartDate_EndDate ON BusinessTrips (StartDate, EndDate);

-- TabelExtraWork table
CREATE INDEX IX_TabelExtraWork_EmployeeId_Date ON TabelExtraWork (EmployeeId, Date);

-- TabelBulletin table
CREATE INDEX IX_TabelBulletin_InvalidityDates ON TabelBulletin (EmployeeId, InvalidityBeginDate, InvalidityEndDate);

-- TabelAbsent table
CREATE INDEX IX_TabelAbsent_EmployeeId_Date ON TabelAbsent (EmployeeId, Date);

-- TabelVacation table
CREATE INDEX IX_TabelVacation_BeginDate_EndDate ON TabelVacation (EmployeeId, BeginDate, EndDate);

SELECT * FROM TabelExtraWork  WHERE EmployeeId = 11652

SELECT * FROM Employees WHERE Name LIKE N'%Ceyhun%' AND Surname LIKE N'%?liyev%'

CREATE INDEX IX_TabelExtraWork_Filtering ON TabelExtraWork (EmployeeId, Date);
CREATE INDEX IX_TabelBulletin_Filtering ON TabelBulletin (EmployeeId, InvalidityBeginDate, InvalidityEndDate);
CREATE INDEX IX_TabelAbsent_Filtering ON TabelAbsent (EmployeeId, Date);
CREATE INDEX IX_TabelVacation_Filtering ON TabelVacation (EmployeeId, BeginDate, EndDate);

GetEmployeesWithFullDetails @Year = 2024, @Month = 11,  @OrganizationStructureId = 570

CREATE PROCEDURE GetEmployeesWithFullDetails
    @Year INT,
    @Month INT,
    @OrganizationStructureId INT = NULL -- Optional parameter
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        emp.Id, 
        emp.TabelNumber, 
        ic.FinCode,  
        emp.SocialInsuranceNumber,
        emp.Surname + ' ' + emp.Name + ' ' + emp.FatherName AS [Name],
        stbl.Name AS StateTableName,
        os.FullName AS OrganizationName,
        stbl.Degree,
        swt.Type AS WorkType,
        stbl.WorkHours,
        stbl.WorkHoursSaturday,
        (
            SELECT 
                bsns_tr.StartDate,
                bsns_tr.EndDate
            FROM TripEmployees tr_emp
            JOIN BusinessTrips bsns_tr ON bsns_tr.Id = tr_emp.TripId
            WHERE tr_emp.EmployeeId = emp.Id 
              AND (
                    YEAR(bsns_tr.StartDate) = @Year AND MONTH(bsns_tr.StartDate) = @Month AND
                    YEAR(bsns_tr.EndDate) = @Year AND MONTH(bsns_tr.EndDate) = @Month
                  )
            FOR JSON PATH
        ) AS BusinessTrips,
        (
            SELECT 
                tbl_xtr.ExtraWorkHours,
                tbl_xtr.ExtraWorkNightHours,
                tbl_xtr.ExtraWorkType,
                tbl_xtr.Date
            FROM TabelExtraWork tbl_xtr
            WHERE tbl_xtr.EmployeeId = emp.Id 
              AND YEAR(tbl_xtr.Date) = @Year
              AND MONTH(tbl_xtr.Date) = @Month
            FOR JSON PATH
        ) AS ExtraWork,
        (
            SELECT 
                TabelBulletin.InvalidityBeginDate,
                TabelBulletin.InvalidityEndDate,
                TabelBulletin.InvalidityContinues
            FROM TabelBulletin
            WHERE TabelBulletin.EmployeeId = emp.Id
              AND (
                    YEAR(TabelBulletin.InvalidityBeginDate) = @Year AND MONTH(TabelBulletin.InvalidityBeginDate) = @Month AND
                    YEAR(TabelBulletin.InvalidityEndDate) = @Year AND MONTH(TabelBulletin.InvalidityEndDate) = @Month
                  )
            FOR JSON PATH
        ) AS Invalidity,
        (
            SELECT 
                TabelAbsent.Date
            FROM TabelAbsent
            WHERE TabelAbsent.EmployeeId = emp.Id
              AND YEAR(TabelAbsent.Date) = @Year
              AND MONTH(TabelAbsent.Date) = @Month
            FOR JSON PATH
        ) AS Absences,
        (
            SELECT 
                TabelVacation.BeginDate,
                TabelVacation.EndDate
            FROM TabelVacation
            WHERE TabelVacation.EmployeeId = emp.Id
              AND (
                    YEAR(TabelVacation.BeginDate) = @Year AND MONTH(TabelVacation.BeginDate) = @Month AND
                    YEAR(TabelVacation.EndDate) = @Year AND MONTH(TabelVacation.EndDate) = @Month
                  )
            FOR JSON PATH
        ) AS Vacations
    FROM Employees AS emp
    LEFT JOIN IdentityCards AS ic ON ic.EmployeeId = emp.Id
    LEFT JOIN StateTables AS stbl ON stbl.Id = emp.StateTableId
    LEFT JOIN OrganizationStructures AS os ON os.Id = stbl.OrganizationStructureId
    LEFT JOIN StateWorkTypes AS swt ON swt.Id = stbl.WorkTypeId
    WHERE emp.IsWorking  = 1 AND (@OrganizationStructureId IS NULL OR os.Id = @OrganizationStructureId)-- Filter if parameter is provided
    ORDER BY os.Id ASC, stbl.Degree DESC; -- Order by OrganizationStructureId
END;



