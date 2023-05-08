CREATE TABLE [dbo].[SignOffs]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(350) NULL,
	[SignOffDate] DATETIME2(7) NULL,
	[SignOffUserID] INT NULL,
	[ReportMonth] DATE NULL,
	[DirectorateID] INT NULL,
	[ProjectID] INT NULL,
	[SignOffEntities] NVARCHAR(MAX) NULL,
	[IsCurrent] BIT NULL,
	[PartnerOrganisationID] INT NULL,
	[RiskID] INT NULL,
	[ReportJson] NVARCHAR(MAX) NULL,
	CONSTRAINT [PK_SignOffs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SignOffs]  ADD  CONSTRAINT [FK_SignOffs_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO

ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_Directorates]
GO
ALTER TABLE [dbo].[SignOffs]  ADD  CONSTRAINT [FK_SignOffs_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO

ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_PartnerOrganisations]
GO
ALTER TABLE [dbo].[SignOffs]  ADD  CONSTRAINT [FK_SignOffs_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO

ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_Projects]
GO
ALTER TABLE [dbo].[SignOffs]  ADD  CONSTRAINT [FK_SignOffs_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO

ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_Risks]
GO
ALTER TABLE [dbo].[SignOffs]  ADD  CONSTRAINT [FK_SignOffs_Users] FOREIGN KEY([SignOffUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_Users]
GO
ALTER TABLE [dbo].[SignOffs] ADD  CONSTRAINT [DF_SignOffs_IsCurrent]  DEFAULT ((0)) FOR [IsCurrent]
