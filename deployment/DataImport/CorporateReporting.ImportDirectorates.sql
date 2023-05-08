--
-- Create SignOff records before running script
--

PRINT N'
Importing users'

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Director]
	,i.[Director]
FROM [dbo].[ImportDirectorates$] AS i
WHERE i.[Director] IS NOT NULL AND i.[Director] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Lead]
	,i.[Lead]
FROM [dbo].[ImportKeyWorkAreas$] AS i
WHERE i.[Lead] IS NOT NULL AND i.[Lead] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Contributor]
	,i.[Contributor]
FROM [dbo].[ImportKeyWorkAreas$] AS i
WHERE i.[Contributor] IS NOT NULL AND i.[Contributor] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Contributor2]
	,i.[Contributor2]
FROM [dbo].[ImportKeyWorkAreas$] AS i
WHERE i.[Contributor2] IS NOT NULL AND i.[Contributor2] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Contributor3]
	,i.[Contributor3]
FROM [dbo].[ImportKeyWorkAreas$] AS i
WHERE i.[Contributor3] IS NOT NULL AND i.[Contributor3] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Lead]
	,i.[Lead]
FROM [dbo].[ImportMetrics$] AS i
WHERE i.[Lead] IS NOT NULL AND i.[Lead] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Contributor]
	,i.[Contributor]
FROM [dbo].[ImportMetrics$] AS i
WHERE i.[Contributor] IS NOT NULL AND i.[Contributor] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Lead]
	,i.[Lead]
FROM [dbo].[ImportMilestones$] AS i
WHERE i.[Lead] IS NOT NULL AND i.[Lead] NOT IN (SELECT [Title] FROM [dbo].[Users])


PRINT N'
Importing directorate objectives'

UPDATE d
SET d.[Objectives] = i.[Objectives]
FROM [dbo].[Directorates] AS d 
INNER JOIN [dbo].[ImportDirectorates$] AS i ON d.[Title] = i.[Name]


PRINT N'
Creating Sign-Offs'

INSERT INTO [dbo].[SignOffs] 
	([SignOffDate]
	,[SignOffUserID]
	,[ReportMonth]
	,[DirectorateID]
	,[IsCurrent])
SELECT 
	GETDATE()
	,1
	,i.[Report Month]
	,d.[ID]
	,1
FROM [dbo].[ImportDirectorateUpdates$] AS i
INNER JOIN [dbo].[Directorates] AS d ON i.[Directorate] = d.[Title]
WHERE i.[Directorate] IS NOT NULL AND CONCAT(d.[ID],'#',FORMAT(i.[Report Month],'yyyy-MM-dd')) NOT IN (SELECT CONCAT([DirectorateID],'#',[ReportMonth]) FROM [dbo].[SignOffs] WHERE [DirectorateID] IS NOT NULL)


PRINT N'
Importing directorate updates'

INSERT INTO [dbo].[DirectorateUpdates] 
	([DirectorateID]
	,[UpdateDate]
	,[OverallRagOptionID]
	,[FinanceRagOptionID]
	,[FinanceComment]
	,[PeopleRagOptionID]
	,[PeopleComment]
	,[MilestonesRagOptionID]
	,[MilestonesComment]
	,[MetricsRagOptionID]
	,[MetricsComment]
	,[ProgressUpdate]
	,[FutureActions]
	,[Escalations]
	,[SignOffID])
SELECT DISTINCT
	d.[ID]
	,GETDATE()
	,[DC Rating]
	,[Finance RAG]
	,LEFT([Finance Narrative],250)
	,[People RAG]
	,LEFT([People Narrative],250)
	,[Milestones RAG]
	,LEFT([Milestones Narrative],250)
	,[Metrics RAG]
	,LEFT([Metrics Narrative],250)
	,LEFT([Headline report],400)
	,LEFT([Future Action],300)
	,LEFT([Escalation],200)
	,s.[ID]
FROM [dbo].[ImportDirectorateUpdates$] AS i 
INNER JOIN [dbo].[Directorates] AS d ON i.[Directorate] = d.[Title]
INNER JOIN [dbo].[SignOffs] AS s ON d.[ID] = s.[DirectorateID] AND i.[Report Month] = s.[ReportMonth]
WHERE i.[Directorate] IS NOT NULL AND CONCAT(d.[ID],'#',s.[ID]) NOT IN (SELECT CONCAT([DirectorateID],'#',[SignOffID]) FROM [dbo].[DirectorateUpdates] WHERE [SignOffID] IS NOT NULL)


