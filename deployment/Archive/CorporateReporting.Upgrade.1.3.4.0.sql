-- DB Schema Upgrade for v1.3.4.0

ALTER TABLE [dbo].[Directorates] ADD [ReportApproverUserID] [int] NULL;
GO
ALTER TABLE [dbo].[Directorates]  WITH CHECK ADD  CONSTRAINT [FK_Directorates_ReportApproverUsers] FOREIGN KEY([ReportApproverUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Projects] ADD [ReportApproverUserID] [int] NULL;
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_ReportApproverUsers] FOREIGN KEY([ReportApproverUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Risks] ADD [RiskIsOngoing] BIT;
GO
ALTER TABLE [dbo].[RiskMitigationActions] ADD [ActionIsOngoing] BIT;
GO

-- CARP-449 Partner Orgs

CREATE TABLE [dbo].[PartnerOrganisations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[DirectorateID] [int] NOT NULL,
	[LeadPolicySponsorUserID] [int] NULL,
	[ReportAuthorUserID] [int] NULL,
	[Objectives] [nvarchar](MAX) NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ModifiedByUserID] [int] NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
 CONSTRAINT [PK_PartnerOrganisations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[PartnerOrganisations] )
)
GO

ALTER TABLE [dbo].[PartnerOrganisations] ADD  CONSTRAINT [DF_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO

ALTER TABLE [dbo].[PartnerOrganisations] ADD  CONSTRAINT [DF_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO

ALTER TABLE [dbo].[PartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisations_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_Directorates]
GO

ALTER TABLE [dbo].[PartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisations_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_EntityStatuses]
GO

ALTER TABLE [dbo].[PartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisations_LeadPolicySponsorUsers] FOREIGN KEY([LeadPolicySponsorUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_LeadPolicySponsorUsers]
GO

ALTER TABLE [dbo].[PartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisations_ReportAuthorUsers] FOREIGN KEY([ReportAuthorUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_ReportAuthorUsers]
GO

ALTER TABLE [dbo].[PartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisations_Users] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_Users]
GO

--

-- CARP-422 User Partner Orgs

CREATE TABLE [dbo].[UserPartnerOrganisations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UserID] [int] NOT NULL,
	[PartnerOrganisationID] [int] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
 CONSTRAINT [PK_UserPartnerOrganisations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[UserPartnerOrganisations] )
)
GO

ALTER TABLE [dbo].[UserPartnerOrganisations] ADD  CONSTRAINT [DF_UserPartnerOrganisations_IsAdmin]  DEFAULT ((0)) FOR [IsAdmin]
GO

ALTER TABLE [dbo].[UserPartnerOrganisations] ADD  CONSTRAINT [DF_UserPartnerOrganisations_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO

ALTER TABLE [dbo].[UserPartnerOrganisations] ADD  CONSTRAINT [DF_UserPartnerOrganisations_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO

ALTER TABLE [dbo].[UserPartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_UserPartnerOrganisations_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO

ALTER TABLE [dbo].[UserPartnerOrganisations] CHECK CONSTRAINT [FK_UserPartnerOrganisations_PartnerOrganisations]
GO

ALTER TABLE [dbo].[UserPartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_UserPartnerOrganisations_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[UserPartnerOrganisations] CHECK CONSTRAINT [FK_UserPartnerOrganisations_ModifiedByUsers]
GO

ALTER TABLE [dbo].[UserPartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_UserPartnerOrganisations_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[UserPartnerOrganisations] CHECK CONSTRAINT [FK_UserPartnerOrganisations_Users]
GO

ALTER TABLE [dbo].[UserPartnerOrganisations] ADD CONSTRAINT UQ_UserPartnerOrganisations UNIQUE(UserID,PartnerOrganisationID);
GO

--

-- CARP-423 Partner Org Assessments

CREATE TABLE [dbo].[PartnerOrganisationUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Comment] [nvarchar](50) NULL,
	[RagOptionID] [int] NULL,
	[PartnerOrganisationID] [int] NULL,
	[UpdateDate] [datetime2](7) NULL,
	[OverallRagOptionID] [int] NULL,
	[FinanceRagOptionID] [int] NULL,
	[FinanceComment] [nvarchar](250) NULL,
	[PeopleRagOptionID] [int] NULL,
	[PeopleComment] [nvarchar](250) NULL,
	[MilestonesRagOptionID] [int] NULL,
	[MilestonesComment] [nvarchar](250) NULL,
	[KPIRagOptionID] [int] NULL,
	[KPIComment] [nvarchar](250) NULL,
	[ProgressUpdate] [nvarchar](400) NULL,
	[FutureActions] [nvarchar](300) NULL,
	[Escalations] [nvarchar](200) NULL,
	[UpdateUserID] [int] NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
 CONSTRAINT [PK_PartnerOrganisationUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_PartnerOrganisations]
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionFinance] FOREIGN KEY([FinanceRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionFinance]
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionKPI] FOREIGN KEY([KPIRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionKPI]
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionMilestone] FOREIGN KEY([MilestonesRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionMilestone]
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionOverall] FOREIGN KEY([OverallRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionOverall]
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionPeople] FOREIGN KEY([PeopleRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionPeople]
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_SignOffs]
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_Users]
GO

--

-- CARP-507 Partner Org milestones

ALTER TABLE [dbo].[Milestones] ADD [PartnerOrganisationID] INT, [ReportingFrequency] TINYINT, [ReportingStartMonth] TINYINT;
GO

ALTER TABLE [dbo].[Milestones]  WITH CHECK ADD  CONSTRAINT [FK_Milestones_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO

ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_PartnerOrganisations]
GO

SET IDENTITY_INSERT [dbo].[MilestoneTypes] ON
INSERT INTO [dbo].[MilestoneTypes] (ID, Title) VALUES (3, 'Partner organisation')
SET IDENTITY_INSERT [dbo].[MilestoneTypes] OFF

--

-- CARP-528 Partner Org sign-off

ALTER TABLE [dbo].[SignOffs] ADD [PartnerOrganisationID] INT;
GO

ALTER TABLE [dbo].[SignOffs]  WITH CHECK ADD  CONSTRAINT [FK_SignOffs_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO

ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_PartnerOrganisations]
GO

--

-- CARP-489 Risk impact level descriptions

ALTER TABLE [dbo].[RiskImpactLevels] ADD [Description] NVARCHAR(255);
GO

ALTER TABLE [dbo].[RiskImpactLevels] ALTER COLUMN [Title] NVARCHAR(255);
GO

UPDATE [dbo].[RiskImpactLevels] SET [Description] = N'Minimal impact on business plan targets with minor reputational damage to the department' WHERE [ID] = 1
UPDATE [dbo].[RiskImpactLevels] SET [Description] = N'Limited impact on business plan targets with potential media/public awareness' WHERE [ID] = 2
UPDATE [dbo].[RiskImpactLevels] SET [Description] = N'Business plan targets are compromised leading to scrutiny from key stakeholders (e.g. public, media, parliament)' WHERE [ID] = 3
UPDATE [dbo].[RiskImpactLevels] SET [Description] = N'Significant impact to business plan targets resulting in criticism among key stakeholders (e.g. public, media, parliament)' WHERE [ID] = 4
UPDATE [dbo].[RiskImpactLevels] SET [Description] = N'BEIS cannot deliver its objectives culminating in a loss of confidence among key stakeholders (e.g. public, media, parliament)' WHERE [ID] = 5
GO

--

-- CARP-423 Partner org assessments - change char limits

ALTER TABLE [dbo].[PartnerOrganisationUpdates] ALTER COLUMN [ProgressUpdate] NVARCHAR(1000);
ALTER TABLE [dbo].[PartnerOrganisationUpdates] ALTER COLUMN [FutureActions] NVARCHAR(1000);
ALTER TABLE [dbo].[PartnerOrganisationUpdates] ALTER COLUMN [Escalations] NVARCHAR(1000);
GO

--

-- CARP-530 Add risk is ongoing to risk updates

ALTER TABLE [dbo].[RiskUpdates] ADD [RiskIsOngoing] BIT;

--

-- CARP-520 Add status to Groups

ALTER TABLE [dbo].[Groups] ADD [EntityStatusID] INT, [EntityStatusDate] [datetime2](7);
GO

ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO

ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_EntityStatuses]
GO

UPDATE [dbo].[Groups] SET [EntityStatusID] = 1
GO

--

-- CARP-543 Change risk updates to sign off model

---- Convert sign off date to datetime2

ALTER TABLE [dbo].[SignOffs] ALTER COLUMN [SignOffDate] DATETIME2;
GO

---- Add risks to sign off table

ALTER TABLE [dbo].[SignOffs] ADD [RiskID] INT;
GO

ALTER TABLE [dbo].[SignOffs]  WITH CHECK ADD  CONSTRAINT [FK_SignOffs_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO

ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_Risks]
GO

---- Add sign off column to risk updates table

ALTER TABLE [dbo].[RiskUpdates] ADD [SignOffID] INT;

ALTER TABLE [dbo].[RiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO

ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_SignOffs]
GO

---- Add sign off column to risk mitigation action updates table

ALTER TABLE [dbo].[RiskMitigationActionUpdates] ADD [SignOffID] INT;

ALTER TABLE [dbo].[RiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActionUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO

ALTER TABLE [dbo].[RiskMitigationActionUpdates] CHECK CONSTRAINT [FK_RiskMitigationActionUpdates_SignOffs]
GO

---- Copy 'signed off' risk updates to sign offs

INSERT INTO [dbo].[SignOffs] (Title, SignOffDate, SignOffUserID, ReportMonth, SignOffEntities, IsCurrent, RiskID)
SELECT 
	CONCAT(RiskCode, ' - ', Title)
	,UpdateDate
	,UpdateUserID
	,UpdatePeriod
	,CASE RiskMitigationActionUpdates
		WHEN '[]' THEN
			REPLACE(RiskMitigationActionUpdates, '[]', CONCAT('[{"EntityType":"RiskUpdate","EntityID":', ID, '}]'))
		ELSE
			REPLACE(
				REPLACE(
					REPLACE(RiskMitigationActionUpdates,',','},{"EntityType":"RiskMitigationActionUpdate","EntityID":')
					,'['
					,CONCAT('[{"EntityType":"RiskUpdate","EntityID":', ID, '},{"EntityType":"RiskMitigationActionUpdate","EntityID":')
				)
				,']'
				,'}]'
			) END
	,IsCurrent
	,RiskID
FROM [dbo].[RiskUpdates]

UPDATE ru
SET ru.SignOffID = so.ID
FROM [dbo].[RiskUpdates] AS ru
INNER JOIN [dbo].[SignOffs] AS so ON ru.RiskID = so.RiskID AND ru.UpdateDate = so.SignOffDate

UPDATE rmau
SET rmau.SignOffID = so.ID
FROM [dbo].[RiskMitigationActionUpdates] AS rmau
INNER JOIN [dbo].[RiskUpdates] AS ru ON rmau.RiskUpdateID = ru.ID
INNER JOIN [dbo].[SignOffs] AS so ON ru.RiskID = so.RiskID AND ru.UpdateDate = so.SignOffDate

--

-- CARP-451 - Partner org risks

ALTER TABLE [dbo].[Risks] ADD [PartnerOrganisationID] INT;
GO

ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO

ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_PartnerOrganisations]
GO

--
