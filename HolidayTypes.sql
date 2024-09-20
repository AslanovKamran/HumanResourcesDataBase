GO
USE SP_HR

CREATE Table HolidayTypes
(
[Id] INT IDENTITY PRIMARY KEY,
[Type] NVARCHAR (255) NOT NULL UNIQUE
)

INSERT INTO HolidayTypes VALUES (N'Bayram/Səsvermə')
INSERT INTO HolidayTypes VALUES (N'Matəm')
INSERT INTO HolidayTypes VALUES (N'İstirahət günü')
INSERT INTO HolidayTypes VALUES (N'Ödənişli qeyri iş günü')
INSERT INTO HolidayTypes VALUES (N'İş günü')

