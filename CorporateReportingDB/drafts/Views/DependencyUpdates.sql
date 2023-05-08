CREATE VIEW [drafts].[DependencyUpdates]
AS
  SELECT du.ID AS [Dependency Update ID]
		, g.Title AS [Group]
		, dir.Title AS [Directorate]
		, p.Title AS [Project]
		, du.UpdatePeriod AS [Report Month]
		, d.ThirdParty AS [Name of third party]
		, d.ID AS [Dependency ID]
		, d.Title AS [Dependency]
		, du.Comment AS [Progress Update]
		, CAST(d.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
		, CAST(du.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
		, CAST(du.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
		, pdu.PreviousRAG AS [Previous RAG]
		, pdu.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - pdu.PreviousRAGScore AS [RAG Change]
		, LeadUser.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(du.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE du.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Dependency Closed]
		, es.Title AS [Status]
  FROM (SELECT MAX(ID) AS CurrentDraftID
    FROM [dbo].[DependencyUpdates]
    GROUP BY DependencyID, UpdatePeriod) AS currentDraft INNER JOIN
    dbo.DependencyUpdates AS du ON currentDraft.CurrentDraftID = du.ID INNER JOIN
    dbo.Dependencies AS d ON du.DependencyID = d.ID INNER JOIN
    dbo.Projects AS p ON d.ProjectID = p.ID LEFT OUTER JOIN
    dbo.Directorates AS dir ON p.DirectorateID = dir.ID LEFT OUTER JOIN
    dbo.Groups AS g ON dir.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON d.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON du.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON du.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON d.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.PreviousDependencyUpdates AS pdu ON d.ID = pdu.DependencyID AND du.UpdatePeriod = pdu.NextMonth;