PRINT N'
Importing key work areas'

INSERT INTO [dbo].[KeyWorkAreas]
	([DirectorateID]
	,[Title]
	,[LeadUserID])
SELECT DISTINCT
	d.[ID]
	,[Name]
	,u.[ID]
FROM [dbo].[ImportKeyWorkAreas$] AS i
INNER JOIN [dbo].[Directorates] AS d ON i.[Directorate] = d.[Title]
INNER JOIN [dbo].[Users] AS u ON i.[Lead] = u.[Title]
WHERE i.[Name] IS NOT NULL AND CONCAT(d.[ID],'#',[Name]) NOT IN (SELECT CONCAT([DirectorateID],'#',[Title]) FROM [dbo].[KeyWorkAreas])


PRINT N'
Importing key work area updates'

INSERT INTO [dbo].[KeyWorkAreaUpdates]
	([KeyWorkAreaID]
    ,[UpdateDate]
    ,[RagOptionID]
    ,[Comment]
    ,[SignOffID])
SELECT DISTINCT
	k.[ID]
	,GETDATE()
	,[RAG]
	,LEFT([Update],500)
	,s.[ID]
FROM [dbo].[ImportKeyWorkAreaUpdates$] AS i 
INNER JOIN [dbo].[Directorates] AS d ON i.[Directorate] = d.[Title]
INNER JOIN [dbo].[KeyWorkAreas] AS k ON i.[Key Work Area] = k.[Title] AND k.[DirectorateID] = d.[ID]
INNER JOIN [dbo].[SignOffs] AS s ON d.[ID] = s.[DirectorateID] AND i.[Report Month] = s.[ReportMonth]
WHERE CONCAT(i.[Update],'#',s.[ID]) NOT IN (SELECT CONCAT([Comment],'#',[SignOffID]) FROM [dbo].[KeyWorkAreaUpdates] WHERE [SignOffID] IS NOT NULL)


PRINT N'
Importing metrics'

INSERT INTO [dbo].[Metrics]
	([Title]
	,[MetricCode]
	,[DirectorateID]
	,[Description]
	,[TargetPerformanceLowerLimit]
	,[TargetPerformanceUpperLimit]
	,[LeadUserID])
SELECT DISTINCT
	i.[Name]
	,i.[Metric ID]
	,d.[ID]
	,i.[Description]
	,i.[Target performance lower limit]
	,i.[Target performance upper limit]
	,u.[ID]
FROM [dbo].[ImportMetrics$] AS i
INNER JOIN [dbo].[Directorates] AS d ON i.[Directorate] = d.[Title]
LEFT OUTER JOIN [dbo].[Users] AS u ON i.[Lead] = u.[Title]
WHERE i.[Name] IS NOT NULL AND CONCAT(d.[ID],'#',i.[Name]) NOT IN (SELECT CONCAT([DirectorateID],'#',[Title]) FROM [dbo].[Metrics])


PRINT N'
Importing metric updates'

INSERT INTO [dbo].[MetricUpdates]
	([MetricID]
    ,[UpdateDate]
    ,[RagOptionID]
    ,[Comment]
	,[CurrentPerformance]
    ,[SignOffID])
SELECT DISTINCT
	m.[ID]
	,GETDATE()
	,[RAG]
	,LEFT([Progress update],400)
	,i.[Current performance]
	,s.[ID]
FROM [dbo].[ImportMetricUpdates$] AS i 
INNER JOIN [dbo].[Metrics] AS m ON i.[Metric] = m.[Title]
INNER JOIN [dbo].[SignOffs] AS s ON m.[DirectorateID] = s.[DirectorateID] AND i.[Report Month] = s.[ReportMonth]
WHERE i.[Progress update] IS NOT NULL AND CONCAT(i.[Progress update],'#',s.[ID]) NOT IN (SELECT CONCAT([Comment],'#',[SignOffID]) FROM [dbo].[MetricUpdates] WHERE [SignOffID] IS NOT NULL)


PRINT N'
Importing milestones'

INSERT INTO [dbo].[Milestones]
	([Title]
	,[MilestoneCode]
	,[BaselineDate]
	,[ForecastDate]
	,[ActualDate]
	,[LeadUserID]
	,[KeyWorkAreaID])
SELECT DISTINCT
	i.[Name]
	,i.[Milestone ID]
	,i.[Baseline date]
	,i.[Forecast date]
	,i.[Actual date]
	,u.[ID]
	,k.[ID]
