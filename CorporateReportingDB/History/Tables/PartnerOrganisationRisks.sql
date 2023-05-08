CREATE TABLE [History].[PartnerOrganisationRisks] 
(
    [ID]                           INT            NOT NULL,
    [Title]                        NVARCHAR (255) NULL,
    [RiskCode]                     NVARCHAR (50)  NULL,
    [PartnerOrganisationID]        INT            NOT NULL,
    [RiskOwnerUserID]              INT            NULL,
    [BeisRiskOwnerUserID]          INT            NULL,
    [RagOptionID]                  INT            NULL,
    [RiskEventDescription]         NVARCHAR (600) NULL,
    [RiskCauseDescription]         NVARCHAR (600) NULL,
    [RiskImpactDescription]        NVARCHAR (600) NULL,
    [UnmitigatedRiskProbabilityID] INT            NULL,
    [UnmitigatedRiskImpactLevelID] INT            NULL,
    [TargetRiskProbabilityID]      INT            NULL,
    [TargetRiskImpactLevelID]      INT            NULL,
	[BEISUnmitigatedRiskProbabilityID] INT            NULL,
    [BEISUnmitigatedRiskImpactLevelID] INT            NULL,
    [BEISTargetRiskProbabilityID]      INT            NULL,
    [BEISTargetRiskImpactLevelID]      INT            NULL,
    [RiskAppetiteID]               INT            NULL,
    [BeisRiskAppetiteID]           INT            NULL,
    [DepartmentalObjectiveID]      INT            NULL,
    [RiskProximity]                DATE           NULL,
    [RiskIsOngoing]                BIT            NULL,
    [ReportingFrequency]           TINYINT        NULL,
    [ReportingStartMonth]          TINYINT        NULL,
    [ReportingDueDay]              TINYINT        NULL,
	[ReportingStartDate]           DATETIME2 (0)  NULL,
    [EntityStatusID]               INT            NULL,
    [EntityStatusDate]             DATETIME2 (7)  NULL,
    [ModifiedByUserID]             INT            NULL,
    [SysStartTime]                 DATETIME2 (0)  NOT NULL,
    [SysEndTime]                   DATETIME2 (0)  NOT NULL,
    [Description]                  NVARCHAR(500)  NULL,
    [LeadUserID]                   INT            NULL
);
GO

CREATE CLUSTERED INDEX [ix_PartnerOrganisationRisks]
    ON [History].[PartnerOrganisationRisks]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);
GO
