CREATE TABLE [dbo].[DirectorateUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[Comment] NVARCHAR(50) NULL,
	[RagOptionID] INT NULL,
	[DirectorateID] INT NULL,
	[UpdateDate] DATETIME2(7) NULL,
	[OverallRagOptionID] INT NULL,
	[FinanceRagOptionID] INT NULL,
	[FinanceComment] NVARCHAR(500) NULL,
	[PeopleRagOptionID] INT NULL,
	[PeopleComment] NVARCHAR(500) NULL,
	[MilestonesRagOptionID] INT NULL,
	[MilestonesComment] NVARCHAR(500) NULL,
	[MetricsRagOptionID] INT NULL,
	[MetricsComment] NVARCHAR(500) NULL,
	[ProgressUpdate] NVARCHAR(500) NULL,
	[FutureActions] NVARCHAR(500) NULL,
	[Escalations] NVARCHAR(500) NULL,
	[UpdateUserID] INT NULL,
	[SignOffID] INT NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	CONSTRAINT [PK_DirectorateUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  ADD  CONSTRAINT [FK_DirectorateUpdates_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO

ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_Directorates]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  ADD  CONSTRAINT [FK_DirectorateUpdates_RagOptionFinance] FOREIGN KEY([FinanceRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_RagOptionFinance]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  ADD  CONSTRAINT [FK_DirectorateUpdates_RagOptionMetric] FOREIGN KEY([MetricsRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_RagOptionMetric]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  ADD  CONSTRAINT [FK_DirectorateUpdates_RagOptionMilestone] FOREIGN KEY([MilestonesRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_RagOptionMilestone]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  ADD  CONSTRAINT [FK_DirectorateUpdates_RagOptionOverall] FOREIGN KEY([OverallRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_RagOptionOverall]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  ADD  CONSTRAINT [FK_DirectorateUpdates_RagOptionPeople] FOREIGN KEY([PeopleRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_RagOptionPeople]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  ADD  CONSTRAINT [FK_DirectorateUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO

ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_SignOffs]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  ADD  CONSTRAINT [FK_DirectorateUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_Users]