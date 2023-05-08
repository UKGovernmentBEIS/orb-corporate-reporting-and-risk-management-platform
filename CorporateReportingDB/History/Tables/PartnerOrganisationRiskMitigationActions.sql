CREATE TABLE [History].[PartnerOrganisationRiskMitigationActions]
(
    [ID] INT NOT NULL,
    [Title] NVARCHAR (200) NULL,
    [Description] NVARCHAR (500) NULL,
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
    [ReportingStartDate] DATETIME2 (0) NULL,
    [EntityStatusID] INT NULL,
    [EntityStatusDate] DATETIME2 (7) NULL,
    [SysStartTime] DATETIME2 (0) NOT NULL,
    [SysEndTime] DATETIME2 (0) NOT NULL,
    [ModifiedByUserID] INT NULL,
    [LeadUserID] INT NULL
);
GO

CREATE CLUSTERED INDEX [ix_PartnerOrganisationRiskMitigationActions]
    ON [History].[PartnerOrganisationRiskMitigationActions]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

