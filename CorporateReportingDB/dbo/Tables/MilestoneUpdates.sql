CREATE TABLE [dbo].[MilestoneUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[MilestoneID] INT NOT NULL,
	[UpdateDate] DATETIME2(7) NULL,
	[RagOptionID] INT NULL,
	[Comment] NVARCHAR(500) NULL,
	[ForecastDate] DATETIME2(7) NULL,
	[ActualDate] DATETIME2(7) NULL,
	[UpdateUserID] INT NULL,
	[SignOffID] INT NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	CONSTRAINT [PK_MilestoneUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MilestoneUpdates]  ADD  CONSTRAINT [FK_MilestoneUpdates_Milestones] FOREIGN KEY([MilestoneID])
REFERENCES [dbo].[Milestones] ([ID])
GO
ALTER TABLE [dbo].[MilestoneUpdates] CHECK CONSTRAINT [FK_MilestoneUpdates_Milestones]
GO

ALTER TABLE [dbo].[MilestoneUpdates]  ADD  CONSTRAINT [FK_MilestoneUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[MilestoneUpdates] CHECK CONSTRAINT [FK_MilestoneUpdates_RagOptions]
GO

ALTER TABLE [dbo].[MilestoneUpdates]  ADD  CONSTRAINT [FK_MilestoneUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[MilestoneUpdates] CHECK CONSTRAINT [FK_MilestoneUpdates_SignOffs]
GO

ALTER TABLE [dbo].[MilestoneUpdates]  ADD  CONSTRAINT [FK_MilestoneUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[MilestoneUpdates] CHECK CONSTRAINT [FK_MilestoneUpdates_Users]
GO