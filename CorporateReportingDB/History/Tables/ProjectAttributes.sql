CREATE TABLE [History].[ProjectAttributes]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[ProjectAttributeTypeID] INT NOT NULL,
	[ProjectID] INT NOT NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL
) ON [PRIMARY]