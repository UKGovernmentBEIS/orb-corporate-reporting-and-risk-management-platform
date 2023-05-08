CREATE VIEW [drafts].[CommitmentUpdates]
AS
  SELECT cu.ID AS [Commitment Update ID]
			, g.Title AS [Group]
			, d.Title AS [Directorate]
			, cu.UpdatePeriod AS [Report Month]
			, c.ID AS [Commitment ID]
			, c.Title AS [Commitment]
			, cu.Comment AS [Progress Update]
			, c.BaselineDate AS [Baseline]
			, cu.ForecastDate AS [Forecast]
			, cu.ActualDate AS [Actual]
			, pcu.PreviousRAG AS [Previous RAG]
			, pcu.PreviousRAGScore AS [Previous RAG Score]
			, dbo.RagOptions.ReportName AS [Current RAG]
			, dbo.RagOptions.Score AS [Current RAG Score]
			, dbo.RagOptions.Score - pcu.PreviousRAGScore AS [RAG Change]
			, LeadUser.Title AS [Lead]
			, UpdateAuthor.Title AS [Author]
			, CAST(cu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			, CASE cu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Commitment Closed]
			, es.Title AS [Status]
  FROM dbo.Commitments AS c LEFT OUTER JOIN
    dbo.CommitmentUpdates AS cu ON c.ID = cu.CommitmentID INNER JOIN
    (SELECT MAX(ID) AS CurrentDraftID
    FROM [dbo].[CommitmentUpdates]
    GROUP BY CommitmentID, UpdatePeriod) AS currentDraft ON cu.ID = currentDraft.CurrentDraftID LEFT OUTER JOIN
    dbo.Directorates AS d ON c.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON c.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON cu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON cu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON c.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.PreviousCommitmentUpdates AS pcu ON c.ID = pcu.CommitmentID AND cu.UpdatePeriod = pcu.NextMonth;