﻿CREATE TABLE [dbo].[MeasurementUnits]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(50) NULL,
	CONSTRAINT [PK_UnitsOfMeasurement] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]