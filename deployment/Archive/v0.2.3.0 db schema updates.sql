ALTER TABLE BenefitUpdates
ADD [UpdatePeriod] date, [ToBeClosed] [bit];

ALTER TABLE CommitmentUpdates
ADD [UpdatePeriod] date, [ToBeClosed] [bit];

ALTER TABLE DependencyUpdates
ADD [UpdatePeriod] date, [ToBeClosed] [bit];

ALTER TABLE DirectorateUpdates
ADD [UpdatePeriod] date, [ToBeClosed] [bit];

ALTER TABLE KeyWorkAreaUpdates
ADD [UpdatePeriod] date, [ToBeClosed] [bit];

ALTER TABLE MetricUpdates
ADD [UpdatePeriod] date, [ToBeClosed] [bit];

ALTER TABLE MilestoneUpdates
ADD [UpdatePeriod] date, [ToBeClosed] [bit];

ALTER TABLE ProjectUpdates
ADD [UpdatePeriod] date, [ToBeClosed] [bit];

ALTER TABLE WorkStreamUpdates
ADD [UpdatePeriod] date, [ToBeClosed] [bit];
