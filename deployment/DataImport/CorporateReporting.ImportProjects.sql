--
-- 
--

PRINT N'
Importing users'

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[SRO]
	,i.[SRO]
FROM [dbo].[ImportProjects$] AS i
WHERE i.[SRO] IS NOT NULL AND i.[SRO] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Lead]
	,i.[Lead]
FROM [dbo].[ImportWorkStreams$] AS i
WHERE i.[Lead] IS NOT NULL AND i.[Lead] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Contributor]
	,i.[Contributor]
FROM [dbo].[ImportWorkStreams$] AS i
WHERE i.[Contributor] IS NOT NULL AND i.[Contributor] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Contributor2]
	,i.[Contributor2]
FROM [dbo].[ImportWorkStreams$] AS i
WHERE i.[Contributor2] IS NOT NULL AND i.[Contributor2] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Contributor3]
	,i.[Contributor3]
FROM [dbo].[ImportWorkStreams$] AS i
WHERE i.[Contributor3] IS NOT NULL AND i.[Contributor3] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Lead]
	,i.[Lead]
FROM [dbo].[ImportBenefits$] AS i
WHERE i.[Lead] IS NOT NULL AND i.[Lead] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Contributor]
	,i.[Contributor]
FROM [dbo].[ImportBenefits$] AS i
WHERE i.[Contributor] IS NOT NULL AND i.[Contributor] NOT IN (SELECT [Title] FROM [dbo].[Users])

INSERT INTO [dbo].[Users]
	([Username]
	,[Title])
SELECT DISTINCT
	i.[Lead]
	,i.[Lead]
FROM [dbo].[ImportProjectMilestones$] AS i
WHERE i.[Lead] IS NOT NULL AND i.[Lead] NOT IN (SELECT [Title] FROM [dbo].[Users])


PRINT N'
Importing projects'

INSERT INTO [dbo].[Projects]
	([Title]
	,[SeniorResponsibleOwnerUserID]
	,[ProjectManagerUserID]
	,[Objectives]
	,[StartDate]
	,[EndDate])
SELECT
	i.[Name]
	,sro.[ID]
	,pm.[ID]
	,i.[Objectives]
	,i.[Start Date]
	,i.[End Date]
FROM [dbo].[ImportProjects$] AS i
INNER JOIN [dbo].[Users] AS sro ON i.[SRO] = sro.[Title]
LEFT OUTER JOIN [dbo].[Users] AS pm ON i.[Project Manager] = pm.[Title]
WHERE i.[Name] IS NOT NULL AND i.[Name] NOT IN (SELECT [Title] FROM [dbo].[Projects])


PRINT N'
Creating Sign-Offs'

INSERT INTO [dbo].[SignOffs] 
	([SignOffDate]
	,[SignOffUserID]
	,[ReportMonth]
	,[ProjectID]
	,[IsCurrent])
SELECT 
	GETDATE()
	,1
	,i.[Report Month]
	,p.[ID]
	,1
FROM [dbo].[ImportProjectUpdates$] AS i
INNER JOIN [dbo].[Projects] AS p ON i.[Project] = p.[Title]
WHERE i.[Project] IS NOT NULL AND CONCAT(p.[ID],'#',FORMAT(i.[Report Month],'yyyy-MM-dd')) NOT IN (SELECT CONCAT([ProjectID],'#',[ReportMonth]) FROM [dbo].[SignOffs] WHERE [ProjectID] IS NOT NULL)


PRINT N'
Importing project updates'
GO

INSERT INTO [dbo].[ProjectUpdates] 
	([ProjectID]
	,[UpdateDate]
	,[OverallRagOptionID]
	,[FinanceRagOptionID]
	,[FinanceComment]
	,[PeopleRagOptionID]
	,[PeopleComment]
	,[MilestonesRagOptionID]
	,[MilestonesComment]
	,[BenefitsRagOptionID]
	,[BenefitsComment]
	,[ProgressUpdate]
	,[FutureActions]
	,[Escalations]
	,[SignOffID]
	,[UpdatePeriod])
