﻿CREATE TABLE [History].[Contributors]
(
	[ID] INT NOT NULL,
	[Title] NVARCHAR(50) NULL,
	[ContributorUserID] INT NULL,
	[BenefitID] INT NULL,
	[CommitmentID] INT NULL,
	[DependencyID] INT NULL,
	[KeyWorkAreaID] INT NULL,
	[MetricID] INT NULL,
	[MilestoneID] INT NULL,
	[WorkStreamID] INT NULL,
	[SysStartTime] DATETIME2(0) NOT NULL,
	[SysEndTime] DATETIME2(0) NOT NULL,
	[ModifiedByUserID] INT NULL,
	[RiskID] INT NULL,
	[RiskMitigationActionID] INT NULL,
	[PartnerOrganisationRiskID] INT NULL,
	[PartnerOrganisationRiskMitigationActionID] INT NULL,
	[PartnerOrganisationID] INT NULL,
	[IsReadOnly] BIT NULL,
	[ReportingEntityID] INT NULL,
	[DirectorateID] INT NULL,
	[ProjectID] INT NULL
) ON [PRIMARY]