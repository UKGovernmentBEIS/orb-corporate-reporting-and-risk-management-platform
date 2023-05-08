CREATE VIEW [drafts].[DirectorateUpdates]
AS
	SELECT g.Title AS [Group]
		, d.Title AS [Directorate]
		, d.ID AS [Directorate ID]
		, Months.UpdatePeriod AS [Report Month]
		, DirectorUser.Title AS [Director]
		, UpdateAuthor.Title AS [Author]
		, es.Title AS [Status] 
		, CAST(du.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, d.Objectives AS [Objectives]
		, du.ProgressUpdate AS [Delivery Confidence Update]
		, du.FutureActions AS [Future Actions Update]
		, du.Escalations AS [Escalations Update]

		, pdu.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, pdu.PreviousFinanceRAG AS [Previous Finance RAG]
		, pdu.PreviousMilestonesRAG AS [Previous Milestones RAG]
		, pdu.PreviousMetricsRAG AS [Previous Metrics RAG]
		, pdu.PreviousPeopleRAG AS [Previous People RAG]

		, pdu.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score]
		, pdu.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, pdu.PreviousMilestonesRAGScore AS [Previous Milestones RAG Score]
		, pdu.PreviousMetricsRAGScore AS [Previous Metrics RAG Score]
		, pdu.PreviousPeopleRAGScore AS [Previous People RAG Score]

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

		, du.FinanceComment AS [Finance Update]
		, du.MilestonesComment AS [Milestones Update]
		, du.MetricsComment AS [Metrics Update]
		, du.PeopleComment AS [People Update]

		, (OverallRAG.Score - pdu.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (FinanceRAG.Score - pdu.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (MilestonesRAG.Score - pdu.PreviousMilestonesRAGScore) AS [Milestones RAG Change]
		, (MetricsRAG.Score - pdu.PreviousMetricsRAGScore) AS [Metrics RAG Change]
		, (PeopleRAG.Score - pdu.PreviousPeopleRAGScore) AS [People RAG Change]

	FROM dbo.Directorates AS d CROSS JOIN
    (SELECT DISTINCT UpdatePeriod
		FROM dbo.DirectorateUpdates
		WHERE UpdatePeriod IS NOT NULL) AS Months LEFT OUTER JOIN
		dbo.DirectorateUpdates AS du ON d.ID = du.DirectorateID AND Months.UpdatePeriod = du.UpdatePeriod AND du.ID IN
    	(SELECT MAX([ID])
			FROM [dbo].[DirectorateUpdates]
			GROUP BY DirectorateID, UpdatePeriod) LEFT OUTER JOIN
		dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON d.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.RagOptions AS OverallRAG ON du.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON du.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON du.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON du.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MetricsRAG ON du.MetricsRagOptionID = MetricsRAG.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON du.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.Users AS DirectorUser ON d.DirectorUserID = DirectorUser.ID LEFT OUTER JOIN
		dbo.PreviousDirectorateUpdates AS pdu ON d.ID = pdu.DirectorateID AND Months.UpdatePeriod = pdu.NextMonth;