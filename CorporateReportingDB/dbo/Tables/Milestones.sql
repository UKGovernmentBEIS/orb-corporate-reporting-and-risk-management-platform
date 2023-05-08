CREATE TABLE [dbo].[Milestones]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[MilestoneCode] NVARCHAR(255) NULL,
	[BaselineDate] DATETIME NULL,
	[ForecastDate] DATETIME NULL,
	[ActualDate] DATETIME NULL,
	[MilestoneTypeID] INT NULL,
	[LeadUserID] INT NULL,
	[RagOptionID] INT NULL,
	[WorkStreamID] INT NULL,
	[KeyWorkAreaID] INT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[PartnerOrganisationID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingStartMonth] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[StartDate] DATETIME NULL,
	[Description] NVARCHAR(500) NULL,
	CONSTRAINT [PK_Milestones] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Milestones] )
)
GO

ALTER TABLE [dbo].[Milestones]  ADD  CONSTRAINT [FK_Milestones_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_EntityStatuses]
GO

ALTER TABLE [dbo].[Milestones]  ADD  CONSTRAINT [FK_Milestones_KeyWorkAreas] FOREIGN KEY([KeyWorkAreaID])
REFERENCES [dbo].[KeyWorkAreas] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_KeyWorkAreas]
GO

ALTER TABLE [dbo].[Milestones]  ADD  CONSTRAINT [FK_Milestones_MilestoneTypes] FOREIGN KEY([MilestoneTypeID])
REFERENCES [dbo].[MilestoneTypes] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_MilestoneTypes]
GO

ALTER TABLE [dbo].[Milestones]  ADD  CONSTRAINT [FK_Milestones_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_ModifiedByUsers]
GO

ALTER TABLE [dbo].[Milestones]  ADD  CONSTRAINT [FK_Milestones_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_PartnerOrganisations]
GO

ALTER TABLE [dbo].[Milestones]  ADD  CONSTRAINT [FK_Milestones_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_RagOptions]
GO

ALTER TABLE [dbo].[Milestones]  ADD  CONSTRAINT [FK_Milestones_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_Users]
GO

ALTER TABLE [dbo].[Milestones]  ADD  CONSTRAINT [FK_Milestones_WorkStreams] FOREIGN KEY([WorkStreamID])
REFERENCES [dbo].[WorkStreams] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_WorkStreams]
GO

ALTER TABLE [dbo].[Milestones] ADD  CONSTRAINT [DF_Milestones_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Milestones] ADD  CONSTRAINT [DF_Milestones_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO