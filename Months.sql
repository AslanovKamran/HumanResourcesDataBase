--GO
--USE SP_HR

--GO
--CREATE TABLE Months
--(
--[Id] INT PRIMARY KEY IDENTITY,
--[Name] NVARCHAR (50) UNIQUE NOT NULL
--)


INSERT INTO Months VALUES(N'January')
INSERT INTO Months VALUES(N'February')
INSERT INTO Months VALUES(N'March')
INSERT INTO Months VALUES(N'April')
INSERT INTO Months VALUES(N'May')
INSERT INTO Months VALUES(N'June')
INSERT INTO Months VALUES(N'July')
INSERT INTO Months VALUES(N'August')
INSERT INTO Months VALUES(N'September')
INSERT INTO Months VALUES(N'October')
INSERT INTO Months VALUES(N'November')
INSERT INTO Months VALUES(N'December')

SELECT * FROM Months ORDER BY Id