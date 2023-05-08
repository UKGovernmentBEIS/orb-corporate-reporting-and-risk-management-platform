CREATE VIEW [reports].[WorkStreamUpdates]
AS
	SELECT dbo.WorkStreamUpdates.ID AS [Work Stream Update ID]
		, dbo.WorkStreamUpdates.SignOffID AS [SignOff ID]
		, dbo.Groups.Title AS [Group]
		, dbo.Directorates.Title AS [Directorate]
		, dbo.Projects.Title AS [Project]
		, dbo.SignOffs.ReportMonth AS [Report Month]
		, dbo.WorkStreams.ID AS [Work Stream ID]
		, dbo.WorkStreams.Title AS [Work Stream]
		, dbo.WorkStreamUpdates.Comment AS [Progress Update]
		, dbo.PreviousWorkStreamUpdates.PreviousRAG AS [Previous RAG]
		, dbo.PreviousWorkStreamUpdates.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - dbo.PreviousWorkStreamUpdates.PreviousRAGScore AS [RAG Change]
		, LeadUser.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(dbo.WorkStreamUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE dbo.WorkStreamUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Work Stream Closed]
		, es.Title AS [Status]
	FROM dbo.SignOffs LEFT OUTER JOIN
		dbo.WorkStreamUpdates ON dbo.SignOffs.ID = dbo.WorkStreamUpdates.SignOffID INNER JOIN
		dbo.WorkStreams ON dbo.WorkStreamUpdates.WorkStreamID = dbo.WorkStreams.ID INNER JOIN
		dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID AND dbo.WorkStreams.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
		dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON dbo.WorkStreams.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.Users AS LeadUser ON dbo.WorkStreams.LeadUserID = LeadUser.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON dbo.WorkStreamUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.WorkStreamUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.PreviousWorkStreamUpdates ON dbo.WorkStreams.ID = dbo.PreviousWorkStreamUpdates.ID AND dbo.SignOffs.ReportMonth = dbo.PreviousWorkStreamUpdates.NextMonth
	WHERE   (dbo.SignOffs.IsCurrent = 1)