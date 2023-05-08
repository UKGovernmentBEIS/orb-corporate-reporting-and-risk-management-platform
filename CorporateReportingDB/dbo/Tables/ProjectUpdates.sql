CREATE TABLE [dbo].[ProjectUpdates]
(
    [ID] INT IDENTITY(1, 1) NOT NULL,
    [Title] NVARCHAR(255) NULL,
    [Comment] VARCHAR(1000) NULL,
    [RagOptionID] INT NULL,
    [ProjectID] INT NOT NULL,
    [UpdateDate] DATETIME2(7) NULL,
    [UpdateUserID] INT NULL,
    [OverallRagOptionID] INT NULL,
    [FinanceRagOptionID] INT NULL,
    [FinanceComment] NVARCHAR(500) NULL,
    [PeopleRagOptionID] INT NULL,
    [PeopleComment] NVARCHAR(500) NULL,
    [MilestonesRagOptionID] INT NULL,
    [MilestonesComment] NVARCHAR(500) NULL,
    [BenefitsRagOptionID] INT NULL,
    [BenefitsComment] NVARCHAR(500) NULL,
    [ProgressUpdate] NVARCHAR(500) NULL,
    [FutureActions] NVARCHAR(500) NULL,
    [Escalations] NVARCHAR(500) NULL,
    [ProjectPhaseID] INT NULL,
    [BusinessCaseTypeID] INT NULL,
    [BusinessCaseDate] DATETIME2(7) NULL,
    [WholeLifeCost] DECIMAL(18, 4) NULL,
    [WholeLifeBenefit] DECIMAL(18, 4) NULL,
    [NetPresentValue] DECIMAL(18, 4) NULL,
    [SignOffID] INT NULL,
    [ToBeClosed] BIT NULL,
    [UpdatePeriod] DATE NULL,
    CONSTRAINT [PK_ProjectUpdates] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_ProjectUpdates_ProjectBusinessCaseTypes] FOREIGN KEY ([BusinessCaseTypeID]) REFERENCES [dbo].[ProjectBusinessCaseTypes] ([ID]),
    CONSTRAINT [FK_ProjectUpdates_ProjectPhases] FOREIGN KEY ([ProjectPhaseID]) REFERENCES [dbo].[ProjectPhases] ([ID]),
    CONSTRAINT [FK_ProjectUpdates_Projects] FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Projects] ([ID]),
    CONSTRAINT [FK_ProjectUpdates_RagOptionBenefit] FOREIGN KEY ([BenefitsRagOptionID]) REFERENCES [dbo].[RagOptions] ([ID]),
    CONSTRAINT [FK_ProjectUpdates_RagOptionFinance] FOREIGN KEY ([FinanceRagOptionID]) REFERENCES [dbo].[RagOptions] ([ID]),
    CONSTRAINT [FK_ProjectUpdates_RagOptionMilestone] FOREIGN KEY ([MilestonesRagOptionID]) REFERENCES [dbo].[RagOptions] ([ID]),
    CONSTRAINT [FK_ProjectUpdates_RagOptionOverall] FOREIGN KEY ([OverallRagOptionID]) REFERENCES [dbo].[RagOptions] ([ID]),
    CONSTRAINT [FK_ProjectUpdates_RagOptionPeople] FOREIGN KEY ([PeopleRagOptionID]) REFERENCES [dbo].[RagOptions] ([ID]),
    CONSTRAINT [FK_ProjectUpdates_SignOffs] FOREIGN KEY ([SignOffID]) REFERENCES [dbo].[SignOffs] ([ID]),
    CONSTRAINT [FK_ProjectUpdates_UpdateUser] FOREIGN KEY ([UpdateUserID]) REFERENCES [dbo].[Users] ([ID])
);
GO