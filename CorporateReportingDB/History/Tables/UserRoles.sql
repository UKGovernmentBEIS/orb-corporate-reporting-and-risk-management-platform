﻿CREATE TABLE [History].[UserRoles]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[UserID] INT NOT NULL,
	[RoleID] INT NOT NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL
) ON [PRIMARY]