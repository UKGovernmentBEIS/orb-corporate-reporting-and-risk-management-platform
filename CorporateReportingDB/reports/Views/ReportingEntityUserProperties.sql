CREATE VIEW [reports].[ReportingEntityUserProperties]
AS
  SELECT rep.ReportingEntityID, rep.FieldTitle, u.Title AS [User]
  FROM [dbo].[ReportingEntityProperties] AS rep
  OUTER APPLY OPENJSON(rep.Value) AS users INNER JOIN
    [dbo].[Users] AS u ON users.value = u.ID
  WHERE rep.FieldType = 5