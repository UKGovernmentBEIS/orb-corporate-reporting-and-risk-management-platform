CREATE VIEW [reports].[Risks]
AS
	WITH
		RiskTypesForRisk
		AS
		(
			SELECT r.ID AS RiskID, STRING_AGG(rt.Title, ',') AS RiskTypes
			FROM dbo.Risks r
				JOIN dbo.RiskRiskTypes rrt ON rrt.RiskID = r.ID
				JOIN dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID
			GROUP BY r.ID
		)
	SELECT r.ID AS [Risk ID]
	, r.Title AS [Risk Name]
	, r.RiskCode AS [Risk ID (user)]
	, riskTypes.RiskTypes AS [Risk Type]
	, g.Title AS [Group]
	, d.Title AS [Directorate]
	, es.Title AS [Status]
	, u.Title AS [Risk Owner]
	, rr.Title AS [Risk Register]
	, r.RiskEventDescription AS [Risk Description (event)]
	, r.RiskCauseDescription AS [Risk Description (cause)]
	, r.RiskImpactDescription AS [Risk Description (impact)]
	, urp.Title AS [Unmitigated Probability]
	, uril.Title AS [Unmitigated Impact]
	, OverallUrp.[RAGReportName] AS [Unmitigated RAG]
	, OverallUrp.RAGScore AS [Unmitigated RAG Score] 
	, trp.Title AS [Target Probability]
	, tril.Title AS [Target Impact]
	, OverallTrp.[RAGReportName] AS [Target RAG]
	, OverallTrp.RAGScore AS [Target RAG Score] 
	, ra.Title AS [Risk Appetite]
	, do.Title AS [Departmental Objective]
	, lr.Title AS [Linked Risk]
	, r.RiskProximity AS [Risk Proximity]
	FROM dbo.Risks AS r LEFT OUTER JOIN
		dbo.Directorates AS d ON r.DirectorateID = d.ID LEFT OUTER JOIN
		dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON r.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.Users AS u ON r.RiskOwnerUserID = u.ID LEFT OUTER JOIN
		dbo.RiskRegisters AS rr ON r.RiskRegisterID = rr.ID LEFT OUTER JOIN
		dbo.RiskProbabilities AS urp ON r.UnmitigatedRiskProbabilityID = urp.ID LEFT OUTER JOIN
		dbo.RiskImpactLevels AS uril ON r.UnmitigatedRiskImpactLevelID = uril.ID LEFT OUTER JOIN
		dbo.RiskProbabilities AS trp ON r.TargetRiskProbabilityID = trp.ID LEFT OUTER JOIN
		dbo.RiskImpactLevels AS tril ON r.TargetRiskImpactLevelID = tril.ID LEFT OUTER JOIN
		dbo.RiskAppetites AS ra ON r.RiskAppetiteID = ra.ID LEFT OUTER JOIN
		dbo.DepartmentalObjectives AS do ON r.DepartmentalObjectiveID = do.ID LEFT OUTER JOIN
		dbo.Risks AS lr ON r.LinkedRiskID = lr.ID LEFT OUTER JOIN
		dbo.RiskRiskTypes AS riskrt ON r.ID = riskrt.RiskID LEFT OUTER JOIN
		RiskTypesForRisk AS riskTypes ON r.ID = riskTypes.RiskID LEFT OUTER JOIN
		reports.RagFromRILandRP OverallTrp ON r.TargetRiskProbabilityID = OverallTrp.RPID and r.TargetRiskImpactLevelID = OverallTrp.RILID LEFT OUTER JOIN
		reports.RagFromRILandRP OverallUrp ON r.UnmitigatedRiskProbabilityID = OverallUrp.RPID and r.UnmitigatedRiskImpactLevelID = OverallUrp.RILID
	WHERE r.Discriminator = 'CorporateRisk'
