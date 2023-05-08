CREATE VIEW [dbo].[ReportingEntityProperties]
AS
  SELECT re.ID AS ReportingEntityID
  , retf.FieldType
  , retf.LookupListID
  , retf.LookupList
  , retf.FieldTitle
  , props.value AS [Value]
  FROM [dbo].[ReportingEntities] AS re 
  CROSS APPLY OPENJSON(Properties) AS props INNER JOIN
    [dbo].[ReportingEntityTypeFields] AS retf ON re.ReportingEntityTypeID = retf.ReportingEntityTypeID AND props.[key] COLLATE Latin1_General_CI_AS = retf.FieldName
