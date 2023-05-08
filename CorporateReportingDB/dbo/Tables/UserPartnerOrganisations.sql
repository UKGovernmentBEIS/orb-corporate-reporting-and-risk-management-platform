﻿CREATE TABLE [dbo].[UserPartnerOrganisations]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[UserID] INT NOT NULL,
	[PartnerOrganisationID] INT NOT NULL,
	[IsAdmin] BIT NOT NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[HideHeadlines] BIT NULL,
	[HideMilestones] BIT NULL,
	[HideCustomSections] BIT NULL,
	CONSTRAINT [PK_UserPartnerOrganisations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT [UQ_UserPartnerOrganisations] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[PartnerOrganisationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[UserPartnerOrganisations] )
)
GO

ALTER TABLE [dbo].[UserPartnerOrganisations] ADD CONSTRAINT [FK_UserPartnerOrganisations_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserPartnerOrganisations] CHECK CONSTRAINT [FK_UserPartnerOrganisations_ModifiedByUsers]
GO

ALTER TABLE [dbo].[UserPartnerOrganisations] ADD CONSTRAINT [FK_UserPartnerOrganisations_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[UserPartnerOrganisations] CHECK CONSTRAINT [FK_UserPartnerOrganisations_PartnerOrganisations]
GO

ALTER TABLE [dbo].[UserPartnerOrganisations] ADD CONSTRAINT [FK_UserPartnerOrganisations_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserPartnerOrganisations] CHECK CONSTRAINT [FK_UserPartnerOrganisations_Users]
GO

ALTER TABLE [dbo].[UserPartnerOrganisations] ADD CONSTRAINT [DF_UserPartnerOrganisations_IsAdmin] DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[UserPartnerOrganisations] ADD CONSTRAINT [DF_UserPartnerOrganisations_SysStart] DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[UserPartnerOrganisations] ADD CONSTRAINT [DF_UserPartnerOrganisations_SysEnd] DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO