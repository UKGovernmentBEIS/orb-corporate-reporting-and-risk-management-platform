CREATE TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates]
(
    [ID] INT IDENTITY(1, 1) NOT NULL,
    [Title] NVARCHAR(500) NULL,
    [PartnerOrganisationRiskMitigationActionID] INT NULL,
    [UpdateDate] DATETIME2(7) NULL,
    [UpdateUserID] INT NULL,
    [RagOptionID] INT NULL,
    [Comment] NVARCHAR(500) NULL,
    [ForecastDate] DATE NULL,
    [ActualDate] DATE NULL,
    [ToBeClosed] BIT NULL,
    [UpdatePeriod] DATE NULL,
    [SignOffID] INT NULL,
    CONSTRAINT [PK_PartnerOrganisationRiskMitigationActionUpdates] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_PartnerOrganisationRiskMitigationActions] FOREIGN KEY ([PartnerOrganisationRiskMitigationActionID]) REFERENCES [dbo].[PartnerOrganisationRiskMitigationActions] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_RagOptions] FOREIGN KEY ([RagOptionID]) REFERENCES [dbo].[RagOptions] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_SignOffs] FOREIGN KEY ([SignOffID]) REFERENCES [dbo].[SignOffs] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_Users] FOREIGN KEY ([UpdateUserID]) REFERENCES [dbo].[Users] ([ID])
);
GO

