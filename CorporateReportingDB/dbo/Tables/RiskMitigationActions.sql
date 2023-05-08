CREATE TABLE [dbo].[RiskMitigationActions]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[Description] NVARCHAR(750) NULL,
	[RiskID] INT NULL,
	[RiskMitigationActionCode] INT NULL,
	[BaselineDate] DATE NULL,
	[ForecastDate] DATE NULL,
	[ActualDate] DATE NULL,
	[OwnerUserID] INT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[ActionIsOngoing] BIT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[Discriminator] NVARCHAR(MAX) NOT NULL DEFAULT N'CorporateRiskMitigationAction',
	[OngoingActionReviewFrequency] TINYINT NULL,
	[OngoingActionReviewDueDay] TINYINT NULL,
	[OngoingActionReviewStartDate] DATETIME2(0) NULL,
	[LeadUserID] INT NULL,
	CONSTRAINT [PK_RiskMitigatingActions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[RiskMitigationActions] )
)
GO

ALTER TABLE [dbo].[RiskMitigationActions] ADD CONSTRAINT [FK_RiskMitigationActions_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_EntityStatuses]
GO

ALTER TABLE [dbo].[RiskMitigationActions] ADD CONSTRAINT [FK_RiskMitigationActions_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_ModifiedByUsers]
GO

ALTER TABLE [dbo].[RiskMitigationActions] ADD CONSTRAINT [FK_RiskMitigationActions_RiskMitigationActions] FOREIGN KEY([ID])
REFERENCES [dbo].[RiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_RiskMitigationActions]
GO

ALTER TABLE [dbo].[RiskMitigationActions] ADD CONSTRAINT [FK_RiskMitigationActions_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_Risks]
GO

ALTER TABLE [dbo].[RiskMitigationActions] ADD CONSTRAINT [FK_RiskMitigationActions_Users] FOREIGN KEY([OwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_Users]
GO

ALTER TABLE [dbo].[RiskMitigationActions] ADD CONSTRAINT [FK_RiskMitigationActions_LeadUsers] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_LeadUsers]
GO

ALTER TABLE [dbo].[RiskMitigationActions] ADD CONSTRAINT [DF_RiskMitigationActions_SysStart] DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[RiskMitigationActions] ADD CONSTRAINT [DF_RiskMitigationActions_SysEnd] DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO