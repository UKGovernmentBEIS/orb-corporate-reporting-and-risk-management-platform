CREATE VIEW [reports].[Dependencies]
AS
	SELECT dbo.Dependencies.ID AS [Dependency ID]
			, dbo.Dependencies.Title AS [Dependency]
			, dbo.Projects.Title AS [Project]
			, dbo.Users.Title AS [Lead]
			, dbo.EntityStatuses.Title AS [Status]
			, CAST(dbo.Dependencies.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
			, dbo.Dependencies.StartDate AS [Start date]
			, dbo.Dependencies.EndDate AS [End date]
			, CAST(dbo.Dependencies.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
			, CAST(dbo.Dependencies.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
			, CAST(dbo.Dependencies.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
	FROM dbo.Dependencies LEFT OUTER JOIN
		dbo.Projects ON dbo.Dependencies.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
		dbo.Users ON dbo.Dependencies.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
		dbo.EntityStatuses ON dbo.Dependencies.EntityStatusID = dbo.EntityStatuses.ID