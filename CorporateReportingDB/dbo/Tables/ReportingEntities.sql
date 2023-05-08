CREATE TABLE [dbo].[ReportingEntities]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[ReportingEntityTypeID] INT NOT NULL,
	[DirectorateID] INT NULL,
	[ProjectID] INT NULL,
	[PartnerOrganisationID] INT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[CreatedDate] DATETIME2(0) NULL DEFAULT GETUTCDATE(),
	[ModifiedByUserID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[LeadUserID] INT NULL,
	[MeasurementUnitID] INT NULL,
	[TargetPerformanceUpperLimit] DECIMAL(18, 4) NULL,
	[TargetPerformanceLowerLimit] DECIMAL(18, 4) NULL,
	[BaselineDate] DATETIME2(0) NULL,
	[ForecastDate] DATETIME2(0) NULL,
	[ActualDate] DATETIME2(0) NULL,
	[Properties] NVARCHAR(MAX) NULL,
	CONSTRAINT [PK_ReportingEntities] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[ReportingEntities] )
)
GO

ALTER TABLE [dbo].[ReportingEntities]  ADD  CONSTRAINT [FK_ReportingEntities_ReportingEntityTypes] FOREIGN KEY([ReportingEntityTypeID])
REFERENCES [dbo].[ReportingEntityTypes] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_ReportingEntityTypes]
GO

ALTER TABLE [dbo].[ReportingEntities]  ADD  CONSTRAINT [FK_ReportingEntities_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_Directorates]
GO

ALTER TABLE [dbo].[ReportingEntities]  ADD  CONSTRAINT [FK_ReportingEntities_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_Projects]
GO

ALTER TABLE [dbo].[ReportingEntities]  ADD  CONSTRAINT [FK_ReportingEntities_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_PartnerOrganisations]
GO

ALTER TABLE [dbo].[ReportingEntities]  ADD  CONSTRAINT [FK_ReportingEntities_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_EntityStatuses]
GO

ALTER TABLE [dbo].[ReportingEntities]  ADD  CONSTRAINT [FK_ReportingEntities_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_ModifiedByUsers]
GO

ALTER TABLE [dbo].[ReportingEntities]  ADD  CONSTRAINT [FK_ReportingEntities_LeadUsers] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_LeadUsers]
GO

ALTER TABLE [dbo].[ReportingEntities]  ADD  CONSTRAINT [FK_ReportingEntities_MeasurementUnits] FOREIGN KEY([MeasurementUnitID])
REFERENCES [dbo].[MeasurementUnits] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_MeasurementUnits]
GO

ALTER TABLE [dbo].[ReportingEntities] ADD  CONSTRAINT [DF_ReportingEntities_SysStart]  DEFAULT (SYSUTCDATETIME()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[ReportingEntities] ADD  CONSTRAINT [DF_ReportingEntities_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]