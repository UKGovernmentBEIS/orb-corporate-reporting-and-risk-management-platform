CREATE VIEW [reports].[KeyWorkAreas]
AS
SELECT    dbo.KeyWorkAreas.ID AS [Key Work Area ID]
			,dbo.KeyWorkAreas.Title AS [Key Work Area]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.KeyWorkAreas.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
FROM     dbo.KeyWorkAreas LEFT OUTER JOIN
			dbo.Directorates ON dbo.KeyWorkAreas.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Users ON dbo.KeyWorkAreas.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.KeyWorkAreas.EntityStatusID = dbo.EntityStatuses.ID