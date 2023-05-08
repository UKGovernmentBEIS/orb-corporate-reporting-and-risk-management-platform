CREATE TABLE [dbo].[BenefitUpdates]
(
	[ID] INT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR(255) NULL,
	[BenefitID] INT NULL,
	[UpdateDate] DATETIME2(7) NULL,
	[RagOptionID] INT NULL,
	[Comment] NVARCHAR(500) NULL,
	[CurrentPerformance] DECIMAL(18, 4) NULL,
	[UpdateUserID] INT NULL,
	[SignOffID] INT NULL,
	[ToBeClosed] BIT NULL,
	[UpdatePeriod] DATE NULL,
	[ForecastDate] DATE NULL,
	[ActualDate] DATE NULL,
	CONSTRAINT [PK_BenefitUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BenefitUpdates]  ADD  CONSTRAINT [FK_BenefitUpdates_Benefits] FOREIGN KEY([BenefitID])
REFERENCES [dbo].[Benefits] ([ID])
GO

ALTER TABLE [dbo].[BenefitUpdates] CHECK CONSTRAINT [FK_BenefitUpdates_Benefits]
GO
ALTER TABLE [dbo].[BenefitUpdates]  ADD  CONSTRAINT [FK_BenefitUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO

ALTER TABLE [dbo].[BenefitUpdates] CHECK CONSTRAINT [FK_BenefitUpdates_RagOptions]
GO
ALTER TABLE [dbo].[BenefitUpdates]  ADD  CONSTRAINT [FK_BenefitUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO

ALTER TABLE [dbo].[BenefitUpdates] CHECK CONSTRAINT [FK_BenefitUpdates_SignOffs]
GO
ALTER TABLE [dbo].[BenefitUpdates]  ADD  CONSTRAINT [FK_BenefitUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO

ALTER TABLE [dbo].[BenefitUpdates] CHECK CONSTRAINT [FK_BenefitUpdates_Users]