SELECT 
	p.[ID]
	,GETDATE()
	,[DC Rating]
	,[Finance RAG]
	,LEFT([Finance Narrative],250)
	,[People RAG]
	,LEFT([People Narrative],250)
	,[Milestones RAG]
	,LEFT([Milestones Narrative],250)
	,[Benefits RAG]
	,LEFT([Benefits Narrative],250)
	,LEFT([Headline report],400)
	,LEFT([Future Action],300)
	,LEFT([Escalation],200)
	,s.[ID]
	,i.[Report Month]
FROM [dbo].[ImportProjectUpdates$] AS i
INNER JOIN [dbo].[Projects] AS p ON i.[Project] = p.[Title]
INNER JOIN [dbo].[SignOffs] AS s ON p.[ID] = s.[ProjectID] AND i.[Report Month] = s.[ReportMonth]
WHERE i.[Project] IS NOT NULL AND CONCAT(p.[ID],'#',s.[ID]) NOT IN (SELECT CONCAT([ProjectID],'#',[SignOffID]) FROM [dbo].[ProjectUpdates] WHERE [SignOffID] IS NOT NULL)


PRINT N'
Importing work streams'

INSERT INTO [dbo].[WorkStreams]
	([ProjectID]
	,[Title]
	,[LeadUserID])
SELECT
	p.[ID]
	,[Name]
	,u.[ID]
FROM [dbo].[ImportWorkStreams$] AS i
INNER JOIN [dbo].[Projects] AS p ON i.[Project] = p.[Title]
LEFT OUTER JOIN [dbo].[Users] AS u ON i.[Lead] = u.[Title]
WHERE i.[Name] IS NOT NULL AND CONCAT(p.[ID],'#',[Name]) NOT IN (SELECT CONCAT([ProjectID],'#',[Title]) FROM [dbo].[WorkStreams])


PRINT N'
Importing work stream updates'

INSERT INTO [dbo].[WorkStreamUpdates]
	([WorkStreamID]
    ,[UpdateDate]
    ,[RagOptionID]
    ,[Comment]
    ,[SignOffID])
SELECT 
	w.[ID]
	,GETDATE()
	,[RAG]
	,LEFT([Update],500)
	,s.[ID]
FROM [dbo].[ImportWorkStreamsUpdates$] AS i 
INNER JOIN [dbo].[WorkStreams] AS w ON i.[Work Stream] = w.[Title]
INNER JOIN [dbo].[SignOffs] AS s ON w.[ProjectID] = s.[ProjectID] AND i.[Report Month] = s.[ReportMonth]
WHERE CONCAT(i.[Update],'#',s.[ID]) NOT IN (SELECT CONCAT([Comment],'#',[SignOffID]) FROM [dbo].[WorkStreamUpdates] WHERE [SignOffID] IS NOT NULL)


PRINT N'
Importing benefits'

INSERT INTO [dbo].[Benefits]
	([Title]
	,[ProjectID]
	,[TargetPerformanceLowerLimit]
	,[TargetPerformanceUpperLimit]
	,[LeadUserID])
SELECT
	i.[Name]
	,p.[ID]
	,i.[Target performance lower limit]
	,i.[Target performance upper limit]
	,u.[ID]
FROM [dbo].[ImportBenefits$] AS i
INNER JOIN [dbo].[Projects] AS p ON i.[Project] = p.[Title]
LEFT OUTER JOIN [dbo].[Users] AS u ON i.[Lead] = u.[Title]
WHERE i.[Name] IS NOT NULL AND CONCAT(p.[ID],'#',i.[Name]) NOT IN (SELECT CONCAT([ProjectID],'#',[Title]) FROM [dbo].[Benefits])


PRINT N'
Importing benefit updates'

INSERT INTO [dbo].[BenefitUpdates]
	([BenefitID]
    ,[UpdateDate]
    ,[RagOptionID]
    ,[Comment]
    ,[SignOffID])
SELECT 
	b.[ID]
	,GETDATE()
	,[RAG]
	,LEFT([Progress update],400)
	,s.[ID]
FROM [dbo].[ImportBenefitUpdates$] AS i 
INNER JOIN [dbo].[Benefits] AS b ON i.[Name] = b.[Title]
INNER JOIN [dbo].[SignOffs] AS s ON b.[ProjectID] = s.[ProjectID] AND i.[Report Month] = s.[ReportMonth]
WHERE CONCAT(i.[Progress update],'#',s.[ID]) NOT IN (SELECT CONCAT([Comment],'#',[SignOffID]) FROM [dbo].[BenefitUpdates] WHERE [SignOffID] IS NOT NULL)


