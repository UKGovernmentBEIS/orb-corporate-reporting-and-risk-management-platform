CREATE VIEW [drafts].[MetricUpdates]
AS
  SELECT mu.ID AS [Metric Update ID]
		, g.Title AS [Group]
		, d.Title AS [Directorate]
		, mu.UpdatePeriod AS [Report Month]
		, m.ID AS [Metric ID]
		, m.MetricCode AS [Metric ID (User)]
		, m.Title AS [Metric]
		, mu.Comment AS [Progress Update]
		, CAST(pmu.PreviousPerformance AS float) AS [Previous Performance]
		, CAST(mu.CurrentPerformance AS float) AS [Current Performance]
		, CAST(m.TargetPerformanceLowerLimit AS float) AS [Target Performance Lower]
		, CAST(m.TargetPerformanceUpperLimit AS float) AS [Target Performance Upper]
		, measurements.Title AS [Performance Unit]
		, pmu.PreviousRAG AS [Previous RAG]
		, pmu.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - pmu.PreviousRAGScore AS [RAG Change]
		, LeadUser.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(mu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE mu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Metric Closed]
		, es.Title AS [Status] 
		 , CASE m.ReportingFrequency 
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
        , CASE m.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(m.ReportingStartDate)
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(m.ReportingStartDate)
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(m.ReportingStartDate)
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
  FROM (SELECT MAX(ID) AS CurrentDraftID
      , MetricID
      , UpdatePeriod
    FROM [dbo].[MetricUpdates]
    GROUP BY MetricID, UpdatePeriod) AS currentDraft LEFT OUTER JOIN
    dbo.MetricUpdates AS mu ON currentDraft.CurrentDraftID = mu.ID INNER JOIN
    dbo.Metrics AS m ON mu.MetricID = m.ID INNER JOIN
    dbo.Directorates AS d ON m.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON m.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON mu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON mu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.PreviousMetricUpdates AS pmu ON m.ID = pmu.MetricID AND mu.UpdatePeriod = pmu.NextMonth LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON m.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.MeasurementUnits AS measurements ON m.MeasurementUnitID = measurements.ID;
