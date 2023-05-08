CREATE TABLE [History].[UserGroups]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[UserID] INT NOT NULL,
	[GroupID] INT NOT NULL,
	[IsRiskAdmin] BIT NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL,
	[Discriminator] NVARCHAR(50) NOT NULL DEFAULT N'UserGroup'
) ON [PRIMARY]