PRINT N'
Importing milestones'

INSERT INTO [dbo].[Milestones]
	([Title]
	,[MilestoneCode]
	,[BaselineDate]
	,[ForecastDate]
	,[ActualDate]
	,[LeadUserID]
	,[WorkStreamID])
SELECT 
	i.[Name]
	,i.[Milestone ID]
	,i.[Baseline date]
	,i.[Forecast date]
	,i.[Actual date]
	,u.[ID]
	,w.[ID]
FROM [dbo].[ImportProjectMilestones$] AS i
INNER JOIN [dbo].[WorkStreams] AS w ON i.[Work Stream] = w.[Title]
LEFT OUTER JOIN [dbo].[Users] AS u ON i.[Lead] = u.[Title]
WHERE i.[Name] IS NOT NULL AND CONCAT(w.[ID],'#',i.[Name]) NOT IN (SELECT CONCAT([WorkStreamID],'#',[Title]) FROM [dbo].[Milestones])


PRINT N'
Importing milestone attributes'

INSERT INTO [dbo].[MilestoneAttributes]
	([MilestoneID]
	,[MilestoneAttributeTypeID]
	,[AttributeValue])
SELECT
	m.[ID]
	,mat.[ID]
	,i.[Attribute Value]
FROM [dbo].[ImportProjectMilestones$] AS i
INNER JOIN [dbo].[Milestones] AS m ON i.[Name] = m.[Title]
INNER JOIN [dbo].[MilestoneAttributeTypes] AS mat ON i.[Attribute Name] = mat.[Title]
WHERE i.[Name] IS NOT NULL AND i.[Attribute Name] IS NOT NULL AND CONCAT(m.[ID],'#',mat.[ID]) NOT IN (SELECT CONCAT([MilestoneID],'#',[MilestoneAttributeTypeID]) FROM [dbo].[MilestoneAttributes])

INSERT INTO [dbo].[MilestoneAttributes]
	([MilestoneID]
	,[MilestoneAttributeTypeID]
	,[AttributeValue])
SELECT
	m.[ID]
	,mat.[ID]
	,i.[Attribute Value 2]
FROM [dbo].[ImportProjectMilestones$] AS i
INNER JOIN [dbo].[Milestones] AS m ON i.[Name] = m.[Title]
INNER JOIN [dbo].[MilestoneAttributeTypes] AS mat ON i.[Attribute Name2] = mat.[Title]
WHERE i.[Name] IS NOT NULL AND i.[Attribute Name2] IS NOT NULL AND CONCAT(m.[ID],'#',mat.[ID]) NOT IN (SELECT CONCAT([MilestoneID],'#',[MilestoneAttributeTypeID]) FROM [dbo].[MilestoneAttributes])

INSERT INTO [dbo].[MilestoneAttributes]
	([MilestoneID]
	,[MilestoneAttributeTypeID]
	,[AttributeValue])
SELECT
	m.[ID]
	,mat.[ID]
	,i.[Attribute Value 3]
FROM [dbo].[ImportProjectMilestones$] AS i
INNER JOIN [dbo].[Milestones] AS m ON i.[Name] = m.[Title]
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
SELECT 
	m.[ID]
	,GETDATE()
	,i.[RAG]
	,LEFT(i.[Progress update],400)
	,i.[Forecast date]
	,i.[Actual completion date]
	,sw.[ID]
FROM [dbo].[ImportProjectMilestoneUpdates$] AS i 
INNER JOIN [dbo].[Milestones] AS m ON i.[Milestone] = m.[Title]
INNER JOIN [dbo].[WorkStreams] AS w ON w.[ID] = m.[WorkStreamID]
INNER JOIN [dbo].[SignOffs] AS sw ON w.[ProjectID] = sw.[ProjectID] AND i.[Report Month] = sw.[ReportMonth]
WHERE CONCAT(i.[Progress update],'#',sw.[ID]) NOT IN (SELECT CONCAT([Comment],'#',[SignOffID]) FROM [dbo].[MilestoneUpdates] WHERE [SignOffID] IS NOT NULL)
