GO
USE SP_HR

CREATE Table HolidaysForShifts
(
[Id] INT IDENTITY PRIMARY KEY,
[Shift] NVARCHAR (255) NOT NULL UNIQUE
)

INSERT INTO HolidaysForShifts VALUES (N'Yalnız 5 günlük iş rejimi üçün')
INSERT INTO HolidaysForShifts VALUES (N'Yalnız 5 və ya 6 günlük iş rejimi üçün')
INSERT INTO HolidaysForShifts VALUES (N'Yalnız 6 günlük iş rejimi üçün')
INSERT INTO HolidaysForShifts VALUES (N'Yalnız istirahət günü şənbə olan 6 günlük iş rejimi üçün')
INSERT INTO HolidaysForShifts VALUES (N'Yalnız 5 və ya istirahət günü bazar olan 6 günlük iş rejimi üçün')

