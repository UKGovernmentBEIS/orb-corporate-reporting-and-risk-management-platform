--CARP-194
ALTER TABLE [dbo].[BenefitUpdates] ALTER COLUMN [Comment] nvarchar(400) --Was MAX
ALTER TABLE [dbo].[CommitmentUpdates] ALTER COLUMN [Comment] nvarchar(400) --Was 200
ALTER TABLE [dbo].[DependencyUpdates] ALTER COLUMN [Comment] nvarchar(400) --Was 300
ALTER TABLE [dbo].[DirectorateUpdates] ALTER COLUMN [ProgressUpdate] nvarchar(400) --Was 300
ALTER TABLE [dbo].[DirectorateUpdates] ALTER COLUMN [FutureActions] nvarchar(300) --Was 200
ALTER TABLE [dbo].[DirectorateUpdates] ALTER COLUMN [Escalations] nvarchar(200) --Was 100
ALTER TABLE [dbo].[DirectorateUpdates] ALTER COLUMN [FinanceComment] nvarchar(250) --Was 200
ALTER TABLE [dbo].[DirectorateUpdates] ALTER COLUMN [PeopleComment] nvarchar(250) --Was 200
ALTER TABLE [dbo].[DirectorateUpdates] ALTER COLUMN [MilestonesComment] nvarchar(250) --Was 200
ALTER TABLE [dbo].[DirectorateUpdates] ALTER COLUMN [MetricsComment] nvarchar(250) --Was 200
--No change ALTER TABLE [dbo].[KeyWorkAreaUpdates] ALTER COLUMN [Comment] nvarchar(500) --Was 500
ALTER TABLE [dbo].[MetricUpdates] ALTER COLUMN [Comment] nvarchar(400) --Was 500
ALTER TABLE [dbo].[MilestoneUpdates] ALTER COLUMN [Comment] nvarchar(400) --Was 255
ALTER TABLE [dbo].[ProjectUpdates] ALTER COLUMN [ProgressUpdate] nvarchar(400) --Was 300
ALTER TABLE [dbo].[ProjectUpdates] ALTER COLUMN [FutureActions] nvarchar(300) --Was 200
ALTER TABLE [dbo].[ProjectUpdates] ALTER COLUMN [Escalations] nvarchar(200) --Was 100
ALTER TABLE [dbo].[ProjectUpdates] ALTER COLUMN [FinanceComment] nvarchar(250) --Was 200
ALTER TABLE [dbo].[ProjectUpdates] ALTER COLUMN [PeopleComment] nvarchar(250) --Was 200
ALTER TABLE [dbo].[ProjectUpdates] ALTER COLUMN [MilestonesComment] nvarchar(250) --Was 200
ALTER TABLE [dbo].[ProjectUpdates] ALTER COLUMN [BenefitsComment] nvarchar(250) --Was 200
--No change ALTER TABLE [dbo].[WorkStreamUpdates] ALTER COLUMN [Comment] nvarchar(500) --Was 500