CREATE TABLE [dbo].[Dependencies]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[ProjectID] INT NOT NULL,
	[ThirdParty] NVARCHAR(255) NULL,
	[RagOptionID] INT NULL,
	[LeadUserID] INT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[Description] NVARCHAR(500) NULL,
	[StartDate] DATE NULL,
	[EndDate] DATE NULL,
	[BaselineDate] DATETIME NULL,
	[ForecastDate] DATETIME NULL,
	[ActualDate] DATETIME NULL,
	CONSTRAINT [PK_Dependency] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Dependencies] )
)
GO

ALTER TABLE [dbo].[Dependencies]  ADD  CONSTRAINT [FK_Dependencies_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies_EntityStatuses]
GO

ALTER TABLE [dbo].[Dependencies]  ADD  CONSTRAINT [FK_Dependencies_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies_ModifiedByUsers]
GO

ALTER TABLE [dbo].[Dependencies]  ADD  CONSTRAINT [FK_Dependencies_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies_Projects]
GO

ALTER TABLE [dbo].[Dependencies]  ADD  CONSTRAINT [FK_Dependencies_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies_RagOptions]
GO

ALTER TABLE [dbo].[Dependencies]  ADD  CONSTRAINT [FK_Dependencies_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies_Users]
GO

ALTER TABLE [dbo].[Dependencies] ADD  CONSTRAINT [DF_Dependencies_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Dependencies] ADD  CONSTRAINT [DF_Dependencies_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
