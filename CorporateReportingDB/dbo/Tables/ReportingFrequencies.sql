CREATE TABLE [dbo].[ReportingFrequencies]
(
    [ID] INT IDENTITY(1,1) NOT NULL,
    [Title] NVARCHAR(50) NOT NULL,
    [RemindAuthorsDaysBeforeDue] INT NULL,
    [RemindApproverDaysBeforeDue] INT NULL,
    [EarlyUpdateWarningDays] INT NULL,
    CONSTRAINT [PK_ReportingFrequencies] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
