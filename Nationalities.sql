USE SP_HR

GO
CREATE TABLE Nationalities (
[Id] INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR (50) UNIQUE NOT NULL
)

INSERT INTO Nationalities VALUES (N'Azərbaycanlı')
INSERT INTO Nationalities VALUES (N'Ləzgi')
INSERT INTO Nationalities VALUES (N'Rus')
INSERT INTO Nationalities VALUES (N'Talış')
INSERT INTO Nationalities VALUES (N'Tat')

SELECT * FROM Nationalities