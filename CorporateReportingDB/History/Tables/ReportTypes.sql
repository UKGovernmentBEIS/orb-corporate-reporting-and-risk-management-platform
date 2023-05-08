CREATE TABLE [History].[ReportTypes]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[CreatedDate] DATETIME2(0) NULL,
	[ModifiedByUserID] INT NULL
) ON [PRIMARY]