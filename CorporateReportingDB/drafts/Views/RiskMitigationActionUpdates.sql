CREATE VIEW [drafts].[RiskMitigationActionUpdates]
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
	, rmau.ID AS [Risk Mitigation Action Update ID]
	, r.ID AS [Risk ID]
	, rma.ID AS [Risk Mitigation Action ID]
	, r.Title AS [Risk Name]
	, riskTypes.RiskTypes AS [Risk Type]
	, rma.Title AS [Mitigation Action]
	, rma.Description AS [Description]
	, rma.BaselineDate AS [Baseline Date]
	, ISNULL(rma.ActualDate, rma.ForecastDate) AS [Delivery Date]
	, CASE
		WHEN rma.ActionIsOngoing = 'true' THEN 'Yes'
		ELSE 'No'
	 END AS [Is Ongoing]
	, rmao.Title AS [Action Owner]
	, rmau.UpdatePeriod AS [Report Month]
	, ro.ReportName AS [RAG Status]
	, ro.Score AS [RAG Score] 
	, RiskMitigationActionsLastMonth.[RAG Status] AS [Previous RAG Status]
	, RiskMitigationActionsLastMonth.[RAG Score] AS [Previous RAG Score]
	, ro.Score - RiskMitigationActionsLastMonth.[RAG Score] AS [RAG Change] 
	, rmau.Comment AS [Progress]
	, rmauu.Title AS [Last Updated by]
	, es.Title AS [Status]
	, CAST(rmau.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
  FROM dbo.RiskMitigationActionUpdates AS rmau LEFT OUTER JOIN
    (SELECT MAX(ID) AS CurrentDraftID
      , RiskMitigationActionID
      , UpdatePeriod
    FROM [dbo].[RiskMitigationActionUpdates]
    GROUP BY RiskMitigationActionID, UpdatePeriod) AS currentDraft ON rmau.ID = currentDraft.CurrentDraftID LEFT OUTER JOIN
    dbo.RiskMitigationActions AS rma ON rmau.RiskMitigationActionID = rma.ID LEFT OUTER JOIN
    dbo.Risks AS r ON r.ID = rma.RiskID LEFT OUTER JOIN
    dbo.Directorates AS dir ON r.DirectorateID = dir.ID LEFT OUTER JOIN
    dbo.Groups AS gr ON dir.GroupID = gr.ID LEFT OUTER JOIN
    dbo.Users AS rmao ON rmao.ID = rma.OwnerUserID LEFT OUTER JOIN
    dbo.Users AS rmauu ON rmauu.ID = rmau.UpdateUserID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON es.ID = rma.EntityStatusID LEFT OUTER JOIN
    dbo.RagOptions AS ro ON ro.ID = rmau.RagOptionID LEFT OUTER JOIN
    RiskTypesForRisk AS riskTypes ON r.ID = riskTypes.RiskID LEFT OUTER JOIN
    (SELECT rmau.RiskMitigationActionID AS [RiskMitigationActionID]
		, EOMONTH(DATEADD(MONTH, 1, rmau.UpdatePeriod)) AS [NextMonth]
		, ro.ReportName AS [RAG status]
		, ro.Score AS [RAG Score]
    FROM dbo.RiskMitigationActionUpdates AS rmau LEFT OUTER JOIN
      dbo.SignOffs AS so ON rmau.SignOffID = so.ID LEFT OUTER JOIN
      dbo.RiskMitigationActions AS rma ON rma.ID = rmau.RiskMitigationActionID LEFT OUTER JOIN
      dbo.RagOptions ro ON ro.ID = rmau.RagOptionID
    WHERE so.IsCurrent = 1) AS RiskMitigationActionsLastMonth ON rmau.RiskMitigationActionID = RiskMitigationActionsLastMonth.RiskMitigationActionID
      AND rmau.UpdatePeriod = RiskMitigationActionsLastMonth.NextMonth
  WHERE
  r.Discriminator = 'CorporateRisk'