CREATE TABLE [dbo].[RiskRiskMitigationActions]
(
  [ID] INT IDENTITY(1,1) NOT NULL,
  [Title] NVARCHAR(255) NULL,
  [RiskID] INT NOT NULL,
  [RiskMitigationActionID] INT NOT NULL,
  [SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
  [SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
  [ModifiedByUserID] INT NULL,
  [Discriminator] NVARCHAR(MAX) NOT NULL DEFAULT N'CorporateRiskRiskMitigationAction',
  CONSTRAINT [PK_RiskRiskMitigationActions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
  PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[RiskRiskMitigationActions] )
)
GO

ALTER TABLE [dbo].[RiskRiskMitigationActions] ADD CONSTRAINT [FK_RiskRiskMitigationActions_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions] CHECK CONSTRAINT [FK_RiskRiskMitigationActions_Risks]
GO

ALTER TABLE [dbo].[RiskRiskMitigationActions] ADD CONSTRAINT [FK_RiskRiskMitigationActions_RiskMitigationActions] FOREIGN KEY([RiskMitigationActionID])
REFERENCES [dbo].[RiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions] CHECK CONSTRAINT [FK_RiskRiskMitigationActions_RiskMitigationActions]
GO

ALTER TABLE [dbo].[RiskRiskMitigationActions] ADD CONSTRAINT [FK_RiskRiskMitigationActions_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions] CHECK CONSTRAINT [FK_RiskRiskMitigationActions_ModifiedByUsers]
GO

ALTER TABLE [dbo].[RiskRiskMitigationActions] ADD CONSTRAINT [DF_RiskRiskMitigationActions_SysStart] DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions] ADD CONSTRAINT [DF_RiskRiskMitigationActions_SysEnd] DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO