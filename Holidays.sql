CREATE TABLE Holidays 
(
[Id] INT PRIMARY KEY IDENTITY,
[Date] DATE NOT NULL,
[Note] NVARCHAR (100) NULL,
[HolidayTypeId] INT FOREIGN KEY REFERENCES HolidayTypes(Id) NOT NULL,
[HolidayForShiftId] INT FOREIGN KEY REFERENCES HolidaysForShifts(Id) NULL
)

SELECT * FROM Holidays 
ORDER BY Date ASC

