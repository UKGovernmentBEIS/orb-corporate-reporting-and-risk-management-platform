CREATE TABLE [dbo].[ProjectAttributes]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[ProjectAttributeTypeID] INT NOT NULL,
	[ProjectID] INT NOT NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	CONSTRAINT [PK_ProjectAttributes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[ProjectAttributes] )
)
GO
ALTER TABLE [dbo].[ProjectAttributes]  ADD  CONSTRAINT [FK_ProjectAttributes_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[ProjectAttributes] CHECK CONSTRAINT [FK_ProjectAttributes_ModifiedByUsers]
GO
ALTER TABLE [dbo].[ProjectAttributes]  ADD  CONSTRAINT [FK_ProjectAttributes_ProjectAttributeTypes] FOREIGN KEY([ProjectAttributeTypeID])
REFERENCES [dbo].[ProjectAttributeTypes] ([ID])
GO

ALTER TABLE [dbo].[ProjectAttributes] CHECK CONSTRAINT [FK_ProjectAttributes_ProjectAttributeTypes]
GO
ALTER TABLE [dbo].[ProjectAttributes]  ADD  CONSTRAINT [FK_ProjectAttributes_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO

ALTER TABLE [dbo].[ProjectAttributes] CHECK CONSTRAINT [FK_ProjectAttributes_Projects]
GO
ALTER TABLE [dbo].[ProjectAttributes] ADD  CONSTRAINT [DF_ProjectAttributes_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[ProjectAttributes] ADD  CONSTRAINT [DF_ProjectAttributes_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]