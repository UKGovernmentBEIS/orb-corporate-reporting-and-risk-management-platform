CREATE VIEW [dbo].[PreviousPartnerOrganisationUpdates]
AS
	SELECT so.PartnerOrganisationID 
			, nextso.ReportMonth AS [NextMonth]
			, DeliveryConfidenceRAG.ReportName AS [PreviousDeliveryConfidenceRAG]
			, DeliveryConfidenceRAG.Score AS [PreviousDeliveryConfidenceRAGScore]
			, FinanceRAG.ReportName AS [PreviousFinanceRAG]
			, FinanceRAG.Score AS [PreviousFinanceRAGScore]
			, MilestonesRAG.ReportName AS [PreviousMilestonesRAG]
			, MilestonesRAG.Score AS [PreviousMilestonesRAGScore]
			, KeyPerformanceIndicatorsRAG.ReportName AS [PreviousKeyPerformanceIndicatorRAG]
			, KeyPerformanceIndicatorsRAG.Score AS [PreviousKeyPerformanceIndicatorScore] 
			, PeopleRAG.ReportName AS [PreviousPeopleRAG]
			, PeopleRAG.Score AS [PreviousPeopleRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.PartnerOrganisationUpdates AS pou ON so.ID = pou.SignOffID LEFT OUTER JOIN
		dbo.RagOptions AS DeliveryConfidenceRAG ON pou.OverallRagOptionID = DeliveryConfidenceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON pou.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON pou.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS KeyPerformanceIndicatorsRAG ON pou.KPIRagOptionID = KeyPerformanceIndicatorsRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON pou.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.PartnerOrganisationID = nextso.PartnerOrganisationID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE PartnerOrganisationID = so.PartnerOrganisationID AND ReportMonth > so.ReportMonth AND IsCurrent = 1)
	WHERE so.IsCurrent = 1;