CREATE TABLE [dbo].[PartnerOrganisationRiskMitigationActions]
(
    [ID] INT IDENTITY (1, 1) NOT NULL,
    [Title] NVARCHAR(200) NULL,
    [Description] NVARCHAR(500) NULL,
    [PartnerOrganisationRiskID] INT NULL,
    [RiskMitigationActionCode] INT NULL,
    [BaselineDate] DATE NULL,
    [ForecastDate] DATE NULL,
    [ActualDate] DATE NULL,
    [OwnerUserID] INT NULL,
    [ActionIsOngoing] BIT NULL,
    [ReportingFrequency] TINYINT NULL,
    [ReportingStartMonth] TINYINT NULL,
    [ReportingDueDay] TINYINT NULL,
    [ReportingStartDate] DATETIME2(0) NULL,
    [EntityStatusID] INT NULL,
    [EntityStatusDate] DATETIME2(7) NULL,
    [SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_PartnerOrganisationRiskMitigationActions_SysStart] DEFAULT (SYSUTCDATETIME()) NOT NULL,
    [SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END CONSTRAINT [DF_PartnerOrganisationRiskMitigationActions_SysEnd] DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) NOT NULL,
    [ModifiedByUserID] INT NULL,
    [LeadUserID] INT NULL,
    CONSTRAINT [PK_PartnerOrganisationRiskMitigatingActions] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_EntityStatuses] FOREIGN KEY ([EntityStatusID]) REFERENCES [dbo].[EntityStatuses] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_ModifiedByUsers] FOREIGN KEY ([ModifiedByUserID]) REFERENCES [dbo].[Users] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_PartnerOrganisationRisks] FOREIGN KEY ([PartnerOrganisationRiskID]) REFERENCES [dbo].[PartnerOrganisationRisks] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_Users] FOREIGN KEY ([OwnerUserID]) REFERENCES [dbo].[Users] ([ID]),
    CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_LeadUsers] FOREIGN KEY ([LeadUserID]) REFERENCES [dbo].[Users] ([ID]),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[History].[PartnerOrganisationRiskMitigationActions], DATA_CONSISTENCY_CHECK=ON));
GO

