-- =============================================
-- Author:      Andrew Lott
-- Create Date: 2021-03-10
-- Description: Function to generate ReportJson for existing reports
-- =============================================
CREATE FUNCTION [dbo].[GenerateReportJson]
(
    @signOffId INT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    
	IF (SELECT DirectorateID FROM [dbo].[SignOffs] WHERE ID = @signOffId) IS NOT NULL
	BEGIN
		-- Get directorate details at time of report
		DECLARE @directorateJson NVARCHAR(MAX);
		SET @directorateJson = (
			SELECT d.ID
				,d.Title
				,d.GroupID
				,d.DirectorUserID
				,d.Objectives
				,d.EntityStatusID
				,d.EntityStatusDate
				,d.ModifiedByUserID
				,d.ReportApproverUserID
				,d.ReportingLeadUserID
				,d.ReportingFrequency
				,d.ReportingDueDay
				,d.ReportingStartDate 
				,(SELECT du.[ID]
					  ,du.[Title]
					  ,du.[Comment]
					  ,du.[RagOptionID]
					  ,du.[DirectorateID]
					  ,du.[UpdateDate]
					  ,du.[OverallRagOptionID]
					  ,du.[FinanceRagOptionID]
					  ,du.[FinanceComment]
					  ,du.[PeopleRagOptionID]
					  ,du.[PeopleComment]
					  ,du.[MilestonesRagOptionID]
					  ,du.[MilestonesComment]
					  ,du.[MetricsRagOptionID]
					  ,du.[MetricsComment]
					  ,du.[ProgressUpdate]
					  ,du.[FutureActions]
					  ,du.[Escalations]
					  ,du.[UpdateUserID]
					  ,du.[SignOffID]
					  ,du.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(du.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = du.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[DirectorateUpdates] AS du WHERE du.SignOffID = so.ID FOR JSON PATH) AS DirectorateUpdates
			FROM [dbo].[Directorates] FOR SYSTEM_TIME ALL AS d
			INNER JOIN [dbo].[SignOffs] AS so ON d.ID = so.DirectorateID AND so.SignOffDate >= d.SysStartTime AND so.SignOffDate < d.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
		);

		-- Get key work areas and updates at time of report
		DECLARE @keyWorkAreaJson NVARCHAR(MAX);
		SET @keyWorkAreaJson = (
			SELECT k.ID
				,k.DirectorateID
				,k.Title
				,k.LeadUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = k.LeadUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS LeadUser
				,k.RagOptionID
				,k.EntityStatusID
				,k.EntityStatusDate
				,k.ModifiedByUserID
				,k.ReportingFrequency
				,k.ReportingDueDay
				,k.ReportingStartDate
				,(SELECT ku.[ID]
					  ,ku.[Title]
					  ,ku.[KeyWorkAreaID]
					  ,ku.[UpdateDate]
					  ,ku.[RagOptionID]
					  ,ku.[Comment]
					  ,ku.[UpdateUserID]
					  ,ku.[SignOffID]
					  ,ku.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(ku.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = ku.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[KeyWorkAreaUpdates] AS ku WHERE ku.KeyWorkAreaID = k.ID AND ku.SignOffID = so.ID FOR JSON PATH) AS KeyWorkAreaUpdates 
				,(SELECT ID, Title, AttributeTypeID, AttributeValue, KeyWorkAreaID, ModifiedByUserID, (SELECT JSON_QUERY((SELECT ID, Title, Display FROM [dbo].[AttributeTypes] AS t WHERE t.ID = a.AttributeTypeID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS AttributeType 
					FROM [dbo].[Attributes] FOR SYSTEM_TIME ALL AS a WHERE a.KeyWorkAreaID = k.ID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime FOR JSON PATH) AS Attributes 
			FROM [dbo].[KeyWorkAreas] FOR SYSTEM_TIME ALL AS k
			INNER JOIN [dbo].[SignOffs] AS so ON k.DirectorateID = so.DirectorateID AND so.SignOffDate >= k.SysStartTime AND so.SignOffDate < k.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		-- Get milestones and updates at time of report
		DECLARE @milestoneJson NVARCHAR(MAX);
		SET @milestoneJson = (
			SELECT m.ID
				,m.Title
				,m.ReportingFrequency
				,m.ReportingDueDay
				,m.ReportingStartDate
				,m.EntityStatusID
				,m.EntityStatusDate
				,m.MilestoneCode
				,m.BaselineDate
				,m.ForecastDate
				,m.ActualDate
				,m.MilestoneTypeID
				,m.LeadUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = m.LeadUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS LeadUser
				,m.RagOptionID
				,m.StartDate
				,m.[Description]
				,m.KeyWorkAreaID
				,(SELECT mu.[ID]
					  ,mu.[Title]
					  ,mu.[MilestoneID]
					  ,mu.[UpdateDate]
					  ,mu.[RagOptionID]
					  ,mu.[Comment]
					  ,mu.[ForecastDate]
					  ,mu.[ActualDate]
					  ,mu.[UpdateUserID]
					  ,mu.[SignOffID]
					  ,mu.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(mu.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = mu.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[MilestoneUpdates] AS mu WHERE mu.MilestoneID = m.ID AND mu.SignOffID = so.ID FOR JSON PATH) AS MilestoneUpdates 
			FROM [dbo].[Milestones] FOR SYSTEM_TIME ALL AS m
			INNER JOIN [dbo].[KeyWorkAreas] FOR SYSTEM_TIME ALL AS k ON m.KeyWorkAreaID = k.ID
			INNER JOIN [dbo].[SignOffs] AS so ON k.DirectorateID = so.DirectorateID AND so.SignOffDate >= m.SysStartTime AND so.SignOffDate < m.SysEndTime AND so.SignOffDate >= k.SysStartTime AND so.SignOffDate < k.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		-- Get commitments and updates at time of report
		DECLARE @commitmentJson NVARCHAR(MAX);
		SET @commitmentJson = (
			SELECT c.ID
				,c.Title
				,c.ReportingFrequency
				,c.ReportingDueDay
				,c.ReportingStartDate
				,c.EntityStatusID
				,c.EntityStatusDate
				,c.DirectorateID
				,c.BaselineDate
				,c.ForecastDate
				,c.ActualDate
				,c.RagOptionID
				,c.LeadUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = c.LeadUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS LeadUser
				,(SELECT cu.[ID]
					  ,cu.[Title]
					  ,cu.[CommitmentID]
					  ,cu.[UpdateDate]
					  ,cu.[UpdateUserID]
					  ,cu.[RagOptionID]
					  ,cu.[Comment]
					  ,cu.[ForecastDate]
					  ,cu.[ActualDate]
					  ,cu.[SignOffID]
					  ,cu.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(cu.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = cu.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser 
					FROM [dbo].[CommitmentUpdates] AS cu WHERE cu.CommitmentID = c.ID AND cu.SignOffID = so.ID FOR JSON PATH) AS CommitmentUpdates
				,(SELECT ID, Title, AttributeTypeID, AttributeValue, CommitmentID, ModifiedByUserID, (SELECT JSON_QUERY((SELECT ID, Title, Display FROM [dbo].[AttributeTypes] AS t WHERE t.ID = a.AttributeTypeID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS AttributeType 
					FROM [dbo].[Attributes] FOR SYSTEM_TIME ALL AS a WHERE a.CommitmentID = c.ID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime FOR JSON PATH) AS Attributes 
			FROM [dbo].[Commitments] FOR SYSTEM_TIME ALL AS c
			INNER JOIN [dbo].[SignOffs] AS so ON c.DirectorateID = so.DirectorateID AND so.SignOffDate >= c.SysStartTime AND so.SignOffDate < c.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		-- Get metrics and updates at time of report
		DECLARE @metricJson NVARCHAR(MAX);
		SET @metricJson = (
			SELECT m.ID
				,m.Title
				,m.ReportingFrequency
				,m.ReportingDueDay
				,m.ReportingStartDate
				,m.EntityStatusID
				,m.EntityStatusDate
				,m.MetricCode
				,m.DirectorateID
				,m.[Description]
				,m.MeasurementUnitID
				,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[MeasurementUnits] AS mu WHERE mu.ID = m.MeasurementUnitID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS MeasurementUnit
				,m.TargetPerformanceUpperLimit
				,m.TargetPerformanceLowerLimit
				,m.LeadUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = m.LeadUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS LeadUser
				,m.RagOptionID
				,(SELECT mu.[ID]
					  ,mu.[Title]
					  ,mu.[MetricID]
					  ,mu.[UpdateDate]
					  ,mu.[RagOptionID]
					  ,mu.[Comment]
					  ,mu.[CurrentPerformance]
					  ,mu.[UpdateUserID]
					  ,mu.[SignOffID]
					  ,mu.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(mu.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = mu.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[MetricUpdates] AS mu WHERE mu.MetricID = m.ID AND mu.SignOffID = so.ID FOR JSON PATH) AS MetricUpdates
				,(SELECT ID, Title, AttributeTypeID, AttributeValue, MetricID, ModifiedByUserID, (SELECT JSON_QUERY((SELECT ID, Title, Display FROM [dbo].[AttributeTypes] AS t WHERE t.ID = a.AttributeTypeID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS AttributeType 
					FROM [dbo].[Attributes] FOR SYSTEM_TIME ALL AS a WHERE a.MetricID = m.ID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime FOR JSON PATH) AS Attributes 
			FROM [dbo].[Metrics] FOR SYSTEM_TIME ALL AS m
			INNER JOIN [dbo].[SignOffs] AS so ON m.DirectorateID = so.DirectorateID AND so.SignOffDate >= m.SysStartTime AND so.SignOffDate < m.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		-- Get project details at time of report
		DECLARE @directorateProjectsJson NVARCHAR(MAX);
		SET @directorateProjectsJson = (
			SELECT p.ID
				,p.Title
				,p.DirectorateID
				,p.Objectives
				,p.EntityStatusID
				,p.EntityStatusDate
				,p.ModifiedByUserID
				,p.ReportApproverUserID
				,p.ReportingLeadUserID
				,p.ReportingFrequency
				,p.ReportingDueDay
				,p.ReportingStartDate 
				,(SELECT pu.[ID]
					  ,pu.[Title]
					  ,pu.[Comment]
					  ,pu.[RagOptionID]
					  ,pu.[ProjectID]
					  ,pu.[UpdateDate]
					  ,pu.[UpdateUserID]
					  ,pu.[OverallRagOptionID]
					  ,pu.[FinanceRagOptionID]
					  ,pu.[FinanceComment]
					  ,pu.[PeopleRagOptionID]
					  ,pu.[PeopleComment]
					  ,pu.[MilestonesRagOptionID]
					  ,pu.[MilestonesComment]
					  ,pu.[BenefitsRagOptionID]
					  ,pu.[BenefitsComment]
					  ,pu.[ProgressUpdate]
					  ,pu.[FutureActions]
					  ,pu.[Escalations]
					  ,pu.[ProjectPhaseID]
					  ,pu.[BusinessCaseTypeID]
					  ,pu.[BusinessCaseDate]
					  ,pu.[WholeLifeCost]
					  ,pu.[WholeLifeBenefit]
					  ,pu.[NetPresentValue]
					  ,pu.[SignOffID]
					  ,pu.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(pu.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = pu.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[ProjectUpdates] AS pu WHERE pu.SignOffID = so.ID FOR JSON PATH) AS ProjectUpdates 
				,(SELECT ID, Title, ProjectAttributeTypeID, ProjectID, ModifiedByUserID, (SELECT JSON_QUERY((SELECT ID, Title, Display FROM [dbo].[ProjectAttributeTypes] AS t WHERE t.ID = a.ProjectAttributeTypeID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS ProjectAttributeType 
					FROM [dbo].[ProjectAttributes] FOR SYSTEM_TIME ALL AS a WHERE a.ProjectID = p.ID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime FOR JSON PATH) AS ProjectAttributes
			FROM [dbo].[Projects] FOR SYSTEM_TIME ALL AS p
			INNER JOIN [dbo].[SignOffs] AS so ON p.DirectorateID = so.DirectorateID AND so.SignOffDate >= p.SysStartTime AND so.SignOffDate < p.SysEndTime
			WHERE so.ID = @signOffId AND p.ShowOnDirectorateReport = 'true'
			FOR JSON PATH
		);

		RETURN CONCAT('{',
		'"Directorate":', COALESCE(@directorateJson, '{}'), ',',
		'"KeyWorkAreas":', COALESCE(@keyWorkAreaJson, '[]'), ',',
		'"Milestones":', COALESCE(@milestoneJson, '[]'), ',',
		'"Metrics":', COALESCE(@metricJson, '[]'), ',',
		'"Commitments":', COALESCE(@commitmentJson, '[]'), ',',
		'"Projects":', COALESCE(@directorateProjectsJson, '[]'),
		'}');
	END
	
	IF (SELECT ProjectID FROM [dbo].[SignOffs] WHERE ID = @signOffId) IS NOT NULL
	BEGIN
		-- Get project details at time of report
		DECLARE @projectJson NVARCHAR(MAX);
		SET @projectJson = (
			SELECT p.ID
				,p.Title
				,p.DirectorateID
				,p.Objectives
				,p.EntityStatusID
				,p.EntityStatusDate
				,p.ModifiedByUserID
				,p.ReportApproverUserID
				,p.ReportingLeadUserID
				,p.ReportingFrequency
				,p.ReportingDueDay
				,p.ReportingStartDate 
				,(SELECT pu.[ID]
					  ,pu.[Title]
					  ,pu.[Comment]
					  ,pu.[RagOptionID]
					  ,pu.[ProjectID]
					  ,pu.[UpdateDate]
					  ,pu.[UpdateUserID]
					  ,pu.[OverallRagOptionID]
					  ,pu.[FinanceRagOptionID]
					  ,pu.[FinanceComment]
					  ,pu.[PeopleRagOptionID]
					  ,pu.[PeopleComment]
					  ,pu.[MilestonesRagOptionID]
					  ,pu.[MilestonesComment]
					  ,pu.[BenefitsRagOptionID]
					  ,pu.[BenefitsComment]
					  ,pu.[ProgressUpdate]
					  ,pu.[FutureActions]
					  ,pu.[Escalations]
					  ,pu.[ProjectPhaseID]
					  ,pu.[BusinessCaseTypeID]
					  ,pu.[BusinessCaseDate]
					  ,pu.[WholeLifeCost]
					  ,pu.[WholeLifeBenefit]
					  ,pu.[NetPresentValue]
					  ,pu.[SignOffID]
					  ,pu.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(pu.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = pu.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[ProjectUpdates] AS pu WHERE pu.SignOffID = so.ID FOR JSON PATH) AS ProjectUpdates 
				,(SELECT ID, Title, ProjectAttributeTypeID, ProjectID, ModifiedByUserID, (SELECT JSON_QUERY((SELECT ID, Title, Display FROM [dbo].[ProjectAttributeTypes] AS t WHERE t.ID = a.ProjectAttributeTypeID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS ProjectAttributeType 
					FROM [dbo].[ProjectAttributes] FOR SYSTEM_TIME ALL AS a WHERE a.ProjectID = p.ID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime FOR JSON PATH) AS ProjectAttributes
			FROM [dbo].[Projects] FOR SYSTEM_TIME ALL AS p
			INNER JOIN [dbo].[SignOffs] AS so ON p.ID = so.ProjectID AND so.SignOffDate >= p.SysStartTime AND so.SignOffDate < p.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
		);

		-- Get work streams and updates at time of report
		DECLARE @workStreamJson NVARCHAR(MAX);
		SET @workStreamJson = (
			SELECT w.ID
				,w.Title
				,w.ReportingFrequency
				,w.ReportingDueDay
				,w.ReportingStartDate 
				,w.EntityStatusID
				,w.EntityStatusDate
				,w.WorkStreamCode
				,w.ProjectID
				,w.LeadUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = w.LeadUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS LeadUser
				,w.RagOptionID
				,w.ModifiedByUserID
				,(SELECT wu.[ID]
					  ,wu.[Title]
					  ,wu.[WorkStreamID]
					  ,wu.[UpdateDate]
					  ,wu.[UpdateUserID]
					  ,wu.[RagOptionID]
					  ,wu.[Comment]
					  ,wu.[SignOffID]
					  ,wu.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(wu.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = wu.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[WorkStreamUpdates] AS wu WHERE wu.WorkStreamID = w.ID AND wu.SignOffID = so.ID FOR JSON PATH) AS WorkStreamUpdates 
				,(SELECT ID, Title, AttributeTypeID, AttributeValue, WorkStreamID, ModifiedByUserID, (SELECT JSON_QUERY((SELECT ID, Title, Display FROM [dbo].[AttributeTypes] AS t WHERE t.ID = a.AttributeTypeID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS AttributeType 
					FROM [dbo].[Attributes] FOR SYSTEM_TIME ALL AS a WHERE a.WorkStreamID = w.ID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime FOR JSON PATH) AS Attributes 
			FROM [dbo].[WorkStreams] FOR SYSTEM_TIME ALL AS w
			INNER JOIN [dbo].[SignOffs] AS so ON w.ProjectID = so.ProjectID AND so.SignOffDate >= w.SysStartTime AND so.SignOffDate < w.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		-- Get milestones and updates at time of report
		DECLARE @projectMilestoneJson NVARCHAR(MAX);
		SET @projectMilestoneJson = (
			SELECT m.ID
				,m.Title
				,m.ReportingFrequency
				,m.ReportingDueDay
				,m.ReportingStartDate
				,m.EntityStatusID
				,m.EntityStatusDate
				,m.MilestoneCode
				,m.BaselineDate
				,m.ForecastDate
				,m.ActualDate
				,m.MilestoneTypeID
				,m.LeadUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = m.LeadUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS LeadUser
				,m.RagOptionID
				,m.StartDate
				,m.[Description]
				,m.WorkStreamID
				,(SELECT mu.[ID]
					  ,mu.[Title]
					  ,mu.[MilestoneID]
					  ,mu.[UpdateDate]
					  ,mu.[RagOptionID]
					  ,mu.[Comment]
					  ,mu.[ForecastDate]
					  ,mu.[ActualDate]
					  ,mu.[UpdateUserID]
					  ,mu.[SignOffID]
					  ,mu.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(mu.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = mu.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[MilestoneUpdates] AS mu WHERE mu.MilestoneID = m.ID AND mu.SignOffID = so.ID FOR JSON PATH) AS MilestoneUpdates 
				,(SELECT ID, Title, AttributeTypeID, AttributeValue, MilestoneID, ModifiedByUserID, (SELECT JSON_QUERY((SELECT ID, Title, Display FROM [dbo].[AttributeTypes] AS t WHERE t.ID = a.AttributeTypeID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS AttributeType 
					FROM [dbo].[Attributes] FOR SYSTEM_TIME ALL AS a WHERE a.MilestoneID = m.ID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime FOR JSON PATH) AS Attributes 
			FROM [dbo].[Milestones] FOR SYSTEM_TIME ALL AS m
			INNER JOIN [dbo].[WorkStreams] FOR SYSTEM_TIME ALL AS w ON m.WorkStreamID = w.ID
			INNER JOIN [dbo].[SignOffs] AS so ON w.ProjectID = so.ProjectID AND so.SignOffDate >= m.SysStartTime AND so.SignOffDate < m.SysEndTime AND so.SignOffDate >= w.SysStartTime AND so.SignOffDate < w.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		-- Get dependencies and updates at time of report
		DECLARE @dependencyJson NVARCHAR(MAX);
		SET @dependencyJson = (
			SELECT d.ID
				,d.Title
				,d.ReportingFrequency
				,d.ReportingDueDay
				,d.ReportingStartDate
				,d.EntityStatusID
				,d.EntityStatusDate
				,d.ProjectID
				,d.ThirdParty
				,d.RagOptionID
				,d.LeadUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = d.LeadUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS LeadUser
				,d.ModifiedByUserID
				,(SELECT du.[ID]
					  ,du.[Title]
					  ,du.[DependencyID]
					  ,du.[UpdateDate]
					  ,du.[UpdateUserID]
					  ,du.[RagOptionID]
					  ,du.[Comment]
					  ,du.[SignOffID]
					  ,du.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(du.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = du.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[DependencyUpdates] AS du WHERE du.DependencyID = d.ID AND du.SignOffID = so.ID FOR JSON PATH) AS DependencyUpdates 
			FROM [dbo].[Dependencies] FOR SYSTEM_TIME ALL AS d
			INNER JOIN [dbo].[SignOffs] AS so ON d.ProjectID = so.ProjectID AND so.SignOffDate >= d.SysStartTime AND so.SignOffDate < d.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		-- Get benefits and updates at time of report
		DECLARE @benefitJson NVARCHAR(MAX);
		SET @benefitJson = (
			SELECT b.ID
				,b.Title
				,b.ReportingFrequency
				,b.ReportingDueDay
				,b.ReportingStartDate
				,b.EntityStatusID
				,b.EntityStatusDate
				,b.ProjectID
				,b.BenefitTypeID
				,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[BenefitTypes] AS bt WHERE bt.ID = b.BenefitTypeID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS BenefitType
				,b.MeasurementUnitID
				,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[MeasurementUnits] AS mu WHERE mu.ID = b.MeasurementUnitID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS MeasurementUnit
				,b.TargetPerformanceLowerLimit
				,b.TargetPerformanceUpperLimit
				,b.LeadUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = b.LeadUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS LeadUser
				,b.RagOptionID
				,b.ModifiedByUserID
				,b.[Description]
				,b.BaselineDate
				,b.ForecastDate
				,(SELECT bu.[ID]
					  ,bu.[Title]
					  ,bu.[BenefitID]
					  ,bu.[UpdateDate]
					  ,bu.[RagOptionID]
					  ,bu.[Comment]
					  ,bu.[CurrentPerformance]
					  ,bu.[UpdateUserID]
					  ,bu.[SignOffID]
					  ,bu.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(bu.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,bu.[ForecastDate]
					  ,bu.[ActualDate]
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = bu.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[BenefitUpdates] AS bu WHERE bu.BenefitID = b.ID AND bu.SignOffID = so.ID FOR JSON PATH) AS BenefitUpdates 
				,(SELECT ID, Title, AttributeTypeID, AttributeValue, BenefitID, ModifiedByUserID, (SELECT JSON_QUERY((SELECT ID, Title, Display FROM [dbo].[AttributeTypes] AS t WHERE t.ID = a.AttributeTypeID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS AttributeType 
					FROM [dbo].[Attributes] FOR SYSTEM_TIME ALL AS a WHERE a.BenefitID = b.ID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime FOR JSON PATH) AS Attributes 
			FROM [dbo].[Benefits] FOR SYSTEM_TIME ALL AS b
			INNER JOIN [dbo].[SignOffs] AS so ON b.ProjectID = so.ProjectID AND so.SignOffDate >= b.SysStartTime AND so.SignOffDate < b.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		-- Get project details at time of report
		DECLARE @projectProjectsJson NVARCHAR(MAX);
		SET @projectProjectsJson = (
			SELECT p.ID
				,p.Title
				,p.DirectorateID
				,p.Objectives
				,p.EntityStatusID
				,p.EntityStatusDate
				,p.ModifiedByUserID
				,p.ReportApproverUserID
				,p.ReportingLeadUserID
				,p.ReportingFrequency
				,p.ReportingDueDay
				,p.ReportingStartDate 
				,(SELECT pu.[ID]
					  ,pu.[Title]
					  ,pu.[Comment]
					  ,pu.[RagOptionID]
					  ,pu.[ProjectID]
					  ,pu.[UpdateDate]
					  ,pu.[UpdateUserID]
					  ,pu.[OverallRagOptionID]
					  ,pu.[FinanceRagOptionID]
					  ,pu.[FinanceComment]
					  ,pu.[PeopleRagOptionID]
					  ,pu.[PeopleComment]
					  ,pu.[MilestonesRagOptionID]
					  ,pu.[MilestonesComment]
					  ,pu.[BenefitsRagOptionID]
					  ,pu.[BenefitsComment]
					  ,pu.[ProgressUpdate]
					  ,pu.[FutureActions]
					  ,pu.[Escalations]
					  ,pu.[ProjectPhaseID]
					  ,pu.[BusinessCaseTypeID]
					  ,pu.[BusinessCaseDate]
					  ,pu.[WholeLifeCost]
					  ,pu.[WholeLifeBenefit]
					  ,pu.[NetPresentValue]
					  ,pu.[SignOffID]
					  ,pu.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(pu.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = pu.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[ProjectUpdates] AS pu WHERE pu.SignOffID = so.ID FOR JSON PATH) AS ProjectUpdates 
				,(SELECT ID, Title, ProjectAttributeTypeID, ProjectID, ModifiedByUserID, (SELECT JSON_QUERY((SELECT ID, Title, Display FROM [dbo].[ProjectAttributeTypes] AS t WHERE t.ID = a.ProjectAttributeTypeID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS ProjectAttributeType 
					FROM [dbo].[ProjectAttributes] FOR SYSTEM_TIME ALL AS a WHERE a.ProjectID = p.ID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime FOR JSON PATH) AS ProjectAttributes
			FROM [dbo].[Projects] FOR SYSTEM_TIME ALL AS p
			INNER JOIN [dbo].[SignOffs] AS so ON p.ParentProjectID = so.ProjectID AND so.SignOffDate >= p.SysStartTime AND so.SignOffDate < p.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		RETURN CONCAT('{',
		'"Project":', COALESCE(@projectJson, '{}'), ',',
		'"WorkStreams":', COALESCE(@workStreamJson, '[]'), ',',
		'"Milestones":', COALESCE(@projectMilestoneJson, '[]'), ',',
		'"Dependencies":', COALESCE(@dependencyJson, '[]'), ',',
		'"Benefits":', COALESCE(@benefitJson, '[]'), ',',
		'"Projects":', COALESCE(@projectProjectsJson, '[]'),
		'}');
	END

	IF (SELECT PartnerOrganisationID FROM [dbo].[SignOffs] WHERE ID = @signOffId) IS NOT NULL
	BEGIN
		-- Get partner org details at time of report
		DECLARE @partnerOrgJson NVARCHAR(MAX);
		SET @partnerOrgJson = (
			SELECT p.ID
				,p.Title
				,p.ReportingFrequency
				,p.ReportingDueDay
				,p.ReportingStartDate 
				,p.EntityStatusID
				,p.EntityStatusDate
				,(SELECT pu.[ID]
					  ,pu.[Title]
					  ,pu.[Comment]
					  ,pu.[RagOptionID]
					  ,pu.[PartnerOrganisationID]
					  ,pu.[UpdateDate]
					  ,pu.[OverallRagOptionID]
					  ,pu.[FinanceRagOptionID]
					  ,pu.[FinanceComment]
					  ,pu.[PeopleRagOptionID]
					  ,pu.[PeopleComment]
					  ,pu.[MilestonesRagOptionID]
					  ,pu.[MilestonesComment]
					  ,pu.[KPIRagOptionID]
					  ,pu.[KPIComment]
					  ,pu.[ProgressUpdate]
					  ,pu.[FutureActions]
					  ,pu.[Escalations]
					  ,pu.[UpdateUserID]
					  ,pu.[SignOffID]
					  ,pu.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(pu.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = pu.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[PartnerOrganisationUpdates] AS pu WHERE pu.SignOffID = so.ID FOR JSON PATH) AS PartnerOrganisationUpdates
			FROM [dbo].[PartnerOrganisations] FOR SYSTEM_TIME ALL AS p
			INNER JOIN [dbo].[SignOffs] AS so ON p.ID = so.PartnerOrganisationID AND so.SignOffDate >= p.SysStartTime AND so.SignOffDate < p.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
		);

		-- Get milestones and updates at time of report
		DECLARE @partnerOrgMilestoneJson NVARCHAR(MAX);
		SET @partnerOrgMilestoneJson = (
			SELECT m.ID
				,m.Title
				,m.ReportingFrequency
				,m.ReportingDueDay
				,m.ReportingStartDate
				,m.EntityStatusID
				,m.EntityStatusDate
				,m.MilestoneCode
				,m.BaselineDate
				,m.ForecastDate
				,m.ActualDate
				,m.MilestoneTypeID
				,m.LeadUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = m.LeadUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS LeadUser
				,m.RagOptionID
				,m.StartDate
				,m.[Description]
				,m.PartnerOrganisationID
				,(SELECT mu.[ID]
					  ,mu.[Title]
					  ,mu.[MilestoneID]
					  ,mu.[UpdateDate]
					  ,mu.[RagOptionID]
					  ,mu.[Comment]
					  ,mu.[ForecastDate]
					  ,mu.[ActualDate]
					  ,mu.[UpdateUserID]
					  ,mu.[SignOffID]
					  ,mu.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(mu.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = mu.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[MilestoneUpdates] AS mu WHERE mu.MilestoneID = m.ID AND mu.SignOffID = so.ID FOR JSON PATH) AS MilestoneUpdates 
			FROM [dbo].[Milestones] FOR SYSTEM_TIME ALL AS m
			INNER JOIN [dbo].[SignOffs] AS so ON m.PartnerOrganisationID = so.PartnerOrganisationID AND so.SignOffDate >= m.SysStartTime AND so.SignOffDate < m.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		-- Partner org risks
		DECLARE @partnerOrgRiskJson NVARCHAR(MAX);
		SET @partnerOrgRiskJson = (
			SELECT r.ID
				,r.Title
				,r.ReportingFrequency
				,r.ReportingDueDay
				,r.ReportingStartDate 
				,r.EntityStatusID
				,r.EntityStatusDate
				,r.RiskCode
				,r.PartnerOrganisationID
				,r.RiskOwnerUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = r.RiskOwnerUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS RiskOwnerUser
				,r.BeisRiskOwnerUserID
				,r.RagOptionID
				,r.RiskEventDescription
				,r.RiskCauseDescription
				,r.RiskImpactDescription
				,r.UnmitigatedRiskProbabilityID
				,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[RiskProbabilities] AS urp WHERE urp.ID = r.UnmitigatedRiskProbabilityID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UnmitigatedRiskProbability
				,r.UnmitigatedRiskImpactLevelID
				,(SELECT JSON_QUERY((SELECT ID, Title, [Description] FROM [dbo].[RiskImpactLevels] AS uril WHERE uril.ID = r.UnmitigatedRiskImpactLevelID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UnmitigatedRiskImpactLevel
				,r.TargetRiskProbabilityID
				,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[RiskProbabilities] AS trp WHERE trp.ID = r.TargetRiskProbabilityID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS TargetRiskProbability
				,r.TargetRiskImpactLevelID
				,(SELECT JSON_QUERY((SELECT ID, Title, [Description] FROM [dbo].[RiskImpactLevels] AS tril WHERE tril.ID = r.TargetRiskImpactLevelID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS TargetRiskImpactLevel
				,r.RiskAppetiteID
				,r.BeisRiskAppetiteID
				,r.DepartmentalObjectiveID
				,CONVERT(VARCHAR(40), CAST(r.[RiskProximity] AS datetime2), 127) AS [RiskProximity]
				,r.RiskIsOngoing
				,r.ModifiedByUserID
				,r.BEISUnmitigatedRiskProbabilityID
				,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[RiskProbabilities] AS burp WHERE burp.ID = r.BEISUnmitigatedRiskProbabilityID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS BEISUnmitigatedRiskProbability
				,r.BEISUnmitigatedRiskImpactLevelID
				,(SELECT JSON_QUERY((SELECT ID, Title, [Description] FROM [dbo].[RiskImpactLevels] AS buril WHERE buril.ID = r.BEISUnmitigatedRiskImpactLevelID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS BEISUnmitigatedRiskImpactLevel
				,r.BEISTargetRiskProbabilityID
				,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[RiskProbabilities] AS btrp WHERE btrp.ID = r.BEISTargetRiskProbabilityID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS BEISTargetRiskProbability
				,r.BEISTargetRiskImpactLevelID
				,(SELECT JSON_QUERY((SELECT ID, Title, [Description] FROM [dbo].[RiskImpactLevels] AS btril WHERE btril.ID = r.BEISTargetRiskImpactLevelID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS BEISTargetRiskImpactLevel
				,(SELECT ru.[ID]
						,ru.[Title]
						,ru.[Comment]
						,ru.[RagOptionID]
						,ru.[BeisRagOptionID]
						,ru.[PartnerOrganisationRiskID]
						,ru.[UpdateUserID]
						,ru.[UpdateDate]
						,ru.[RiskProbabilityID]
						,ru.[RiskImpactLevelID]
						,ru.[BeisRiskProbabilityID]
						,ru.[BeisRiskImpactLevelID]
						,ru.[ToBeClosed]
						,CONVERT(VARCHAR(40), CAST(ru.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
						,ru.[IsCurrent]
						,CONVERT(VARCHAR(40), CAST(ru.[RiskProximity] AS datetime2), 127) AS [RiskProximity]
						,ru.[RiskIsOngoing]
						,ru.[SignOffID]
						,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = ru.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
						,(SELECT JSON_QUERY((SELECT ID, Title, [Description] FROM [dbo].[RiskImpactLevels] AS ril WHERE ril.ID = ru.RiskImpactLevelID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS RiskImpactLevel
						,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[RiskProbabilities] AS rp WHERE rp.ID = ru.RiskProbabilityID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS RiskProbability
						,(SELECT JSON_QUERY((SELECT ID, Title, [Description] FROM [dbo].[RiskImpactLevels] AS bril WHERE bril.ID = ru.BeisRiskImpactLevelID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS BeisRiskImpactLevel
						,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[RiskProbabilities] AS brp WHERE brp.ID = ru.BeisRiskProbabilityID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS BeisRiskProbability
					FROM [dbo].[PartnerOrganisationRiskUpdates] AS ru WHERE ru.SignOffID = so.ID FOR JSON PATH) AS PartnerOrganisationRiskUpdates
			FROM [dbo].[PartnerOrganisationRisks] FOR SYSTEM_TIME ALL AS r
			INNER JOIN [dbo].[SignOffs] AS so ON r.PartnerOrganisationID = so.PartnerOrganisationID AND so.SignOffDate >= r.SysStartTime AND so.SignOffDate < r.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		-- Partner org risk actions
		DECLARE @partnerOrgRiskActionJson NVARCHAR(MAX);
		SET @partnerOrgRiskActionJson = (
			SELECT a.ID
				,a.Title
				,a.ReportingFrequency
				,a.ReportingDueDay
				,a.ReportingStartDate
				,a.EntityStatusID
				,a.EntityStatusDate
				,a.[Description]
				,a.PartnerOrganisationRiskID
				,a.RiskMitigationActionCode
				,a.BaselineDate
				,a.ForecastDate
				,a.ActualDate
				,a.OwnerUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = a.OwnerUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS OwnerUser
				,a.ActionIsOngoing
				,a.ModifiedByUserID
				,(SELECT au.[ID]
					  ,au.[Title]
					  ,au.[PartnerOrganisationRiskMitigationActionID]
					  ,au.[UpdateDate]
					  ,au.[UpdateUserID]
					  ,au.[RagOptionID]
					  ,au.[Comment]
					  ,au.[ForecastDate]
					  ,au.[ActualDate]
					  ,au.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(au.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,au.[SignOffID]
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = au.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[PartnerOrganisationRiskMitigationActionUpdates] AS au WHERE au.PartnerOrganisationRiskMitigationActionID = a.ID AND au.SignOffID = so.ID FOR JSON PATH) AS PartnerOrganisationRiskMitigationActionUpdates 
			FROM [dbo].[PartnerOrganisationRiskMitigationActions] FOR SYSTEM_TIME ALL AS a
			INNER JOIN [dbo].[PartnerOrganisationRisks] FOR SYSTEM_TIME ALL AS r ON a.PartnerOrganisationRiskID = r.ID
			INNER JOIN [dbo].[SignOffs] AS so ON r.PartnerOrganisationID = so.PartnerOrganisationID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime AND so.SignOffDate >= r.SysStartTime AND so.SignOffDate < r.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		RETURN CONCAT('{',
		'"PartnerOrganisation":', COALESCE(@partnerOrgJson, '{}'), ',',
		'"Milestones":', COALESCE(@partnerOrgMilestoneJson, '[]'), ',',
		'"PartnerOrganisationRisks":', COALESCE(@partnerOrgRiskJson, '[]'), ',',
		'"PartnerOrganisationRiskMitigationActions":', COALESCE(@partnerOrgRiskActionJson, '[]'),
		'}');
	END

	IF (SELECT RiskID FROM [dbo].[SignOffs] WHERE ID = @signOffId) IS NOT NULL
	BEGIN

		-- Get risk details and update at time of report
		DECLARE @riskJson NVARCHAR(MAX);
		SET @riskJson = (
			SELECT r.ID
				,r.Title
				,r.ReportingFrequency
				,r.ReportingDueDay
				,r.ReportingStartDate 
				,r.EntityStatusID
				,r.EntityStatusDate
				,r.RiskCode
				,r.DirectorateID
				,r.RiskOwnerUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = r.RiskOwnerUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS RiskOwnerUser
				,r.RagOptionID
				,r.RiskRegisterID
				,r.RiskEventDescription
				,r.RiskCauseDescription
				,r.RiskImpactDescription
				,r.UnmitigatedRiskProbabilityID
				,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[RiskProbabilities] AS urp WHERE urp.ID = r.UnmitigatedRiskProbabilityID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UnmitigatedRiskProbability
				,r.UnmitigatedRiskImpactLevelID
				,(SELECT JSON_QUERY((SELECT ID, Title, [Description] FROM [dbo].[RiskImpactLevels] AS uril WHERE uril.ID = r.UnmitigatedRiskImpactLevelID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UnmitigatedRiskImpactLevel
				,r.TargetRiskProbabilityID
				,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[RiskProbabilities] AS trp WHERE trp.ID = r.TargetRiskProbabilityID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS TargetRiskProbability
				,r.TargetRiskImpactLevelID
				,(SELECT JSON_QUERY((SELECT ID, Title, [Description] FROM [dbo].[RiskImpactLevels] AS tril WHERE tril.ID = r.TargetRiskImpactLevelID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS TargetRiskImpactLevel
				,r.RiskAppetiteID
				,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[RiskAppetites] AS ra WHERE ra.ID = r.RiskAppetiteID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS RiskAppetite
				,r.DepartmentalObjectiveID
				,r.ModifiedByUserID
				,r.IsProjectRisk
				,r.ProjectID
				,CONVERT(VARCHAR(40), CAST(r.[RiskProximity] AS datetime2), 127) AS [RiskProximity]
				,r.RiskIsOngoing
				,r.LinkedRiskID
				,r.ReportApproverUserID
				,r.CreatedDate
				,(SELECT ru.[ID]
					  ,ru.[Title]
					  ,ru.[Comment]
					  ,ru.[RagOptionID]
					  ,ru.[RiskID]
					  ,ru.[UpdateUserID]
					  ,ru.[UpdateDate]
					  ,ru.[RiskProbabilityID]
					  ,ru.[RiskImpactLevelID]
					  ,ru.[Escalate]
					  ,ru.[DeEscalate]
					  ,ru.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(ru.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,ru.[RiskMitigationActionUpdates]
					  ,ru.[IsCurrent]
					  ,ru.[SendNotifications]
					  ,ru.[RiskRegisterID]
					  ,CONVERT(VARCHAR(40), CAST(ru.[RiskProximity] AS datetime2), 127) AS [RiskProximity]
					  ,ru.[RiskCode]
					  ,ru.[RiskIsOngoing]
					  ,ru.[SignOffID]
					  ,ru.[RiskAppetiteBreachAuthorised]
					  ,ru.[Narrative]
					  ,ru.[ClosureReason] 
					,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = ru.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					,(SELECT JSON_QUERY((SELECT ID, Title, [Description] FROM [dbo].[RiskImpactLevels] AS ril WHERE ril.ID = ru.RiskImpactLevelID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS RiskImpactLevel
					,(SELECT JSON_QUERY((SELECT ID, Title FROM [dbo].[RiskProbabilities] AS rp WHERE rp.ID = ru.RiskProbabilityID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS RiskProbability
					FROM [dbo].[RiskUpdates] AS ru WHERE ru.SignOffID = so.ID FOR JSON PATH) AS RiskUpdates
				,(SELECT ID, Title, AttributeTypeID, AttributeValue, RiskID, ModifiedByUserID, (SELECT JSON_QUERY((SELECT ID, Title, Display FROM [dbo].[AttributeTypes] AS t WHERE t.ID = a.AttributeTypeID FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS AttributeType 
					FROM [dbo].[Attributes] FOR SYSTEM_TIME ALL AS a WHERE a.RiskID = r.ID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime FOR JSON PATH) AS Attributes 
			FROM [dbo].[Risks] FOR SYSTEM_TIME ALL AS r
			INNER JOIN [dbo].[SignOffs] AS so ON r.ID = so.RiskID AND so.SignOffDate >= r.SysStartTime AND so.SignOffDate < r.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
		);

		-- Get risk actions and updates at time of report
		DECLARE @riskActionJson NVARCHAR(MAX);
		SET @riskActionJson = (
			SELECT a.ID
				,a.Title
				,a.ReportingFrequency
				,a.ReportingDueDay
				,a.ReportingStartDate
				,a.EntityStatusID
				,a.EntityStatusDate
				,a.RiskID
				,a.OwnerUserID
				,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = a.OwnerUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS OwnerUser
				,a.RiskMitigationActionCode
				,a.[Description]
				,a.BaselineDate
				,a.ForecastDate
				,a.ActualDate
				,a.ActionIsOngoing
				,(SELECT au.[ID]
					  ,au.[Title]
					  ,au.[RiskMitigationActionID]
					  ,au.[UpdateDate]
					  ,au.[UpdateUserID]
					  ,au.[RagOptionID]
					  ,au.[Comment]
					  ,au.[ForecastDate]
					  ,au.[ActualDate]
					  ,au.[ToBeClosed]
					  ,CONVERT(VARCHAR(40), CAST(au.[UpdatePeriod] AS datetime2), 127) AS UpdatePeriod
					  ,au.[RiskUpdateID]
					  ,au.[SignOffID]
					  ,(SELECT JSON_QUERY((SELECT ID, Username, Title FROM [dbo].[Users] FOR SYSTEM_TIME ALL AS u WHERE u.ID = au.UpdateUserID AND so.SignOffDate >= u.SysStartTime AND so.SignOffDate < u.SysEndTime FOR JSON PATH, WITHOUT_ARRAY_WRAPPER))) AS UpdateUser
					FROM [dbo].[RiskMitigationActionUpdates] AS au WHERE au.RiskMitigationActionID = a.ID AND au.SignOffID = so.ID FOR JSON PATH) AS RiskMitigationActionUpdates 
			FROM [dbo].[RiskMitigationActions] FOR SYSTEM_TIME ALL AS a
			INNER JOIN [dbo].[SignOffs] AS so ON a.RiskID = so.RiskID AND so.SignOffDate >= a.SysStartTime AND so.SignOffDate < a.SysEndTime
			WHERE so.ID = @signOffId
			FOR JSON PATH
		);

		RETURN CONCAT('{',
		'"Risk":', COALESCE(@riskJson, '{}'), ',',
		'"RiskMitigationActions":', COALESCE(@riskActionJson, '[]'),
		'}');
	END

	RETURN '';
END