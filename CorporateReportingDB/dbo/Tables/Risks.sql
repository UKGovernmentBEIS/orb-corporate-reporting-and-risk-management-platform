CREATE TABLE [dbo].[Risks]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[RiskCode] NVARCHAR(50) NULL,
	[DirectorateID] INT NULL,
	[EntityStatusID] INT NULL,
	[RiskOwnerUserID] INT NULL,
	[RagOptionID] INT NULL,
	[RiskRegisterID] INT NULL,
	[RiskEventDescription] NVARCHAR(750) NULL,
	[RiskCauseDescription] NVARCHAR(750) NULL,
	[RiskImpactDescription] NVARCHAR(750) NULL,
	[UnmitigatedRiskProbabilityID] INT NULL,
	[UnmitigatedRiskImpactLevelID] INT NULL,
	[TargetRiskProbabilityID] INT NULL,
	[TargetRiskImpactLevelID] INT NULL,
	[RiskAppetiteID] INT NULL,
	[DepartmentalObjectiveID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[IsProjectRisk] BIT NULL,
	[ProjectID] INT NULL,
	[RiskProximity] DATE NULL,
	[RiskIsOngoing] BIT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingStartMonth] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[LinkedRiskID] INT NULL,
	[ReportApproverUserID] INT NULL,
	[CreatedDate] DATETIME2(0) NULL DEFAULT GETUTCDATE(),
	[RiskRegisteredDate] DATETIME2(0) NULL,
	[StaffNonStaffSpend] NVARCHAR(50) NULL,
	[Discriminator] NVARCHAR(MAX) NOT NULL DEFAULT N'CorporateRisk',
	[FundingClassification] NVARCHAR(MAX) NULL,
	[EconomicRingfence] NVARCHAR(MAX) NULL,
	[PolicyRingfence] NVARCHAR(MAX) NULL,
	[UniformChartOfAccountsID] NVARCHAR(MAX) NULL,
	[GroupID] INT NULL,
	[OwnedByDgOffice] BIT NULL,
	[OwnedByMultipleGroups] BIT NULL,
	[Description] NVARCHAR(500) NULL,
	CONSTRAINT [PK_Risks] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Risks] )
)
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_DepartmentalObjectives] FOREIGN KEY([DepartmentalObjectiveID])
REFERENCES [dbo].[DepartmentalObjectives] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_DepartmentalObjectives]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_Directorates]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_EntityStatuses]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_ModifiedByUsers]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_Projects]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_RagOptions]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_RiskAppetites] FOREIGN KEY([RiskAppetiteID])
REFERENCES [dbo].[RiskAppetites] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_RiskAppetites]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_RiskRegisters] FOREIGN KEY([RiskRegisterID])
REFERENCES [dbo].[RiskRegisters] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_RiskRegisters]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_TargetRiskImpactLevels] FOREIGN KEY([TargetRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_TargetRiskImpactLevels]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_TargetRiskProbabilities] FOREIGN KEY([TargetRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_TargetRiskProbabilities]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_UnmitigatedRiskImpactLevels] FOREIGN KEY([UnmitigatedRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_UnmitigatedRiskImpactLevels]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_UnmitigatedRiskProbabilities] FOREIGN KEY([UnmitigatedRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_UnmitigatedRiskProbabilities]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_ReportApproverUsers] FOREIGN KEY([ReportApproverUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_ReportApproverUsers]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_Users] FOREIGN KEY([RiskOwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_Users]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_Risks] FOREIGN KEY([LinkedRiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_Risks]
GO

ALTER TABLE [dbo].[Risks] ADD  CONSTRAINT [DF_Risks_SysStart]  DEFAULT (CONVERT(DATETIME2(0),'2018-01-01 00:00:00')) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Risks] ADD  CONSTRAINT [DF_Risks_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO

ALTER TABLE [dbo].[Risks]  ADD  CONSTRAINT [FK_Risks_Groups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_Groups]
GO