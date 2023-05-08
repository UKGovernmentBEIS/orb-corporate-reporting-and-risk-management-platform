CREATE TABLE [dbo].[WorkStreamUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[WorkStreamID] INT NOT NULL,
	[UpdateDate] DATETIME2(7) NULL,
	[UpdateUserID] INT NULL,
	[RagOptionID] INT NULL,
	[Comment] NVARCHAR(500) NULL,
	[SignOffID] INT NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	CONSTRAINT [PK_WorkStreamUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WorkStreamUpdates]  ADD  CONSTRAINT [FK_WorkStreamUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[WorkStreamUpdates] CHECK CONSTRAINT [FK_WorkStreamUpdates_RagOptions]
GO
ALTER TABLE [dbo].[WorkStreamUpdates]  ADD  CONSTRAINT [FK_WorkStreamUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO

ALTER TABLE [dbo].[WorkStreamUpdates] CHECK CONSTRAINT [FK_WorkStreamUpdates_SignOffs]
GO
ALTER TABLE [dbo].[WorkStreamUpdates]  ADD  CONSTRAINT [FK_WorkStreamUpdates_UpdateUser] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[WorkStreamUpdates] CHECK CONSTRAINT [FK_WorkStreamUpdates_UpdateUser]
GO
ALTER TABLE [dbo].[WorkStreamUpdates]  ADD  CONSTRAINT [FK_WorkStreamUpdates_WorkStreams] FOREIGN KEY([WorkStreamID])
REFERENCES [dbo].[WorkStreams] ([ID])
GO

ALTER TABLE [dbo].[WorkStreamUpdates] CHECK CONSTRAINT [FK_WorkStreamUpdates_WorkStreams]