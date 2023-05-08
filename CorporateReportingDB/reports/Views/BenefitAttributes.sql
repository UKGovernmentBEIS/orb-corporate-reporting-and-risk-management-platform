CREATE VIEW [reports].[BenefitAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.BenefitID AS [Benefit ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.BenefitID IS NOT NULL