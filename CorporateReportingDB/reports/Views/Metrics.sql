CREATE VIEW [reports].[Metrics]
AS
SELECT    dbo.Metrics.ID AS [Metric ID]
			,dbo.Metrics.MetricCode AS [Metric ID (User)]
			,dbo.Metrics.Title AS [Metric]
			,dbo.Metrics.Description AS [Metric Description]
			,dbo.Groups.Title AS [Group]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.MeasurementUnits.Title AS [Performance Unit]
			,dbo.Metrics.TargetPerformanceLowerLimit AS [Target Performance Lower Limit]
			,dbo.Metrics.TargetPerformanceUpperLimit AS [Target Performance Upper Limit]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.Metrics.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
FROM     dbo.Metrics LEFT OUTER JOIN
			dbo.Directorates ON dbo.Metrics.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
			dbo.MeasurementUnits ON dbo.Metrics.MeasurementUnitID = dbo.MeasurementUnits.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Metrics.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Metrics.EntityStatusID = dbo.EntityStatuses.ID