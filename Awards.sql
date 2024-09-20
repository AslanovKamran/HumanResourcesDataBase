GO
USE SP_HR

--GO 
--CREATE TABLE Awards 
--(
--[Id] INT PRIMARY KEY,
--[OrderDate] DATETIME,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
--[Note] NVARCHAR (1000) NULL,
--[TypeId] INT ,
--[OrderNumber] NVARCHAR (255),
--[Amount] NVARCHAR (255)
--)

--ALTER TABLE Awards
--ADD CONSTRAINT FK_AWARD_TYPES
--FOREIGN KEY (TypeId)
--REFERENCES AwardTypes(Id);




--Adding Identity
--SELECT * INTO Temp
--FROM Awards;


--DROP TABLE Awards

--GO 
--CREATE TABLE Awards 
--(
--[Id]				INT IDENTITY(4277,1) PRIMARY KEY,
--[OrderDate]				 DATETIME,
--[EmployeeId]			INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
--[Note]					 NVARCHAR (1000) NULL,
--[TypeId]				INT FOREIGN KEY REFERENCES AwardTypes(Id),
--[OrderNumber]					NVARCHAR (255),
--[Amount]					NVARCHAR (255)
--)

--SET IDENTITY_INSERT Awards ON;


--INSERT INTO Awards 
--(
--[Id]		,	
--[OrderDate]		,
--[EmployeeId]	,
--[Note]			,
--[TypeId]		,
--[OrderNumber]	,
--[Amount]		
   
--)
--SELECT * FROM Temp;

--SET IDENTITY_INSERT Awards OFF;

--DROP TABLE Temp


