CREATE TABLE [dbo].[PartnerOrganisationUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[Comment] NVARCHAR(50) NULL,
	[RagOptionID] INT NULL,
	[PartnerOrganisationID] INT NULL,
	[UpdateDate] DATETIME2(7) NULL,
	[OverallRagOptionID] INT NULL,
	[FinanceRagOptionID] INT NULL,
	[FinanceComment] NVARCHAR(500) NULL,
	[PeopleRagOptionID] INT NULL,
	[PeopleComment] NVARCHAR(500) NULL,
	[MilestonesRagOptionID] INT NULL,
	[MilestonesComment] NVARCHAR(500) NULL,
	[KPIRagOptionID] INT NULL,
	[KPIComment] NVARCHAR(500) NULL,
	[ProgressUpdate] NVARCHAR(1000) NULL,
	[FutureActions] NVARCHAR(1000) NULL,
	[Escalations] NVARCHAR(1000) NULL,
	[UpdateUserID] INT NULL,
	[SignOffID] INT NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	CONSTRAINT [PK_PartnerOrganisationUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_PartnerOrganisations]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionFinance] FOREIGN KEY([FinanceRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionFinance]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionKPI] FOREIGN KEY([KPIRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionKPI]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionMilestone] FOREIGN KEY([MilestonesRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionMilestone]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionOverall] FOREIGN KEY([OverallRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionOverall]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionPeople] FOREIGN KEY([PeopleRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionPeople]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_SignOffs]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_Users]