CREATE TABLE [History].[ReportingEntityTypes]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[CreatedDate] DATETIME2(0) NULL,
	[ModifiedByUserID] INT NULL,
	[ReportTypeID] INT NOT NULL,
	[InheritReportSchedule] BIT NULL,
	[IsHeadlineSection] BIT NULL,
	[UpdateHasRag] BIT NULL,
	[UpdateRagIsRequired] BIT NULL,
	[UpdateHasNarrative] BIT NULL,
	[UpdateNarrativeIsRequired] BIT NULL,
	[UpdateNarrativeMaxChars] INT NULL,
	[UpdateHasDeliveryDates] BIT NULL,
	[UpdateDeliveryDatesIsRequired] BIT NULL,
	[HasUpperAndLowerTargets] BIT NULL,
	[UpdateHasMeasurement] BIT NULL,
	[UpdateMeasurementIsRequired] BIT NULL,
	[CustomFields] NVARCHAR(MAX) NULL
) ON [PRIMARY]