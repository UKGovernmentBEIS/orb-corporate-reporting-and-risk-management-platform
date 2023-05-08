CREATE TABLE [dbo].[PartnerOrganisationRiskUpdates]
(
    [ID] INT IDENTITY(1, 1) NOT NULL,
    [Title] NVARCHAR(255) NULL,
    [Comment] NVARCHAR(500) NULL,
    [RagOptionID] INT NULL,
    [BeisRagOptionID] INT NULL,
    [PartnerOrganisationRiskID] INT NULL,
    [UpdateUserID] INT NULL,
    [UpdateDate] DATETIME2(7) NULL,
    [RiskProbabilityID] INT NULL,
    [RiskImpactLevelID] INT NULL,
    [BeisRiskProbabilityID] INT NULL,
    [BeisRiskImpactLevelID] INT NULL,
    [ToBeClosed] BIT NULL,
    [UpdatePeriod] DATE NULL,
    [IsCurrent] BIT NULL,
    [RiskProximity] DATE NULL,
    [RiskIsOngoing] BIT NULL,
    [SignOffID] INT NULL,
    CONSTRAINT [PK_PartnerOrganisationRiskUpdates] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRagOptions] FOREIGN KEY ([BeisRagOptionID]) REFERENCES [dbo].[RagOptions] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRiskImpactLevels] FOREIGN KEY ([BeisRiskImpactLevelID]) REFERENCES [dbo].[RiskImpactLevels] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRiskProbabilities] FOREIGN KEY ([BeisRiskProbabilityID]) REFERENCES [dbo].[RiskProbabilities] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskUpdates_PartnerOrganisationRisks] FOREIGN KEY ([PartnerOrganisationRiskID]) REFERENCES [dbo].[PartnerOrganisationRisks] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RagOptions] FOREIGN KEY ([RagOptionID]) REFERENCES [dbo].[RagOptions] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RiskImpactLevels] FOREIGN KEY ([RiskImpactLevelID]) REFERENCES [dbo].[RiskImpactLevels] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RiskProbabilities] FOREIGN KEY ([RiskProbabilityID]) REFERENCES [dbo].[RiskProbabilities] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskUpdates_SignOffs] FOREIGN KEY ([SignOffID]) REFERENCES [dbo].[SignOffs] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskUpdates_Users] FOREIGN KEY ([UpdateUserID]) REFERENCES [dbo].[Users] ([ID])
);
GO

