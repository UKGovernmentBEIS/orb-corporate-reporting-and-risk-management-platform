CREATE TABLE [dbo].[MetricUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[MetricID] INT NOT NULL,
	[UpdateDate] DATETIME2(7) NULL,
	[RagOptionID] INT NULL,
	[Comment] NVARCHAR(500) NULL,
	[CurrentPerformance] DECIMAL(18, 4) NULL,
	[UpdateUserID] INT NULL,
	[SignOffID] INT NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	CONSTRAINT [PK_MetricUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MetricUpdates]  ADD  CONSTRAINT [FK_MetricUpdates_Metrics] FOREIGN KEY([MetricID])
REFERENCES [dbo].[Metrics] ([ID])
GO
ALTER TABLE [dbo].[MetricUpdates] CHECK CONSTRAINT [FK_MetricUpdates_Metrics]
GO

ALTER TABLE [dbo].[MetricUpdates]  ADD  CONSTRAINT [FK_MetricUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[MetricUpdates] CHECK CONSTRAINT [FK_MetricUpdates_RagOptions]
GO

ALTER TABLE [dbo].[MetricUpdates]  ADD  CONSTRAINT [FK_MetricUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[MetricUpdates] CHECK CONSTRAINT [FK_MetricUpdates_SignOffs]
GO

ALTER TABLE [dbo].[MetricUpdates]  ADD  CONSTRAINT [FK_MetricUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[MetricUpdates] CHECK CONSTRAINT [FK_MetricUpdates_Users]
GO