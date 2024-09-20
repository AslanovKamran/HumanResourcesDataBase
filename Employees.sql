GO
USE SP_HR

GO
CREATE TABLE Employees(
[Id] INT PRIMARY KEY,
[Surname] NVARCHAR (100) NOT NULL,
[Name] NVARCHAR (100) NOT NULL,
[FatherName] NVARCHAR (100) NOT NULL,
[BirthPlace] NVARCHAR (255) NULL,
[BirthDate] DATE NULL,
[GenderId] INT FOREIGN KEY REFERENCES Genders(Id), --1 For Male | 2 For Female
[MaritalStatusId] INT FOREIGN KEY REFERENCES MaritalStatuses(Id), --1 For Married | 2 For Single  
[SocialInsuranceNumber] NVARCHAR (255) NULL,
[PhotoUrl] NVARCHAR (255) NULL,

[EntryDate] DATE NOT NULL DEFAULT SYSDATETIME(),
[Trainership] INT NULL,
[LivingAddress] NVARCHAR (255) NULL,
[MobileNumber] NVARCHAR (255) NULL,
[TelephoneNumber] NVARCHAR (255) NULL,
[Email] NVARCHAR (255) NULL,
[Note] NVARCHAR (255) NULL, --Additional information about an employee
[IsWorking] BIT NOT NULL DEFAULT 1, 
[StateTableId] INT FOREIGN KEY REFERENCES StateTables(Id) NOT NULL,
[TabelNumber] NVARCHAR(255) NULL,

[TrainershipYear] INT NULL,
[TrainershipMonth] INT NULL,
[TrainershipDay] INT NULL,

[InternalNumber] NVARCHAR (100) NULL,

[PoliticalParty] NVARCHAR (255) NULL,
[PartyMembershipNumber] NVARCHAR (255) NULL,
[PartyEntranceDate] DATE NULL,
[PartyCardGivenDate] DATE NULL,
[PartyOrganizationRegion] NVARCHAR(255) NULL,

[MobileNumber2] NVARCHAR (255) NULL,
[MobileNumber3] NVARCHAR (255) NULL,
[BadgeGivenDate] DATE NULL,
[RegistrationAddress] NVARCHAR(255) NULL,
[TabelNumberOld] NVARCHAR(255) NULL,
[NationalityId] INT FOREIGN KEY REFERENCES Nationalities(Id) DEFAULT 1 NOT NULL,
[IsTradeUnionMember] BIT NOT NULL DEFAULT 1,

[HQBiletNumber] NVARCHAR(150) NULL,
[HQQeydiyyatQrupu] NVARCHAR(150) NULL,
[HQQeydiyyatDerecesi] NVARCHAR(150) NULL,
[HQTerkibi] NVARCHAR(150) NULL,
[HQHerbiRutbesi] NVARCHAR (150) NULL,
[HQXidmetNovu] NVARCHAR (150) NULL,
[HQIxtisasi] NVARCHAR (150) NULL,
[HQNomre] NVARCHAR (150) NULL,
[HQYararligi] NVARCHAR (150) NULL,
[HQKomissarliginAdi] NVARCHAR (150) NULL,
[HQXususiUchetdaDurduguNo] NVARCHAR (150) NULL,

[DisabilityDegree] INT NULL,
[IsVeteran] BIT DEFAULT 0 NOT NULL,
[IsRefugee] BIT DEFAULT 0 NOT NULL,
[AnvisUserId] NVARCHAR(255) NULL,
[HasDisabledChild] BIT DEFAULT 0 NOT NULL,
[OrderNumber] INT NULL,
[HasWarInjury] BIT DEFAULT 0 NOT NULL,
[IsRefugeeFromAnotherCountry] BIT DEFAULT 0 NOT NULL
)


--IDENTITY IS NOT SET 
