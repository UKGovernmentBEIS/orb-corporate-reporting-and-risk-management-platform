CREATE VIEW [dbo].[PreviousCommitmentUpdates]
AS
	SELECT dbo.CommitmentUpdates.CommitmentID AS [CommitmentID]
			, nextso.ReportMonth AS [NextMonth]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.CommitmentUpdates ON so.ID = dbo.CommitmentUpdates.SignOffID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.CommitmentUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.DirectorateID = nextso.DirectorateID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE DirectorateID = so.DirectorateID AND ReportMonth > so.ReportMonth AND IsCurrent = 1)
	WHERE so.IsCurrent = 1