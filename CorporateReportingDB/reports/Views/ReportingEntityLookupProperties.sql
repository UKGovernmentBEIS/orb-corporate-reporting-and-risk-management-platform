CREATE VIEW [reports].[ReportingEntityLookupProperties]
AS
  SELECT rep.ReportingEntityID
  , rep.LookupList
  , rep.FieldTitle
  , CASE rep.LookupListID
  WHEN -1 THEN kwa.Title
  WHEN -2 THEN milestones.Title
  WHEN -3 THEN metrics.Title
  WHEN -4 THEN commitments.Title
  WHEN -5 THEN workStreams.Title
  WHEN -6 THEN milestones.Title
  WHEN -7 THEN benefits.Title
  WHEN -8 THEN dependencies.Title
  WHEN -9 THEN milestones.Title
  WHEN -10 THEN poRisks.Title
  WHEN -11 THEN poRMA.Title
  ELSE re.Title
  END AS [Value]
  FROM [dbo].[ReportingEntityProperties] AS rep LEFT OUTER JOIN
    [dbo].[KeyWorkAreas] AS kwa ON rep.LookupListID = -1 AND rep.[Value] = kwa.ID LEFT OUTER JOIN
    [dbo].[Milestones] AS milestones ON (rep.LookupListID = -2 OR rep.LookupListID = -6 OR rep.LookupListID = -9) AND rep.[Value] = milestones.ID LEFT OUTER JOIN
    [dbo].[Metrics] AS metrics ON rep.LookupListID = -3 AND rep.[Value] = metrics.ID LEFT OUTER JOIN
    [dbo].[Commitments] AS commitments ON rep.LookupListID = -4 AND rep.[Value] = commitments.ID LEFT OUTER JOIN
    [dbo].[WorkStreams] AS workStreams ON rep.LookupListID = -5 AND rep.[Value] = workStreams.ID LEFT OUTER JOIN
    [dbo].[Benefits] AS benefits ON rep.LookupListID = -7 AND rep.[Value] = benefits.ID LEFT OUTER JOIN
    [dbo].[Dependencies] AS dependencies ON rep.LookupListID = -8 AND rep.[Value] = dependencies.ID LEFT OUTER JOIN
    [dbo].[PartnerOrganisationRisks] AS poRisks ON rep.LookupListID = -10 AND rep.[Value] = poRisks.ID LEFT OUTER JOIN
    [dbo].[PartnerOrganisationRiskMitigationActions] AS poRMA ON rep.LookupListID = -11 AND rep.[Value] = poRMA.ID LEFT OUTER JOIN
    [dbo].[ReportingEntities] AS re ON rep.LookupListID = re.ReportingEntityTypeID AND rep.[Value] = re.ID
  WHERE rep.FieldType = 3