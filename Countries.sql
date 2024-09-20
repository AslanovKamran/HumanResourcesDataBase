GO
USE SP_HR

GO
CREATE TABLE Countries
(
[Id] INT PRIMARY KEY,
[Name] NVARCHAR (50) NOT NULL UNIQUE
)

SELECT * FROM Countries ORDER BY Id


--GO
--INSERT INTO Countries VALUES (1,N'Azərbaycan')
--INSERT INTO Countries VALUES (2,N'Rusiya')
--INSERT INTO Countries VALUES (3,N'Gürcüstan')
--INSERT INTO Countries VALUES (5,N'Türkiyə')
--INSERT INTO Countries VALUES (21,N'Yaponiya')
--INSERT INTO Countries VALUES (41,N'İran')
--INSERT INTO Countries VALUES (61,N'İtaliya')
--INSERT INTO Countries VALUES (81,N'BƏƏ')
--INSERT INTO Countries VALUES (121,N'Rumıniya Respublikası')

--SELECT * INTO Temp
--FROM Countries;

--DROP TABLE Countries

--GO
--CREATE TABLE Countries
--(
--[Id] INT PRIMARY KEY IDENTITY(122,1),
--[Name] NVARCHAR (50) NOT NULL UNIQUE
--)

--SET IDENTITY_INSERT Countries ON;


--INSERT INTO Countries (
--    [Id], [Name]
--)
--SELECT * FROM Temp;

--SET IDENTITY_INSERT Countries OFF;

--DROP TABLE Temp

