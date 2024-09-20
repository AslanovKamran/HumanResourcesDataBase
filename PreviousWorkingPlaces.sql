GO
USE SP_HR

GO 
CREATE TABLE PreviousWorkingPlaces
(
[Id] INT PRIMARY KEY,
[OrganizationName] NVARCHAR (255)  NULL,
[Position] NVARCHAR (255)  NULL,
[StartedAt]  DATE NULL,
[EndedAt]  DATE NULL,
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
[Reason] NVARCHAR (255)  NULL,
)

--BULK HERE

SELECT * FROM PreviousWorkingPlaces ORDER BY Id DESC

--SELECT * INTO Temp
--FROM PreviousWorkingPlaces;

--DROP TABLE PreviousWorkingPlaces

--CREATE TABLE PreviousWorkingPlaces
--(
--[Id]					 INT PRIMARY KEY IDENTITY (1234,1),
--[OrganizationName]		 NVARCHAR (255)  NULL,
--[Position]			 NVARCHAR (255)  NULL,
--[StartedAt]				 DATE NULL,
--[EndedAt]				 DATE NULL,
--[EmployeeId]				INT FOREIGN KEY REFERENCES Employees(Id),
--[Reason]				 NVARCHAR (255)  NULL,
--)

--SET IDENTITY_INSERT PreviousWorkingPlaces ON


--INSERT INTO PreviousWorkingPlaces 
--(

--[Id]				,
--[OrganizationName],
--[Position]		,
--[StartedAt]		,
--[EndedAt]			,
--[EmployeeId]		,
--[Reason]			
--)
--SELECT * FROM Temp;


--SET IDENTITY_INSERT PreviousWorkingPlaces OFF

--DROP TABLE Temp

