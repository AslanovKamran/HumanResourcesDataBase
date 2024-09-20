GO
USE SP_HR

--GO
--CREATE TABLE IdentityCard
--(
--[Id] INT PRIMARY KEY,
--[Series] NVARCHAR (50) NULL,
--[CardNumber] NVARCHAR (100) NULL,
--[Organization] NVARCHAR (100) NULL,
--[GivenAt] DATE NULL,
--[ValidUntil] DATE NULL,
--[FinCode] NVARCHAR (50) NULL,
--[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id),
--[PhotoFront] NVARCHAR (255) NULL,
--[PhotoBack] NVARCHAR (255) NULL,
--)

-- BULK INSERT HERE
--!!!!!!!!!!!!!! IDENTITY NOT SET AS THE EMPLOYEES KEEP BEING ADDED !!!!!!!!!!!!!!!!!!!!!

SELECT * FROM IdentityCard 


