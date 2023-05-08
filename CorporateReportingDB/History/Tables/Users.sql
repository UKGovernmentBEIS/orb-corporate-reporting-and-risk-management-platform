CREATE TABLE [History].[Users]
(
	[ID] INT NOT NULL,
	[Username] NVARCHAR(255) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL,
	[CreatedDate] DATETIME2(0) NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(0) NULL,
	[EmailAddress] NVARCHAR(255) NULL,
	[IsServiceAccount] BIT NULL
) ON [PRIMARY]