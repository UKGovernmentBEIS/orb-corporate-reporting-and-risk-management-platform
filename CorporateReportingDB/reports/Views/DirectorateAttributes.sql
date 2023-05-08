CREATE VIEW [reports].[DirectorateAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.DirectorateID AS [Directorate ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.DirectorateID IS NOT NULL