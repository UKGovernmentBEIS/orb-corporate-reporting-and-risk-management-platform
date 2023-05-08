-- CARP-775: Update Risk Probability and Risk Impact Level reference data to add new labels and retire the existing ones

-- Check the values given for the StartUpdatePeriod and EndUpdatePeriod columns to ensure they are correct (they will need to change depending on when this change is rolled-out)

SET IDENTITY_INSERT dbo.RiskProbabilities ON

MERGE
INTO dbo.RiskProbabilities AS Target  
USING (VALUES 
	(1, 'Very Unlikely (<10%)', NULL, '20190930'), 
	(2, 'Unlikely (>10%-<30%)', NULL, '20190930'),
	(3, 'Possible (>30%-<60%)', NULL, '20190930'),
	(4, 'Likely (>60%-<80%)', NULL, '20190930'),
    (5, 'Very Likely (>80%)', NULL, '20190930'),
	(6, 'Very Unlikely (<10%)', '20191031', NULL), 
	(7, 'Unlikely (>10%-<35%)', '20191031', NULL),
	(8, 'Possible (>35%-<65%)', '20191031', NULL),
	(9, 'Likely (>65%-<90%)', '20191031', NULL),
    (10, 'Very Likely (>90%)', '20191031', NULL)
) AS Source (ID, Title, StartUpdatePeriod, EndUpdatePeriod)
ON Target.ID = Source.ID  
WHEN MATCHED THEN
UPDATE SET Title = Source.Title,
	StartUpdatePeriod = Source.StartUpdatePeriod, 
	EndUpdatePeriod = Source.EndUpdatePeriod
WHEN NOT MATCHED BY TARGET THEN  
INSERT (ID, Title, StartUpdatePeriod, EndUpdatePeriod)
VALUES (Source.ID, Source.Title, Source.StartUpdatePeriod, Source.EndUpdatePeriod); 

SET IDENTITY_INSERT dbo.RiskProbabilities OFF

SET IDENTITY_INSERT dbo.RiskImpactLevels ON

MERGE
INTO dbo.RiskImpactLevels AS Target  
USING (VALUES 
	(1, 'Negligible', 'Minimal impact on business plan targets with minor reputational damage to the department', NULL, '20190930'), 
	(2, 'Marginal', 'Limited impact on business plan targets with potential media/public awareness', NULL, '20190930'),
	(3, 'Moderate', 'Business plan targets are compromised leading to scrutiny from key stakeholders (e.g. public, media, parliament)', NULL, '20190930'),
	(4, 'Critical', 'Significant impact to business plan targets resulting in criticism among key stakeholders (e.g. public, media, parliament)', NULL, '20190930'),
    (5, 'Crisis', 'BEIS cannot deliver its objectives culminating in a loss of confidence among key stakeholders (e.g. public, media, parliament)', NULL, '20190930'),
	(6, 'Very Low', 'Minimal impact on business plan targets with minor reputational damage to the department', '20191031', NULL),
	(7, 'Low', 'Limited impact on business plan targets with potential media/public awareness', '20191031', NULL),
	(8, 'Medium', 'Business plan targets are compromised leading to scrutiny from key stakeholders (e.g. public, media, parliament)', '20191031', NULL),
	(9, 'High', 'Significant impact to business plan targets resulting in criticism among key stakeholders (e.g. public, media, parliament)', '20191031', NULL),
    (10, 'Very High', 'BEIS cannot deliver its objectives culminating in a loss of confidence among key stakeholders (e.g. public, media, parliament)', '20191031', NULL)
) AS Source (ID, Title, Description, StartUpdatePeriod, EndUpdatePeriod)
ON Target.ID = Source.ID  
WHEN MATCHED THEN
UPDATE SET Title = Source.Title,
	Description = Source.Description,
	StartUpdatePeriod = Source.StartUpdatePeriod,
	EndUpdatePeriod = Source.EndUpdatePeriod
WHEN NOT MATCHED BY TARGET THEN  
INSERT (ID, Title, Description, StartUpdatePeriod, EndUpdatePeriod)
VALUES (Source.ID, Source.Title, Source.Description, Source.StartUpdatePeriod, Source.EndUpdatePeriod); 

SET IDENTITY_INSERT dbo.RiskImpactLevels OFF

MERGE
INTO dbo.RagOptionsMapping AS Target
USING (VALUES
        (5, 5, 1),
		(5, 4, 1),
		(5, 3, 2),
		(5, 2, 4),
		(5, 1, 5),
		(4, 5, 1),
		(4, 4, 1),
		(4, 3, 2),
		(4, 2, 4),
		(4, 1, 5),
        (3, 5, 1),
		(3, 4, 2),
		(3, 3, 2),
		(3, 2, 4),
		(3, 1, 5),
		(2, 5, 2),
		(2, 4, 2),
		(2, 3, 4),
		(2, 2, 5),
		(2, 1, 5),
		(1, 5, 2),
		(1, 4, 4),
		(1, 3, 5),
		(1, 2, 5),
		(1, 1, 5),
        (10, 10, 1),
		(10, 9, 1),
		(10, 8, 2),
		(10, 7, 4),
		(10, 6, 5),
		(9, 10, 1),
		(9, 9, 1),
		(9, 8, 2),
		(9, 7, 4),
		(9, 6, 5),
        (8, 10, 1),
		(8, 9, 2),
		(8, 8, 2),
		(8, 7, 4),
		(8, 6, 5),
		(7, 10, 2),
		(7, 9, 2),
		(7, 8, 4),
		(7, 7, 5),
		(7, 6, 5),
		(6, 10, 2),
		(6, 9, 4),
		(6, 8, 5),
		(6, 7, 5),
		(6, 6, 5)
) AS Source (RiskProbabilityID, RiskImpactLevelID, RagOptionID)
ON Target.RiskProbabilityID = Source.RiskProbabilityID
AND Target.RiskImpactLevelID = Source.RiskImpactLevelID
WHEN MATCHED THEN
UPDATE SET RagOptionID = Source.RagOptionID
WHEN NOT MATCHED BY TARGET THEN
INSERT (RiskProbabilityID, RiskImpactLevelID, RagOptionID)
VALUES (Source.RiskProbabilityID, Source.RiskImpactLevelID, Source.RagOptionID);
