CREATE TABLE [dbo].[KeyWorkAreaUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[KeyWorkAreaID] INT NOT NULL,
	[UpdateDate] DATETIME2(7) NOT NULL,
	[RagOptionID] INT NULL,
	[Comment] NVARCHAR(500) NULL,
	[UpdateUserID] INT NULL,
	[SignOffID] INT NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	CONSTRAINT [PK_KeyWorkAreaUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates]  ADD  CONSTRAINT [FK_KeyWorkAreaUpdates_KeyWorkAreas] FOREIGN KEY([KeyWorkAreaID])
REFERENCES [dbo].[KeyWorkAreas] ([ID])
GO

ALTER TABLE [dbo].[KeyWorkAreaUpdates] CHECK CONSTRAINT [FK_KeyWorkAreaUpdates_KeyWorkAreas]
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates]  ADD  CONSTRAINT [FK_KeyWorkAreaUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[KeyWorkAreaUpdates] CHECK CONSTRAINT [FK_KeyWorkAreaUpdates_RagOptions]
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates]  ADD  CONSTRAINT [FK_KeyWorkAreaUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO

ALTER TABLE [dbo].[KeyWorkAreaUpdates] CHECK CONSTRAINT [FK_KeyWorkAreaUpdates_SignOffs]
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates]  ADD  CONSTRAINT [FK_KeyWorkAreaUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[KeyWorkAreaUpdates] CHECK CONSTRAINT [FK_KeyWorkAreaUpdates_Users]