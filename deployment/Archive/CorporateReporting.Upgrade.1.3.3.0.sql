-- DB Schema Upgrade for v1.3.3.0

ALTER TABLE [dbo].[Benefits] ADD [ReportingFrequency] TINYINT, [ReportingStartMonth] TINYINT;
GO

ALTER TABLE [dbo].[Directorates] ADD [ReportApproverUserID] INT;
GO

ALTER TABLE [dbo].[Directorates]  WITH CHECK ADD  CONSTRAINT [FK_Directorates_ReportApproverUsers] FOREIGN KEY([ReportApproverUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_ReportApproverUsers]
GO

ALTER TABLE [dbo].[Projects] ADD [ReportApproverUserID] INT;
GO

ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_ReportApproverUsers] FOREIGN KEY([ReportApproverUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ReportApproverUsers]
GO

ALTER TABLE [dbo].[Metrics] ADD [ReportingFrequency] TINYINT, [ReportingStartMonth] TINYINT;
GO

ALTER TABLE [dbo].[Risks] ADD [IsProjectRisk] BIT, [ProjectID] INT;
GO

ALTER TABLE [dbo].[Risks]  WITH NOCHECK ADD  CONSTRAINT [FK_Risks_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO


BEGIN TRAN

ALTER TABLE [dbo].[UserProjects] SET (SYSTEM_VERSIONING = OFF);
GO

ALTER TABLE [dbo].[UserProjects] ADD [IsRiskAdmin] BIT;
GO

UPDATE [dbo].[UserProjects] SET [IsRiskAdmin] = 'False';
GO

ALTER TABLE [History].[UserProjects] ADD [IsRiskAdmin] BIT;
GO

UPDATE [History].[UserProjects] SET [IsRiskAdmin] = 'False';
GO

ALTER TABLE [dbo].[UserProjects] ALTER COLUMN [IsRiskAdmin] BIT NOT NULL;
GO

ALTER TABLE [History].[UserProjects] ALTER COLUMN [IsRiskAdmin] BIT NOT NULL;
GO

ALTER TABLE [dbo].[UserProjects] SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = [History].[UserProjects]));
COMMIT;
