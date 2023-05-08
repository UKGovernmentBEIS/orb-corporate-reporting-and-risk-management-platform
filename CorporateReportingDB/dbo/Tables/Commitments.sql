CREATE TABLE [dbo].[Commitments]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[DirectorateID] INT NOT NULL,
	[BaselineDate] DATE NULL,
	[ForecastDate] DATE NULL,
	[ActualDate] DATE NULL,
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
	CONSTRAINT [PK_Commitments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Commitments] )
)
GO

ALTER TABLE [dbo].[Commitments]  ADD  CONSTRAINT [FK_Commitments_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[Commitments] CHECK CONSTRAINT [FK_Commitments_Directorates]
GO

ALTER TABLE [dbo].[Commitments]  ADD  CONSTRAINT [FK_Commitments_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Commitments] CHECK CONSTRAINT [FK_Commitments_EntityStatuses]
GO

ALTER TABLE [dbo].[Commitments]  ADD  CONSTRAINT [FK_Commitments_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Commitments] CHECK CONSTRAINT [FK_Commitments_ModifiedByUsers]
GO

ALTER TABLE [dbo].[Commitments]  ADD  CONSTRAINT [FK_Commitments_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Commitments] CHECK CONSTRAINT [FK_Commitments_RagOptions]
GO

ALTER TABLE [dbo].[Commitments]  ADD  CONSTRAINT [FK_Commitments_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Commitments] CHECK CONSTRAINT [FK_Commitments_Users]
GO

ALTER TABLE [dbo].[Commitments] ADD  CONSTRAINT [DF_Commitments_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Commitments] ADD  CONSTRAINT [DF_Commitments_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO