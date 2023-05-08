CREATE TABLE [dbo].[Projects]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[SeniorResponsibleOwnerUserID] INT NULL,
	[ProjectManagerUserID] INT NULL,
	[Objectives] NVARCHAR(MAX) NULL,
	[StartDate] DATETIME NULL,
	[EndDate] DATETIME NULL,
	[DirectorateID] INT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[ReportApproverUserID] INT NULL,
	[ShowOnDirectorateReport] BIT NULL,
	[ParentProjectID] INT NULL,
	[ReportingLeadUserID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[CorporateProjectID] NVARCHAR(MAX) NULL,
	[Description] NVARCHAR(500) NULL,
	[IntegrationID] NVARCHAR(255) NULL,
	[IntegrationLastModified] DATETIME2(7) NULL,
	CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Projects] )
)
GO

ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK_Projects_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_Directorates]
GO

ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK_Projects_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_EntityStatuses]
GO

ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK_Projects_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ModifiedByUsers]
GO

ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK_Projects_ProjectManager] FOREIGN KEY([ProjectManagerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ProjectManager]
GO

ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK_Projects_ReportApproverUsers] FOREIGN KEY([ReportApproverUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ReportApproverUsers]
GO

ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK_Projects_SeniorResponsibleOwner] FOREIGN KEY([SeniorResponsibleOwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_SeniorResponsibleOwner]
GO

ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [DF_Projects_SysStart] DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [DF_Projects_SysEnd] DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [DF_Projects_ShowOnDirectorateReport] DEFAULT ('false') FOR [ShowOnDirectorateReport]
GO
ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK_Projects_ParentProject] FOREIGN KEY([ParentProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO

ALTER TABLE [dbo].[Projects] ADD CONSTRAINT [FK_Projects_ReportingLeadUsers] FOREIGN KEY([ReportingLeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ReportingLeadUsers]
GO