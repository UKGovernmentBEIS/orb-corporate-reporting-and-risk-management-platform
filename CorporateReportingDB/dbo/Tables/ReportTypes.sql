﻿CREATE TABLE [dbo].[ReportTypes]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	[CreatedDate] DATETIME2(0) NULL DEFAULT GETUTCDATE(),
	[ModifiedByUserID] INT NULL,	
	CONSTRAINT [PK_ReportTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[ReportTypes] )
)
GO

ALTER TABLE [dbo].[ReportTypes]  ADD  CONSTRAINT [FK_ReportTypes_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ReportTypes] CHECK CONSTRAINT [FK_ReportTypes_ModifiedByUsers]
GO

ALTER TABLE [dbo].[ReportTypes] ADD  CONSTRAINT [DF_ReportTypes_SysStart]  DEFAULT (SYSUTCDATETIME()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[ReportTypes] ADD  CONSTRAINT [DF_ReportTypes_SysEnd]  DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO