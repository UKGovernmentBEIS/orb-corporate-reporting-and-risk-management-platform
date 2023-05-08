CREATE VIEW [drafts].[WorkStreamUpdates]
AS
  SELECT wu.ID AS [Work Stream Update ID]
		, g.Title AS [Group]
		, d.Title AS [Directorate]
		, p.Title AS [Project]
		, wu.UpdatePeriod AS [Report Month]
		, w.ID AS [Work Stream ID]
		, w.Title AS [Work Stream]
		, wu.Comment AS [Progress Update]
		, pwu.PreviousRAG AS [Previous RAG]
		, pwu.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - pwu.PreviousRAGScore AS [RAG Change]
		, LeadUser.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(wu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE wu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Work Stream Closed]
		, es.Title AS [Status]
  FROM (SELECT MAX(ID) AS CurrentDraftID
      , WorkStreamID
      , UpdatePeriod
    FROM [dbo].[WorkStreamUpdates]
    GROUP BY WorkStreamID, UpdatePeriod) AS currentDraft INNER JOIN
    dbo.WorkStreamUpdates AS wu ON currentDraft.CurrentDraftID = wu.ID INNER JOIN
    dbo.WorkStreams AS w ON wu.WorkStreamID = w.ID INNER JOIN
    dbo.Projects AS p ON w.ProjectID = p.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON p.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON w.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON w.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON wu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON wu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.PreviousWorkStreamUpdates AS pwu ON w.ID = pwu.ID AND wu.UpdatePeriod = pwu.NextMonth;