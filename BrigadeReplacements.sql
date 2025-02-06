GO
CREATE TABLE BrigadeReplacements 
(
[Id] INT PRIMARY KEY IDENTITY,
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
[FirstBrigadeId] INT FOREIGN KEY REFERENCES Brigades(Id),
[SecondBrigadeId] INT FOREIGN KEY REFERENCES Brigades(Id),
[StartDate] DATETIME,
[EndDate] DATETIME
);


--Id = 10916 Calilov Farid
--Id = 13623 Aslanov Kamran



GO
CREATE PROC GetBrigadeReplacements
AS
BEGIN
SELECT * FROM BrigadeReplacements
END


GO
CREATE PROC AddBrigadeReplacement @EmployeeId INT, @FirstBrigadeId INT, @SecondBrigadeId INT, @StartDate DATETIME, @EndDate DATETIME 
AS
BEGIN
INSERT INTO BrigadeReplacements VALUES (@EmployeeId, @FirstBrigadeId, @SecondBrigadeId, @StartDate, @EndDate)
END


GO
CREATE PROC DeleteBrigadeReplacement @Id INT
AS
BEGIN
DELETE FROM BrigadeReplacements WHERE Id = @Id
END


