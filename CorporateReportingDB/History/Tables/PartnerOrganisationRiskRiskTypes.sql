CREATE TABLE [History].[PartnerOrganisationRiskRiskTypes]
(
    [ID] INT NOT NULL,
    [Title] NVARCHAR (50) NULL,
    [PartnerOrganisationRiskID] INT NOT NULL,
    [RiskTypeID] INT NOT NULL,
    [ModifiedByUserID] INT NULL,
    [SysStartTime] DATETIME2 (0) NOT NULL,
    [SysEndTime] DATETIME2 (0) NOT NULL
);
GO

CREATE CLUSTERED INDEX [ix_PartnerOrganisationRiskRiskTypes]
    ON [History].[PartnerOrganisationRiskRiskTypes]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);
GO

