UPDATE BenefitUpdates
SET [UpdatePeriod]=EOMONTH([UpdateDate]);

UPDATE CommitmentUpdates
SET [UpdatePeriod]=EOMONTH([UpdateDate]);

UPDATE DependencyUpdates
SET [UpdatePeriod]=EOMONTH([UpdateDate]);

UPDATE DirectorateUpdates
SET [UpdatePeriod]=EOMONTH([UpdateDate]);

UPDATE KeyWorkAreaUpdates
SET [UpdatePeriod]=EOMONTH([UpdateDate]);

UPDATE MetricUpdates
SET [UpdatePeriod]=EOMONTH([UpdateDate]);

UPDATE MilestoneUpdates
SET [UpdatePeriod]=EOMONTH([UpdateDate]);

UPDATE ProjectUpdates
SET [UpdatePeriod]=EOMONTH([UpdateDate]);

UPDATE WorkStreamUpdates
SET [UpdatePeriod]=EOMONTH([UpdateDate]);