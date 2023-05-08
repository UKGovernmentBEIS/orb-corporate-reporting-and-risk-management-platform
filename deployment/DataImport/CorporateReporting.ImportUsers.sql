--
-- Import users from spreadsheet table
--

PRINT N'
Importing users'

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Username]
	,i.[Name]
FROM [dbo].[ImportUsers$] AS i
WHERE i.[Username] NOT IN (SELECT [Username] FROM [dbo].[Users]) AND i.[Name] NOT IN (SELECT [Title] FROM [dbo].[Users])


PRINT N'
Importing user directorates'

INSERT INTO [dbo].[UserDirectorates]
	([UserID]
	,[DirectorateID]
	,[IsAdmin])
SELECT DISTINCT
	u.[ID]
	,d.[ID]
	,CASE i.[Administrator] WHEN 'Y' THEN 1 ELSE 0 END
FROM [dbo].[ImportUserDirectorates$] AS i
INNER JOIN [dbo].[Users] AS u ON i.[Username] = u.[Username]
INNER JOIN [dbo].[Directorates] AS d ON i.[Directorate] = d.[Title]
WHERE CONCAT(u.[ID], '#', d.[ID]) NOT IN (SELECT CONCAT([UserID], '#', [DirectorateID]) FROM [dbo].[UserDirectorates])


PRINT N'
Importing user projects'

INSERT INTO [dbo].[UserProjects]
	([UserID]
	,[ProjectID]
	,[IsAdmin])
SELECT DISTINCT
	u.[ID]
	,p.[ID]
	,CASE i.[Administrator] WHEN 'Y' THEN 1 ELSE 0 END
FROM [dbo].[ImportUserProjects$] AS i
INNER JOIN [dbo].[Users] AS u ON i.[Username] = u.[Username]
INNER JOIN [dbo].[Projects] AS p ON i.[Project] = p.[Title]
WHERE CONCAT(u.[ID], '#', p.[ID]) NOT IN (SELECT CONCAT([UserID], '#', [ProjectID]) FROM [dbo].[UserProjects])
