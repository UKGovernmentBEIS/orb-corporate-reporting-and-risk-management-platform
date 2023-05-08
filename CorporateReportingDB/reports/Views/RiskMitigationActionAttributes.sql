CREATE VIEW [reports].[RiskMitigationActionAttributes]
AS
  SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.RiskMitigationActionID AS [Risk Mitigating Action ID]
  FROM dbo.Attributes INNER JOIN
    dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
  WHERE dbo.Attributes.RiskMitigationActionID IS NOT NULL
