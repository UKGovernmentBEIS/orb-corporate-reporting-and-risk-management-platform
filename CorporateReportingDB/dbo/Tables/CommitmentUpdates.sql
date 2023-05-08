CREATE TABLE [dbo].[CommitmentUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[CommitmentID] INT NOT NULL,
	[UpdateDate] DATETIME2(7) NULL,
	[UpdateUserID] INT NULL,
	[RagOptionID] INT NULL,
	[Comment] NVARCHAR(500) NULL,
	[ForecastDate] DATE NULL,
	[ActualDate] DATE NULL,
	[SignOffID] INT NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	CONSTRAINT [PK_DependencyUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CommitmentUpdates]  ADD  CONSTRAINT [FK_CommitmentUpdates_Commitments] FOREIGN KEY([CommitmentID])
REFERENCES [dbo].[Commitments] ([ID])
GO

ALTER TABLE [dbo].[CommitmentUpdates] CHECK CONSTRAINT [FK_CommitmentUpdates_Commitments]
GO
ALTER TABLE [dbo].[CommitmentUpdates]  ADD  CONSTRAINT [FK_CommitmentUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[CommitmentUpdates] CHECK CONSTRAINT [FK_CommitmentUpdates_RagOptions]
GO
ALTER TABLE [dbo].[CommitmentUpdates]  ADD  CONSTRAINT [FK_CommitmentUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO

ALTER TABLE [dbo].[CommitmentUpdates] CHECK CONSTRAINT [FK_CommitmentUpdates_SignOffs]
GO
ALTER TABLE [dbo].[CommitmentUpdates]  ADD  CONSTRAINT [FK_CommitmentUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[CommitmentUpdates] CHECK CONSTRAINT [FK_CommitmentUpdates_Users]