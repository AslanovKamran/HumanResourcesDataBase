GO
USE SP_HR

GO
CREATE TABLE FamilyMembers
(
[Id] INT PRIMARY KEY,
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
[FamilyMemberTypeId] INT FOREIGN KEY REFERENCES FamilyMemberTypes(Id),
[BirthYear] INT,
[Name]			NVARCHAR(50) NOT NULL,
[Surname]		NVARCHAR(50) NOT NULL,
[FatherName]	NVARCHAR(50) NOT NULL
)


-----Bulk Inert Here 