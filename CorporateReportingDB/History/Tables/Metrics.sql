CREATE TABLE [History].[Metrics]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[MetricCode] NVARCHAR(255) NULL,
	[DirectorateID] INT NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	[MeasurementUnitID] INT NULL,
	[TargetPerformanceUpperLimit] DECIMAL(18, 4) NULL,
	[TargetPerformanceLowerLimit] DECIMAL(18, 4) NULL,
	[LeadUserID] INT NULL,
	[RagOptionID] INT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingStartMonth] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]