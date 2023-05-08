CREATE VIEW [drafts].[BenefitUpdates]
AS
  SELECT bu.ID AS [Benefit Update ID]
		, g.Title AS [Group]
		, d.Title AS [Directorate]
		, p.Title AS [Project]
		, bu.UpdatePeriod AS [Report Month]
		, b.ID AS [Benefit ID]
		, b.Title AS [Benefit]
		, bu.Comment AS [Progress Update]
		, b.Description AS [Benefit Description]
		, CAST(pbu.PreviousPerformance AS float) AS [Previous Performance]
		, CAST(bu.CurrentPerformance AS float) AS [Current Performance]
		, CAST(b.TargetPerformanceLowerLimit AS float) AS [Target Performance Lower]
		, CAST(b.TargetPerformanceUpperLimit AS float) AS [Target Performance Upper]
		, mu.Title AS [Performance Unit]
		, pbu.PreviousRAG AS [Previous RAG]
		, pbu.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - pbu.PreviousRAGScore AS [RAG Change]
		, LeadUser.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(bu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE bu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Benefit Closed]
		, es.Title AS [Status] 
		, CASE b.ReportingFrequency
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
        , CASE b.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(b.ReportingStartDate)  
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(b.ReportingStartDate)  
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(b.ReportingStartDate)  
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
    FROM [dbo].[BenefitUpdates]
    GROUP BY BenefitID, UpdatePeriod) AS currentDraft LEFT OUTER JOIN
    dbo.BenefitUpdates AS bu ON currentDraft.CurrentDraftID = bu.ID INNER JOIN
    dbo.Benefits AS b ON bu.BenefitID = b.ID INNER JOIN
    dbo.Projects AS p ON b.ProjectID = p.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON p.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON b.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON bu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON bu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.PreviousBenefitUpdates AS pbu ON b.ID = pbu.BenefitID AND bu.UpdatePeriod = pbu.NextMonth LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON b.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.MeasurementUnits AS mu ON b.MeasurementUnitID = mu.ID;