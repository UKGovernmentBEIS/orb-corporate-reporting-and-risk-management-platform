CREATE VIEW [reports].[Benefits]
AS
SELECT    dbo.Benefits.ID AS [Benefit ID]
			,dbo.Benefits.Title AS [Benefit]
			,dbo.Projects.Title AS [Project]
			,dbo.BenefitTypes.Title AS [Benefit Type]
			,dbo.Benefits.Description AS [Benefit Description]
			,dbo.MeasurementUnits.Title AS [Performance Unit]
			,dbo.Benefits.TargetPerformanceLowerLimit AS [Target Performance Lower Limit]
			,dbo.Benefits.TargetPerformanceUpperLimit AS [Target Performance Upper Limit]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.Benefits.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
FROM     dbo.Benefits LEFT OUTER JOIN
			dbo.Projects ON dbo.Benefits.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
			dbo.BenefitTypes ON dbo.Benefits.BenefitTypeID = dbo.BenefitTypes.ID LEFT OUTER JOIN
			dbo.MeasurementUnits ON dbo.Benefits.MeasurementUnitID = dbo.MeasurementUnits.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Benefits.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Benefits.EntityStatusID = dbo.EntityStatuses.ID