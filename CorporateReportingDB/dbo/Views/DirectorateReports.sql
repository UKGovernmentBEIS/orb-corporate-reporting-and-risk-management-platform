CREATE VIEW [dbo].[DirectorateReports]
AS
    SELECT
        g.Title AS [Group]
        , report.DirectorateName AS [Directorate]
        , so.DirectorateID AS [DirectorateID]
        , so.ReportMonth AS [ReportMonth]
        , DirectorUser.Title AS [Director]
        , report.UpdateUser AS [DirectorateUpdateAuthor]
        , so.ID AS [SignOffID]
        , es.Title AS [DirectorateStatus] 
		, so.SignOffDate AS [SignOffDate]
		, report.UpdateDate AS [DirectorateUpdateDate]
		, report.Objectives AS [Objectives]
		, report.ProgressUpdate AS [ProgressUpdate]
		, report.FutureActions AS [FutureActions]
		, report.Escalations AS [Escalations]

		, OverallRAG.ReportName AS [OverallRAG]
		, FinanceRAG.ReportName AS [FinanceRAG]
		, MilestonesRAG.ReportName AS [MilestonesRAG]
		, MetricsRAG.ReportName AS [MetricsRAG]
		, PeopleRAG.ReportName AS [PeopleRAG]

		, OverallRAG.Score AS [OverallRAGScore]
		, FinanceRAG.Score AS [FinanceRAGScore]
		, MilestonesRAG.Score AS [MilestonesRAGScore]
		, MetricsRAG.Score AS [MetricsRAGScore]
		, PeopleRAG.Score AS [PeopleRAGScore]

		, report.FinanceComment AS [FinanceComment]
		, report.MilestonesComment AS [MilestonesComment]
		, report.MetricsComment AS [MetricsComment]
		, report.PeopleComment AS [PeopleComment]

    FROM dbo.SignOffs AS so 
    CROSS APPLY OPENJSON(so.ReportJson, 'lax $.Directorate') 
    WITH (
        DirectorateName NVARCHAR(255) '$.Title',
        GroupID INT '$.GroupID',
        DirectorUserID INT '$.DirectorUserID',
        Objectives NVARCHAR(MAX) '$.Objectives',
        EntityStatusID INT '$.EntityStatusID',
        ProgressUpdate NVARCHAR(1000) '$.DirectorateUpdates[0].ProgressUpdate',
        FutureActions NVARCHAR(1000) '$.DirectorateUpdates[0].FutureActions',
        Escalations NVARCHAR(1000) '$.DirectorateUpdates[0].Escalations',
        UpdateUser NVARCHAR(255) '$.DirectorateUpdates[0].UpdateUser.Title',
        UpdateDate DATETIME2(7) '$.DirectorateUpdates[0].UpdateDate',
        OverallRagOptionID INT '$.DirectorateUpdates[0].OverallRagOptionID',
        FinanceRagOptionID INT '$.DirectorateUpdates[0].FinanceRagOptionID',
        FinanceComment NVARCHAR(1000) '$.DirectorateUpdates[0].FinanceComment',
        PeopleRagOptionID INT '$.DirectorateUpdates[0].PeopleRagOptionID',
        PeopleComment NVARCHAR(1000) '$.DirectorateUpdates[0].PeopleComment',
        MilestonesRagOptionID INT '$.DirectorateUpdates[0].MilestonesRagOptionID',
        MilestonesComment NVARCHAR(1000) '$.DirectorateUpdates[0].MilestonesComment',
        MetricsRagOptionID INT '$.DirectorateUpdates[0].MetricsRagOptionID',
        MetricsComment NVARCHAR(1000) '$.DirectorateUpdates[0].MetricsComment'
    ) AS report LEFT OUTER JOIN
        dbo.Groups AS g ON report.GroupID = g.ID LEFT OUTER JOIN
        dbo.EntityStatuses AS es ON report.EntityStatusID = es.ID LEFT OUTER JOIN
        dbo.Users AS DirectorUser ON report.DirectorUserID = directoruser.ID LEFT OUTER JOIN
        dbo.RagOptions AS OverallRAG ON report.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
        dbo.RagOptions AS FinanceRAG ON report.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
        dbo.RagOptions AS PeopleRAG ON report.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
        dbo.RagOptions AS MilestonesRAG ON report.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
        dbo.RagOptions AS MetricsRAG ON report.MetricsRagOptionID = MetricsRAG.ID
    WHERE so.IsCurrent = 1