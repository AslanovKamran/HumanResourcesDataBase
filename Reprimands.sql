GO 
USE SP_HR

--GO
--CREATE TABLE Reprimands (
--    Id INT PRIMARY KEY ,
--    IssuedAt DATE NULL,
--    TakenAt DATE NULL,
--    EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
--    Reason NVARCHAR(MAX) NULL,
--    OrderNumber NVARCHAR(255),
--    TypeId INT FOREIGN KEY REFERENCES ReprimandTypes(Id),
--    Amount NVARCHAR(255) NULL
--);

-- BULK HERE


--SELECT * FROM Reprimands  ORDER BY ID DESC


----SELECT * INTO Temp
----FROM Reprimands;

----DROP TABLE Reprimands

--GO
--CREATE TABLE Reprimands (
--    Id			 INT PRIMARY KEY IDENTITY (6237,1),
--    IssuedAt		 DATE NULL,
--    TakenAt				DATE NULL,
--    EmployeeId			 INT FOREIGN KEY REFERENCES Employees(Id),
--    Reason				NVARCHAR(MAX) NULL,
--    OrderNumber			NVARCHAR(255),
--    TypeId				INT FOREIGN KEY REFERENCES ReprimandTypes(Id),
--    Amount				 NVARCHAR(255) NULL
--);

----SET IDENTITY_INSERT Reprimands ON


--INSERT INTO Reprimands 
--(

-- Id				,
-- IssuedAt	   ,
-- TakenAt		,
-- EmployeeId	   ,
-- Reason		   ,
-- OrderNumber	,
-- TypeId		   ,
-- Amount		

--)
--SELECT * FROM Temp;


--SET IDENTITY_INSERT Reprimands OFF

--DROP TABLE Temp
