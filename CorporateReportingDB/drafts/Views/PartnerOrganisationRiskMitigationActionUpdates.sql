CREATE VIEW [drafts].[PartnerOrganisationRiskMitigationActionUpdates]
AS
  WITH
    RiskTypesForRisk
    AS
    (
      SELECT por.ID AS PartnerOrganisationRiskID, STRING_AGG(rt.Title, ',') WITHIN GROUP (ORDER BY rt.Title) AS RiskTypes
      FROM dbo.PartnerOrganisationRisks por
        JOIN dbo.PartnerOrganisationRiskRiskTypes porrt ON porrt.PartnerOrganisationRiskID = por.ID
        JOIN dbo.RiskTypes rt ON rt.ID = porrt.RiskTypeID
      GROUP BY por.ID
    )
  SELECT rmau.ID AS [Risk Mitigation Action Update ID]
	, po.Title AS [Partner Organisation]
	, d.Title AS [Directorate] 
	, g.Title AS [Group] 
	, r.ID AS [Risk ID]
	, rma.ID AS [Risk Mitigation Action ID]
	, r.Title AS [Risk Name]
	, poRiskTypes.RiskTypes AS [Risk Type] 
	, rma.Title AS [Mitigation Action]
	, rma.Description AS [Description]
	, ISNULL(rma.ActualDate, rma.ForecastDate) AS [Delivery Date]
	, CASE
		WHEN rma.ActionIsOngoing = 'true' THEN 'Yes'
		ELSE 'No'
	 END AS [Is ongoing]
	, rmao.Title AS [Action Owner]
	, rmau.UpdatePeriod AS [Report Month]
	, ro.ReportName AS [RAG Status]
	, ro.Score AS [RAG Score]
	, PartnerOrganisationRiskMitigationActionsLastMonth.[RAG Status] AS [Previous RAG Status]
	, PartnerOrganisationRiskMitigationActionsLastMonth.[RAG Score] AS [Previous RAG Score] 
	, (ro.Score - PartnerOrganisationRiskMitigationActionsLastMonth.[RAG Score]) AS [RAG Change] 
	, rmau.Comment AS [Progress]
	, rmauu.Title AS [Last Updated by]
	, es.Title AS [Status]
	, CAST(ru.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]

  FROM dbo.PartnerOrganisationRiskMitigationActionUpdates AS rmau LEFT OUTER JOIN
    dbo.PartnerOrganisationRiskMitigationActions AS rma ON rmau.PartnerOrganisationRiskMitigationActionID = rma.ID LEFT OUTER JOIN
    dbo.PartnerOrganisationRiskUpdates AS ru ON rma.PartnerOrganisationRiskID = ru.PartnerOrganisationRiskID LEFT OUTER JOIN
    dbo.PartnerOrganisationRisks AS r ON r.ID = rma.PartnerOrganisationRiskID LEFT OUTER JOIN
    dbo.PartnerOrganisations AS po ON r.PartnerOrganisationID = po.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON po.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users rmao ON rmao.ID = rma.OwnerUserID LEFT OUTER JOIN
    dbo.Users rmauu ON rmauu.ID = rmau.UpdateUserID LEFT OUTER JOIN
    dbo.EntityStatuses es ON es.ID = rma.EntityStatusID LEFT OUTER JOIN
    dbo.RagOptions ro ON ro.ID = rmau.RagOptionID LEFT OUTER JOIN
    RiskTypesForRisk AS poRiskTypes ON r.ID = poRiskTypes.PartnerOrganisationRiskID LEFT OUTER JOIN
    (SELECT rmau.PartnerOrganisationRiskMitigationActionID AS [PartnerOrganisationRiskMitigationActionID]
		, EOMONTH(DATEADD(MONTH, 1, rmau.UpdatePeriod)) AS [NextMonth]
		, ro.ReportName AS [RAG status]
		, ro.Score AS [RAG Score]
    FROM dbo.PartnerOrganisationRiskMitigationActionUpdates AS rmau LEFT OUTER JOIN
      dbo.PartnerOrganisationRiskUpdates AS ru ON ru.SignOffID = rmau.SignOffID LEFT OUTER JOIN
      dbo.PartnerOrganisationRiskMitigationActions AS rma ON rma.ID = rmau.PartnerOrganisationRiskMitigationActionID LEFT OUTER JOIN
      dbo.RagOptions ro ON ro.ID = rmau.RagOptionID
    WHERE ru.IsCurrent = 1) AS PartnerOrganisationRiskMitigationActionsLastMonth ON rmau.PartnerOrganisationRiskMitigationActionID = PartnerOrganisationRiskMitigationActionsLastMonth.PartnerOrganisationRiskMitigationActionID
      AND rmau.UpdatePeriod = PartnerOrganisationRiskMitigationActionsLastMonth.NextMonth
  WHERE	ru.IsCurrent = 1