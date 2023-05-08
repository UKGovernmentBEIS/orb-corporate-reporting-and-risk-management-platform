CREATE TABLE [History].[UserDirectorates]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[UserID] INT NOT NULL,
	[DirectorateID] INT NOT NULL,
	[IsAdmin] BIT NOT NULL,
	[IsRiskAdmin] BIT NOT NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL
) ON [PRIMARY]