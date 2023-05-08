CREATE VIEW [reports].[KeyWorkAreaUpdates]
AS
	SELECT dbo.KeyWorkAreaUpdates.ID AS [Key Work Area Update ID]
			, dbo.KeyWorkAreaUpdates.SignOffID AS [SignOff ID]
			, dbo.Groups.Title AS [Group]
			, dbo.Directorates.Title AS [Directorate]
			, dbo.SignOffs.ReportMonth AS [Report Month]
			, dbo.KeyWorkAreaUpdates.KeyWorkAreaID AS [Key Work Area ID]
			, dbo.KeyWorkAreas.Title AS [Key Work Area]
			, dbo.KeyWorkAreaUpdates.Comment AS [Progress Update]
			, dbo.PreviousKeyWorkAreaUpdates.PreviousRAG AS [Previous RAG]
			, dbo.PreviousKeyWorkAreaUpdates.PreviousRAGScore AS [Previous RAG Score]
			, dbo.RagOptions.ReportName AS [Current RAG]
			, dbo.RagOptions.Score AS [Current RAG Score]
			, dbo.RagOptions.Score - dbo.PreviousKeyWorkAreaUpdates.PreviousRAGScore AS [RAG Change]
			, LeadUser.Title AS [Lead]
			, UpdateAuthor.Title AS [Author]
			, CAST(dbo.KeyWorkAreaUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			, CASE dbo.KeyWorkAreaUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Key Work Area Closed]
			, es.Title AS [Status]
	FROM dbo.SignOffs LEFT OUTER JOIN
		dbo.KeyWorkAreaUpdates ON dbo.SignOffs.ID = dbo.KeyWorkAreaUpdates.SignOffID INNER JOIN
		dbo.KeyWorkAreas ON dbo.KeyWorkAreaUpdates.KeyWorkAreaID = dbo.KeyWorkAreas.ID INNER JOIN
		dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID AND dbo.KeyWorkAreas.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
		dbo.Users AS LeadUser ON dbo.KeyWorkAreas.LeadUserID = LeadUser.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON dbo.KeyWorkAreaUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.KeyWorkAreaUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON dbo.KeyWorkAreas.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.PreviousKeyWorkAreaUpdates ON dbo.KeyWorkAreas.ID = dbo.PreviousKeyWorkAreaUpdates.ID AND dbo.SignOffs.ReportMonth = dbo.PreviousKeyWorkAreaUpdates.NextMonth
	WHERE        (dbo.SignOffs.IsCurrent = 1)