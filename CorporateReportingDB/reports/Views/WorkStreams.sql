CREATE VIEW [reports].[WorkStreams]
AS
SELECT    dbo.WorkStreams.ID AS [Work Stream ID]
			,dbo.WorkStreams.WorkStreamCode AS [Work Stream ID (User)]
			,dbo.WorkStreams.Title AS [Work Stream]
			,dbo.Projects.Title AS [Project]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.WorkStreams.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
FROM     dbo.WorkStreams LEFT OUTER JOIN
			dbo.Projects ON dbo.WorkStreams.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
			dbo.Users ON dbo.WorkStreams.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.WorkStreams.EntityStatusID = dbo.EntityStatuses.ID