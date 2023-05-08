CREATE VIEW [dbo].[PreviousBenefitUpdates]
AS
	SELECT DISTINCT dbo.Benefits.ID AS [BenefitID]
			, nextso.ReportMonth AS [NextMonth]
			, nextbu.UpdatePeriod AS [NextBenefitUpdate]
			, bu.CurrentPerformance AS [PreviousPerformance]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.BenefitUpdates AS bu ON so.ID = bu.SignOffID INNER JOIN
		dbo.Benefits ON bu.BenefitID = dbo.Benefits.ID LEFT OUTER JOIN
		dbo.RagOptions ON bu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.ProjectID = nextso.ProjectID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE ProjectID = so.ProjectID AND ReportMonth > so.ReportMonth AND IsCurrent = 1) LEFT OUTER JOIN
		dbo.BenefitUpdates AS nextbu ON bu.BenefitID = nextbu.BenefitID AND nextbu.UpdatePeriod = 
			(SELECT MIN(UpdatePeriod)
			FROM BenefitUpdates INNER JOIN
				SignOffs ON BenefitUpdates.SignOffID = SignOffs.ID
			WHERE BenefitID = bu.BenefitID AND UpdatePeriod > bu.UpdatePeriod AND SignOffs.IsCurrent = 1)
	WHERE so.IsCurrent = 1