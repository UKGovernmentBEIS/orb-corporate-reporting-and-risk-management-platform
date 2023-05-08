CREATE VIEW [dbo].[PreviousMetricUpdates]
AS
	SELECT DISTINCT dbo.Metrics.ID AS [MetricID]
			, nextso.ReportMonth AS [NextMonth]
			, nextbu.UpdatePeriod AS [NextMetricUpdate]
			, bu.CurrentPerformance AS [PreviousPerformance]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.MetricUpdates AS bu ON so.ID = bu.SignOffID INNER JOIN
		dbo.Metrics ON bu.MetricID = dbo.Metrics.ID LEFT OUTER JOIN
		dbo.RagOptions ON bu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.ProjectID = nextso.ProjectID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE ProjectID = so.ProjectID AND ReportMonth > so.ReportMonth AND IsCurrent = 1) LEFT OUTER JOIN
		dbo.MetricUpdates AS nextbu ON bu.MetricID = nextbu.MetricID AND nextbu.UpdatePeriod = 
			(SELECT MIN(UpdatePeriod)
			FROM MetricUpdates INNER JOIN
				SignOffs ON MetricUpdates.SignOffID = SignOffs.ID
			WHERE MetricID = bu.MetricID AND UpdatePeriod > bu.UpdatePeriod AND SignOffs.IsCurrent = 1)
	WHERE so.IsCurrent = 1