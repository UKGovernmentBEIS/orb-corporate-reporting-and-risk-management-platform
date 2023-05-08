CREATE TABLE [History].[Directorates]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[GroupID] INT NOT NULL,
	[DirectorUserID] INT NULL,
	[Objectives] NVARCHAR(MAX) NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL,
	[ReportApproverUserID] INT NULL,
	[ReportingLeadUserID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[Description] NVARCHAR(500) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]