CREATE VIEW [reports].[PartnerOrganisationUpdates]
AS
    SELECT grp.Title AS [Group]
        , dr.Title AS [Directorate]
		, po.Title AS [Partner Organisation] 
		, po.ID AS [ID]
		, Months.ReportMonth AS [Report Month]
		, us.Title AS [Director]
        , lps.Title AS [Lead Policy Sponsor]
        , ra.Title AS [Author]
		, sou.Title AS [Signed-off by]
		, pou.SignOffID AS [SignOff ID]
		, CAST(sinof.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Date Signed-off]
		, CAST(pou.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, po.Objectives AS [Objectives]
		, pou.ProgressUpdate AS [Delivery Confidence Update]
		, pou.FutureActions AS [Future Actions Update]
		, pou.Escalations AS [Escalations Update]
		, es.Title AS [Status]
        , CASE po.ReportingFrequency 
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
        , CASE po.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(po.ReportingStartDate)
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(po.ReportingStartDate)
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(po.ReportingStartDate)
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
      
        /* RAGs */
		, PrevPOU.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, PrevPOU.PreviousFinanceRAG AS [Previous Finance RAG]
		, PrevPOU.PreviousKeyPerformanceIndicatorRAG AS [Previous Key Performance Indicators RAG]
		, PrevPOU.PreviousPeopleRAG AS [Previous Milestones RAG]
		, PrevPOU.PreviousMilestonesRAG AS [Previous People RAG]

		, PrevPOU.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score] 
		, PrevPOU.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, PrevPOU.PreviousKeyPerformanceIndicatorScore AS [Previous Key Performance Indicators RAG Score]
		, PrevPOU.PreviousPeopleRAGScore AS [Previous Milestones RAG Score]
		, PrevPOU.PreviousMilestonesRAGScore As [Previous People RAG Score]

		, dcRag.ReportName AS [Delivery Confidence RAG]
		, fiRag.ReportName AS [Finance RAG]
		, kpiRag.ReportName AS [Key Performance Indicators RAG]
		, mileRag.ReportName AS [Milestones RAG]
		, pplRag.ReportName AS [People RAG]

		, dcRag.Score AS [Delivery Confidence RAG Score] 
		, fiRag.Score AS [Finance RAG Score]
		, kpiRag.Score AS [Key Performance Indicators RAG Score]
		, mileRag.Score AS [Milestones RAG Score]
		, pplRag.Score As [People RAG Score]

		, pou.FinanceComment AS [Finance Update]
		, pou.KPIComment AS [Key Performance Indicators Update]
		, pou.MilestonesComment AS [Milestones Update]
		, pou.PeopleComment AS [People Update]
       
		, (dcRag.Score - PrevPOU.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (fiRag.Score - PrevPOU.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (kpiRag.Score - PrevPOU.PreviousKeyPerformanceIndicatorScore) AS [Key Performance Indicator RAG Change]
		, (pplRag.Score - PrevPOU.PreviousPeopleRAGScore) AS [People RAG Change]
		, (mileRag.Score - PrevPOU.PreviousMilestonesRAGScore) AS [Milestones RAG Change]

    FROM dbo.PartnerOrganisations po CROSS JOIN
    (SELECT DISTINCT dbo.SignOffs.ReportMonth
        FROM dbo.SignOffs
        WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months LEFT OUTER JOIN
        dbo.SignOffs sinof ON sinof.PartnerOrganisationID = po.ID AND sinof.ReportMonth = Months.ReportMonth AND sinof.IsCurrent = 1 LEFT OUTER JOIN
        dbo.PartnerOrganisationUpdates pou ON sinof.ID = pou.SignOffID INNER JOIN
        dbo.Directorates dr ON po.DirectorateID = dr.ID LEFT OUTER JOIN
        dbo.Groups grp ON dr.GroupID = grp.ID LEFT OUTER JOIN
        dbo.EntityStatuses AS es ON po.EntityStatusID = es.ID LEFT OUTER JOIN
        /* Users */
        dbo.Users lps ON po.LeadPolicySponsorUserID = lps.ID LEFT OUTER JOIN
        dbo.Users ra ON po.ReportAuthorUserID = ra.ID LEFT OUTER JOIN
        dbo.Users sou ON sinof.SignOffUserID = sou.ID LEFT OUTER JOIN
        dbo.Users us ON dr.DirectorUserID = us.ID LEFT OUTER JOIN
        /* RAGs */
        dbo.RagOptions AS dcRag ON pou.OverallRagOptionID = dcRag.ID LEFT OUTER JOIN
        dbo.RagOptions AS fiRag ON pou.FinanceRagOptionID = fiRag.ID LEFT OUTER JOIN
        dbo.RagOptions AS kpiRag ON pou.KPIRagOptionID = kpiRag.ID LEFT OUTER JOIN
        dbo.RagOptions AS mileRag ON pou.MilestonesRagOptionID = mileRag.ID LEFT OUTER JOIN
        dbo.RagOptions AS pplRag ON pou.PeopleRagOptionID = pplRag.ID LEFT OUTER JOIN
        dbo.PreviousPartnerOrganisationUpdates AS PrevPOU ON po.ID =PrevPOU.PartnerOrganisationID AND sinof.ReportMonth = PrevPOU.NextMonth;
