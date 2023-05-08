CREATE VIEW [dbo].[PreviousKeyWorkAreaUpdates]
AS
	SELECT dbo.KeyWorkAreas.ID
			, nextso.ReportMonth AS [NextMonth]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.KeyWorkAreas INNER JOIN
		dbo.KeyWorkAreaUpdates ON dbo.KeyWorkAreas.ID = dbo.KeyWorkAreaUpdates.KeyWorkAreaID INNER JOIN
		dbo.SignOffs AS so ON dbo.KeyWorkAreaUpdates.SignOffID = so.ID INNER JOIN
		dbo.RagOptions ON dbo.KeyWorkAreaUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.DirectorateID = nextso.DirectorateID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE DirectorateID = so.DirectorateID AND ReportMonth > so.ReportMonth AND IsCurrent = 1)
	WHERE so.IsCurrent = 1