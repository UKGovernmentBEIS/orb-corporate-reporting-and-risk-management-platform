CREATE TABLE [dbo].[ReportingEntityUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[ReportingEntityID] INT NOT NULL,
	[UpdateDate] DATETIME2(7) NULL,
	[RagOptionID] INT NULL,
	[Comment] NVARCHAR(MAX) NULL,
	[CurrentPerformance] DECIMAL(18, 4) NULL,
	[ForecastDate] DATETIME2(7) NULL,
	[ActualDate] DATETIME2(7) NULL,
	[UpdateUserID] INT NULL,
	[SignOffID] INT NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	CONSTRAINT [PK_ReportingEntityUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ReportingEntityUpdates]  ADD  CONSTRAINT [FK_ReportingEntityUpdates_ReportingEntities] FOREIGN KEY([ReportingEntityID])
REFERENCES [dbo].[ReportingEntities] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityUpdates] CHECK CONSTRAINT [FK_ReportingEntityUpdates_ReportingEntities]
GO

ALTER TABLE [dbo].[ReportingEntityUpdates]  ADD  CONSTRAINT [FK_ReportingEntityUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityUpdates] CHECK CONSTRAINT [FK_ReportingEntityUpdates_RagOptions]
GO

ALTER TABLE [dbo].[ReportingEntityUpdates]  ADD  CONSTRAINT [FK_ReportingEntityUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityUpdates] CHECK CONSTRAINT [FK_ReportingEntityUpdates_SignOffs]
GO

ALTER TABLE [dbo].[ReportingEntityUpdates]  ADD  CONSTRAINT [FK_ReportingEntityUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityUpdates] CHECK CONSTRAINT [FK_ReportingEntityUpdates_Users]
GO