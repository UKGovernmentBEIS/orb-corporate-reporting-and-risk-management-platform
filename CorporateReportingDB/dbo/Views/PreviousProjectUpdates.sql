CREATE VIEW [dbo].[PreviousProjectUpdates]
AS
	SELECT dbo.ProjectUpdates.ProjectID
			, nextso.ReportMonth AS [NextMonth]
			, DeliveryConfidenceRAG.ReportName AS [PreviousDeliveryConfidenceRAG]
			, DeliveryConfidenceRAG.Score AS [PreviousDeliveryConfidenceRAGScore]
			, FinanceRAG.ReportName AS [PreviousFinanceRAG]
			, FinanceRAG.Score AS [PreviousFinanceRAGScore]
			, BenefitsRAG.ReportName AS [PreviousBenefitsRAG]
			, BenefitsRAG.Score AS [PreviousBenefitsRAGScore]
			, MilestonesRAG.ReportName AS [PreviousMilestonesRAG]
			, MilestonesRAG.Score AS [PreviousMilestonesRAGScore]
			, PeopleRAG.ReportName AS [PreviousPeopleRAG]
			, PeopleRAG.Score AS [PreviousPeopleRAGScore]
	FROM dbo.SignOffs INNER JOIN
		dbo.ProjectUpdates ON dbo.SignOffs.ID = dbo.ProjectUpdates.SignOffID LEFT OUTER JOIN
		dbo.RagOptions AS DeliveryConfidenceRAG ON dbo.ProjectUpdates.OverallRagOptionID = DeliveryConfidenceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON dbo.ProjectUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS BenefitsRAG ON dbo.ProjectUpdates.BenefitsRagOptionID = BenefitsRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON dbo.ProjectUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON dbo.ProjectUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND dbo.SignOffs.ProjectID = nextso.ProjectID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE ProjectID = dbo.SignOffs.ProjectID AND ReportMonth > dbo.SignOffs.ReportMonth AND IsCurrent = 1)
	WHERE dbo.SignOffs.IsCurrent = 1