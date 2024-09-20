GO
USE SP_HR

--GO 
--CREATE TABLE PreviousNames
--(
--[Id] INT PRIMARY KEY,
--[Surname] NVARCHAR (50) NOT NULL,
--[Name] NVARCHAR (50) NOT NULL,
--[FatherName] NVARCHAR (50) NOT NULL,
--[ChangedAt] DATE NULL,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id)
--)

--BULK HERE

SELECT * FROM PreviousNames ORDER BY Id DESC

--SELECT * INTO Temp
--FROM PreviousNames;

--DROP TABLE PreviousNames

--GO 
--CREATE TABLE PreviousNames
--(
--[Id]				INT PRIMARY KEY IDENTITY(283,1),
--[Surname]			 NVARCHAR (50) NOT NULL,
--[Name]			NVARCHAR (50) NOT NULL,
--[FatherName]		 NVARCHAR (50) NOT NULL,
--[ChangedAt]		 DATE NULL,
--[EmployeeId]		INT FOREIGN KEY REFERENCES Employees(Id)
--)

--SET IDENTITY_INSERT PreviousNames ON


--INSERT INTO PreviousNames 
--(
--[Id]	,		
--[Surname]	,	
--[Name]	,	
--[FatherName],	
--[ChangedAt]	,
--[EmployeeId]	
--)
--SELECT * FROM Temp;


--SET IDENTITY_INSERT PreviousNames OFF

--DROP TABLE Temp