FROM [dbo].[ImportMilestones$] AS i
INNER JOIN [dbo].[KeyWorkAreas] AS k ON i.[Key Work Area] = k.[Title]
LEFT OUTER JOIN [dbo].[Users] AS u ON i.[Lead] = u.[Title]
WHERE i.[Name] IS NOT NULL AND CONCAT(k.[ID],'#',i.[Name]) NOT IN (SELECT CONCAT([KeyWorkAreaID],'#',[Title]) FROM [dbo].[Milestones])


PRINT N'
Importing milestone attributes'

INSERT INTO [dbo].[MilestoneAttributes]
	([MilestoneID]
	,[MilestoneAttributeTypeID]
	,[AttributeValue])
SELECT DISTINCT
	m.[ID]
	,mat.[ID]
	,i.[Attribute Value]
FROM [dbo].[ImportMilestones$] AS i
LEFT OUTER JOIN [dbo].[Milestones] AS m ON i.[Name] = m.[Title]
INNER JOIN [dbo].[MilestoneAttributeTypes] AS mat ON i.[Attribute Name] = mat.[Title]
WHERE i.[Name] IS NOT NULL AND i.[Attribute Name] IS NOT NULL AND CONCAT(m.[ID],'#',mat.[ID]) NOT IN (SELECT CONCAT([MilestoneID],'#',[MilestoneAttributeTypeID]) FROM [dbo].[MilestoneAttributes])

INSERT INTO [dbo].[MilestoneAttributes]
	([MilestoneID]
	,[MilestoneAttributeTypeID]
	,[AttributeValue])
SELECT DISTINCT
	m.[ID]
	,mat.[ID]
	,i.[Attribute Value 2]
FROM [dbo].[ImportMilestones$] AS i
LEFT OUTER JOIN [dbo].[Milestones] AS m ON i.[Name] = m.[Title]
INNER JOIN [dbo].[MilestoneAttributeTypes] AS mat ON i.[Attribute Name2] = mat.[Title]
WHERE i.[Name] IS NOT NULL AND i.[Attribute Name2] IS NOT NULL AND CONCAT(m.[ID],'#',mat.[ID]) NOT IN (SELECT CONCAT([MilestoneID],'#',[MilestoneAttributeTypeID]) FROM [dbo].[MilestoneAttributes])

INSERT INTO [dbo].[MilestoneAttributes]
	([MilestoneID]
	,[MilestoneAttributeTypeID]
	,[AttributeValue])
SELECT DISTINCT
	m.[ID]
	,mat.[ID]
	,i.[Attribute Value 3]
FROM [dbo].[ImportMilestones$] AS i
LEFT OUTER JOIN [dbo].[Milestones] AS m ON i.[Name] = m.[Title]
INNER JOIN [dbo].[MilestoneAttributeTypes] AS mat ON i.[Attribute Name3] = mat.[Title]
WHERE i.[Name] IS NOT NULL AND i.[Attribute Name3] IS NOT NULL AND CONCAT(m.[ID],'#',mat.[ID]) NOT IN (SELECT CONCAT([MilestoneID],'#',[MilestoneAttributeTypeID]) FROM [dbo].[MilestoneAttributes])

PRINT N'
Importing milestone updates'

INSERT INTO [dbo].[MilestoneUpdates]
	([MilestoneID]
    ,[UpdateDate]
    ,[RagOptionID]
    ,[Comment]
	,[ForecastDate]
	,[ActualDate]
    ,[SignOffID])
SELECT DISTINCT
	m.[ID]
	,GETDATE()
	,i.[RAG]
	,LEFT(i.[Progress update],400)
	,i.[Forecast date]
	,i.[Actual completion date]
	,sk.[ID]
FROM [dbo].[ImportMilestoneUpdates$] AS i 
INNER JOIN [dbo].[Milestones] AS m ON i.[Milestone] = m.[Title]
INNER JOIN [dbo].[KeyWorkAreas] AS k ON k.[ID] = m.[KeyWorkAreaID]
INNER JOIN [dbo].[SignOffs] AS sk ON k.[DirectorateID] = sk.[DirectorateID] AND i.[Report Month] = sk.[ReportMonth]
WHERE CONCAT(i.[Progress update],'#',sk.[ID]) NOT IN (SELECT CONCAT([Comment],'#',[SignOffID]) FROM [dbo].[MilestoneUpdates] WHERE [SignOffID] IS NOT NULL)
