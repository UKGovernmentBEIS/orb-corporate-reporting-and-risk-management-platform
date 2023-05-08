CREATE VIEW [dbo].[PreviousWorkStreamUpdates]
AS
	SELECT dbo.WorkStreams.ID
			, nextso.ReportMonth AS [NextMonth]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.WorkStreamUpdates ON so.ID = dbo.WorkStreamUpdates.SignOffID INNER JOIN
		dbo.WorkStreams ON dbo.WorkStreamUpdates.WorkStreamID = dbo.WorkStreams.ID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.WorkStreamUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.ProjectID = nextso.ProjectID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE ProjectID = so.ProjectID AND ReportMonth > so.ReportMonth AND IsCurrent = 1)
	WHERE so.IsCurrent = 1