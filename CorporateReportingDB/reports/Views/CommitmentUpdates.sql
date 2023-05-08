CREATE VIEW [reports].[CommitmentUpdates]
AS
	SELECT dbo.CommitmentUpdates.ID AS [Commitment Update ID]
			, dbo.SignOffs.ID AS [SignOff ID]
			, dbo.Groups.Title AS [Group]
			, dbo.Directorates.Title AS [Directorate]
			, dbo.SignOffs.ReportMonth AS [Report Month]
			, dbo.Commitments.ID AS [Commitment ID]
			, dbo.Commitments.Title AS [Commitment]
			, dbo.CommitmentUpdates.Comment AS [Progress Update]
			, dbo.Commitments.BaselineDate AS [Baseline]
			, dbo.CommitmentUpdates.ForecastDate AS [Forecast]
			, dbo.CommitmentUpdates.ActualDate AS [Actual]
			, dbo.PreviousCommitmentUpdates.PreviousRAG AS [Previous RAG]
			, dbo.PreviousCommitmentUpdates.PreviousRAGScore AS [Previous RAG Score]
			, dbo.RagOptions.ReportName AS [Current RAG]
			, dbo.RagOptions.Score AS [Current RAG Score]
			, dbo.RagOptions.Score - dbo.PreviousCommitmentUpdates.PreviousRAGScore AS [RAG Change]
			, LeadUser.Title AS [Lead]
			, UpdateAuthor.Title AS [Author]
			, CAST(dbo.CommitmentUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			, CASE dbo.CommitmentUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Commitment Closed]
			, es.Title AS [Status]
	FROM dbo.Commitments LEFT OUTER JOIN
		dbo.CommitmentUpdates ON dbo.CommitmentUpdates.SignOffID IS NOT NULL AND dbo.Commitments.ID = dbo.CommitmentUpdates.CommitmentID INNER JOIN
		dbo.SignOffs ON dbo.CommitmentUpdates.SignOffID = dbo.SignOffs.ID LEFT OUTER JOIN
		dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
		dbo.Users AS LeadUser ON dbo.Commitments.LeadUserID = LeadUser.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON dbo.CommitmentUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.CommitmentUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON dbo.Commitments.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.PreviousCommitmentUpdates ON dbo.Commitments.ID = dbo.PreviousCommitmentUpdates.CommitmentID AND dbo.SignOffs.ReportMonth = dbo.PreviousCommitmentUpdates.NextMonth
	WHERE (dbo.SignOffs.IsCurrent = 1)