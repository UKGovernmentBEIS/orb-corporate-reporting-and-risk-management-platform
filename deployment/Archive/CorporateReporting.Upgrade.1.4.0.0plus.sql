-- DB Schema Upgrade for next release after v1.4.0.0

-- CARP-451 Partner organisation risks

ALTER TABLE [dbo].[Risks] ADD [IsPartnerOrganisationRisk] [bit] NULL, [ReportingFrequency] [tinyint] NULL, [ReportingStartMonth] [tinyint] NULL;
GO

ALTER TABLE [dbo].[Risks] ALTER COLUMN [DirectorateID] [int] NULL;
GO

ALTER TABLE [dbo].[RiskMitigationActions] ADD [ReportingFrequency] [tinyint] NULL, [ReportingStartMonth] [tinyint] NULL;
GO

--

-- CARP-454 Change partner organisation risks

ALTER TABLE [dbo].[Risks] DROP CONSTRAINT [FK_Risks_PartnerOrganisations]
GO

ALTER TABLE [dbo].[Risks] DROP COLUMN [PartnerOrganisationID], [IsPartnerOrganisationRisk];
GO

-- Partner org risks

CREATE TABLE [dbo].[PartnerOrganisationRisks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[RiskCode] [nvarchar](50) NULL,
	[PartnerOrganisationID] [int] NOT NULL,
	[RiskOwnerUserID] [int] NULL,
	[BeisRiskOwnerUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[RiskEventDescription] [nvarchar](500) NULL,
	[RiskCauseDescription] [nvarchar](500) NULL,
	[RiskImpactDescription] [nvarchar](500) NULL,
	[UnmitigatedRiskProbabilityID] [int] NULL,
	[UnmitigatedRiskImpactLevelID] [int] NULL,
	[TargetRiskProbabilityID] [int] NULL,
	[TargetRiskImpactLevelID] [int] NULL,
	[RiskAppetiteID] [int] NULL,
	[BeisRiskAppetiteID] [int] NULL,
	[DepartmentalObjectiveID] [int] NULL,
	[RiskProximity] [date] NULL,
	[RiskIsOngoing] [bit] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,	
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[ModifiedByUserID] [int] NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PK_PartnerOrganisationRisks] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[PartnerOrganisationRisks] )
)
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] ADD  CONSTRAINT [DF_PartnerOrganisationRisks_SysStart]  DEFAULT SYSUTCDATETIME() FOR [SysStartTime]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] ADD  CONSTRAINT [DF_PartnerOrganisationRisks_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_DepartmentalObjectives] FOREIGN KEY([DepartmentalObjectiveID])
REFERENCES [dbo].[DepartmentalObjectives] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_DepartmentalObjectives]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_EntityStatuses]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_ModifiedByUsers]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_PartnerOrganisations]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_RagOptions]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_RiskAppetites] FOREIGN KEY([RiskAppetiteID])
REFERENCES [dbo].[RiskAppetites] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_RiskAppetites]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_BeisRiskAppetites] FOREIGN KEY([BeisRiskAppetiteID])
REFERENCES [dbo].[RiskAppetites] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_BeisRiskAppetites]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_TargetRiskImpactLevels] FOREIGN KEY([TargetRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_TargetRiskImpactLevels]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_TargetRiskProbabilities] FOREIGN KEY([TargetRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_TargetRiskProbabilities]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_UnmitigatedRiskImpactLevels] FOREIGN KEY([UnmitigatedRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_UnmitigatedRiskImpactLevels]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_UnmitigatedRiskProbabilities] FOREIGN KEY([UnmitigatedRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_UnmitigatedRiskProbabilities]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_Users] FOREIGN KEY([RiskOwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_Users]
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_BeisUsers] FOREIGN KEY([BeisRiskOwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_BeisUsers]
GO

-- Partner org risk actions


CREATE TABLE [dbo].[PartnerOrganisationRiskMitigationActions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NULL,
	[Description] [nvarchar](500) NULL,
	[PartnerOrganisationRiskID] [int] NULL,
	[RiskMitigationActionCode] [int] NULL,
	[BaselineDate] [date] NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
	[OwnerUserID] [int] NULL,
	[ActionIsOngoing] [bit] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	
 CONSTRAINT [PK_PartnerOrganisationRiskMitigatingActions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[PartnerOrganisationRiskMitigationActions] )
)
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] ADD  CONSTRAINT [DF_PartnerOrganisationRiskMitigationActions_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] ADD  CONSTRAINT [DF_PartnerOrganisationRiskMitigationActions_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_EntityStatuses]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_ModifiedByUsers]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_PartnerOrganisationRisks] FOREIGN KEY([PartnerOrganisationRiskID])
REFERENCES [dbo].[PartnerOrganisationRisks] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_PartnerOrganisationRisks]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_Users] FOREIGN KEY([OwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_Users]
GO

-- Partner org risk updates

CREATE TABLE [dbo].[PartnerOrganisationRiskUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Comment] [nvarchar](500) NULL,
	[RagOptionID] [int] NULL,
	[BeisRagOptionID] [int] NULL,
	[PartnerOrganisationRiskID] [int] NULL,
	[UpdateUserID] [int] NULL,
	[UpdateDate] [datetime2](7) NULL,
	[RiskProbabilityID] [int] NULL,
	[RiskImpactLevelID] [int] NULL,
	[BeisRiskProbabilityID] [int] NULL,
	[BeisRiskImpactLevelID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
	[IsCurrent] [bit] NULL,
	[RiskProximity] [date] NULL,
	[RiskIsOngoing] [bit] NULL,
	[SignOffID] [int] NULL,
 CONSTRAINT [PK_PartnerOrganisationRiskUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RagOptions]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRagOptions] FOREIGN KEY([BeisRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRagOptions]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RiskImpactLevels] FOREIGN KEY([RiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RiskImpactLevels]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RiskProbabilities] FOREIGN KEY([RiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RiskProbabilities]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRiskImpactLevels] FOREIGN KEY([BeisRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRiskImpactLevels]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRiskProbabilities] FOREIGN KEY([BeisRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RiskProbabilities]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_PartnerOrganisationRisks] FOREIGN KEY([PartnerOrganisationRiskID])
REFERENCES [dbo].[PartnerOrganisationRisks] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_PartnerOrganisationRisks]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_SignOffs]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_Users]
GO

