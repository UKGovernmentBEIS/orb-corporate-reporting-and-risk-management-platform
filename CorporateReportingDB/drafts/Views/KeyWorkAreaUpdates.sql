CREATE VIEW [drafts].[KeyWorkAreaUpdates]
AS
  SELECT ku.ID AS [Key Work Area Update ID]
			, g.Title AS [Group]
			, d.Title AS [Directorate]
			, ku.UpdatePeriod AS [Report Month]
			, ku.KeyWorkAreaID AS [Key Work Area ID]
			, k.Title AS [Key Work Area]
			, ku.Comment AS [Progress Update]
			, pku.PreviousRAG AS [Previous RAG]
			, pku.PreviousRAGScore AS [Previous RAG Score]
			, dbo.RagOptions.ReportName AS [Current RAG]
			, dbo.RagOptions.Score AS [Current RAG Score]
			, dbo.RagOptions.Score - pku.PreviousRAGScore AS [RAG Change]
			, LeadUser.Title AS [Lead]
			, UpdateAuthor.Title AS [Author]
			, CAST(ku.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			, CASE ku.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Key Work Area Closed]
			, es.Title AS [Status]
  FROM (SELECT MAX(ID) AS CurrentDraftID
      , KeyWorkAreaID
      , UpdatePeriod
    FROM [dbo].[KeyWorkAreaUpdates]
    GROUP BY KeyWorkAreaID, UpdatePeriod) AS currentDraft INNER JOIN
    dbo.KeyWorkAreaUpdates AS ku ON currentDraft.CurrentDraftID = ku.ID INNER JOIN
    dbo.KeyWorkAreas AS k ON ku.KeyWorkAreaID = k.ID INNER JOIN
    dbo.Directorates AS d ON k.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON k.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON ku.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON ku.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON k.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.PreviousKeyWorkAreaUpdates AS pku ON k.ID = pku.ID AND ku.UpdatePeriod = pku.NextMonth
