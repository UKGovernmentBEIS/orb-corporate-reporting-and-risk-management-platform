CREATE VIEW [reports].[DirectorateUpdates]
AS
	SELECT dbo.Groups.Title AS [Group]
		, dbo.Directorates.Title AS [Directorate]
		, dbo.Directorates.ID AS [ID]
		, Months.ReportMonth AS [Report Month]
		, DirectorUser.Title AS [Director]
		, UpdateAuthor.Title AS [Author]
		, SignOffUser.Title AS [Signed-off by]
		, dbo.SignOffs.ID AS [SignOff ID]
		, es.Title AS [Status] 
		, CAST(dbo.SignOffs.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Date Signed-off]
		, CAST(dbo.DirectorateUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, dbo.Directorates.Objectives AS [Objectives]
		, dbo.DirectorateUpdates.ProgressUpdate AS [Delivery Confidence Update]
		, dbo.DirectorateUpdates.FutureActions AS [Future Actions Update]
		, dbo.DirectorateUpdates.Escalations AS [Escalations Update]

		, dbo.PreviousDirectorateUpdates.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, dbo.PreviousDirectorateUpdates.PreviousFinanceRAG AS [Previous Finance RAG]
		, dbo.PreviousDirectorateUpdates.PreviousMilestonesRAG AS [Previous Milestones RAG]
		, dbo.PreviousDirectorateUpdates.PreviousMetricsRAG AS [Previous Metrics RAG]
		, dbo.PreviousDirectorateUpdates.PreviousPeopleRAG AS [Previous People RAG]

		, dbo.PreviousDirectorateUpdates.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score]
		, dbo.PreviousDirectorateUpdates.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, dbo.PreviousDirectorateUpdates.PreviousMilestonesRAGScore AS [Previous Milestones RAG Score]
		, dbo.PreviousDirectorateUpdates.PreviousMetricsRAGScore AS [Previous Metrics RAG Score]
		, dbo.PreviousDirectorateUpdates.PreviousPeopleRAGScore AS [Previous People RAG Score]

		, OverallRAG.ReportName AS [Delivery Confidence RAG]
		, FinanceRAG.ReportName AS [Finance RAG]
		, MilestonesRAG.ReportName AS [Milestones RAG]
		, MetricsRAG.ReportName AS [Metrics RAG]
		, PeopleRAG.ReportName AS [People RAG]

		, OverallRAG.Score AS [Delivery Confidence RAG Score]
		, FinanceRAG.Score AS [Finance RAG Score]
		, MilestonesRAG.Score AS [Milestones RAG Score]
		, MetricsRAG.Score AS [Metrics RAG Score]
		, PeopleRAG.Score AS [People RAG Score]

		, dbo.DirectorateUpdates.FinanceComment AS [Finance Update]
		, dbo.DirectorateUpdates.MilestonesComment AS [Milestones Update]
		, dbo.DirectorateUpdates.MetricsComment AS [Metrics Update]
		, dbo.DirectorateUpdates.PeopleComment AS [People Update]

		, (OverallRAG.Score - dbo.PreviousDirectorateUpdates.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (FinanceRAG.Score - dbo.PreviousDirectorateUpdates.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (MilestonesRAG.Score - dbo.PreviousDirectorateUpdates.PreviousMilestonesRAGScore) AS [Milestones RAG Change]
		, (MetricsRAG.Score - dbo.PreviousDirectorateUpdates.PreviousMetricsRAGScore) AS [Metrics RAG Change]
		, (PeopleRAG.Score - dbo.PreviousDirectorateUpdates.PreviousPeopleRAGScore) AS [People RAG Change]

	FROM dbo.Directorates CROSS JOIN
           (SELECT DISTINCT dbo.SignOffs.ReportMonth
		FROM dbo.SignOffs
		WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months LEFT OUTER JOIN
		dbo.SignOffs ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID AND dbo.SignOffs.ReportMonth = Months.ReportMonth AND dbo.SignOffs.IsCurrent = 1 LEFT OUTER JOIN
		dbo.DirectorateUpdates ON dbo.DirectorateUpdates.DirectorateID = dbo.SignOffs.DirectorateID AND dbo.DirectorateUpdates.SignOffID = dbo.SignOffs.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON dbo.Directorates.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.RagOptions AS OverallRAG ON dbo.DirectorateUpdates.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON dbo.DirectorateUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON dbo.DirectorateUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON dbo.DirectorateUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MetricsRAG ON dbo.DirectorateUpdates.MetricsRagOptionID = MetricsRAG.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON dbo.DirectorateUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.Users AS DirectorUser ON dbo.Directorates.DirectorUserID = DirectorUser.ID LEFT OUTER JOIN
		dbo.Users AS SignOffUser ON dbo.SignOffs.SignOffUserID = SignOffUser.ID LEFT OUTER JOIN
		dbo.PreviousDirectorateUpdates ON dbo.Directorates.ID = dbo.PreviousDirectorateUpdates.DirectorateID AND Months.ReportMonth = dbo.PreviousDirectorateUpdates.NextMonth
