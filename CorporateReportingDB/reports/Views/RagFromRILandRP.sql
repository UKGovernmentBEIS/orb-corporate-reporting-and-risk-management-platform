CREATE VIEW [reports].[RagFromRILandRP]
AS 
SELECT rom.RiskImpactLevelID AS RILID, 
rom.RiskProbabilityID AS RPID, 
rom.RagOptionID AS RAG,
ro.ReportName AS [RAGReportName],
CASE rom.RagOptionID
    WHEN 1 THEN 1 -- Red
	WHEN 2 THEN 2 -- Amber-Red
	WHEN 3 THEN 0 -- No Amber for Risks
	WHEN 4 THEN 3 -- Amber-Green
	WHEN 5 THEN 4 -- Green
END AS [RAGScore] 
FROM dbo.RagOptionsMapping rom
LEFT OUTER JOIN dbo.RagOptions ro ON rom.RagOptionID = ro.ID