-- Partner org action updates

CREATE TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NULL,
	[PartnerOrganisationRiskMitigationActionID] [int] NULL,
	[UpdateDate] [datetime2](7) NULL,
	[UpdateUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[Comment] [nvarchar](500) NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
	[SignOffID] [int] NULL,
 CONSTRAINT [PK_PartnerOrganisationRiskMitigationActionUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_RagOptions]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_PartnerOrganisationRiskMitigationActions] FOREIGN KEY([PartnerOrganisationRiskMitigationActionID])
REFERENCES [dbo].[PartnerOrganisationRiskMitigationActions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_PartnerOrganisationRiskMitigationActions]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_SignOffs]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_Users]
GO

-- Partner org risk types

CREATE TABLE [dbo].[PartnerOrganisationRiskRiskTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[PartnerOrganisationRiskID] [int] NOT NULL,
	[RiskTypeID] [int] NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PK_PartnerOrganisationRiskRiskTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[PartnerOrganisationRiskRiskTypes] )
)
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes] ADD  CONSTRAINT [DF_PartnerOrganisationRiskRiskTypes_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes] ADD  CONSTRAINT [DF_PartnerOrganisationRiskRiskTypes_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_PartnerOrganisationRisks] FOREIGN KEY([PartnerOrganisationRiskID])
REFERENCES [dbo].[PartnerOrganisationRisks] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes] CHECK CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_PartnerOrganisationRisks]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_RiskTypes] FOREIGN KEY([RiskTypeID])
REFERENCES [dbo].[RiskTypes] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes] CHECK CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_RiskTypes]
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_Users] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes] CHECK CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_Users]
GO

-- Partner org risk contributors

ALTER TABLE [dbo].[Contributors] ADD [PartnerOrganisationRiskID] [int] NULL, [PartnerOrganisationRiskMitigationActionID] [int] NULL;
GO 

ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_PartnerOrganisationRisks] FOREIGN KEY([PartnerOrganisationRiskID])
REFERENCES [dbo].[PartnerOrganisationRisks] ([ID])
GO

ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_PartnerOrganisationRisks]
GO

ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_PartnerOrganisationRiskMitigationActions] FOREIGN KEY([PartnerOrganisationRiskMitigationActionID])
REFERENCES [dbo].[PartnerOrganisationRiskMitigationActions] ([ID])
GO

ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_PartnerOrganisationRiskMitigationActions]
GO

CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_PartnerOrganisationRiskContributors
ON Contributors(ContributorUserID,PartnerOrganisationRiskID)
WHERE PartnerOrganisationRiskID IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_PartnerOrganisationRiskMitigationActionContributors
ON Contributors(ContributorUserID,PartnerOrganisationRiskMitigationActionID)
WHERE PartnerOrganisationRiskMitigationActionID IS NOT NULL;

--

-- Fix character limits on partner org updates

ALTER TABLE [dbo].[PartnerOrganisationUpdates] ALTER COLUMN [FutureActions] NVARCHAR(1000) NULL;
ALTER TABLE [dbo].[PartnerOrganisationUpdates] ALTER COLUMN [Escalations] NVARCHAR(1000) NULL;
ALTER TABLE [dbo].[PartnerOrganisationUpdates] ALTER COLUMN [ProgressUpdate] NVARCHAR(1000) NULL;
GO

--