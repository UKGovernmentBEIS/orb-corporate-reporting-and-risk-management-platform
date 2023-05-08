CREATE TABLE [dbo].[Metrics]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
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
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingStartMonth] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	CONSTRAINT [PK_Metrics] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Metrics] )
)
GO

ALTER TABLE [dbo].[Metrics]  ADD  CONSTRAINT [FK_Metrics_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_Directorates]
GO

ALTER TABLE [dbo].[Metrics]  ADD  CONSTRAINT [FK_Metrics_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_EntityStatuses]
GO

ALTER TABLE [dbo].[Metrics]  ADD  CONSTRAINT [FK_Metrics_MeasurementUnits] FOREIGN KEY([MeasurementUnitID])
REFERENCES [dbo].[MeasurementUnits] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_MeasurementUnits]
GO

ALTER TABLE [dbo].[Metrics]  ADD  CONSTRAINT [FK_Metrics_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_ModifiedByUsers]
GO

ALTER TABLE [dbo].[Metrics]  ADD  CONSTRAINT [FK_Metrics_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_RagOptions]
GO

ALTER TABLE [dbo].[Metrics]  ADD  CONSTRAINT [FK_Metrics_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_Users]
GO

ALTER TABLE [dbo].[Metrics] ADD  CONSTRAINT [DF_Metrics_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Metrics] ADD  CONSTRAINT [DF_Metrics_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]