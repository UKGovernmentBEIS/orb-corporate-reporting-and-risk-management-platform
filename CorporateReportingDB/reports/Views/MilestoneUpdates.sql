CREATE VIEW [reports].[MilestoneUpdates]
AS
	SELECT dbo.MilestoneUpdates.ID AS [Milestone Update ID]
			, dbo.SignOffs.ID AS [Sign Off ID]
			, dbo.SignOffs.ReportMonth AS [Report Month]
			, ISNULL(dbo.Groups.Title, ProjectDirectorateGroups.Title) AS [Group]
			, ISNULL(dbo.Directorates.Title, ProjectDirectorates.Title) AS [Directorate]
			, dbo.Projects.Title AS [Project]
			, dbo.Milestones.KeyWorkAreaID AS [Key Work Area ID]
			, dbo.KeyWorkAreas.Title AS [Key Work Area]
			, dbo.Milestones.WorkStreamID AS [Work Stream ID]
			, dbo.WorkStreams.Title AS [Work Stream]
			, dbo.Milestones.ID AS [Milestone ID]
			, dbo.Milestones.MilestoneCode AS [Milestone ID (User)]
			, dbo.Milestones.Title AS [Milestone]
			, dbo.MilestoneUpdates.Comment AS [Progress Update]
			, dbo.Milestones.Description AS [Milestone Description]
			, CAST(dbo.Milestones.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
			, CAST(dbo.MilestoneUpdates.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
			, CAST(MilestoneUpdates.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
			, dbo.PreviousMilestoneUpdates.PreviousRAG AS [Previous RAG]
			, dbo.PreviousMilestoneUpdates.PreviousRAGScore AS [Previous RAG Score]
			, dbo.RagOptions.ReportName AS [Current RAG]
			, dbo.RagOptions.ID AS [Current RAG Score]
			, dbo.RagOptions.ID - dbo.PreviousMilestoneUpdates.PreviousRAGScore AS [RAG Change]
			, dbo.Users.Title AS [Lead]
			, UpdateAuthor.Title AS [Author]
			, CAST(dbo.MilestoneUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			, CASE dbo.MilestoneUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Milestone Closed]
			, CASE WHEN SdpMilestones.ID IS NOT NULL THEN 'Yes' ELSE NULL END AS [SDP]
			, SdpMilestones.AttributeValue AS [SDP Value]
            , dbo.PartnerOrganisations.Title AS [Partner Organisation]
			, CAST(dbo.Milestones.StartDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Start Date] 
			, dbo.EntityStatuses.Title AS [Status]

	FROM dbo.Milestones LEFT OUTER JOIN
		dbo.KeyWorkAreas ON dbo.Milestones.KeyWorkAreaID = dbo.KeyWorkAreas.ID LEFT OUTER JOIN
		dbo.WorkStreams ON dbo.Milestones.WorkStreamID = dbo.WorkStreams.ID LEFT OUTER JOIN
		dbo.MilestoneUpdates ON dbo.MilestoneUpdates.SignOffID IS NOT NULL AND dbo.Milestones.ID = dbo.MilestoneUpdates.MilestoneID INNER JOIN
		dbo.SignOffs ON dbo.MilestoneUpdates.SignOffID = dbo.SignOffs.ID LEFT OUTER JOIN
		dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
		dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
		dbo.Directorates AS ProjectDirectorates ON dbo.Projects.DirectorateID = ProjectDirectorates.ID LEFT OUTER JOIN
		dbo.Groups AS ProjectDirectorateGroups ON ProjectDirectorates.GroupID = ProjectDirectorateGroups.ID LEFT OUTER JOIN
		dbo.Users ON dbo.Milestones.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON dbo.MilestoneUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.MilestoneUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.PreviousMilestoneUpdates ON dbo.Milestones.ID = dbo.PreviousMilestoneUpdates.MilestoneID AND dbo.SignOffs.ReportMonth = dbo.PreviousMilestoneUpdates.NextMonth LEFT OUTER JOIN
		dbo.Attributes AS SdpMilestones ON dbo.Milestones.ID = SdpMilestones.MilestoneID AND SdpMilestones.AttributeTypeID = 2 LEFT OUTER JOIN
		dbo.PartnerOrganisations ON dbo.Milestones.PartnerOrganisationID = dbo.PartnerOrganisations.ID LEFT OUTER JOIN
		dbo.EntityStatuses ON dbo.Milestones.EntityStatusID = dbo.EntityStatuses.ID
	WHERE       (dbo.SignOffs.IsCurrent = 1)