CREATE TABLE [dbo].[Benefits]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[ProjectID] INT NOT NULL,
	[BenefitTypeID] INT NULL,
	[MeasurementUnitID] INT NULL,
	[TargetPerformanceLowerLimit] DECIMAL(18, 4) NULL,
	[TargetPerformanceUpperLimit] DECIMAL(18, 4) NULL,
	[LeadUserID] INT NULL,
	[RagOptionID] INT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[ReportingStartMonth] TINYINT NULL,
	[Description] NVARCHAR(500) NULL,
	[BaselineDate] DATETIME2(0) NULL,
	[ForecastDate] DATETIME2(0) NULL,
	[ActualDate] DATETIME2(0) NULL,
	CONSTRAINT [PK_Benefits] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Benefits] )
)
GO

ALTER TABLE [dbo].[Benefits]  ADD  CONSTRAINT [FK_Benefits_BenefitTypes] FOREIGN KEY([BenefitTypeID])
REFERENCES [dbo].[BenefitTypes] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_BenefitTypes]
GO

ALTER TABLE [dbo].[Benefits]  ADD  CONSTRAINT [FK_Benefits_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_EntityStatuses]
GO

ALTER TABLE [dbo].[Benefits]  ADD  CONSTRAINT [FK_Benefits_MeasurementUnits] FOREIGN KEY([MeasurementUnitID])
REFERENCES [dbo].[MeasurementUnits] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_MeasurementUnits]
GO

ALTER TABLE [dbo].[Benefits]  ADD  CONSTRAINT [FK_Benefits_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_ModifiedByUsers]
GO

ALTER TABLE [dbo].[Benefits]  ADD  CONSTRAINT [FK_Benefits_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_Projects]
GO

ALTER TABLE [dbo].[Benefits]  ADD  CONSTRAINT [FK_Benefits_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_RagOptions]
GO

ALTER TABLE [dbo].[Benefits]  ADD  CONSTRAINT [FK_Benefits_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_Users]
GO

ALTER TABLE [dbo].[Benefits] ADD  CONSTRAINT [DF_Benefits_SysStart]  DEFAULT (SYSUTCDATETIME()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Benefits] ADD  CONSTRAINT [DF_Benefits_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO