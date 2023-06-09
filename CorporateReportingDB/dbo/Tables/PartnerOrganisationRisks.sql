﻿CREATE TABLE [dbo].[PartnerOrganisationRisks]
(
    [ID] INT IDENTITY(1, 1) NOT NULL,
    [Title] NVARCHAR(255) NULL,
    [RiskCode] NVARCHAR(50) NULL,
    [PartnerOrganisationID] INT NOT NULL,
    [RiskOwnerUserID] INT NULL,
    [BeisRiskOwnerUserID] INT NULL,
    [RagOptionID] INT NULL,
    [RiskEventDescription] NVARCHAR(600) NULL,
    [RiskCauseDescription] NVARCHAR(600) NULL,
    [RiskImpactDescription] NVARCHAR(600) NULL,
    [UnmitigatedRiskProbabilityID] INT NULL,
    [UnmitigatedRiskImpactLevelID] INT NULL,
    [TargetRiskProbabilityID] INT NULL,
    [TargetRiskImpactLevelID] INT NULL,
    [BEISUnmitigatedRiskProbabilityID] INT NULL,
    [BEISUnmitigatedRiskImpactLevelID] INT NULL,
    [BEISTargetRiskProbabilityID] INT NULL,
    [BEISTargetRiskImpactLevelID] INT NULL,
    [RiskAppetiteID] INT NULL,
    [BeisRiskAppetiteID] INT NULL,
    [DepartmentalObjectiveID] INT NULL,
    [RiskProximity] DATE NULL,
    [RiskIsOngoing] BIT NULL,
    [ReportingFrequency] TINYINT NULL,
    [ReportingStartMonth] TINYINT NULL,
    [ReportingDueDay] TINYINT NULL,
    [ReportingStartDate] DATETIME2(0) NULL,
    [EntityStatusID] INT NULL,
    [EntityStatusDate] DATETIME2(7) NULL,
    [ModifiedByUserID] INT NULL,
    [SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_PartnerOrganisationRisks_SysStart] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END CONSTRAINT [DF_PartnerOrganisationRisks_SysEnd] DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) NOT NULL,
    [Description] NVARCHAR(500) NULL,
    [LeadUserID] INT NULL,
    CONSTRAINT [PK_PartnerOrganisationRisks] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_PartnerOrganisationRisks_BeisRiskAppetites] FOREIGN KEY ([BeisRiskAppetiteID]) REFERENCES [dbo].[RiskAppetites] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_BeisUsers] FOREIGN KEY ([BeisRiskOwnerUserID]) REFERENCES [dbo].[Users] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_DepartmentalObjectives] FOREIGN KEY ([DepartmentalObjectiveID]) REFERENCES [dbo].[DepartmentalObjectives] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_EntityStatuses] FOREIGN KEY ([EntityStatusID]) REFERENCES [dbo].[EntityStatuses] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_ModifiedByUsers] FOREIGN KEY ([ModifiedByUserID]) REFERENCES [dbo].[Users] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_PartnerOrganisations] FOREIGN KEY ([PartnerOrganisationID]) REFERENCES [dbo].[PartnerOrganisations] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_RagOptions] FOREIGN KEY ([RagOptionID]) REFERENCES [dbo].[RagOptions] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_RiskAppetites] FOREIGN KEY ([RiskAppetiteID]) REFERENCES [dbo].[RiskAppetites] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_TargetRiskImpactLevels] FOREIGN KEY ([TargetRiskImpactLevelID]) REFERENCES [dbo].[RiskImpactLevels] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_TargetRiskProbabilities] FOREIGN KEY ([TargetRiskProbabilityID]) REFERENCES [dbo].[RiskProbabilities] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_UnmitigatedRiskImpactLevels] FOREIGN KEY ([UnmitigatedRiskImpactLevelID]) REFERENCES [dbo].[RiskImpactLevels] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_UnmitigatedRiskProbabilities] FOREIGN KEY ([UnmitigatedRiskProbabilityID]) REFERENCES [dbo].[RiskProbabilities] ([ID]),

    CONSTRAINT [FK_PartnerOrganisationRisks_BEISTargetRiskImpactLevels] FOREIGN KEY ([BEISTargetRiskImpactLevelID]) REFERENCES [dbo].[RiskImpactLevels] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_BEISTargetRiskProbabilities] FOREIGN KEY ([BEISTargetRiskProbabilityID]) REFERENCES [dbo].[RiskProbabilities] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_BEISUnmitigatedRiskImpactLevels] FOREIGN KEY ([BEISUnmitigatedRiskImpactLevelID]) REFERENCES [dbo].[RiskImpactLevels] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_BEISUnmitigatedRiskProbabilities] FOREIGN KEY ([BEISUnmitigatedRiskProbabilityID]) REFERENCES [dbo].[RiskProbabilities] ([ID]),

    CONSTRAINT [FK_PartnerOrganisationRisks_Users] FOREIGN KEY ([RiskOwnerUserID]) REFERENCES [dbo].[Users] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRisks_LeadUsers] FOREIGN KEY ([LeadUserID]) REFERENCES [dbo].[Users] ([ID]),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[History].[PartnerOrganisationRisks], DATA_CONSISTENCY_CHECK=ON));
GO

