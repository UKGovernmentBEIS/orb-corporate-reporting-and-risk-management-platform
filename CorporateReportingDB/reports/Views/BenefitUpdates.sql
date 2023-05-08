CREATE VIEW [reports].[BenefitUpdates]
AS
    SELECT dbo.BenefitUpdates.ID AS [Benefit Update ID]
		, dbo.SignOffs.ID AS [SignOff ID]
		, dbo.Groups.Title AS [Group]
		, dbo.Directorates.Title AS [Directorate]
		, dbo.Projects.Title AS [Project]
		, dbo.SignOffs.ReportMonth AS [Report Month]
		, dbo.Benefits.ID AS [Benefit ID]
		, dbo.Benefits.Title AS [Benefit]
		, dbo.BenefitUpdates.Comment AS [Progress Update]
		, dbo.Benefits.Description AS [Benefit Description]
		, CAST(dbo.PreviousBenefitUpdates.PreviousPerformance AS float) AS [Previous Performance]
		, CAST(dbo.BenefitUpdates.CurrentPerformance AS float) AS [Current Performance]
		, CAST(dbo.Benefits.TargetPerformanceLowerLimit AS float) AS [Target Performance Lower]
		, CAST(dbo.Benefits.TargetPerformanceUpperLimit AS float) AS [Target Performance Upper]
		, dbo.MeasurementUnits.Title AS [Performance Unit]
		, dbo.PreviousBenefitUpdates.PreviousRAG AS [Previous RAG]
		, dbo.PreviousBenefitUpdates.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - dbo.PreviousBenefitUpdates.PreviousRAGScore AS [RAG Change]
		, dbo.Users.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(dbo.BenefitUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE dbo.BenefitUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Benefit Closed]
		, es.Title AS [Status] 
		, CASE dbo.Benefits.ReportingFrequency
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
        , CASE dbo.Benefits.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(dbo.Benefits.ReportingStartDate)  
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(dbo.Benefits.ReportingStartDate)  
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(dbo.Benefits.ReportingStartDate)  
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
        dbo.BenefitUpdates ON dbo.SignOffs.ID = dbo.BenefitUpdates.SignOffID INNER JOIN
        dbo.Benefits ON dbo.BenefitUpdates.BenefitID = dbo.Benefits.ID INNER JOIN
        dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID AND dbo.Benefits.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
        dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
        dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
        dbo.Users ON dbo.Benefits.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
        dbo.Users AS UpdateAuthor ON dbo.BenefitUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
        dbo.RagOptions ON dbo.BenefitUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
        dbo.PreviousBenefitUpdates ON dbo.Benefits.ID = dbo.PreviousBenefitUpdates.BenefitID AND dbo.SignOffs.ReportMonth = dbo.PreviousBenefitUpdates.NextMonth LEFT OUTER JOIN
        dbo.EntityStatuses AS es ON dbo.Benefits.EntityStatusID = es.ID LEFT OUTER JOIN
        dbo.MeasurementUnits ON dbo.Benefits.MeasurementUnitID = dbo.MeasurementUnits.ID
    WHERE dbo.SignOffs.IsCurrent = 1;