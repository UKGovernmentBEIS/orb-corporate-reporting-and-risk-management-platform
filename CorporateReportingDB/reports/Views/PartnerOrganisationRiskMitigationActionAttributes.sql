CREATE VIEW [reports].[PartnerOrganisationRiskMitigationActionAttributes]
AS
  SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.PartnerOrganisationRiskMitigationActionID AS [Partner Organisation Risk Mitigating Action ID]
  FROM dbo.Attributes INNER JOIN
    dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
  WHERE dbo.Attributes.PartnerOrganisationRiskMitigationActionID IS NOT NULL
