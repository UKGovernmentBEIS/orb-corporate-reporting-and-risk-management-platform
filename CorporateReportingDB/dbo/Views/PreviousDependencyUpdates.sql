CREATE VIEW [dbo].[PreviousDependencyUpdates]
AS
	SELECT dbo.DependencyUpdates.DependencyID AS [DependencyID]
		, nextso.ReportMonth AS [NextMonth]
		, dbo.RagOptions.ReportName AS [PreviousRAG]
		, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.DependencyUpdates ON so.ID = dbo.DependencyUpdates.SignOffID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.DependencyUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.ProjectID = nextso.ProjectID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE ProjectID = so.ProjectID AND ReportMonth > so.ReportMonth AND IsCurrent = 1)
	WHERE so.IsCurrent = 1