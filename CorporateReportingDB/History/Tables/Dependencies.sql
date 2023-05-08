CREATE TABLE [History].[Dependencies]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[ProjectID] INT NOT NULL,
	[ThirdParty] NVARCHAR(255) NULL,
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
	[Description] NVARCHAR(500) NULL,
	[StartDate] DATE NULL,
	[EndDate] DATE NULL,
	[BaselineDate] DATETIME NULL,
	[ForecastDate] DATETIME NULL,
	[ActualDate] DATETIME NULL
) ON [PRIMARY]