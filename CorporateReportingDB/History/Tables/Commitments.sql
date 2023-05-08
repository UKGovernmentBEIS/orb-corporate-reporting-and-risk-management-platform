CREATE TABLE [History].[Commitments]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[DirectorateID] INT NOT NULL,
	[BaselineDate] DATE NULL,
	[ForecastDate] DATE NULL,
	[ActualDate] DATE NULL,
	[RagOptionID] INT NULL,
	[LeadUserID] INT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[Description] NVARCHAR(500) NULL
) ON [PRIMARY]