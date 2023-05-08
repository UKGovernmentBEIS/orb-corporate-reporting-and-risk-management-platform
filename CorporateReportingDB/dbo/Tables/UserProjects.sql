CREATE TABLE [dbo].[UserProjects]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[UserID] INT NOT NULL,
	[ProjectID] INT NOT NULL,
	[IsAdmin] BIT NOT NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] INT NULL,
	[IsRiskAdmin] BIT NOT NULL,
	CONSTRAINT [PK_UserProjects] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT [UQ_UserProjects] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[UserProjects] )
)
GO

ALTER TABLE [dbo].[UserProjects] ADD CONSTRAINT [FK_UserProjects_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserProjects] CHECK CONSTRAINT [FK_UserProjects_ModifiedByUsers]
GO

ALTER TABLE [dbo].[UserProjects] ADD CONSTRAINT [FK_UserProjects_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[UserProjects] CHECK CONSTRAINT [FK_UserProjects_Projects]
GO

ALTER TABLE [dbo].[UserProjects] ADD CONSTRAINT [FK_UserProjects_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserProjects] CHECK CONSTRAINT [FK_UserProjects_Users]
GO

ALTER TABLE [dbo].[UserProjects] ADD CONSTRAINT [DF_UserProjects_IsAdmin] DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[UserProjects] ADD CONSTRAINT [DF_UserProjects_IsRiskAdmin] DEFAULT ((0)) FOR [IsRiskAdmin]
GO
ALTER TABLE [dbo].[UserProjects] ADD CONSTRAINT [DF_UserProjects_SysStart] DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[UserProjects] ADD CONSTRAINT [DF_UserProjects_SysEnd] DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO