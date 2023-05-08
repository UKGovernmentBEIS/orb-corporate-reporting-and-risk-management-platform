CREATE VIEW [reports].[PartnerOrganisationRiskAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.PartnerOrganisationRiskID AS [Partner Organisation Risk ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.PartnerOrganisationRiskID IS NOT NULL