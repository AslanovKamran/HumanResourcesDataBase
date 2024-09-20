GO
USE SP_HR

GO
CREATE TABLE ReprimandTypes
(
[Id] INT PRIMARY KEY IDENTITY,
[Type] NVARCHAR (50) NOT NULL UNIQUE
)

INSERT INTO ReprimandTypes VALUES (N'Töhmət')
INSERT INTO ReprimandTypes VALUES (N'Xəbərdarlıq')
INSERT INTO ReprimandTypes VALUES (N'Əmək haqqından tutulma')
INSERT INTO ReprimandTypes VALUES (N'Sonuncu xəbərdarlıq olmaqla şiddətli töhmət')

