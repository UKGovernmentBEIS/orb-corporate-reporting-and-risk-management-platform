CREATE VIEW [reports].[ProjectAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.ProjectID AS [Project ID]
		, dbo.Attributes.ID AS [Project Attribute ID]
		, dbo.AttributeTypes.Title AS [Project Attribute]
		, dbo.Attributes.AttributeValue AS [Project Attribute Value]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.ProjectID IS NOT NULL