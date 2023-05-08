CREATE TABLE [History].[RiskRiskMitigationActions]
(
  [ID] INT NOT NULL,
  [Title] NVARCHAR(255) NULL,
  [RiskID] INT NOT NULL,
  [RiskMitigationActionID] INT NOT NULL,
  [SysStartTime] DATETIME2(0) NOT NULL,
  [SysEndTime] DATETIME2(0) NOT NULL,
  [ModifiedByUserID] INT NULL,
  [Discriminator] NVARCHAR(MAX) NOT NULL
) ON [PRIMARY]