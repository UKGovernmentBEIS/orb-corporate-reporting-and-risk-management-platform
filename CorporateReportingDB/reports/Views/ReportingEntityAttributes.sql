CREATE VIEW [reports].[ReportingEntityAttributes]
AS
  SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.ReportingEntityID AS [Reporting Entity ID]
  FROM dbo.Attributes INNER JOIN
    dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
  WHERE dbo.Attributes.ReportingEntityID IS NOT NULL