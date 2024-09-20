GO
USE SP_HR

GO
CREATE TABLE Medals 
(
[Id] INT PRIMARY KEY,
[OrderDate] DATE NULL,
[OrderNumber] NVARCHAR (100) NULL,
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
[Note] NVARCHAR(255) NULL,
[MedalTypeId] INT FOREIGN KEY REFERENCES MedalTypes(Id)
)

SELECT Employees.Surname FROM Medals 
JOIN Employees ON Medals.EmployeeId = Employees.Id

-- BULK HERE

--SELECT * INTO Temp
--FROM Medals;

--DROP TABLE Medals

--GO
--CREATE TABLE Medals 
--(
--[Id] INT PRIMARY KEY IDENTITY(2222,1),
--[OrderDate] DATE NULL,
--[OrderNumber] NVARCHAR (100) NULL,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
--[Note] NVARCHAR(255) NULL,
--[MedalTypeId] INT FOREIGN KEY REFERENCES MedalTypes(Id)
--)

--SET IDENTITY_INSERT Medals ON


--INSERT INTO Medals (
--    [Id], [OrderDate], [OrderNumber], [EmployeeId], [Note], [MedalTypeId]
--)
--SELECT * FROM Temp;


--SET IDENTITY_INSERT Medals OFF

--DROP TABLE Temp