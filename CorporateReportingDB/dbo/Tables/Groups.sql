CREATE TABLE [dbo].[Groups]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[DirectorGeneralUserID] INT NULL,
	[RiskChampionDeputyDirectorUserID] INT NULL,
	[BusinessPartnerUserID] INT NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Groups] )
)
GO

ALTER TABLE [dbo].[Groups]  ADD  CONSTRAINT [FK_Groups_BusinessPartnerUsers] FOREIGN KEY([BusinessPartnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_BusinessPartnerUsers]
GO

ALTER TABLE [dbo].[Groups]  ADD  CONSTRAINT [FK_Groups_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_EntityStatuses]
GO

ALTER TABLE [dbo].[Groups]  ADD  CONSTRAINT [FK_Groups_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_ModifiedByUsers]
GO

ALTER TABLE [dbo].[Groups]  ADD  CONSTRAINT [FK_Groups_RiskChampionUsers] FOREIGN KEY([RiskChampionDeputyDirectorUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_RiskChampionUsers]
GO

ALTER TABLE [dbo].[Groups]  ADD  CONSTRAINT [FK_Groups_Users] FOREIGN KEY([DirectorGeneralUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_Users]
GO

ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Groups_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Groups_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO