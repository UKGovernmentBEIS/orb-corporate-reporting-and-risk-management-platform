CREATE TABLE [dbo].[DependencyUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[DependencyID] INT NOT NULL,
	[UpdateDate] DATETIME2(7) NULL,
	[UpdateUserID] INT NULL,
	[RagOptionID] INT NULL,
	[Comment] NVARCHAR(500) NULL,
	[SignOffID] INT NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	[ForecastDate] DATETIME2(7) NULL,
	[ActualDate] DATETIME2(7) NULL,
	CONSTRAINT [PK_DependencyUpdates_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DependencyUpdates] ADD CONSTRAINT [FK_DependencyUpdates_Dependencies] FOREIGN KEY([DependencyID])
REFERENCES [dbo].[Dependencies] ([ID])
GO
ALTER TABLE [dbo].[DependencyUpdates] CHECK CONSTRAINT [FK_DependencyUpdates_Dependencies]
GO

ALTER TABLE [dbo].[DependencyUpdates] ADD CONSTRAINT [FK_DependencyUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[DependencyUpdates] CHECK CONSTRAINT [FK_DependencyUpdates_RagOptions]
GO

ALTER TABLE [dbo].[DependencyUpdates] ADD CONSTRAINT [FK_DependencyUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[DependencyUpdates] CHECK CONSTRAINT [FK_DependencyUpdates_SignOffs]
GO

ALTER TABLE [dbo].[DependencyUpdates] ADD CONSTRAINT [FK_DependencyUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[DependencyUpdates] CHECK CONSTRAINT [FK_DependencyUpdates_Users]
GO