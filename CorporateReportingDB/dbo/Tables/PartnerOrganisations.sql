CREATE TABLE [dbo].[PartnerOrganisations]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[DirectorateID] INT NULL,
	[LeadPolicySponsorUserID] INT NULL,
	[ReportAuthorUserID] INT NULL,
	[Objectives] NVARCHAR(MAX) NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingStartMonth] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[ModifiedByUserID] INT NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[CreatedDate] DATETIME2(0) NULL DEFAULT GETUTCDATE(),
	[Description] NVARCHAR(500) NULL,
	CONSTRAINT [PK_PartnerOrganisations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[PartnerOrganisations] )
)
GO
ALTER TABLE [dbo].[PartnerOrganisations] ADD CONSTRAINT [FK_PartnerOrganisations_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_Directorates]
GO

ALTER TABLE [dbo].[PartnerOrganisations] ADD CONSTRAINT [FK_PartnerOrganisations_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_EntityStatuses]
GO

ALTER TABLE [dbo].[PartnerOrganisations] ADD CONSTRAINT [FK_PartnerOrganisations_LeadPolicySponsorUsers] FOREIGN KEY([LeadPolicySponsorUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_LeadPolicySponsorUsers]
GO

ALTER TABLE [dbo].[PartnerOrganisations] ADD CONSTRAINT [FK_PartnerOrganisations_ReportAuthorUsers] FOREIGN KEY([ReportAuthorUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_ReportAuthorUsers]
GO

ALTER TABLE [dbo].[PartnerOrganisations] ADD CONSTRAINT [FK_PartnerOrganisations_Users] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_Users]
GO

ALTER TABLE [dbo].[PartnerOrganisations] ADD CONSTRAINT [DF_SysStart] DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[PartnerOrganisations] ADD CONSTRAINT [DF_SysEnd] DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]