--GO 
--USE SP_HR

--GO 
--CREATE TABLE Certificates(
--[Id] INT PRIMARY KEY,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
--[GivenAt] DATE NULL,
--[Name] NVARCHAR (255) NOT NULL,
--[Organization] NVARCHAR (255) NULL,
--[ValidUntil] DATE NULL
--)

----BULK INSERT HERE

--SELECT * INTO Temp
--FROM Certificates;


--DROP TABLE Certificates

--CREATE TABLE Certificates(
--[Id] INT PRIMARY KEY IDENTITY (1083,1),
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
--[GivenAt] DATE NULL,
--[Name] NVARCHAR (255) NOT NULL,
--[Organization] NVARCHAR (255) NULL,
--[ValidUntil] DATE NULL
--)

--SET IDENTITY_INSERT Certificates ON;


--INSERT INTO Certificates ([Id], [EmployeeId], [GivenAt], [Name], [Organization],[ValidUntil] )
--SELECT * FROM Temp


--SET IDENTITY_INSERT StateTables OFF;



