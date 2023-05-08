CREATE TABLE [dbo].[Directorates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[GroupID] INT NOT NULL,
	[DirectorUserID] INT NULL,
	[Objectives] NVARCHAR(MAX) NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[ReportApproverUserID] INT NULL,
	[ReportingLeadUserID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[Description] NVARCHAR(500) NULL,
	CONSTRAINT [PK_Directorates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Directorates] )
)
GO
ALTER TABLE [dbo].[Directorates]  ADD  CONSTRAINT [FK_Directorates_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO

ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_EntityStatuses]
GO
ALTER TABLE [dbo].[Directorates]  ADD  CONSTRAINT [FK_Directorates_Groups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([ID])
GO

ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_Groups]
GO
ALTER TABLE [dbo].[Directorates]  ADD  CONSTRAINT [FK_Directorates_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Directorates]  ADD  CONSTRAINT [FK_Directorates_ReportApproverUsers] FOREIGN KEY([ReportApproverUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_ReportApproverUsers]
GO
ALTER TABLE [dbo].[Directorates]  ADD  CONSTRAINT [FK_Directorates_Users] FOREIGN KEY([DirectorUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_Users]
GO
ALTER TABLE [dbo].[Directorates] ADD  CONSTRAINT [DF_Directorates_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Directorates] ADD  CONSTRAINT [DF_Directorates_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO

ALTER TABLE [dbo].[Directorates]  ADD  CONSTRAINT [FK_Directorates_ReportingLeadUsers] FOREIGN KEY([ReportingLeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_ReportingLeadUsers]
GO