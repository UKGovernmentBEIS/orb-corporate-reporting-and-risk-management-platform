CREATE VIEW [drafts].[PartnerOrganisationUpdates]
AS
  SELECT g.Title AS [Group]
    , d.Title AS [Directorate]
		, po.Title AS [Partner Organisation] 
		, po.ID AS [Partner Organisation ID]
		, Months.UpdatePeriod AS [Report Month]
		, DirectorUser.Title AS [Director]
    , LeadPolicySponsorUser.Title AS [Lead Policy Sponsor]
    , ReportAuthorUser.Title AS [Author]
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
		, ppou.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, ppou.PreviousFinanceRAG AS [Previous Finance RAG]
		, ppou.PreviousKeyPerformanceIndicatorRAG AS [Previous Key Performance Indicators RAG]
		, ppou.PreviousPeopleRAG AS [Previous Milestones RAG]
		, ppou.PreviousMilestonesRAG AS [Previous People RAG]

		, ppou.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score] 
		, ppou.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, ppou.PreviousKeyPerformanceIndicatorScore AS [Previous Key Performance Indicators RAG Score]
		, ppou.PreviousPeopleRAGScore AS [Previous Milestones RAG Score]
		, ppou.PreviousMilestonesRAGScore As [Previous People RAG Score]

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
       
		, (dcRag.Score - ppou.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (fiRag.Score - ppou.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (kpiRag.Score - ppou.PreviousKeyPerformanceIndicatorScore) AS [Key Performance Indicator RAG Change]
		, (pplRag.Score - ppou.PreviousPeopleRAGScore) AS [People RAG Change]
		, (mileRag.Score - ppou.PreviousMilestonesRAGScore) AS [Milestones RAG Change]

  FROM dbo.PartnerOrganisations AS po CROSS JOIN
    (SELECT DISTINCT UpdatePeriod
    FROM dbo.PartnerOrganisationUpdates
    WHERE UpdatePeriod IS NOT NULL) AS Months LEFT OUTER JOIN
    dbo.PartnerOrganisationUpdates AS pou ON po.ID = pou.PartnerOrganisationID AND Months.UpdatePeriod = pou.UpdatePeriod AND pou.ID IN
    (SELECT MAX([ID])
    FROM [dbo].[PartnerOrganisationUpdates]
    GROUP BY PartnerOrganisationID, UpdatePeriod) LEFT OUTER JOIN
    dbo.Directorates AS d ON po.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON po.EntityStatusID = es.ID LEFT OUTER JOIN
    /* Users */
    dbo.Users AS LeadPolicySponsorUser ON po.LeadPolicySponsorUserID = LeadPolicySponsorUser.ID LEFT OUTER JOIN
    dbo.Users AS ReportAuthorUser ON po.ReportAuthorUserID = ReportAuthorUser.ID LEFT OUTER JOIN
    dbo.Users AS DirectorUser ON d.DirectorUserID = DirectorUser.ID LEFT OUTER JOIN
    /* RAGs */
    dbo.RagOptions AS dcRag ON pou.OverallRagOptionID = dcRag.ID LEFT OUTER JOIN
    dbo.RagOptions AS fiRag ON pou.FinanceRagOptionID = fiRag.ID LEFT OUTER JOIN
    dbo.RagOptions AS kpiRag ON pou.KPIRagOptionID = kpiRag.ID LEFT OUTER JOIN
    dbo.RagOptions AS mileRag ON pou.MilestonesRagOptionID = mileRag.ID LEFT OUTER JOIN
    dbo.RagOptions AS pplRag ON pou.PeopleRagOptionID = pplRag.ID LEFT OUTER JOIN
    dbo.PreviousPartnerOrganisationUpdates AS ppou ON po.ID = ppou.PartnerOrganisationID AND pou.UpdatePeriod = ppou.NextMonth;