CREATE VIEW [reports].[RiskUpdates]
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
	SELECT gr.Title AS [Group]
	, dir.Title AS [Directorate] 
	, ru.ID AS [Risk Update ID]
	, r.ID AS [Risk ID]
	, r.RiskCode AS [Risk ID (user)]
	, ru.SignOffID AS [SignOff ID] 
	, r.Title AS [Risk Name]
	, riskTypes.RiskTypes AS [Risk Type]
	, ru.Narrative AS [Narrative]
	, Months.ReportMonth AS [Report Month]
	, u.Title AS [Author]
	, proj.Title AS [Project] 
	, CAST(ru.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
	, rr.Title AS [Risk Register]
	, rp.Title AS [Probability]
	, RisksLastMonth.Probability AS [Previous Probability]
	, trp.Title AS [Target Probability]
	, ril.Title AS [Impact Level]
	, RisksLastMonth.[Impact Level] AS [Previous Impact Level] 
	, tril.Title AS [Target Impact Level]
	, CASE WHEN EXISTS (SELECT 1
		FROM dbo.RiskRiskTypes rrt INNER JOIN
			dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID INNER JOIN
			dbo.ThresholdAppetites ta ON ta.ThresholdID = rt.ThresholdID
		WHERE rrt.RiskID = r.ID
			AND ta.RiskImpactLevelID  = ru.RiskImpactLevelID
			AND ta.RiskProbabilityID = ru.RiskProbabilityID
			AND ta.Acceptable = 'false') THEN 'No' ELSE 'Yes' END AS [Falls within departmental risk appetite]
	, (SELECT STRING_AGG(x.title, ', ')
		FROM (SELECT DISTINCT thr.Title
			FROM RiskRiskTypes rrt
				INNER JOIN dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID
				INNER JOIN dbo.Thresholds AS thr ON thr.ID = rt.ThresholdID
			WHERE rrt.RiskID = r.ID) x) AS [Threshold Title]
	, OverallRp.RAGReportName AS [RAG]
	, RisksLastMonth.RAG AS [Previous RAG]
	, OverallTrp.RAGReportName AS [Target RAG]
	, OverallRp.RAGScore AS [RAG Score] 
	, RisksLastMonth.[RAG Score] AS [Previous RAG Score]  
	, OverallTrp.RAGScore AS [Target RAG Score]
	, (OverallRp.RAGScore - RisksLastMonth.[RAG Score]) AS [RAG Change]
	, CASE ru.Escalate WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be escalated]
	, CASE ru.Escalate WHEN 1 THEN ru.Comment ELSE NULL END AS [Escalation comment]
	, CASE ru.DeEscalate WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be de-escalated]
	, CASE ru.DeEscalate WHEN 1 THEN ru.Comment ELSE NULL END AS [De-escalation comment]
	, CASE ru.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be closed]
	, CASE ru.ToBeClosed WHEN 1 THEN ru.Comment ELSE NULL END AS [Closure comment]
	, es.Title AS [Status]
	, ru.RiskProximity AS [Risk proximity]
	FROM dbo.Risks r CROSS JOIN
    (SELECT DISTINCT dbo.SignOffs.ReportMonth
		FROM dbo.SignOffs
		WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months LEFT OUTER JOIN
		dbo.RiskUpdates AS ru ON ru.RiskID = r.ID AND ru.UpdatePeriod = Months.ReportMonth INNER JOIN
		dbo.SignOffs AS so ON ru.SignOffID = so.ID AND so.IsCurrent = 1 LEFT OUTER JOIN
		dbo.Users AS u ON ru.UpdateUserID = u.ID LEFT OUTER JOIN
		dbo.RiskRegisters AS rr ON r.RiskRegisterID = rr.ID LEFT OUTER JOIN
		dbo.RiskProbabilities AS rp ON ru.RiskProbabilityID = rp.ID LEFT OUTER JOIN
		dbo.RiskProbabilities AS trp ON r.TargetRiskProbabilityID = trp.ID LEFT OUTER JOIN
		dbo.RiskImpactLevels AS ril ON ru.RiskImpactLevelID = ril.ID LEFT OUTER JOIN
		dbo.RiskImpactLevels AS tril ON r.TargetRiskImpactLevelID = tril.ID LEFT OUTER JOIN
		dbo.Projects AS proj ON r.ProjectID = proj.ID LEFT OUTER JOIN
		dbo.Directorates AS dir ON r.DirectorateID = dir.ID LEFT OUTER JOIN
		dbo.Groups AS gr ON dir.GroupID = gr.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON r.EntityStatusID = es.ID LEFT OUTER JOIN
		reports.RagFromRILandRP OverallRp ON ru.RiskProbabilityID = OverallRp.RPID AND ru.RiskImpactLevelID = OverallRp.RILID LEFT OUTER JOIN
		reports.RagFromRILandRP OverallTrp ON r.TargetRiskProbabilityID = OverallTrp.RPID AND r.TargetRiskImpactLevelID = OverallTrp.RILID LEFT OUTER JOIN
		RiskTypesForRisk AS riskTypes ON r.ID = riskTypes.RiskID LEFT OUTER JOIN
		(SELECT ru.RiskID AS [RiskID]
			, EOMONTH(DATEADD(month, 1, ru.UpdatePeriod)) AS [NextMonth]
			, OverallRp.RAGReportName AS [RAG]
			, OverallRp.RAGScore AS [RAG Score] 
			, rp.Title AS [Probability]
			, ril.Title AS [Impact level]
		FROM dbo.RiskUpdates AS ru INNER JOIN
			dbo.SignOffs AS so ON ru.SignOffID = so.ID LEFT OUTER JOIN
			dbo.RiskProbabilities AS rp ON ru.RiskProbabilityID = rp.ID LEFT OUTER JOIN
			dbo.RiskImpactLevels AS ril ON ru.RiskImpactLevelID = ril.ID LEFT OUTER JOIN
			reports.RagFromRILandRP OverallRp ON OverallRp.RILID = ru.RiskImpactLevelID AND OverallRp.RPID = ru.RiskProbabilityID
		WHERE so.IsCurrent = 1) AS RisksLastMonth ON r.ID = RisksLastMonth.RiskID AND Months.ReportMonth = RisksLastMonth.NextMonth
