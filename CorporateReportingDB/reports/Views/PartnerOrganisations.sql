CREATE VIEW [reports].[PartnerOrganisations]
AS
    SELECT po.ID AS [Partner Organisation ID]
		, po.Title AS [Partner Organisation]
        , dr.Title AS [Directorate]
		, gr.Title AS [Group]
        , lps.Title AS [Lead Policy Sponsor]
        , ra.Title AS [Report Author]
        , po.Objectives AS [Objectives]
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
			ELSE '' 
        END AS [Reporting Schedule]
    FROM dbo.PartnerOrganisations po LEFT OUTER JOIN
        dbo.Directorates dr ON po.DirectorateID = dr.ID LEFT OUTER JOIN
        dbo.Groups gr ON dr.GroupID = gr.ID LEFT OUTER JOIN
        dbo.Users lps ON po.LeadPolicySponsorUserID = lps.ID LEFT OUTER JOIN
        dbo.Users ra ON po.ReportAuthorUserID = ra.ID;
