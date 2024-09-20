

GO
USE SP_HR

GO
CREATE TABLE EducationTypes
(
[Id] INT PRIMARY KEY,
[Type] NVARCHAR (100) NOT NULL UNIQUE 
)


--INSERT INTO EducationTypes VALUES (5,N'Ümumi təhsil - ibtidai təhsil')
--INSERT INTO EducationTypes VALUES (10,N'Ümumi təhsil - ümumi orta təhsil')
--INSERT INTO EducationTypes VALUES (20,N'Ümumi təhsil - tam orta təhsil')
--INSERT INTO EducationTypes VALUES (30,N'Orta ixtisas təhsili')
--INSERT INTO EducationTypes VALUES (40,N'İlk peşə-ixtisas təhsili')
--INSERT INTO EducationTypes VALUES (50,N'Natamam ali təhsil')
--INSERT INTO EducationTypes VALUES (55,N'Ali təhsil - 1997-ci ilə qədər tam ali təhsil')
--INSERT INTO EducationTypes VALUES (60,N'Ali təhsil - bakalavriat')
--INSERT INTO EducationTypes VALUES (70,N'Ali təhsil - magistratura')
--INSERT INTO EducationTypes VALUES (80,N'Ali təhsil - doktorantura')
--INSERT INTO EducationTypes VALUES (90,N'Yenidənhazırlanma')


--GO
--SELECT * INTO Temp 
--FROM EducationTypes;

--DROP TABLE EducationTypes

--GO
--CREATE TABLE EducationTypes
--(
--[Id] INT PRIMARY KEY IDENTITY (95,5),
--[Type] NVARCHAR (100) NOT NULL UNIQUE 
--)

--SET IDENTITY_INSERT EducationTypes ON


--INSERT INTO EducationTypes(
--    [Id], [Type]
--)
--SELECT * FROM Temp;


--SET IDENTITY_INSERT EducationTypes OFF

--DROP TABLE Temp


SELECT * FROM EducationTypes ORDER BY Id





