CREATE VIEW [dbo].[ReportingEntityTypeFields]
AS
  SELECT ret.ID AS ReportingEntityTypeID
  , FieldName
  , FieldTitle
  , FieldType
  , fields.LookupList AS LookupListID
  , lookup.Title AS LookupList
  FROM [dbo].[ReportingEntityTypes] AS ret
  CROSS APPLY OPENJSON(CustomFields) WITH (
    FieldName NVARCHAR(255) '$.FieldName', 
    FieldTitle NVARCHAR(255) '$.Title', 
    FieldType INT '$.Type', 
    LookupList INT '$.LookupList'
    ) AS fields LEFT OUTER JOIN
    [dbo].[ReportingEntityTypes] AS lookup ON fields.LookupList = lookup.ID