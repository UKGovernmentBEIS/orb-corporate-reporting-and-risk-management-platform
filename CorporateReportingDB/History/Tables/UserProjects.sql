CREATE TABLE [History].[UserProjects]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[UserID] INT NOT NULL,
	[ProjectID] INT NOT NULL,
	[IsAdmin] BIT NOT NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL,
	[IsRiskAdmin] BIT NOT NULL
) ON [PRIMARY]