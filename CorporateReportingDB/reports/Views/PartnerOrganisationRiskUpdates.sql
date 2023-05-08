CREATE VIEW [reports].[PartnerOrganisationRiskUpdates]
AS
WITH RiskTypesForRisk AS
(SELECT por.ID AS PartnerOrganisationRiskID, STRING_AGG(rt.Title, ',') WITHIN GROUP (ORDER BY rt.Title) AS RiskTypes
FROM dbo.PartnerOrganisationRisks por
JOIN dbo.PartnerOrganisationRiskRiskTypes porrt ON porrt.PartnerOrganisationRiskID = por.ID
JOIN dbo.RiskTypes rt ON rt.ID = porrt.RiskTypeID
GROUP BY por.ID
)
SELECT u.Title AS [Author]
		,dir.Title AS [Directorate] 
		,gr.Title AS [Group]
		,poru.SignOffID AS [SignOff ID]
	,CAST(poru.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
	,CASE poru.ToBeClosed WHEN 1 THEN poru.Comment ELSE NULL END AS [Closure Comment]

	,beisRil.Title AS [BEIS Impact level]
	,poRil.Title AS [Partner Organisation Impact Level]
	
	,beisRp.Title AS [BEIS Probability]
	,poRp.Title AS [Partner Organisation Probability] 
	,OverallBeisRp.RAGReportName AS [BEIS RAG]
	,OverallBeisRp.RAGScore AS [BEIS RAG Score]
	
	,OverallRp.RAGReportName AS [Partner Organisation RAG]
	,OverallRp.RAGScore AS [Partner Organisation RAG Score] 
	   
	,poru.UpdatePeriod AS [Report Month]

	,poru.PartnerOrganisationRiskID AS [Risk ID]
	,por.RiskCode AS [Risk ID (user)]
	,poru.Title AS [Risk Name]
	,poRiskTypes.RiskTypes AS [Risk Type]
	,poru.ID AS [Risk Update ID]
		
	,beisTIL.Title AS [BEIS Target Impact]
	,poTIL.Title AS [Partner Organisation Target Impact]
		
	,beisTrp.Title AS [BEIS Target Probability]
	,poTrp.Title AS [Partner Organisation Target Probability]
	
	,OverallBeisTrp.RAGReportName AS [BEIS Target RAG]
	,OverallTrp.RAGReportName AS [Partner Organisation Target RAG]

    ,RisksLastMonth.ProbabilityBEIS AS [BEIS Previous Probability]
	,RisksLastMonth.[Impact levelBEIS] AS [BEIS Previous Impact Level]
    ,RisksLastMonth.RAGBEIS AS [BEIS Previous RAG]
	,RisksLastMonth.BeisRagScore AS [BEIS Previous RAG Score]
	,(OverallBEISRp.RAGScore- RisksLastMonth.BeisRagScore) AS [BEIS RAG Change]

	,RisksLastMonth.ProbabilityPO AS [Partner Organisation Previous Probability]
	,RisksLastMonth.[Impact levelPO] AS [Partner Organisation Previous Impact Level]
    ,RisksLastMonth.RAGPO AS [Partner Organisation Previous RAG]
	,RisksLastMonth.RAGScore AS [Partner Organisation Previous RAG Score]
	,(OverallRp.RAGScore- RisksLastMonth.RAGScore) AS [Partner Organisation RAG Change]

	,CASE poru.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be closed]

	,CAST(poru.RiskProximity AS DATE) AS [Risk Proximity]
	,es.Title AS [Status] 

FROM dbo.PartnerOrganisationRiskUpdates poru  LEFT OUTER JOIN
	dbo.PartnerOrganisationRisks por ON poru.PartnerOrganisationRiskID = por.ID LEFT OUTER JOIN
	dbo.Users u ON poru.UpdateUserID = u.ID LEFT OUTER JOIN
	dbo.PartnerOrganisations AS po ON por.PartnerOrganisationID = po.ID LEFT OUTER JOIN
	dbo.Directorates AS dir ON po.DirectorateID = dir.ID LEFT OUTER JOIN
	dbo.Groups AS gr ON dir.GroupID = gr.ID LEFT OUTER JOIN
	dbo.EntityStatuses AS es ON por.EntityStatusID = es.ID LEFT OUTER JOIN
	RiskTypesForRisk AS poRiskTypes ON por.ID = poRiskTypes.PartnerOrganisationRiskID LEFT OUTER JOIN

	dbo.RiskImpactLevels beisRil ON poru.BeisRiskImpactLevelID = beisRil.ID LEFT OUTER JOIN
	dbo.RiskImpactLevels poRil ON poru.RiskImpactLevelID = poRil.ID LEFT OUTER JOIN
	
	dbo.RiskProbabilities beisRp ON poru.BeisRiskProbabilityID = beisRp.ID LEFT OUTER JOIN
	dbo.RiskProbabilities poRp ON poru.RiskProbabilityID = poRp.ID LEFT OUTER JOIN

	dbo.RiskImpactLevels beisTil ON por.BEISTargetRiskImpactLevelID = beisTil.ID LEFT OUTER JOIN
    dbo.RiskImpactLevels poTil ON por.TargetRiskImpactLevelID = poTil.ID LEFT OUTER JOIN

	dbo.RiskProbabilities beisTrp ON por.BEISTargetRiskProbabilityID = beisTrp.ID LEFT OUTER JOIN
	dbo.RiskProbabilities poTrp ON por.TargetRiskProbabilityID = poTrp.ID  LEFT OUTER JOIN

	reports.RagFromRILandRP OverallBeisRp ON poru.BeisRiskProbabilityID = OverallBeisRp.RPID and poru.BeisRiskImpactLevelID = OverallBeisRp.RILID LEFT OUTER JOIN
	reports.RagFromRILandRP OverallBeisTrp ON por.BEISTargetRiskProbabilityID = OverallBeisTrp.RPID and por.BEISTargetRiskImpactLevelID = OverallBeisTrp.RILID LEFT OUTER JOIN

	reports.RagFromRILandRP OverallRp ON poru.RiskProbabilityID = OverallRp.RPID and poru.RiskImpactLevelID = OverallRp.RILID LEFT OUTER JOIN
	reports.RagFromRILandRP OverallTrp ON por.TargetRiskProbabilityID = OverallTrp.RPID and por.TargetRiskImpactLevelID = OverallTrp.RILID  LEFT OUTER JOIN

	(SELECT	poru2.PartnerOrganisationRiskID AS [RiskID]
			,EOMONTH(DATEADD(month, 1, poru2.UpdatePeriod)) AS [NextMonth]
			,roBEIS.RAGReportName AS [RAGBEIS]
			,rpBEIS.Title AS [ProbabilityBEIS]
			,rilBEIS.Title AS [Impact levelBEIS]
			,roBEIS.RAGScore AS [BeisRagScore] 
			,roPO.RAGReportName AS [RAGPO]
			,roPO.RAGScore AS [RAGScore]
			,rpPO.Title AS [ProbabilityPO]
			,rilPO.Title AS [Impact levelPO]
	FROM    dbo.PartnerOrganisationRiskUpdates poru2 LEFT OUTER JOIN
			reports.RagFromRILandRP roBEIS ON roBEIS.RILID = poru2.BeisRiskImpactLevelID AND roBEIS.RPID = poru2.BeisRiskProbabilityID LEFT OUTER JOIN
			dbo.RiskProbabilities rpBEIS ON poru2.BeisRiskProbabilityID = rpBEIS.ID LEFT OUTER JOIN
			dbo.RiskImpactLevels rilBEIS ON poru2.BeisRiskImpactLevelID = rilBEIS.ID  LEFT OUTER JOIN

			reports.RagFromRILandRP roPO ON roPO.RILID = poru2.RiskImpactLevelID AND roPO.RPID = poru2.RiskProbabilityID LEFT OUTER JOIN
			dbo.RiskProbabilities rpPO ON poru2.RiskProbabilityID = rpPO.ID LEFT OUTER JOIN
			dbo.RiskImpactLevels rilPO ON poru2.RiskImpactLevelID = rilPO.ID
		WHERE poru2.IsCurrent = 1)  RisksLastMonth ON poru.PartnerOrganisationRiskID = RisksLastMonth.RiskID AND poru.UpdatePeriod = RisksLastMonth.NextMonth
WHERE
	poru.IsCurrent = 1
	