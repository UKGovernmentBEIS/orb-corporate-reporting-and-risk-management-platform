CREATE TABLE [History].[Groups]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[DirectorGeneralUserID] INT NULL,
	[RiskChampionDeputyDirectorUserID] INT NULL,
	[BusinessPartnerUserID] INT NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL
) ON [PRIMARY]