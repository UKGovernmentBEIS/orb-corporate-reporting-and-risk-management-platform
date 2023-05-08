CREATE VIEW [drafts].[WorkStreamMilestoneUpdates]
AS
  SELECT mu.ID AS [Milestone Update ID]
			, mu.UpdatePeriod AS [Report Month]
			, g.Title AS [Group]
			, d.Title AS [Directorate]
			, p.Title AS [Project]
			, m.WorkStreamID AS [Work Stream ID]
			, w.Title AS [Work Stream]
			, m.ID AS [Milestone ID]
			, m.MilestoneCode AS [Milestone ID (User)]
			, m.Title AS [Milestone]
			, mu.Comment AS [Progress Update]
			, m.Description AS [Milestone Description]
			, CAST(m.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
			, CAST(mu.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
			, CAST(mu.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
			, pmu.PreviousRAG AS [Previous RAG]
			, pmu.PreviousRAGScore AS [Previous RAG Score]
			, dbo.RagOptions.ReportName AS [Current RAG]
			, dbo.RagOptions.ID AS [Current RAG Score]
			, dbo.RagOptions.ID - pmu.PreviousRAGScore AS [RAG Change]
			, LeadUser.Title AS [Lead]
			, UpdateAuthor.Title AS [Author]
			, CAST(mu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			, CASE mu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Milestone Closed]
			, CASE WHEN SdpMilestones.ID IS NOT NULL THEN 'Yes' ELSE NULL END AS [SDP]
			, SdpMilestones.AttributeValue AS [SDP Value]
			, CAST(m.StartDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Start Date] 
			, es.Title AS [Status]
  FROM dbo.Milestones AS m LEFT OUTER JOIN
    dbo.WorkStreams AS w ON m.WorkStreamID = w.ID LEFT OUTER JOIN
    dbo.MilestoneUpdates AS mu ON m.ID = mu.MilestoneID INNER JOIN
    (SELECT MAX(mu.ID) AS CurrentDraftID
    FROM [dbo].[MilestoneUpdates] AS mu INNER JOIN [dbo].[Milestones] AS m ON mu.MilestoneID = m.ID
    WHERE m.WorkStreamID IS NOT NULL
    GROUP BY MilestoneID, UpdatePeriod) AS currentDraft ON currentDraft.CurrentDraftID = mu.ID LEFT OUTER JOIN
    dbo.Projects AS p ON w.ProjectID = p.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON p.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON m.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON mu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON mu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.PreviousMilestoneUpdates AS pmu ON m.ID = pmu.MilestoneID AND mu.UpdatePeriod = pmu.NextMonth LEFT OUTER JOIN
    dbo.Attributes AS SdpMilestones ON m.ID = SdpMilestones.MilestoneID AND SdpMilestones.AttributeTypeID = 2 LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON m.EntityStatusID = es.ID