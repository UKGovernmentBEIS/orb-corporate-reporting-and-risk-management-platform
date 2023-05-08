CREATE VIEW [reports].[DependencyUpdates]
AS
	SELECT dbo.DependencyUpdates.ID AS [Dependency Update ID]
		, dbo.SignOffs.ID AS [SignOff ID]
		, dbo.Groups.Title AS [Group]
		, dbo.Directorates.Title AS [Directorate]
		, dbo.Projects.Title AS [Project]
		, dbo.SignOffs.ReportMonth AS [Report Month]
		, dbo.Dependencies.ThirdParty AS [Name of third party]
		, dbo.Dependencies.ID AS [Dependency ID]
		, dbo.Dependencies.Title AS [Dependency]
		, dbo.DependencyUpdates.Comment AS [Progress Update]
		, CAST(dbo.Dependencies.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
		, CAST(dbo.DependencyUpdates.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
		, CAST(dbo.DependencyUpdates.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
		, dbo.PreviousDependencyUpdates.PreviousRAG AS [Previous RAG]
		, dbo.PreviousDependencyUpdates.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - dbo.PreviousDependencyUpdates.PreviousRAGScore AS [RAG Change]
		, dbo.Users.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(dbo.DependencyUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE dbo.DependencyUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Dependency Closed]
		, es.Title AS [Status]
	FROM dbo.SignOffs LEFT OUTER JOIN
		dbo.DependencyUpdates ON dbo.SignOffs.ID = dbo.DependencyUpdates.SignOffID INNER JOIN
		dbo.Dependencies ON dbo.DependencyUpdates.DependencyID = dbo.Dependencies.ID INNER JOIN
		dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID AND dbo.Dependencies.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
		dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
		dbo.Users ON dbo.Dependencies.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON dbo.DependencyUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.DependencyUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON dbo.Dependencies.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.PreviousDependencyUpdates ON dbo.Dependencies.ID = dbo.PreviousDependencyUpdates.DependencyID AND dbo.SignOffs.ReportMonth = dbo.PreviousDependencyUpdates.NextMonth
	WHERE		(dbo.SignOffs.IsCurrent = 1)