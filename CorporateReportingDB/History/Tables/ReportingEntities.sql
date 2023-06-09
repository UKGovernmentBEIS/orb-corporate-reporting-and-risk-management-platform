﻿CREATE TABLE [History].[ReportingEntities]
(
	[ID] INT NOT NULL,
	[ReportingEntityTypeID] INT NOT NULL,
	[DirectorateID] INT NULL,
	[ProjectID] INT NULL,
	[PartnerOrganisationID] INT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	[EntityStatusID] INT NULL,
	[EntityStatusDate] DATETIME2(7) NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[CreatedDate] DATETIME2(0) NULL,
	[ModifiedByUserID] INT NULL,
	[ReportingFrequency] TINYINT NULL,
	[ReportingDueDay] TINYINT NULL,
	[ReportingStartDate] DATETIME2(0) NULL,
	[LeadUserID] INT NULL,
	[MeasurementUnitID] INT NULL,
	[TargetPerformanceUpperLimit] DECIMAL(18, 4) NULL,
	[TargetPerformanceLowerLimit] DECIMAL(18, 4) NULL,
	[BaselineDate] DATETIME2(0) NULL,
	[ForecastDate] DATETIME2(0) NULL,
	[ActualDate] DATETIME2(0) NULL,
	[Properties] NVARCHAR(MAX) NULL
) ON [PRIMARY]