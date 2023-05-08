CREATE VIEW [reports].[ReportingEntityChoiceProperties]
AS
  SELECT rep.ReportingEntityID, rep.FieldTitle, choices.value AS [Value]
  FROM [dbo].[ReportingEntityProperties] AS rep
  OUTER APPLY OPENJSON(rep.Value) AS choices
  WHERE rep.FieldType = 6