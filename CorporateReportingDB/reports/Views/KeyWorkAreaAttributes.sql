CREATE VIEW [reports].[KeyWorkAreaAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.KeyWorkAreaID AS [Key Work Area ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.KeyWorkAreaID IS NOT NULL