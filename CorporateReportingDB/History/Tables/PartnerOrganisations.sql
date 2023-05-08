CREATE TABLE [History].[PartnerOrganisations]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[DirectorateID] INT NULL,
	[LeadPolicySponsorUserID] INT NULL,
	[ReportAuthorUserID] INT NULL,
	[Objectives] NVARCHAR(MAX) NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingStartMonth] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[ModifiedByUserID] INT NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[CreatedDate] DATETIME2(0) NULL,
	[Description] NVARCHAR(500) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]