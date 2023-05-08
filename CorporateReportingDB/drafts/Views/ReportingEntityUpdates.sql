CREATE VIEW [drafts].[ReportingEntityUpdates]
AS
  SELECT
    g.Title AS [Group]
    , d.Title AS [Directorate]
    , p.Title AS [Project]
    , po.Title AS [Partner organisation]
    , ru.UpdatePeriod AS [Report period]
    , rt.Title AS [Reporting entity type]
    , r.ID AS [Reporting entity ID]
    , r.Title AS [Reporting entity]
    , ru.Comment AS [Progress update]
    , rag.ReportName AS [Current RAG]
    , rag.Score AS [Current RAG score]
    , ru.CurrentPerformance AS [Current performance]
    , CAST(ru.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast delivery date]
    , CAST(ru.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual delivery date]
    , LeadUser.Title AS [Lead]
    , UpdateAuthor.Title AS [Update author]
    , CAST(ru.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last edited date]
    , CASE ru.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Reporting entity closed]
    , es.Title AS [Status]
  FROM (SELECT MAX(ID) AS CurrentDraftID
      , ReportingEntityID
      , UpdatePeriod
    FROM [dbo].[ReportingEntityUpdates]
    GROUP BY ReportingEntityID, UpdatePeriod) AS currentDraft INNER JOIN
    dbo.ReportingEntityUpdates AS ru ON currentDraft.CurrentDraftID = ru.ID LEFT OUTER JOIN
    dbo.ReportingEntities AS r ON ru.ReportingEntityID = r.ID LEFT OUTER JOIN
    dbo.ReportingEntityTypes AS rt ON r.ReportingEntityTypeID = rt.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON r.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Projects AS p ON r.ProjectID = p.ID LEFT OUTER JOIN
    dbo.PartnerOrganisations AS po ON r.PartnerOrganisationID = po.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON r.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON ru.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions AS rag ON ru.RagOptionID = rag.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON r.EntityStatusID = es.ID;