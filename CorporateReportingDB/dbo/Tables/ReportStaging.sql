CREATE TABLE [dbo].[ReportStaging]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[ProjectID] INT NOT NULL,
	[ReportJson] NVARCHAR(MAX) NOT NULL,
	[SubmittedByUserID] INT NOT NULL,
	[SubmittedDate] DATETIME2(7) NOT NULL,
	CONSTRAINT [PK_ReportStaging] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ReportStaging]  ADD  CONSTRAINT [FK_ReportStaging_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO

ALTER TABLE [dbo].[ReportStaging] CHECK CONSTRAINT [FK_ReportStaging_Projects]
GO

ALTER TABLE [dbo].[ReportStaging]  ADD  CONSTRAINT [FK_ReportStaging_Users] FOREIGN KEY([SubmittedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[ReportStaging] CHECK CONSTRAINT [FK_ReportStaging_Users]
GO