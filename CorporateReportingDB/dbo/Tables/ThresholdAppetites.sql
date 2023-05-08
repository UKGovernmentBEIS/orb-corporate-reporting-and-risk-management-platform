CREATE TABLE [dbo].[ThresholdAppetites]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[ThresholdID] INT NOT NULL, 
	[RiskImpactLevelID] INT NOT NULL, 
	[RiskProbabilityID] INT NOT NULL,
	[Acceptable] BIT NOT NULL,
	CONSTRAINT [PK_ThresholdAppetites] PRIMARY KEY CLUSTERED ([ID])
)
GO

ALTER TABLE [dbo].[ThresholdAppetites]  ADD  CONSTRAINT [FK_ThresholdAppetites_Thresholds] FOREIGN KEY([ThresholdID])
REFERENCES [dbo].[Thresholds] ([ID])
GO
ALTER TABLE [dbo].[ThresholdAppetites] CHECK CONSTRAINT [FK_ThresholdAppetites_Thresholds]
GO

ALTER TABLE [dbo].[ThresholdAppetites]  ADD  CONSTRAINT [FK_ThresholdAppetites_RiskImpactLevels] FOREIGN KEY([RiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[ThresholdAppetites] CHECK CONSTRAINT [FK_ThresholdAppetites_RiskImpactLevels]
GO

ALTER TABLE [dbo].[ThresholdAppetites]  ADD  CONSTRAINT [FK_ThresholdAppetites_RiskProbabilities] FOREIGN KEY([RiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[ThresholdAppetites] CHECK CONSTRAINT [FK_ThresholdAppetites_RiskProbabilities]
GO
