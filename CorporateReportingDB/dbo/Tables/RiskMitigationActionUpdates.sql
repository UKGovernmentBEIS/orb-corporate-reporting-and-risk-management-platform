CREATE TABLE [dbo].[RiskMitigationActionUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(500) NULL,
	[RiskMitigationActionID] INT NULL,
	[UpdateDate] DATETIME2(7) NULL,
	[UpdateUserID] INT NULL,
	[RagOptionID] INT NULL,
	[Comment] NVARCHAR(1000) NULL,
	[ForecastDate] DATE NULL,
	[ActualDate] DATE NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	[RiskUpdateID] INT NULL,
	[SignOffID] INT NULL,
	[Discriminator] NVARCHAR(MAX) NOT NULL DEFAULT N'CorporateRiskMitigationActionUpdate',
	CONSTRAINT [PK_RiskMitigationActionUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RiskMitigationActionUpdates] ADD CONSTRAINT [FK_RiskMitigationActionUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates] CHECK CONSTRAINT [FK_RiskMitigationActionUpdates_RagOptions]
GO

ALTER TABLE [dbo].[RiskMitigationActionUpdates] ADD CONSTRAINT [FK_RiskMitigationActionUpdates_RiskMitigationActions] FOREIGN KEY([RiskMitigationActionID])
REFERENCES [dbo].[RiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates] CHECK CONSTRAINT [FK_RiskMitigationActionUpdates_RiskMitigationActions]
GO

ALTER TABLE [dbo].[RiskMitigationActionUpdates] ADD CONSTRAINT [FK_RiskMitigationActionUpdates_RiskUpdates] FOREIGN KEY([RiskUpdateID])
REFERENCES [dbo].[RiskUpdates] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates] CHECK CONSTRAINT [FK_RiskMitigationActionUpdates_RiskUpdates]
GO

ALTER TABLE [dbo].[RiskMitigationActionUpdates] ADD CONSTRAINT [FK_RiskMitigationActionUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates] CHECK CONSTRAINT [FK_RiskMitigationActionUpdates_SignOffs]
GO

ALTER TABLE [dbo].[RiskMitigationActionUpdates] ADD CONSTRAINT [FK_RiskMitigationActionUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates] CHECK CONSTRAINT [FK_RiskMitigationActionUpdates_Users]
GO