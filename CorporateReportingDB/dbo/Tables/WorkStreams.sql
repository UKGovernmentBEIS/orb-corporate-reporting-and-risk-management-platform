CREATE TABLE [dbo].[WorkStreams]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[WorkStreamCode] NVARCHAR(255) NULL,
	[ProjectID] INT NOT NULL,
	[LeadUserID] INT NULL,
	[RagOptionID] INT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[Description] NVARCHAR(500) NULL,
	CONSTRAINT [PK_WorkStreams] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[WorkStreams] )
)
GO
ALTER TABLE [dbo].[WorkStreams]  ADD  CONSTRAINT [FK_WorkStreams_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO

ALTER TABLE [dbo].[WorkStreams] CHECK CONSTRAINT [FK_WorkStreams_EntityStatuses]
GO
ALTER TABLE [dbo].[WorkStreams]  ADD  CONSTRAINT [FK_WorkStreams_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[WorkStreams] CHECK CONSTRAINT [FK_WorkStreams_ModifiedByUsers]
GO
ALTER TABLE [dbo].[WorkStreams]  ADD  CONSTRAINT [FK_WorkStreams_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO

ALTER TABLE [dbo].[WorkStreams] CHECK CONSTRAINT [FK_WorkStreams_Projects]
GO
ALTER TABLE [dbo].[WorkStreams]  ADD  CONSTRAINT [FK_WorkStreams_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[WorkStreams] CHECK CONSTRAINT [FK_WorkStreams_RagOptions]
GO
ALTER TABLE [dbo].[WorkStreams]  ADD  CONSTRAINT [FK_WorkStreams_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[WorkStreams] CHECK CONSTRAINT [FK_WorkStreams_Users]
GO
ALTER TABLE [dbo].[WorkStreams] ADD  CONSTRAINT [DF_WorkStreams_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[WorkStreams] ADD  CONSTRAINT [DF_WorkStreams_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]