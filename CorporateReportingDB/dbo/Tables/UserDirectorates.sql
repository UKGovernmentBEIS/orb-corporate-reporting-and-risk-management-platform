CREATE TABLE [dbo].[UserDirectorates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[UserID] INT NOT NULL,
	[DirectorateID] INT NOT NULL,
	[IsAdmin] BIT NOT NULL,
	[IsRiskAdmin] BIT NOT NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	CONSTRAINT [PK_UserDirectorates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT [UQ_UserDirectorates] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[DirectorateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[UserDirectorates] )
)
GO

ALTER TABLE [dbo].[UserDirectorates] ADD CONSTRAINT [FK_UserDirectorates_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[UserDirectorates] CHECK CONSTRAINT [FK_UserDirectorates_Directorates]
GO

ALTER TABLE [dbo].[UserDirectorates] ADD CONSTRAINT [FK_UserDirectorates_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserDirectorates] CHECK CONSTRAINT [FK_UserDirectorates_ModifiedByUsers]
GO

ALTER TABLE [dbo].[UserDirectorates] ADD CONSTRAINT [FK_UserDirectorates_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserDirectorates] CHECK CONSTRAINT [FK_UserDirectorates_Users]
GO

ALTER TABLE [dbo].[UserDirectorates] ADD CONSTRAINT [DF_UserDirectorates_IsAdmin] DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[UserDirectorates] ADD CONSTRAINT [DF_UserDirectorates_IsRiskAdmin] DEFAULT ((0)) FOR [IsRiskAdmin]
GO
ALTER TABLE [dbo].[UserDirectorates] ADD CONSTRAINT [DF_UserDirectorates_SysStart] DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[UserDirectorates] ADD CONSTRAINT [DF_UserDirectorates_SysEnd] DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO