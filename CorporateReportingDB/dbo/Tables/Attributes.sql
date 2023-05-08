CREATE TABLE [dbo].[Attributes]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[AttributeTypeID] INT NOT NULL,
	[AttributeValue] NVARCHAR(255) NULL,
	[BenefitID] INT NULL,
	[CommitmentID] INT NULL,
	[KeyWorkAreaID] INT NULL,
	[MetricID] INT NULL,
	[WorkStreamID] INT NULL,
	[MilestoneID] INT NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[RiskID] INT NULL,
	[PartnerOrganisationRiskID] INT NULL,
	[DirectorateID] INT NULL,
	[ProjectID] INT NULL,
	[ReportingEntityID] INT NULL,
	[DependencyID] INT NULL,
	[PartnerOrganisationID] INT NULL,
	[RiskMitigationActionID] INT NULL,
	[PartnerOrganisationRiskMitigationActionID] INT NULL,
	CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Attributes] )
)
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_AttributeTypes] FOREIGN KEY([AttributeTypeID])
REFERENCES [dbo].[AttributeTypes] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_AttributeTypes]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_Benefits] FOREIGN KEY([BenefitID])
REFERENCES [dbo].[Benefits] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Benefits]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_Commitments] FOREIGN KEY([CommitmentID])
REFERENCES [dbo].[Commitments] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Commitments]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_Dependencies] FOREIGN KEY([DependencyID])
REFERENCES [dbo].[Dependencies] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Dependencies]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_KeyWorkAreas] FOREIGN KEY([KeyWorkAreaID])
REFERENCES [dbo].[KeyWorkAreas] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_KeyWorkAreas]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_Metrics] FOREIGN KEY([MetricID])
REFERENCES [dbo].[Metrics] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Metrics]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_Milestones] FOREIGN KEY([MilestoneID])
REFERENCES [dbo].[Milestones] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Milestones]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_ModifiedByUsers]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_WorkStreams] FOREIGN KEY([WorkStreamID])
REFERENCES [dbo].[WorkStreams] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_WorkStreams]
GO

ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF_Attributes_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF_Attributes_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Risks]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_RiskMitigationActions] FOREIGN KEY([RiskMitigationActionID])
REFERENCES [dbo].[RiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_RiskMitigationActions]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_PartnerOrganisations]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_PartnerOrganisationRisks] FOREIGN KEY([PartnerOrganisationRiskID])
REFERENCES [dbo].[PartnerOrganisationRisks] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_PartnerOrganisationRisks]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_PartnerOrganisationRiskMitigationActions] FOREIGN KEY([PartnerOrganisationRiskMitigationActionID])
REFERENCES [dbo].[PartnerOrganisationRiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_PartnerOrganisationRiskMitigationActions]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Directorates]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Projects]
GO

ALTER TABLE [dbo].[Attributes]  ADD  CONSTRAINT [FK_Attributes_ReportingEntities] FOREIGN KEY([ReportingEntityID])
REFERENCES [dbo].[ReportingEntities] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_ReportingEntities]
GO
