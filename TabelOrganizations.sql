GO
USE SP_HR

GO
CREATE Table TabelOrganizations 
(
[Id] INT Primary KEY IDENTITY,
[Name] NVARCHAR (100) NULL
)



SELECT * FROM TabelOrganizations
--INSERT INTO TabelOrganizations VALUES(N'Baş idarə')
--INSERT INTO TabelOrganizations VALUES(N'Terminal təsərrüfat')
--INSERT INTO TabelOrganizations VALUES(N'Mühafizə')
--INSERT INTO TabelOrganizations VALUES(N'Avtonəqliyyat')
--INSERT INTO TabelOrganizations VALUES (N'YDM')
