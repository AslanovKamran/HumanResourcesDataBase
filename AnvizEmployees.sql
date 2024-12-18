GO
CREATE PROC GetAnvizEmployeeData
    @OrganizationStructureId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        emp.TabelNumber, 
        emp.Name,
        emp.Surname, 
        emp.FatherName,
        os.FullName AS [Organization], 
        st.Name AS [Position], 
        st.Degree, 
        swt.Type AS [WorkType], 
        emp.AnvisUserId,
        st.WorkHours 
    FROM 
        Employees AS emp
    JOIN 
        StateTables AS st ON emp.StateTableId = st.Id
    JOIN 
        OrganizationStructures AS os ON st.OrganizationStructureId = os.Id
    JOIN 
        StateWorkTypes AS swt ON st.WorkTypeId = swt.Id
    WHERE 
        emp.AnvisUserId IS NOT NULL 
        AND emp.IsWorking = 1
        AND (@OrganizationStructureId IS NULL OR os.Id = @OrganizationStructureId)
    ORDER BY 
        AnvisUserId;
END;


