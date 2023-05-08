-- DB Schema Upgrade for v1.3.2.0

ALTER TABLE [dbo].[Contributors] ADD [RiskID] INT, [RiskMitigationActionID] INT;
GO

ALTER TABLE [dbo].[Contributors]  WITH NOCHECK ADD  CONSTRAINT [FK_Contributors_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO

ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Risks]
GO

ALTER TABLE [dbo].[Contributors]  WITH NOCHECK ADD  CONSTRAINT [FK_Contributors_RiskMitigationActions] FOREIGN KEY([RiskMitigationActionID])
REFERENCES [dbo].[RiskMitigationActions] ([ID])
GO

ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_RiskMitigationActions]
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UQ_BenefitContributors]
    ON [dbo].[Contributors]([ContributorUserID] ASC, [BenefitID] ASC) WHERE ([BenefitID] IS NOT NULL);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UQ_CommitmentContributors]
    ON [dbo].[Contributors]([ContributorUserID] ASC, [CommitmentID] ASC) WHERE ([CommitmentID] IS NOT NULL);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UQ_DependencyContributors]
    ON [dbo].[Contributors]([ContributorUserID] ASC, [DependencyID] ASC) WHERE ([DependencyID] IS NOT NULL);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UQ_KeyWorkAreaContributors]
    ON [dbo].[Contributors]([ContributorUserID] ASC, [KeyWorkAreaID] ASC) WHERE ([KeyWorkAreaID] IS NOT NULL);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UQ_MetricContributors]
    ON [dbo].[Contributors]([ContributorUserID] ASC, [MetricID] ASC) WHERE ([MetricID] IS NOT NULL);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UQ_MilestoneContributors]
    ON [dbo].[Contributors]([ContributorUserID] ASC, [MilestoneID] ASC) WHERE ([MilestoneID] IS NOT NULL);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UQ_RiskContributors]
    ON [dbo].[Contributors]([ContributorUserID] ASC, [RiskID] ASC) WHERE ([RiskID] IS NOT NULL);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UQ_RiskMitigationActionContributors]
    ON [dbo].[Contributors]([ContributorUserID] ASC, [RiskMitigationActionID] ASC) WHERE ([RiskMitigationActionID] IS NOT NULL);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UQ_WorkStreamContributors]
    ON [dbo].[Contributors]([ContributorUserID] ASC, [WorkStreamID] ASC) WHERE ([WorkStreamID] IS NOT NULL);
GO

ALTER TABLE [dbo].[RiskMitigationActions] ALTER COLUMN [RiskMitigationActionCode] INT;
GO

ALTER TABLE [dbo].[RiskRegisters] ADD [RiskCodePrefix] NVARCHAR (50);
GO

ALTER TABLE [dbo].[Risks] ALTER COLUMN [DirectorateID] INT NOT NULL;
GO

ALTER TABLE [dbo].[Risks] ADD [RiskProximity] DATE NULL;
GO

ALTER TABLE [dbo].[RiskUpdates] ADD [RiskProximity] DATE, [RiskCode] NVARCHAR (50);
GO

ALTER TABLE [dbo].[UserGroups] ALTER COLUMN [IsRiskAdmin] BIT NOT NULL;
GO

ALTER TABLE [dbo].[UserGroups] ADD  CONSTRAINT [DF_UserGroups_IsRiskAdmin]  DEFAULT ((0)) FOR [IsRiskAdmin]
GO
