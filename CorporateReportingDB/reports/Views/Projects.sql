CREATE VIEW [reports].[Projects]
AS
SELECT    Projects.ID AS [Project ID]
			,dbo.Directorates.Title AS [Directorate]
			,Projects.Title AS [Project]
			,SroUser.Title AS [SRO]
			,Projects.Objectives AS [Objectives]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(Projects.StartDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Start Date]
			,CAST(Projects.EndDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [End Date]
			,Projects.CorporateProjectID AS [BEIS Project ID]
FROM     dbo.Projects AS Projects LEFT OUTER JOIN
            dbo.Directorates ON Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
            dbo.Users AS SroUser ON Projects.SeniorResponsibleOwnerUserID = SroUser.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON Projects.EntityStatusID = dbo.EntityStatuses.ID