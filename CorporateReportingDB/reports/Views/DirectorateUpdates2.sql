CREATE VIEW [reports].[DirectorateUpdates2]
AS
	SELECT
		reports.[Group] AS [Group]
		, d.Title AS [Directorate]
		, d.ID AS [ID]
		, Months.ReportMonth AS [Report Month]
		, reports.Director AS [Director]
		, reports.DirectorateUpdateAuthor AS [Author]
		, SignOffUser.Title AS [Signed-off by]
		, so.ID AS [SignOff ID]
		, reports.DirectorateStatus AS [Status] 
		, CAST(so.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Date Signed-off]
		, CAST(reports.DirectorateUpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, reports.Objectives AS [Objectives]
		, reports.ProgressUpdate AS [Delivery Confidence Update]
		, reports.FutureActions AS [Future Actions Update]
		, reports.Escalations AS [Escalations Update]

		, reports.OverallRAG AS [Delivery Confidence RAG]
		, reports.FinanceRAG AS [Finance RAG]
		, reports.MilestonesRAG AS [Milestones RAG]
		, reports.MetricsRAG AS [Metrics RAG]
		, reports.PeopleRAG AS [People RAG]

		, reports.OverallRAGScore AS [Delivery Confidence RAG Score]
		, reports.FinanceRAGScore AS [Finance RAG Score]
		, reports.MilestonesRAGScore AS [Milestones RAG Score]
		, reports.MetricsRAGScore AS [Metrics RAG Score]
		, reports.PeopleRAGScore AS [People RAG Score]

		, reports.FinanceComment AS [Finance Update]
		, reports.MilestonesComment AS [Milestones Update]
		, reports.MetricsComment AS [Metrics Update]
		, reports.PeopleComment AS [People Update]

		, (reports.OverallRAGScore - pdu.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (reports.FinanceRAGScore - pdu.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (reports.MilestonesRAGScore - pdu.PreviousMilestonesRAGScore) AS [Milestones RAG Change]
		, (reports.MetricsRAGScore - pdu.PreviousMetricsRAGScore) AS [Metrics RAG Change]
		, (reports.PeopleRAGScore - pdu.PreviousPeopleRAGScore) AS [People RAG Change]
	FROM dbo.Directorates AS d CROSS JOIN
        (SELECT DISTINCT dbo.SignOffs.ReportMonth
		FROM dbo.SignOffs
		WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months LEFT OUTER JOIN
		dbo.SignOffs AS so ON so.DirectorateID = d.ID AND so.ReportMonth = Months.ReportMonth AND so.IsCurrent = 1 LEFT OUTER JOIN
		dbo.DirectorateReports AS reports ON reports.SignOffID = so.ID LEFT OUTER JOIN
		dbo.PreviousDirectorateUpdates AS pdu ON reports.DirectorateID = pdu.DirectorateID AND Months.ReportMonth = pdu.NextMonth LEFT OUTER JOIN
		dbo.Users AS SignOffUser ON so.SignOffUserID = SignOffUser.ID
