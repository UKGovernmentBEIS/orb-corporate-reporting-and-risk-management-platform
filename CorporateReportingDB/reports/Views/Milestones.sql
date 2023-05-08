CREATE VIEW [reports].[Milestones]
AS
SELECT    dbo.Milestones.ID AS [Milestone ID]
			,dbo.Milestones.MilestoneCode AS [Milestone ID (User)]
			,dbo.Milestones.Title AS [Milestone]
			,dbo.Milestones.Description AS [Milestone Description]
			,CAST(dbo.Milestones.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
			,CAST(dbo.Milestones.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
			,CAST(dbo.Milestones.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
			,dbo.MilestoneTypes.Title AS [Milestone Type]
			,dbo.Directorates.Title AS [Directorate]
			,gr.Title AS [Group]
			,dbo.KeyWorkAreas.Title AS [Key Work Area]
			,dbo.Projects.Title AS [Project]
			,dbo.WorkStreams.Title AS [Work Stream]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.Milestones.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
            ,dbo.PartnerOrganisations.Title AS [Partner Organisation]
FROM     dbo.Milestones LEFT OUTER JOIN
			dbo.MilestoneTypes ON dbo.Milestones.MilestoneTypeID = dbo.MilestoneTypes.ID LEFT OUTER JOIN
			dbo.KeyWorkAreas ON dbo.Milestones.KeyWorkAreaID = dbo.KeyWorkAreas.ID LEFT OUTER JOIN
			dbo.Directorates ON dbo.KeyWorkAreas.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.WorkStreams ON dbo.Milestones.WorkStreamID = dbo.WorkStreams.ID LEFT OUTER JOIN
			dbo.Projects ON dbo.WorkStreams.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Milestones.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Milestones.EntityStatusID = dbo.EntityStatuses.ID LEFT OUTER JOIN
			dbo.Groups AS gr ON dbo.Directorates.GroupID = gr.ID LEFT OUTER JOIN
            dbo.PartnerOrganisations On dbo.Milestones.PartnerOrganisationID = dbo.PartnerOrganisations.ID