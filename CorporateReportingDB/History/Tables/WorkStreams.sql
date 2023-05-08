CREATE TABLE [History].[WorkStreams]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[WorkStreamCode] NVARCHAR(255) NULL,
	[ProjectID] INT NOT NULL,
	[LeadUserID] INT NULL,
	[RagOptionID] INT NULL,
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