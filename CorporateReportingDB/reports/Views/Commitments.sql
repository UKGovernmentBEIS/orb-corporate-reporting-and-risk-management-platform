CREATE VIEW [reports].[Commitments]
AS
SELECT    dbo.Commitments.ID AS [Commitment ID]
			,dbo.Commitments.Title AS [Commitment]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.Commitments.BaselineDate AS [Baseline]
			,dbo.Commitments.ForecastDate AS [Forecast]
			,dbo.Commitments.ActualDate AS [Actual]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.Commitments.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
FROM     dbo.Commitments LEFT OUTER JOIN
			dbo.Directorates ON dbo.Commitments.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Commitments.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Commitments.EntityStatusID = dbo.EntityStatuses.ID