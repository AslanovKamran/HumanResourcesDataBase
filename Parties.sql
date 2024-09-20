GO
USE SP_HR

GO
CREATE Table Parties
(
[Id] INT PRIMARY KEY,
[Surname]	NVARCHAR(100) NOT NULL,
[Name]		NVARCHAR(100) NOT NULL,
[FatherName]NVARCHAR(100) NOT NULL,
[EntryDate] DATE NULL,
[CardNumber] NVARCHAR (100) NULL,
[BirhtDate] DATE NULL
)
-- BULK HERE


--DROP TABLE Parties;

--GO
--CREATE Table Parties
--(
--[Id]			INT PRIMARY KEY IDENTITY (1069,1),
--[Surname]			NVARCHAR(100) NOT NULL,
--[Name]				NVARCHAR(100) NOT NULL,
--[FatherName]		NVARCHAR(100) NOT NULL,
--[EntryDate]			DATE NULL,
--[CardNumber]		 NVARCHAR (100) NULL,
--[BirhtDate]			DATE NULL
--)

--SET IDENTITY_INSERT Parties ON

--INSERT INTO Parties (
--[Id]		,
--[Surname]	,
--[Name]		,
--[FatherName],
--[EntryDate]	,
--[CardNumber],
--[BirhtDate]	)
--SELECT * FROM Temp


--SET IDENTITY_INSERT Parties OFF

--DROP TABLE Temp


SELECT * FROM Parties ORDER BY Id desc