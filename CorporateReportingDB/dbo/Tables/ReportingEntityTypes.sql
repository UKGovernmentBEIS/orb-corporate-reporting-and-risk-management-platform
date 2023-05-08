CREATE TABLE [dbo].[ReportingEntityTypes]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	[SysStartTime] DATETIME2(0) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	[SysEndTime] DATETIME2(0) GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	[CreatedDate] DATETIME2(0) NULL DEFAULT GETUTCDATE(),
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
	[CustomFields] NVARCHAR(MAX) NULL,
	CONSTRAINT [PK_ReportingEntityTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[ReportingEntityTypes] )
)
GO

ALTER TABLE [dbo].[ReportingEntityTypes] ADD CONSTRAINT [FK_ReportingEntityTypes_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityTypes] CHECK CONSTRAINT [FK_ReportingEntityTypes_ModifiedByUsers]
GO

ALTER TABLE [dbo].[ReportingEntityTypes] ADD CONSTRAINT [FK_ReportingEntityTypes_ReportTypes] FOREIGN KEY([ReportTypeID])
REFERENCES [dbo].[ReportTypes] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityTypes] CHECK CONSTRAINT [FK_ReportingEntityTypes_ReportTypes]
GO

ALTER TABLE [dbo].[ReportingEntityTypes] ADD CONSTRAINT [DF_ReportingEntityTypes_SysStart] DEFAULT (SYSUTCDATETIME()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[ReportingEntityTypes] ADD CONSTRAINT [DF_ReportingEntityTypes_SysEnd] DEFAULT (CONVERT(DATETIME2(0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO