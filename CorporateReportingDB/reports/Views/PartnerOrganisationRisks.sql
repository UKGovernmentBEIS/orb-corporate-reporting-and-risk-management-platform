CREATE VIEW [reports].[PartnerOrganisationRisks]
AS 
WITH RiskTypesForRisk AS
(SELECT por.ID AS PartnerOrganisationRiskID, STRING_AGG(rt.Title, ',') WITHIN GROUP (ORDER BY rt.Title) AS RiskTypes
FROM dbo.PartnerOrganisationRisks por
JOIN dbo.PartnerOrganisationRiskRiskTypes porrt ON porrt.PartnerOrganisationRiskID = por.ID
JOIN dbo.RiskTypes rt ON rt.ID = porrt.RiskTypeID
GROUP BY por.ID
)
SELECT do.Title AS [Departmental Objective]
        ,po.Title AS [Partner Organisation]
        ,d.Title AS [Directorate]
        ,g.Title AS [Group]
        ,beisra.Title AS [BEIS Risk Appetite] 
        ,pora.Title AS [Partner Organisation Risk Appetite] 
        ,por.RiskCauseDescription AS [Risk Description (cause)]
        ,por.RiskEventDescription AS [Risk Description (event)]
        ,por.RiskImpactDescription AS [Risk Description (impact)]
        ,por.ID AS [Risk ID]
        ,por.RiskCode AS [Risk ID (user)]
        ,por.Title AS [Risk Name]
		,poRiskTypes.RiskTypes AS [Risk Type] 
        ,beisusr.Title AS [BEIS Risk Owner]
        ,pousr.Title AS [Partner Organisation Risk Owner]
        ,es.Title AS [Status]
        
        ,beisTIL.Title AS [BEIS Target Impact]
        ,poTIL.Title AS [Partner Organisation Target Impact]
        
        ,beisTrp.Title AS [BEIS Target Probability]
        ,poTrp.Title AS [Partner Organisation Target Probability]

		,OverallBeisTrp.RAGReportName AS [BEIS Target RAG]
		,OverallTrp.RAGReportName AS [Partner Organisation RAG] 
       	,OverallBeisTrp.RAGScore AS [BEIS Target RAG Score]
		,OverallTrp.RAGScore AS [Partner Organisation Target RAG Score]

        ,beisUril.Title AS [BEIS Unmitigated Impact]
        ,poUril.Title AS [Partner Organisation Unmitigated Impact]

        ,beisUrp.Title AS [BEIS Unmitigated Probability]
        ,poUrp.Title AS [Partner Organisation Unmitigated Probability]

		,OverallBeisUrp.RAGReportName AS [BEIS Unmitigated RAG]
		,OverallUrp.RAGReportName AS [Partner Organisation Unmitigated RAG]
		,OverallBeisUrp.RAGScore AS [BEIS Unmitigated RAG Score] 
		,OverallUrp.RAGScore AS [Partner Organisation Unmitigated RAG Score] 

		,CAST(por.RiskProximity AS DATE) AS [Risk Proximity]

FROM dbo.PartnerOrganisationRisks por LEFT OUTER JOIN
    dbo.PartnerOrganisations po On por.PartnerOrganisationID = po.ID LEFT OUTER JOIN
    dbo.Directorates d ON po.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.DepartmentalObjectives do ON por.DepartmentalObjectiveID = do.ID LEFT OUTER JOIN
    dbo.RiskAppetites beisra ON por.BeisRiskAppetiteID = beisra.ID LEFT OUTER JOIN
    dbo.RiskAppetites pora ON por.RiskAppetiteID = pora.ID LEFT OUTER JOIN
    dbo.Users beisusr ON por.BeisRiskOwnerUserID = beisusr.ID  LEFT OUTER JOIN
    dbo.Users pousr ON por.RiskOwnerUserID = pousr.ID LEFT OUTER JOIN
    dbo.EntityStatuses es ON por.EntityStatusID = es.ID LEFT OUTER JOIN
   
    dbo.RiskImpactLevels beisTil ON por.BEISTargetRiskImpactLevelID = beisTil.ID LEFT OUTER JOIN
    dbo.RiskImpactLevels poTil ON por.TargetRiskImpactLevelID = poTil.ID LEFT OUTER JOIN

	dbo.RiskProbabilities beisTrp ON por.BEISTargetRiskProbabilityID = beisTrp.ID LEFT OUTER JOIN
	dbo.RiskProbabilities poTrp ON por.TargetRiskProbabilityID = poTrp.ID LEFT OUTER JOIN

	dbo.RiskImpactLevels beisUril ON por.BEISUnmitigatedRiskImpactLevelID = beisUril.ID LEFT OUTER JOIN
	dbo.RiskImpactLevels poURil ON por.UnmitigatedRiskImpactLevelID = poUril.ID LEFT OUTER JOIN

	dbo.RiskProbabilities beisUrp ON por.BEISUnmitigatedRiskProbabilityID = beisUrp.ID LEFT OUTER JOIN
	dbo.RiskProbabilities poUrp ON por.UnmitigatedRiskProbabilityID = poUrp.ID LEFT OUTER JOIN

	reports.RagFromRILandRP OverallBeisUrp ON por.BEISUnmitigatedRiskProbabilityID = OverallBeisUrp.RPID and por.BEISUnmitigatedRiskImpactLevelID = OverallBeisUrp.RILID LEFT OUTER JOIN
	reports.RagFromRILandRP OverallBeisTrp ON por.BEISTargetRiskProbabilityID = OverallBeisTrp.RPID and por.BEISTargetRiskImpactLevelID = OverallBeisTrp.RILID LEFT OUTER JOIN

	reports.RagFromRILandRP OverallUrp ON por.UnmitigatedRiskProbabilityID = OverallUrp.RPID and por.UnmitigatedRiskImpactLevelID = OverallUrp.RILID LEFT OUTER JOIN
	reports.RagFromRILandRP OverallTrp ON por.TargetRiskProbabilityID = OverallTrp.RPID and por.TargetRiskImpactLevelID = OverallTrp.RILID LEFT OUTER JOIN
	dbo.PartnerOrganisationRiskRiskTypes AS riskrt ON por.ID = riskrt.PartnerOrganisationRiskID LEFT OUTER JOIN 
	RiskTypesForRisk AS poRiskTypes ON por.ID = poRiskTypes.PartnerOrganisationRiskID
