CREATE VIEW [reports].[PartnerOrganisationAttributes]
AS
  SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.PartnerOrganisationID AS [Partner Organisation ID]
  FROM dbo.Attributes INNER JOIN
    dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
  WHERE dbo.Attributes.PartnerOrganisationID IS NOT NULL
