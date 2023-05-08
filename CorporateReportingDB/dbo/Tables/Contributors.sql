CREATE TABLE [dbo].[Contributors]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[ContributorUserID] INT NULL,
	[BenefitID] INT NULL,
	[CommitmentID] INT NULL,
	[DependencyID] INT NULL,
	[KeyWorkAreaID] INT NULL,
	[MetricID] INT NULL,
	[MilestoneID] INT NULL,
	[WorkStreamID] INT NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[RiskID] INT NULL,
	[RiskMitigationActionID] INT NULL,
	[PartnerOrganisationRiskID] INT NULL,
	[PartnerOrganisationRiskMitigationActionID] INT NULL,
	[PartnerOrganisationID] INT NULL,
	[IsReadOnly] BIT NULL,
	[ReportingEntityID] INT NULL,
	[DirectorateID] INT NULL,
	[ProjectID] INT NULL,
	CONSTRAINT [PK_Contributors] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Contributors] )
)
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_Benefits] FOREIGN KEY([BenefitID])
REFERENCES [dbo].[Benefits] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Benefits]
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_Commitments] FOREIGN KEY([CommitmentID])
REFERENCES [dbo].[Commitments] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Commitments]
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_Dependencies] FOREIGN KEY([DependencyID])
REFERENCES [dbo].[Dependencies] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Dependencies]
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_KeyWorkAreas] FOREIGN KEY([KeyWorkAreaID])
REFERENCES [dbo].[KeyWorkAreas] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_KeyWorkAreas]
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_Metrics] FOREIGN KEY([MetricID])
REFERENCES [dbo].[Metrics] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Metrics]
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_Milestones] FOREIGN KEY([MilestoneID])
REFERENCES [dbo].[Milestones] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Milestones]
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_ModifiedByUsers]
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_RiskMitigationActions] FOREIGN KEY([RiskMitigationActionID])
REFERENCES [dbo].[RiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_RiskMitigationActions]
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Risks]
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_Users] FOREIGN KEY([ContributorUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Users]
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_WorkStreams] FOREIGN KEY([WorkStreamID])
REFERENCES [dbo].[WorkStreams] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_WorkStreams]
GO

ALTER TABLE [dbo].[Contributors]  ADD  CONSTRAINT [FK_Contributors_ReportingEntities] FOREIGN KEY([ReportingEntityID])
REFERENCES [dbo].[ReportingEntities] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_ReportingEntities]
GO

ALTER TABLE [dbo].[Contributors] ADD  CONSTRAINT [DF_Contributors_SysStart]  DEFAULT (SYSUTCDATETIME()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Contributors] ADD  CONSTRAINT [DF_Contributors_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Contributors] ADD  CONSTRAINT [FK_Contributors_PartnerOrganisationRiskMitigationActions] FOREIGN KEY ([PartnerOrganisationRiskMitigationActionID]) REFERENCES [dbo].[PartnerOrganisationRiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[Contributors] ADD  CONSTRAINT [FK_Contributors_PartnerOrganisationRisks] FOREIGN KEY ([PartnerOrganisationRiskID]) REFERENCES [dbo].[PartnerOrganisationRisks] ([ID])
GO
ALTER TABLE [dbo].[Contributors] ADD  CONSTRAINT [FK_Contributors_PartnerOrganisations] FOREIGN KEY ([PartnerOrganisationID]) REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
 