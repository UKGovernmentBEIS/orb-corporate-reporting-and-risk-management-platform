CREATE VIEW [reports].[MetricUpdates]
AS
    SELECT dbo.MetricUpdates.ID AS [Metric Update ID]
		, dbo.SignOffs.ID AS [SignOff ID]
		, dbo.Groups.Title AS [Group]
		, dbo.Directorates.Title AS [Directorate]
		, dbo.SignOffs.ReportMonth AS [Report Month]
		, dbo.Metrics.ID AS [Metric ID]
		, dbo.Metrics.MetricCode AS [Metric ID (User)]
		, dbo.Metrics.Title AS [Metric]
		, dbo.MetricUpdates.Comment AS [Progress Update]
		, CAST(dbo.PreviousMetricUpdates.PreviousPerformance AS float) AS [Previous Performance]
		, CAST(dbo.MetricUpdates.CurrentPerformance AS float) AS [Current Performance]
		, CAST(dbo.Metrics.TargetPerformanceLowerLimit AS float) AS [Target Performance Lower]
		, CAST(dbo.Metrics.TargetPerformanceUpperLimit AS float) AS [Target Performance Upper]
		, dbo.MeasurementUnits.Title AS [Performance Unit]
		, dbo.PreviousMetricUpdates.PreviousRAG AS [Previous RAG]
		, dbo.PreviousMetricUpdates.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - dbo.PreviousMetricUpdates.PreviousRAGScore AS [RAG Change]
		, dbo.Users.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(dbo.MetricUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE dbo.MetricUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Metric Closed]
		, es.Title AS [Status] 
		 , CASE dbo.Metrics.ReportingFrequency 
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
        , CASE dbo.Metrics.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(dbo.Metrics.ReportingStartDate)
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(dbo.Metrics.ReportingStartDate)
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(dbo.Metrics.ReportingStartDate)
                WHEN 1 THEN 'Jan' 
                WHEN 2 THEN 'Feb' 
                WHEN 3 THEN 'Mar' 
                WHEN 4 THEN 'Apr' 
                WHEN 5 THEN 'May' 
                WHEN 6 THEN 'Jun' 
                WHEN 7 THEN 'Jul' 
                WHEN 8 THEN 'Aug' 
                WHEN 9 THEN 'Sep' 
                WHEN 10 THEN 'Oct' 
                WHEN 11 THEN 'Nov' 
                WHEN 12 THEN 'Dec' 
                ELSE '' 
            END 
        END AS [Reporting Schedule]
    FROM dbo.SignOffs LEFT OUTER JOIN
        dbo.MetricUpdates ON dbo.SignOffs.ID = dbo.MetricUpdates.SignOffID INNER JOIN
        dbo.Metrics ON dbo.MetricUpdates.MetricID = dbo.Metrics.ID INNER JOIN
        dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID AND dbo.Metrics.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
        dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
        dbo.Users ON dbo.Metrics.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
        dbo.Users AS UpdateAuthor ON dbo.MetricUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
        dbo.RagOptions ON dbo.MetricUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
        dbo.PreviousMetricUpdates ON dbo.Metrics.ID = dbo.PreviousMetricUpdates.MetricID AND dbo.SignOffs.ReportMonth = dbo.PreviousMetricUpdates.NextMonth LEFT OUTER JOIN
        dbo.EntityStatuses As es ON dbo.Metrics.EntityStatusID = es.ID LEFT OUTER JOIN
        dbo.MeasurementUnits ON dbo.Metrics.MeasurementUnitID = dbo.MeasurementUnits.ID
    WHERE dbo.SignOffs.IsCurrent = 1;