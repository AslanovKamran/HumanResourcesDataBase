GO
USE SP_HR


SELECT * FROM EducationKinds

GO
CREATE TABLE Educations 
(
[Id] INT PRIMARY KEY,
[Speciality] NVARCHAR (255) NULL,
[Institution] NVARCHAR (255) NULL,
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
[EducationTypeId] INT FOREIGN KEY REFERENCES EducationTypes(Id) NULL,
[DiplomaTypeId] INT FOREIGN KEY REFERENCES DiplomaTypes(Id) NULL,
[DiplomaNumber] NVARCHAR (255) NULL,
[EducationKindId] INT FOREIGN KEY REFERENCES EducationKinds(Id),
[EducationStartedAt] DATE NULL,
[EducationEndedAt] DATE NULL
)

-- Bulk insert here

--Identity Not Set

