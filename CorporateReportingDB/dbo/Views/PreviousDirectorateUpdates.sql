CREATE VIEW [dbo].[PreviousDirectorateUpdates]
AS
	SELECT dbo.DirectorateUpdates.DirectorateID
			, nextso.ReportMonth AS [NextMonth]
			, DeliveryConfidenceRAG.ReportName AS [PreviousDeliveryConfidenceRAG]
			, DeliveryConfidenceRAG.Score AS [PreviousDeliveryConfidenceRAGScore]
			, FinanceRAG.ReportName AS [PreviousFinanceRAG]
			, FinanceRAG.Score AS [PreviousFinanceRAGScore]
			, MetricsRAG.ReportName AS [PreviousMetricsRAG]
			, MetricsRAG.Score AS [PreviousMetricsRAGScore]
			, MilestonesRAG.ReportName AS [PreviousMilestonesRAG]
			, MilestonesRAG.Score AS [PreviousMilestonesRAGScore]
			, PeopleRAG.ReportName AS [PreviousPeopleRAG]
			, PeopleRAG.Score AS [PreviousPeopleRAGScore]
	FROM dbo.SignOffs INNER JOIN
		dbo.DirectorateUpdates ON dbo.SignOffs.ID = dbo.DirectorateUpdates.SignOffID LEFT OUTER JOIN
		dbo.RagOptions AS DeliveryConfidenceRAG ON dbo.DirectorateUpdates.OverallRagOptionID = DeliveryConfidenceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON dbo.DirectorateUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MetricsRAG ON dbo.DirectorateUpdates.MetricsRagOptionID = MetricsRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON dbo.DirectorateUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON dbo.DirectorateUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND dbo.SignOffs.DirectorateID = nextso.DirectorateID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE DirectorateID = dbo.SignOffs.DirectorateID AND ReportMonth > dbo.SignOffs.ReportMonth AND IsCurrent = 1)
	WHERE dbo.SignOffs.IsCurrent = 1
