CREATE VIEW [reports].[ReportingEntities]
AS
  SELECT re.ID AS [Reporting entity ID]
    , rt.Title AS [Report type]
    , ret.Title AS [Reporting entity type]
		, re.Title AS [Reporting entity]
    , d.Title AS [Directorate]
		, p.Title AS [Project]
    , po.Title AS [Partner organisation]
		, re.Description AS [Reporting entity description]
		, mu.Title AS [Performance unit]
		, re.TargetPerformanceLowerLimit AS [Target performance lower limit]
		, re.TargetPerformanceUpperLimit AS [Target performance upper limit]
    , CAST(re.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline delivery date]
		, CAST(re.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast delivery date]
		, CAST(re.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual delivery date]
		, leadUser.Title AS [Lead]
		, e.Title AS [Status]
		, CAST(re.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status last changed]
  FROM dbo.ReportingEntities AS re INNER JOIN
    dbo.ReportingEntityTypes AS ret ON re.ReportingEntityTypeID = ret.ID INNER JOIN
    dbo.ReportTypes AS rt ON ret.ReportTypeID = rt.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON re.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Projects AS p ON re.ProjectID = p.ID LEFT OUTER JOIN
    dbo.PartnerOrganisations AS po ON re.PartnerOrganisationID = po.ID LEFT OUTER JOIN
    dbo.MeasurementUnits AS mu ON re.MeasurementUnitID = mu.ID LEFT OUTER JOIN
    dbo.Users AS leadUser ON re.LeadUserID = leadUser.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS e ON re.EntityStatusID = e.ID