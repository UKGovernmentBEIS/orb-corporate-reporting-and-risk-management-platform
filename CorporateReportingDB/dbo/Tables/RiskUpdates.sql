CREATE TABLE [dbo].[RiskUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[Comment] NVARCHAR(500) NULL,
	[RagOptionID] INT NULL,
	[RiskID] INT NULL,
	[UpdateUserID] INT NULL,
	[UpdateDate] DATETIME2(7) NULL,
	[RiskProbabilityID] INT NULL,
	[RiskImpactLevelID] INT NULL,
	[Escalate] BIT NULL,
	[EscalateToRiskRegisterID] INT NULL,
	[DeEscalate] BIT NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	[RiskMitigationActionUpdates] NVARCHAR(MAX) NULL,
	[IsCurrent] BIT NULL,
	[SendNotifications] BIT NULL,
	[RiskRegisterID] INT NULL,
	[RiskProximity] DATE NULL,
	[RiskCode] NVARCHAR(50) NULL,
	[RiskIsOngoing] BIT NULL,
	[SignOffID] INT NULL,
	[RiskAppetiteBreachAuthorised] BIT NULL,
	[Narrative] NVARCHAR(1000) NULL,
	[ClosureReason] NVARCHAR(50) NULL,
	[Attachments] NVARCHAR(MAX) NULL,
	[Measurements] NVARCHAR(MAX) NULL,
	[Discriminator] NVARCHAR(MAX) NOT NULL DEFAULT N'CorporateRiskUpdate',
	[ToBeDiscussed] BIT NULL,
	[DiscussionForum] NVARCHAR(MAX) NULL,
	CONSTRAINT [PK_RiskUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[RiskUpdates] ADD CONSTRAINT [FK_RiskUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_RagOptions]
GO

ALTER TABLE [dbo].[RiskUpdates] ADD CONSTRAINT [FK_RiskUpdates_RiskImpactLevels] FOREIGN KEY([RiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_RiskImpactLevels]
GO

ALTER TABLE [dbo].[RiskUpdates] ADD CONSTRAINT [FK_RiskUpdates_RiskProbabilities] FOREIGN KEY([RiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_RiskProbabilities]
GO

ALTER TABLE [dbo].[RiskUpdates] ADD CONSTRAINT [FK_RiskUpdates_EscalateToRiskRegisters] FOREIGN KEY([EscalateToRiskRegisterID])
REFERENCES [dbo].[RiskRegisters] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_EscalateToRiskRegisters]
GO

ALTER TABLE [dbo].[RiskUpdates] ADD CONSTRAINT [FK_RiskUpdates_RiskRegisters] FOREIGN KEY([RiskRegisterID])
REFERENCES [dbo].[RiskRegisters] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_RiskRegisters]
GO

ALTER TABLE [dbo].[RiskUpdates] ADD CONSTRAINT [FK_RiskUpdates_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_Risks]
GO

ALTER TABLE [dbo].[RiskUpdates] ADD CONSTRAINT [FK_RiskUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_SignOffs]
GO

ALTER TABLE [dbo].[RiskUpdates] ADD CONSTRAINT [FK_RiskUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_Users]
GO