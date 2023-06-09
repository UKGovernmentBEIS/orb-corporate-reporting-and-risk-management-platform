﻿CREATE TABLE [dbo].[RagOptions]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(50) NULL,
	[ReportName] NVARCHAR(2) NULL,
	[Score] INT NULL,
	CONSTRAINT [PK_RagOptions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]