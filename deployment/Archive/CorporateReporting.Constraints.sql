ALTER TABLE UserDirectorates
ADD CONSTRAINT UQ_UserDirectorates UNIQUE(UserID,DirectorateID);

ALTER TABLE Users
ADD CONSTRAINT UQ_Users UNIQUE(Username);

ALTER TABLE UserProjects
ADD CONSTRAINT UQ_UserProjects UNIQUE(UserID,ProjectID);

ALTER TABLE UserRoles
ADD CONSTRAINT UQ_UserRoles UNIQUE(UserID,RoleID);


CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_BenefitContributors
ON Contributors(ContributorUserID,BenefitID)
WHERE BenefitID IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_CommitmentContributors
ON Contributors(ContributorUserID,CommitmentID)
WHERE CommitmentID IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_DependencyContributors
ON Contributors(ContributorUserID,DependencyID)
WHERE DependencyID IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_KeyWorkAreaContributors
ON Contributors(ContributorUserID,KeyWorkAreaID)
WHERE KeyWorkAreaID IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_MetricContributors
ON Contributors(ContributorUserID,MetricID)
WHERE MetricID IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_MilestoneContributors
ON Contributors(ContributorUserID,MilestoneID)
WHERE MilestoneID IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_WorkStreamContributors
ON Contributors(ContributorUserID,WorkStreamID)
WHERE WorkStreamID IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_RiskContributors
ON Contributors(ContributorUserID,RiskID)
WHERE RiskID IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX IX_UQ_RiskMitigationActionContributors
ON Contributors(ContributorUserID,RiskMitigationActionID)
WHERE RiskMitigationActionID IS NOT NULL;