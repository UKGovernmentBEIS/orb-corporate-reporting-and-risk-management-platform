CREATE TABLE [dbo].[PartnerOrganisationRiskRiskTypes]
(
    [ID] INT IDENTITY(1, 1) NOT NULL,
    [Title] NVARCHAR(50) NULL,
    [PartnerOrganisationRiskID] INT NOT NULL,
    [RiskTypeID] INT NOT NULL,
    [ModifiedByUserID] INT NULL,
    [SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_PartnerOrganisationRiskRiskTypes_SysStart] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END CONSTRAINT [DF_PartnerOrganisationRiskRiskTypes_SysEnd] DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_PartnerOrganisationRiskRiskTypes] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_PartnerOrganisationRisks] FOREIGN KEY ([PartnerOrganisationRiskID]) REFERENCES [dbo].[PartnerOrganisationRisks] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_RiskTypes] FOREIGN KEY ([RiskTypeID]) REFERENCES [dbo].[RiskTypes] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_Users] FOREIGN KEY ([ModifiedByUserID]) REFERENCES [dbo].[Users] ([ID]),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[History].[PartnerOrganisationRiskRiskTypes], DATA_CONSISTENCY_CHECK=ON));
GO

