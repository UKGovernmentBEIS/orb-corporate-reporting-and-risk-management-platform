CREATE VIEW [reports].[SignOffs]
AS
SELECT	dbo.SignOffs.ID AS [Sign Off ID]
		,CAST(dbo.SignOffs.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Sign Off Date]
		,dbo.Users.Title AS [Signed Off By]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
FROM   dbo.SignOffs LEFT OUTER JOIN
		dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
		dbo.Users ON dbo.SignOffs.SignOffUserID = dbo.Users.ID
WHERE        (dbo.SignOffs.IsCurrent = 1)