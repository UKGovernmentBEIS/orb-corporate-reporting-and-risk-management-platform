USE [master]
GO
/****** Object:  Database [dev-corp-reporting-db]    Script Date: 08/11/2022 15:26:58 ******/
CREATE DATABASE [dev-corp-reporting-db]
GO
ALTER DATABASE [dev-corp-reporting-db] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dev-corp-reporting-db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dev-corp-reporting-db] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [dev-corp-reporting-db] SET ANSI_NULLS ON 
GO
ALTER DATABASE [dev-corp-reporting-db] SET ANSI_PADDING ON 
GO
ALTER DATABASE [dev-corp-reporting-db] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [dev-corp-reporting-db] SET ARITHABORT ON 
GO
ALTER DATABASE [dev-corp-reporting-db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dev-corp-reporting-db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dev-corp-reporting-db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dev-corp-reporting-db] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [dev-corp-reporting-db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dev-corp-reporting-db] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [dev-corp-reporting-db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dev-corp-reporting-db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dev-corp-reporting-db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dev-corp-reporting-db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dev-corp-reporting-db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dev-corp-reporting-db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dev-corp-reporting-db] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [dev-corp-reporting-db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dev-corp-reporting-db] SET  MULTI_USER 
GO
ALTER DATABASE [dev-corp-reporting-db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dev-corp-reporting-db] SET ENCRYPTION ON
GO
ALTER DATABASE [dev-corp-reporting-db] SET QUERY_STORE = ON
GO
ALTER DATABASE [dev-corp-reporting-db] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = ALL, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [dev-corp-reporting-db]
GO
ALTER DATABASE SCOPED CONFIGURATION SET ACCELERATED_PLAN_FORCING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ASYNC_STATS_UPDATE_WAIT_AT_LOW_PRIORITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ADAPTIVE_JOINS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET CE_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DEFERRED_COMPILATION_TV = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DW_COMPATIBILITY_LEVEL = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_ONLINE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_RESUMABLE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET EXEC_QUERY_STATS_FOR_SCALAR_FUNCTIONS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET FORCE_SHOWPLAN_RUNTIME_PARAMETER_COLLECTION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET GLOBAL_TEMPORARY_TABLE_AUTO_DROP = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET INTERLEAVED_EXECUTION_TVF = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ISOLATE_SECURITY_POLICY_CARDINALITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LAST_QUERY_PLAN_STATS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MEMORY_GRANT_FEEDBACK_PERSISTENCE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SENSITIVE_PLAN_OPTIMIZATION = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PAUSED_RESUMABLE_INDEX_ABORT_DURATION_MINUTES = 1440;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ROW_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET TSQL_SCALAR_UDF_INLINING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET VERBOSE_TRUNCATION_WARNINGS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_PROCEDURE_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_QUERY_EXECUTION_STATISTICS = OFF;
GO
USE [dev-corp-reporting-db]
GO
/****** Object:  User [tas-dev]    Script Date: 08/11/2022 15:26:59 ******/
CREATE USER [tas-dev] FOR LOGIN [tas-dev] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [rp-dev-27-api]    Script Date: 08/11/2022 15:26:59 ******/
CREATE USER [rp-dev-27-api] WITH PASSWORD=N'nNURWWn0jVkKQZwO2YJIxcTomaa+JY1zfwgODvAT5Z4=', DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [APP - U - Corporate Reporting - Support Users]    Script Date: 08/11/2022 15:26:59 ******/
CREATE USER [APP - U - Corporate Reporting - Support Users] FROM  EXTERNAL PROVIDER 
GO
/****** Object:  User [APP - U - Corporate Reporting - Reports Users]    Script Date: 08/11/2022 15:26:59 ******/
CREATE USER [APP - U - Corporate Reporting - Reports Users] FROM  EXTERNAL PROVIDER 
GO
/****** Object:  User [APP - U - Corporate Reporting - Draft Report Users]    Script Date: 08/11/2022 15:26:59 ******/
CREATE USER [APP - U - Corporate Reporting - Draft Report Users] FROM  EXTERNAL PROVIDER 
GO
/****** Object:  User [APP - U - Corporate Reporting - API Users]    Script Date: 08/11/2022 15:26:59 ******/
CREATE USER [APP - U - Corporate Reporting - API Users] FROM  EXTERNAL PROVIDER 
GO
/****** Object:  DatabaseRole [reports_reader]    Script Date: 08/11/2022 15:26:59 ******/
CREATE ROLE [reports_reader]
GO
/****** Object:  DatabaseRole [drafts_reader]    Script Date: 08/11/2022 15:26:59 ******/
CREATE ROLE [drafts_reader]
GO
/****** Object:  DatabaseRole [api_user]    Script Date: 08/11/2022 15:26:59 ******/
CREATE ROLE [api_user]
GO
ALTER ROLE [api_user] ADD MEMBER [tas-dev]
GO
ALTER ROLE [db_datareader] ADD MEMBER [tas-dev]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [tas-dev]
GO
ALTER ROLE [api_user] ADD MEMBER [rp-dev-27-api]
GO
ALTER ROLE [db_datareader] ADD MEMBER [rp-dev-27-api]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [rp-dev-27-api]
GO
ALTER ROLE [reports_reader] ADD MEMBER [APP - U - Corporate Reporting - Reports Users]
GO
ALTER ROLE [drafts_reader] ADD MEMBER [APP - U - Corporate Reporting - Draft Report Users]
GO
ALTER ROLE [api_user] ADD MEMBER [APP - U - Corporate Reporting - API Users]
GO
ALTER ROLE [db_datareader] ADD MEMBER [APP - U - Corporate Reporting - API Users]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [APP - U - Corporate Reporting - API Users]
GO
ALTER ROLE [db_datareader] ADD MEMBER [api_user]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [api_user]
GO
/****** Object:  Schema [drafts]    Script Date: 08/11/2022 15:27:01 ******/
CREATE SCHEMA [drafts]
GO
/****** Object:  Schema [History]    Script Date: 08/11/2022 15:27:01 ******/
CREATE SCHEMA [History]
GO
/****** Object:  Schema [reports]    Script Date: 08/11/2022 15:27:01 ******/
CREATE SCHEMA [reports]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateReportJson]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[RagOptions]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RagOptions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ReportName] [nvarchar](2) NULL,
	[Score] [int] NULL,
 CONSTRAINT [PK_RagOptions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SignOffs]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SignOffs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](350) NULL,
	[SignOffDate] [datetime2](7) NULL,
	[SignOffUserID] [int] NULL,
	[ReportMonth] [date] NULL,
	[DirectorateID] [int] NULL,
	[ProjectID] [int] NULL,
	[SignOffEntities] [nvarchar](max) NULL,
	[IsCurrent] [bit] NULL,
	[PartnerOrganisationID] [int] NULL,
	[RiskID] [int] NULL,
	[ReportJson] [nvarchar](max) NULL,
 CONSTRAINT [PK_SignOffs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectorateUpdates]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectorateUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Comment] [nvarchar](50) NULL,
	[RagOptionID] [int] NULL,
	[DirectorateID] [int] NULL,
	[UpdateDate] [datetime2](7) NULL,
	[OverallRagOptionID] [int] NULL,
	[FinanceRagOptionID] [int] NULL,
	[FinanceComment] [nvarchar](500) NULL,
	[PeopleRagOptionID] [int] NULL,
	[PeopleComment] [nvarchar](500) NULL,
	[MilestonesRagOptionID] [int] NULL,
	[MilestonesComment] [nvarchar](500) NULL,
	[MetricsRagOptionID] [int] NULL,
	[MetricsComment] [nvarchar](500) NULL,
	[ProgressUpdate] [nvarchar](500) NULL,
	[FutureActions] [nvarchar](500) NULL,
	[Escalations] [nvarchar](500) NULL,
	[UpdateUserID] [int] NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
 CONSTRAINT [PK_DirectorateUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PreviousDirectorateUpdates]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PreviousDirectorateUpdates]
AS
	SELECT dbo.DirectorateUpdates.DirectorateID
			, nextso.ReportMonth AS [NextMonth]
			, DeliveryConfidenceRAG.ReportName AS [PreviousDeliveryConfidenceRAG]
			, DeliveryConfidenceRAG.Score AS [PreviousDeliveryConfidenceRAGScore]
			, FinanceRAG.ReportName AS [PreviousFinanceRAG]
			, FinanceRAG.Score AS [PreviousFinanceRAGScore]
			, MetricsRAG.ReportName AS [PreviousMetricsRAG]
			, MetricsRAG.Score AS [PreviousMetricsRAGScore]
			, MilestonesRAG.ReportName AS [PreviousMilestonesRAG]
			, MilestonesRAG.Score AS [PreviousMilestonesRAGScore]
			, PeopleRAG.ReportName AS [PreviousPeopleRAG]
			, PeopleRAG.Score AS [PreviousPeopleRAGScore]
	FROM dbo.SignOffs INNER JOIN
		dbo.DirectorateUpdates ON dbo.SignOffs.ID = dbo.DirectorateUpdates.SignOffID LEFT OUTER JOIN
		dbo.RagOptions AS DeliveryConfidenceRAG ON dbo.DirectorateUpdates.OverallRagOptionID = DeliveryConfidenceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON dbo.DirectorateUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MetricsRAG ON dbo.DirectorateUpdates.MetricsRagOptionID = MetricsRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON dbo.DirectorateUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON dbo.DirectorateUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND dbo.SignOffs.DirectorateID = nextso.DirectorateID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE DirectorateID = dbo.SignOffs.DirectorateID AND ReportMonth > dbo.SignOffs.ReportMonth AND IsCurrent = 1)
	WHERE dbo.SignOffs.IsCurrent = 1
GO
/****** Object:  Table [dbo].[MeasurementUnits]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeasurementUnits](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
 CONSTRAINT [PK_UnitsOfMeasurement] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [History].[Projects]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Projects](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[SeniorResponsibleOwnerUserID] [int] NULL,
	[ProjectManagerUserID] [int] NULL,
	[Objectives] [nvarchar](max) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[DirectorateID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportApproverUserID] [int] NULL,
	[ShowOnDirectorateReport] [bit] NULL,
	[ParentProjectID] [int] NULL,
	[ReportingLeadUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[CorporateProjectID] [nvarchar](max) NULL,
	[Description] [nvarchar](500) NULL,
	[IntegrationID] [nvarchar](255) NULL,
	[IntegrationLastModified] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[SeniorResponsibleOwnerUserID] [int] NULL,
	[ProjectManagerUserID] [int] NULL,
	[Objectives] [nvarchar](max) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[DirectorateID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportApproverUserID] [int] NULL,
	[ShowOnDirectorateReport] [bit] NULL,
	[ParentProjectID] [int] NULL,
	[ReportingLeadUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[CorporateProjectID] [nvarchar](max) NULL,
	[Description] [nvarchar](500) NULL,
	[IntegrationID] [nvarchar](255) NULL,
	[IntegrationLastModified] [datetime2](7) NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Projects] )
)
GO
/****** Object:  Table [History].[Users]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Users](
	[ID] [int] NOT NULL,
	[Username] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[CreatedDate] [datetime2](0) NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](0) NULL,
	[EmailAddress] [nvarchar](255) NULL,
	[IsServiceAccount] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[CreatedDate] [datetime2](0) NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](0) NULL,
	[EmailAddress] [nvarchar](255) NULL,
	[IsServiceAccount] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Users_Username] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Users] )
)
GO
/****** Object:  Table [History].[Benefits]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Benefits](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[ProjectID] [int] NOT NULL,
	[BenefitTypeID] [int] NULL,
	[MeasurementUnitID] [int] NULL,
	[TargetPerformanceLowerLimit] [decimal](18, 4) NULL,
	[TargetPerformanceUpperLimit] [decimal](18, 4) NULL,
	[LeadUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[Description] [nvarchar](500) NULL,
	[BaselineDate] [datetime2](0) NULL,
	[ForecastDate] [datetime2](0) NULL,
	[ActualDate] [datetime2](0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Benefits]    Script Date: 08/11/2022 15:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Benefits](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[ProjectID] [int] NOT NULL,
	[BenefitTypeID] [int] NULL,
	[MeasurementUnitID] [int] NULL,
	[TargetPerformanceLowerLimit] [decimal](18, 4) NULL,
	[TargetPerformanceUpperLimit] [decimal](18, 4) NULL,
	[LeadUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[Description] [nvarchar](500) NULL,
	[BaselineDate] [datetime2](0) NULL,
	[ForecastDate] [datetime2](0) NULL,
	[ActualDate] [datetime2](0) NULL,
 CONSTRAINT [PK_Benefits] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Benefits] )
)
GO
/****** Object:  Table [dbo].[BenefitUpdates]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BenefitUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[BenefitID] [int] NULL,
	[UpdateDate] [datetime2](7) NULL,
	[RagOptionID] [int] NULL,
	[Comment] [nvarchar](500) NULL,
	[CurrentPerformance] [decimal](18, 4) NULL,
	[UpdateUserID] [int] NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
 CONSTRAINT [PK_BenefitUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [History].[Directorates]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Directorates](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[GroupID] [int] NOT NULL,
	[DirectorUserID] [int] NULL,
	[Objectives] [nvarchar](max) NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportApproverUserID] [int] NULL,
	[ReportingLeadUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Directorates]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Directorates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[GroupID] [int] NOT NULL,
	[DirectorUserID] [int] NULL,
	[Objectives] [nvarchar](max) NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportApproverUserID] [int] NULL,
	[ReportingLeadUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Directorates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Directorates] )
)
GO
/****** Object:  Table [dbo].[EntityStatuses]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntityStatuses](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
 CONSTRAINT [PK_EntityStatuses] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [History].[Groups]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Groups](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[DirectorGeneralUserID] [int] NULL,
	[RiskChampionDeputyDirectorUserID] [int] NULL,
	[BusinessPartnerUserID] [int] NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[DirectorGeneralUserID] [int] NULL,
	[RiskChampionDeputyDirectorUserID] [int] NULL,
	[BusinessPartnerUserID] [int] NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Groups] )
)
GO
/****** Object:  View [dbo].[PreviousBenefitUpdates]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PreviousBenefitUpdates]
AS
	SELECT DISTINCT dbo.Benefits.ID AS [BenefitID]
			, nextso.ReportMonth AS [NextMonth]
			, nextbu.UpdatePeriod AS [NextBenefitUpdate]
			, bu.CurrentPerformance AS [PreviousPerformance]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.BenefitUpdates AS bu ON so.ID = bu.SignOffID INNER JOIN
		dbo.Benefits ON bu.BenefitID = dbo.Benefits.ID LEFT OUTER JOIN
		dbo.RagOptions ON bu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.ProjectID = nextso.ProjectID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE ProjectID = so.ProjectID AND ReportMonth > so.ReportMonth AND IsCurrent = 1) LEFT OUTER JOIN
		dbo.BenefitUpdates AS nextbu ON bu.BenefitID = nextbu.BenefitID AND nextbu.UpdatePeriod = 
			(SELECT MIN(UpdatePeriod)
			FROM BenefitUpdates INNER JOIN
				SignOffs ON BenefitUpdates.SignOffID = SignOffs.ID
			WHERE BenefitID = bu.BenefitID AND UpdatePeriod > bu.UpdatePeriod AND SignOffs.IsCurrent = 1)
	WHERE so.IsCurrent = 1
GO
/****** Object:  View [drafts].[BenefitUpdates]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[BenefitUpdates]
AS
  SELECT bu.ID AS [Benefit Update ID]
		, g.Title AS [Group]
		, d.Title AS [Directorate]
		, p.Title AS [Project]
		, bu.UpdatePeriod AS [Report Month]
		, b.ID AS [Benefit ID]
		, b.Title AS [Benefit]
		, bu.Comment AS [Progress Update]
		, b.Description AS [Benefit Description]
		, CAST(pbu.PreviousPerformance AS float) AS [Previous Performance]
		, CAST(bu.CurrentPerformance AS float) AS [Current Performance]
		, CAST(b.TargetPerformanceLowerLimit AS float) AS [Target Performance Lower]
		, CAST(b.TargetPerformanceUpperLimit AS float) AS [Target Performance Upper]
		, mu.Title AS [Performance Unit]
		, pbu.PreviousRAG AS [Previous RAG]
		, pbu.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - pbu.PreviousRAGScore AS [RAG Change]
		, LeadUser.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(bu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE bu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Benefit Closed]
		, es.Title AS [Status] 
		, CASE b.ReportingFrequency
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
        , CASE b.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(b.ReportingStartDate)  
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(b.ReportingStartDate)  
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(b.ReportingStartDate)  
                WHEN 1 THEN 'Jan' 
                WHEN 2 THEN 'Feb' 
                WHEN 3 THEN 'Mar' 
                WHEN 4 THEN 'Apr' 
                WHEN 5 THEN 'May' 
                WHEN 6 THEN 'Jun' 
                WHEN 7 THEN 'Jul' 
                WHEN 8 THEN 'Aug' 
                WHEN 9 THEN 'Sep' 
                WHEN 10 THEN 'Oct' 
                WHEN 11 THEN 'Nov' 
                WHEN 12 THEN 'Dec' 
                ELSE '' 
            END 
        END AS [Reporting Schedule]
  FROM (SELECT MAX(ID) AS CurrentDraftID
    FROM [dbo].[BenefitUpdates]
    GROUP BY BenefitID, UpdatePeriod) AS currentDraft LEFT OUTER JOIN
    dbo.BenefitUpdates AS bu ON currentDraft.CurrentDraftID = bu.ID INNER JOIN
    dbo.Benefits AS b ON bu.BenefitID = b.ID INNER JOIN
    dbo.Projects AS p ON b.ProjectID = p.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON p.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON b.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON bu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON bu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.PreviousBenefitUpdates AS pbu ON b.ID = pbu.BenefitID AND bu.UpdatePeriod = pbu.NextMonth LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON b.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.MeasurementUnits AS mu ON b.MeasurementUnitID = mu.ID;
GO
/****** Object:  Table [History].[ReportingEntities]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[ReportingEntities](
	[ID] [int] NOT NULL,
	[ReportingEntityTypeID] [int] NOT NULL,
	[DirectorateID] [int] NULL,
	[ProjectID] [int] NULL,
	[PartnerOrganisationID] [int] NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[CreatedDate] [datetime2](0) NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[LeadUserID] [int] NULL,
	[MeasurementUnitID] [int] NULL,
	[TargetPerformanceUpperLimit] [decimal](18, 4) NULL,
	[TargetPerformanceLowerLimit] [decimal](18, 4) NULL,
	[BaselineDate] [datetime2](0) NULL,
	[ForecastDate] [datetime2](0) NULL,
	[ActualDate] [datetime2](0) NULL,
	[Properties] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportingEntities]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportingEntities](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportingEntityTypeID] [int] NOT NULL,
	[DirectorateID] [int] NULL,
	[ProjectID] [int] NULL,
	[PartnerOrganisationID] [int] NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[CreatedDate] [datetime2](0) NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[LeadUserID] [int] NULL,
	[MeasurementUnitID] [int] NULL,
	[TargetPerformanceUpperLimit] [decimal](18, 4) NULL,
	[TargetPerformanceLowerLimit] [decimal](18, 4) NULL,
	[BaselineDate] [datetime2](0) NULL,
	[ForecastDate] [datetime2](0) NULL,
	[ActualDate] [datetime2](0) NULL,
	[Properties] [nvarchar](max) NULL,
 CONSTRAINT [PK_ReportingEntities] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[ReportingEntities] )
)
GO
/****** Object:  Table [dbo].[KeyWorkAreaUpdates]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeyWorkAreaUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[KeyWorkAreaID] [int] NOT NULL,
	[UpdateDate] [datetime2](7) NOT NULL,
	[RagOptionID] [int] NULL,
	[Comment] [nvarchar](500) NULL,
	[UpdateUserID] [int] NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
 CONSTRAINT [PK_KeyWorkAreaUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [History].[KeyWorkAreas]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[KeyWorkAreas](
	[ID] [int] NOT NULL,
	[DirectorateID] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[LeadUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KeyWorkAreas]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeyWorkAreas](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DirectorateID] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[LeadUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_KeyWorkAreas] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[KeyWorkAreas] )
)
GO
/****** Object:  View [dbo].[PreviousKeyWorkAreaUpdates]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PreviousKeyWorkAreaUpdates]
AS
	SELECT dbo.KeyWorkAreas.ID
			, nextso.ReportMonth AS [NextMonth]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.KeyWorkAreas INNER JOIN
		dbo.KeyWorkAreaUpdates ON dbo.KeyWorkAreas.ID = dbo.KeyWorkAreaUpdates.KeyWorkAreaID INNER JOIN
		dbo.SignOffs AS so ON dbo.KeyWorkAreaUpdates.SignOffID = so.ID INNER JOIN
		dbo.RagOptions ON dbo.KeyWorkAreaUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.DirectorateID = nextso.DirectorateID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE DirectorateID = so.DirectorateID AND ReportMonth > so.ReportMonth AND IsCurrent = 1)
	WHERE so.IsCurrent = 1
GO
/****** Object:  Table [History].[Commitments]    Script Date: 08/11/2022 15:27:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Commitments](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[DirectorateID] [int] NOT NULL,
	[BaselineDate] [date] NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
	[RagOptionID] [int] NULL,
	[LeadUserID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Commitments]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Commitments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[DirectorateID] [int] NOT NULL,
	[BaselineDate] [date] NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
	[RagOptionID] [int] NULL,
	[LeadUserID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Commitments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Commitments] )
)
GO
/****** Object:  Table [dbo].[CommitmentUpdates]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommitmentUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[CommitmentID] [int] NOT NULL,
	[UpdateDate] [datetime2](7) NULL,
	[UpdateUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[Comment] [nvarchar](500) NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
 CONSTRAINT [PK_DependencyUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PreviousCommitmentUpdates]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PreviousCommitmentUpdates]
AS
	SELECT dbo.CommitmentUpdates.CommitmentID AS [CommitmentID]
			, nextso.ReportMonth AS [NextMonth]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.CommitmentUpdates ON so.ID = dbo.CommitmentUpdates.SignOffID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.CommitmentUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.DirectorateID = nextso.DirectorateID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE DirectorateID = so.DirectorateID AND ReportMonth > so.ReportMonth AND IsCurrent = 1)
	WHERE so.IsCurrent = 1
GO
/****** Object:  View [drafts].[CommitmentUpdates]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[CommitmentUpdates]
AS
  SELECT cu.ID AS [Commitment Update ID]
			, g.Title AS [Group]
			, d.Title AS [Directorate]
			, cu.UpdatePeriod AS [Report Month]
			, c.ID AS [Commitment ID]
			, c.Title AS [Commitment]
			, cu.Comment AS [Progress Update]
			, c.BaselineDate AS [Baseline]
			, cu.ForecastDate AS [Forecast]
			, cu.ActualDate AS [Actual]
			, pcu.PreviousRAG AS [Previous RAG]
			, pcu.PreviousRAGScore AS [Previous RAG Score]
			, dbo.RagOptions.ReportName AS [Current RAG]
			, dbo.RagOptions.Score AS [Current RAG Score]
			, dbo.RagOptions.Score - pcu.PreviousRAGScore AS [RAG Change]
			, LeadUser.Title AS [Lead]
			, UpdateAuthor.Title AS [Author]
			, CAST(cu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			, CASE cu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Commitment Closed]
			, es.Title AS [Status]
  FROM dbo.Commitments AS c LEFT OUTER JOIN
    dbo.CommitmentUpdates AS cu ON c.ID = cu.CommitmentID INNER JOIN
    (SELECT MAX(ID) AS CurrentDraftID
    FROM [dbo].[CommitmentUpdates]
    GROUP BY CommitmentID, UpdatePeriod) AS currentDraft ON cu.ID = currentDraft.CurrentDraftID LEFT OUTER JOIN
    dbo.Directorates AS d ON c.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON c.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON cu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON cu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON c.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.PreviousCommitmentUpdates AS pcu ON c.ID = pcu.CommitmentID AND cu.UpdatePeriod = pcu.NextMonth;
GO
/****** Object:  Table [History].[Metrics]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Metrics](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[MetricCode] [nvarchar](255) NULL,
	[DirectorateID] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[MeasurementUnitID] [int] NULL,
	[TargetPerformanceUpperLimit] [decimal](18, 4) NULL,
	[TargetPerformanceLowerLimit] [decimal](18, 4) NULL,
	[LeadUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Metrics]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Metrics](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[MetricCode] [nvarchar](255) NULL,
	[DirectorateID] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[MeasurementUnitID] [int] NULL,
	[TargetPerformanceUpperLimit] [decimal](18, 4) NULL,
	[TargetPerformanceLowerLimit] [decimal](18, 4) NULL,
	[LeadUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
 CONSTRAINT [PK_Metrics] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Metrics] )
)
GO
/****** Object:  Table [dbo].[MetricUpdates]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MetricUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[MetricID] [int] NOT NULL,
	[UpdateDate] [datetime2](7) NULL,
	[RagOptionID] [int] NULL,
	[Comment] [nvarchar](500) NULL,
	[CurrentPerformance] [decimal](18, 4) NULL,
	[UpdateUserID] [int] NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
 CONSTRAINT [PK_MetricUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PreviousMetricUpdates]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PreviousMetricUpdates]
AS
	SELECT DISTINCT dbo.Metrics.ID AS [MetricID]
			, nextso.ReportMonth AS [NextMonth]
			, nextbu.UpdatePeriod AS [NextMetricUpdate]
			, bu.CurrentPerformance AS [PreviousPerformance]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.MetricUpdates AS bu ON so.ID = bu.SignOffID INNER JOIN
		dbo.Metrics ON bu.MetricID = dbo.Metrics.ID LEFT OUTER JOIN
		dbo.RagOptions ON bu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.ProjectID = nextso.ProjectID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE ProjectID = so.ProjectID AND ReportMonth > so.ReportMonth AND IsCurrent = 1) LEFT OUTER JOIN
		dbo.MetricUpdates AS nextbu ON bu.MetricID = nextbu.MetricID AND nextbu.UpdatePeriod = 
			(SELECT MIN(UpdatePeriod)
			FROM MetricUpdates INNER JOIN
				SignOffs ON MetricUpdates.SignOffID = SignOffs.ID
			WHERE MetricID = bu.MetricID AND UpdatePeriod > bu.UpdatePeriod AND SignOffs.IsCurrent = 1)
	WHERE so.IsCurrent = 1
GO
/****** Object:  Table [History].[Dependencies]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Dependencies](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ProjectID] [int] NOT NULL,
	[ThirdParty] [nvarchar](255) NULL,
	[RagOptionID] [int] NULL,
	[LeadUserID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[BaselineDate] [datetime] NULL,
	[ForecastDate] [datetime] NULL,
	[ActualDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dependencies]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dependencies](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ProjectID] [int] NOT NULL,
	[ThirdParty] [nvarchar](255) NULL,
	[RagOptionID] [int] NULL,
	[LeadUserID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[BaselineDate] [datetime] NULL,
	[ForecastDate] [datetime] NULL,
	[ActualDate] [datetime] NULL,
 CONSTRAINT [PK_Dependency] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Dependencies] )
)
GO
/****** Object:  Table [dbo].[DependencyUpdates]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DependencyUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[DependencyID] [int] NOT NULL,
	[UpdateDate] [datetime2](7) NULL,
	[UpdateUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[Comment] [nvarchar](500) NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
	[ForecastDate] [datetime2](7) NULL,
	[ActualDate] [datetime2](7) NULL,
 CONSTRAINT [PK_DependencyUpdates_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PreviousDependencyUpdates]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PreviousDependencyUpdates]
AS
	SELECT dbo.DependencyUpdates.DependencyID AS [DependencyID]
		, nextso.ReportMonth AS [NextMonth]
		, dbo.RagOptions.ReportName AS [PreviousRAG]
		, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.DependencyUpdates ON so.ID = dbo.DependencyUpdates.SignOffID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.DependencyUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.ProjectID = nextso.ProjectID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE ProjectID = so.ProjectID AND ReportMonth > so.ReportMonth AND IsCurrent = 1)
	WHERE so.IsCurrent = 1
GO
/****** Object:  View [drafts].[DependencyUpdates]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[DependencyUpdates]
AS
  SELECT du.ID AS [Dependency Update ID]
		, g.Title AS [Group]
		, dir.Title AS [Directorate]
		, p.Title AS [Project]
		, du.UpdatePeriod AS [Report Month]
		, d.ThirdParty AS [Name of third party]
		, d.ID AS [Dependency ID]
		, d.Title AS [Dependency]
		, du.Comment AS [Progress Update]
		, CAST(d.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
		, CAST(du.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
		, CAST(du.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
		, pdu.PreviousRAG AS [Previous RAG]
		, pdu.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - pdu.PreviousRAGScore AS [RAG Change]
		, LeadUser.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(du.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE du.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Dependency Closed]
		, es.Title AS [Status]
  FROM (SELECT MAX(ID) AS CurrentDraftID
    FROM [dbo].[DependencyUpdates]
    GROUP BY DependencyID, UpdatePeriod) AS currentDraft INNER JOIN
    dbo.DependencyUpdates AS du ON currentDraft.CurrentDraftID = du.ID INNER JOIN
    dbo.Dependencies AS d ON du.DependencyID = d.ID INNER JOIN
    dbo.Projects AS p ON d.ProjectID = p.ID LEFT OUTER JOIN
    dbo.Directorates AS dir ON p.DirectorateID = dir.ID LEFT OUTER JOIN
    dbo.Groups AS g ON dir.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON d.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON du.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON du.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON d.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.PreviousDependencyUpdates AS pdu ON d.ID = pdu.DependencyID AND du.UpdatePeriod = pdu.NextMonth;
GO
/****** Object:  Table [dbo].[MilestoneUpdates]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MilestoneUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[MilestoneID] [int] NOT NULL,
	[UpdateDate] [datetime2](7) NULL,
	[RagOptionID] [int] NULL,
	[Comment] [nvarchar](500) NULL,
	[ForecastDate] [datetime2](7) NULL,
	[ActualDate] [datetime2](7) NULL,
	[UpdateUserID] [int] NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
 CONSTRAINT [PK_MilestoneUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PreviousMilestoneUpdates]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PreviousMilestoneUpdates]
AS
	SELECT dbo.MilestoneUpdates.MilestoneID
			, nextso.ReportMonth AS [NextMonth]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.MilestoneUpdates ON so.ID = dbo.MilestoneUpdates.SignOffID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.MilestoneUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND (
			(
				so.DirectorateID = nextso.DirectorateID AND nextso.ReportMonth = (
					SELECT MIN(ReportMonth)
					FROM SignOffs
					WHERE DirectorateID = so.DirectorateID AND ReportMonth > so.ReportMonth AND IsCurrent = 1
				)
			) OR (
				so.ProjectID = nextso.ProjectID AND nextso.ReportMonth = (
					SELECT MIN(ReportMonth)
					FROM SignOffs
					WHERE ProjectID = so.ProjectID AND ReportMonth > so.ReportMonth AND IsCurrent = 1
				)
			) OR (
				so.PartnerOrganisationID = nextso.PartnerOrganisationID AND nextso.ReportMonth = (
					SELECT MIN(ReportMonth)
					FROM SignOffs
					WHERE PartnerOrganisationID = so.PartnerOrganisationID AND ReportMonth > so.ReportMonth AND IsCurrent = 1
				)
			))
	WHERE so.IsCurrent = 1
GO
/****** Object:  Table [History].[Milestones]    Script Date: 08/11/2022 15:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Milestones](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[MilestoneCode] [nvarchar](255) NULL,
	[BaselineDate] [datetime] NULL,
	[ForecastDate] [datetime] NULL,
	[ActualDate] [datetime] NULL,
	[MilestoneTypeID] [int] NULL,
	[LeadUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[WorkStreamID] [int] NULL,
	[KeyWorkAreaID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[PartnerOrganisationID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[StartDate] [datetime] NULL,
	[Description] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Milestones]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Milestones](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[MilestoneCode] [nvarchar](255) NULL,
	[BaselineDate] [datetime] NULL,
	[ForecastDate] [datetime] NULL,
	[ActualDate] [datetime] NULL,
	[MilestoneTypeID] [int] NULL,
	[LeadUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[WorkStreamID] [int] NULL,
	[KeyWorkAreaID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[PartnerOrganisationID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[StartDate] [datetime] NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Milestones] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Milestones] )
)
GO
/****** Object:  Table [History].[Attributes]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Attributes](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[AttributeTypeID] [int] NOT NULL,
	[AttributeValue] [nvarchar](255) NULL,
	[BenefitID] [int] NULL,
	[CommitmentID] [int] NULL,
	[KeyWorkAreaID] [int] NULL,
	[MetricID] [int] NULL,
	[WorkStreamID] [int] NULL,
	[MilestoneID] [int] NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[RiskID] [int] NULL,
	[PartnerOrganisationRiskID] [int] NULL,
	[DirectorateID] [int] NULL,
	[ProjectID] [int] NULL,
	[ReportingEntityID] [int] NULL,
	[DependencyID] [int] NULL,
	[PartnerOrganisationID] [int] NULL,
	[RiskMitigationActionID] [int] NULL,
	[PartnerOrganisationRiskMitigationActionID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attributes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[AttributeTypeID] [int] NOT NULL,
	[AttributeValue] [nvarchar](255) NULL,
	[BenefitID] [int] NULL,
	[CommitmentID] [int] NULL,
	[KeyWorkAreaID] [int] NULL,
	[MetricID] [int] NULL,
	[WorkStreamID] [int] NULL,
	[MilestoneID] [int] NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[RiskID] [int] NULL,
	[PartnerOrganisationRiskID] [int] NULL,
	[DirectorateID] [int] NULL,
	[ProjectID] [int] NULL,
	[ReportingEntityID] [int] NULL,
	[DependencyID] [int] NULL,
	[PartnerOrganisationID] [int] NULL,
	[RiskMitigationActionID] [int] NULL,
	[PartnerOrganisationRiskMitigationActionID] [int] NULL,
 CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Attributes] )
)
GO
/****** Object:  View [drafts].[KeyWorkAreaMilestoneUpdates]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[KeyWorkAreaMilestoneUpdates]
AS
  SELECT mu.ID AS [Milestone Update ID]
			, mu.UpdatePeriod AS [Report Month]
			, g.Title AS [Group]
			, d.Title AS [Directorate]
			, m.KeyWorkAreaID AS [Key Work Area ID]
			, k.Title AS [Key Work Area]
			, m.ID AS [Milestone ID]
			, m.MilestoneCode AS [Milestone ID (User)]
			, m.Title AS [Milestone]
			, mu.Comment AS [Progress Update]
			, m.Description AS [Milestone Description]
			, CAST(m.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
			, CAST(mu.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
			, CAST(mu.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
			, pmu.PreviousRAG AS [Previous RAG]
			, pmu.PreviousRAGScore AS [Previous RAG Score]
			, dbo.RagOptions.ReportName AS [Current RAG]
			, dbo.RagOptions.ID AS [Current RAG Score]
			, dbo.RagOptions.ID - pmu.PreviousRAGScore AS [RAG Change]
			, LeadUser.Title AS [Lead]
			, UpdateAuthor.Title AS [Author]
			, CAST(mu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			, CASE mu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Milestone Closed]
			, CASE WHEN SdpMilestones.ID IS NOT NULL THEN 'Yes' ELSE NULL END AS [SDP]
			, SdpMilestones.AttributeValue AS [SDP Value]
			, CAST(m.StartDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Start Date] 
			, es.Title AS [Status]
  FROM dbo.Milestones AS m LEFT OUTER JOIN
    dbo.KeyWorkAreas AS k ON m.KeyWorkAreaID = k.ID LEFT OUTER JOIN
    dbo.MilestoneUpdates AS mu ON m.ID = mu.MilestoneID INNER JOIN
    (SELECT MAX(mu.ID) AS CurrentDraftID
      , MilestoneID
      , UpdatePeriod
    FROM [dbo].[MilestoneUpdates] AS mu INNER JOIN [dbo].[Milestones] AS m ON mu.MilestoneID = m.ID
    WHERE m.KeyWorkAreaID IS NOT NULL
    GROUP BY MilestoneID, UpdatePeriod) AS currentDraft ON currentDraft.CurrentDraftID = mu.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON k.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON m.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON mu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON mu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.PreviousMilestoneUpdates AS pmu ON m.ID = pmu.MilestoneID AND mu.UpdatePeriod = pmu.NextMonth LEFT OUTER JOIN
    dbo.Attributes AS SdpMilestones ON m.ID = SdpMilestones.MilestoneID AND SdpMilestones.AttributeTypeID = 2 LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON m.EntityStatusID = es.ID
GO
/****** Object:  Table [dbo].[RagOptionsMapping]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RagOptionsMapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RiskProbabilityID] [int] NOT NULL,
	[RiskImpactLevelID] [int] NOT NULL,
	[RagOptionID] [int] NOT NULL,
 CONSTRAINT [PK_RagOptionsMapping] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [reports].[RagFromRILandRP]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[RagFromRILandRP]
AS 
SELECT rom.RiskImpactLevelID AS RILID, 
rom.RiskProbabilityID AS RPID, 
rom.RagOptionID AS RAG,
ro.ReportName AS [RAGReportName],
CASE rom.RagOptionID
    WHEN 1 THEN 1 -- Red
	WHEN 2 THEN 2 -- Amber-Red
	WHEN 3 THEN 0 -- No Amber for Risks
	WHEN 4 THEN 3 -- Amber-Green
	WHEN 5 THEN 4 -- Green
END AS [RAGScore] 
FROM dbo.RagOptionsMapping rom
LEFT OUTER JOIN dbo.RagOptions ro ON rom.RagOptionID = ro.ID
GO
/****** Object:  Table [dbo].[ProjectUpdates]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Comment] [varchar](1000) NULL,
	[RagOptionID] [int] NULL,
	[ProjectID] [int] NOT NULL,
	[UpdateDate] [datetime2](7) NULL,
	[UpdateUserID] [int] NULL,
	[OverallRagOptionID] [int] NULL,
	[FinanceRagOptionID] [int] NULL,
	[FinanceComment] [nvarchar](500) NULL,
	[PeopleRagOptionID] [int] NULL,
	[PeopleComment] [nvarchar](500) NULL,
	[MilestonesRagOptionID] [int] NULL,
	[MilestonesComment] [nvarchar](500) NULL,
	[BenefitsRagOptionID] [int] NULL,
	[BenefitsComment] [nvarchar](500) NULL,
	[ProgressUpdate] [nvarchar](500) NULL,
	[FutureActions] [nvarchar](500) NULL,
	[Escalations] [nvarchar](500) NULL,
	[ProjectPhaseID] [int] NULL,
	[BusinessCaseTypeID] [int] NULL,
	[BusinessCaseDate] [datetime2](7) NULL,
	[WholeLifeCost] [decimal](18, 4) NULL,
	[WholeLifeBenefit] [decimal](18, 4) NULL,
	[NetPresentValue] [decimal](18, 4) NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
 CONSTRAINT [PK_ProjectUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PreviousProjectUpdates]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PreviousProjectUpdates]
AS
	SELECT dbo.ProjectUpdates.ProjectID
			, nextso.ReportMonth AS [NextMonth]
			, DeliveryConfidenceRAG.ReportName AS [PreviousDeliveryConfidenceRAG]
			, DeliveryConfidenceRAG.Score AS [PreviousDeliveryConfidenceRAGScore]
			, FinanceRAG.ReportName AS [PreviousFinanceRAG]
			, FinanceRAG.Score AS [PreviousFinanceRAGScore]
			, BenefitsRAG.ReportName AS [PreviousBenefitsRAG]
			, BenefitsRAG.Score AS [PreviousBenefitsRAGScore]
			, MilestonesRAG.ReportName AS [PreviousMilestonesRAG]
			, MilestonesRAG.Score AS [PreviousMilestonesRAGScore]
			, PeopleRAG.ReportName AS [PreviousPeopleRAG]
			, PeopleRAG.Score AS [PreviousPeopleRAGScore]
	FROM dbo.SignOffs INNER JOIN
		dbo.ProjectUpdates ON dbo.SignOffs.ID = dbo.ProjectUpdates.SignOffID LEFT OUTER JOIN
		dbo.RagOptions AS DeliveryConfidenceRAG ON dbo.ProjectUpdates.OverallRagOptionID = DeliveryConfidenceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON dbo.ProjectUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS BenefitsRAG ON dbo.ProjectUpdates.BenefitsRagOptionID = BenefitsRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON dbo.ProjectUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON dbo.ProjectUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND dbo.SignOffs.ProjectID = nextso.ProjectID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE ProjectID = dbo.SignOffs.ProjectID AND ReportMonth > dbo.SignOffs.ReportMonth AND IsCurrent = 1)
	WHERE dbo.SignOffs.IsCurrent = 1
GO
/****** Object:  View [drafts].[KeyWorkAreaUpdates]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[KeyWorkAreaUpdates]
AS
  SELECT ku.ID AS [Key Work Area Update ID]
			, g.Title AS [Group]
			, d.Title AS [Directorate]
			, ku.UpdatePeriod AS [Report Month]
			, ku.KeyWorkAreaID AS [Key Work Area ID]
			, k.Title AS [Key Work Area]
			, ku.Comment AS [Progress Update]
			, pku.PreviousRAG AS [Previous RAG]
			, pku.PreviousRAGScore AS [Previous RAG Score]
			, dbo.RagOptions.ReportName AS [Current RAG]
			, dbo.RagOptions.Score AS [Current RAG Score]
			, dbo.RagOptions.Score - pku.PreviousRAGScore AS [RAG Change]
			, LeadUser.Title AS [Lead]
			, UpdateAuthor.Title AS [Author]
			, CAST(ku.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			, CASE ku.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Key Work Area Closed]
			, es.Title AS [Status]
  FROM (SELECT MAX(ID) AS CurrentDraftID
      , KeyWorkAreaID
      , UpdatePeriod
    FROM [dbo].[KeyWorkAreaUpdates]
    GROUP BY KeyWorkAreaID, UpdatePeriod) AS currentDraft INNER JOIN
    dbo.KeyWorkAreaUpdates AS ku ON currentDraft.CurrentDraftID = ku.ID INNER JOIN
    dbo.KeyWorkAreas AS k ON ku.KeyWorkAreaID = k.ID INNER JOIN
    dbo.Directorates AS d ON k.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON k.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON ku.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON ku.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON k.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.PreviousKeyWorkAreaUpdates AS pku ON k.ID = pku.ID AND ku.UpdatePeriod = pku.NextMonth
GO
/****** Object:  Table [History].[WorkStreams]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[WorkStreams](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[WorkStreamCode] [nvarchar](255) NULL,
	[ProjectID] [int] NOT NULL,
	[LeadUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkStreams]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkStreams](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[WorkStreamCode] [nvarchar](255) NULL,
	[ProjectID] [int] NOT NULL,
	[LeadUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_WorkStreams] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[WorkStreams] )
)
GO
/****** Object:  Table [dbo].[WorkStreamUpdates]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkStreamUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[WorkStreamID] [int] NOT NULL,
	[UpdateDate] [datetime2](7) NULL,
	[UpdateUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[Comment] [nvarchar](500) NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
 CONSTRAINT [PK_WorkStreamUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PreviousWorkStreamUpdates]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PreviousWorkStreamUpdates]
AS
	SELECT dbo.WorkStreams.ID
			, nextso.ReportMonth AS [NextMonth]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.WorkStreamUpdates ON so.ID = dbo.WorkStreamUpdates.SignOffID INNER JOIN
		dbo.WorkStreams ON dbo.WorkStreamUpdates.WorkStreamID = dbo.WorkStreams.ID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.WorkStreamUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.ProjectID = nextso.ProjectID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE ProjectID = so.ProjectID AND ReportMonth > so.ReportMonth AND IsCurrent = 1)
	WHERE so.IsCurrent = 1
GO
/****** Object:  View [drafts].[MetricUpdates]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[MetricUpdates]
AS
  SELECT mu.ID AS [Metric Update ID]
		, g.Title AS [Group]
		, d.Title AS [Directorate]
		, mu.UpdatePeriod AS [Report Month]
		, m.ID AS [Metric ID]
		, m.MetricCode AS [Metric ID (User)]
		, m.Title AS [Metric]
		, mu.Comment AS [Progress Update]
		, CAST(pmu.PreviousPerformance AS float) AS [Previous Performance]
		, CAST(mu.CurrentPerformance AS float) AS [Current Performance]
		, CAST(m.TargetPerformanceLowerLimit AS float) AS [Target Performance Lower]
		, CAST(m.TargetPerformanceUpperLimit AS float) AS [Target Performance Upper]
		, measurements.Title AS [Performance Unit]
		, pmu.PreviousRAG AS [Previous RAG]
		, pmu.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - pmu.PreviousRAGScore AS [RAG Change]
		, LeadUser.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(mu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE mu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Metric Closed]
		, es.Title AS [Status] 
		 , CASE m.ReportingFrequency 
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
        , CASE m.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(m.ReportingStartDate)
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(m.ReportingStartDate)
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(m.ReportingStartDate)
                WHEN 1 THEN 'Jan' 
                WHEN 2 THEN 'Feb' 
                WHEN 3 THEN 'Mar' 
                WHEN 4 THEN 'Apr' 
                WHEN 5 THEN 'May' 
                WHEN 6 THEN 'Jun' 
                WHEN 7 THEN 'Jul' 
                WHEN 8 THEN 'Aug' 
                WHEN 9 THEN 'Sep' 
                WHEN 10 THEN 'Oct' 
                WHEN 11 THEN 'Nov' 
                WHEN 12 THEN 'Dec' 
                ELSE '' 
            END 
        END AS [Reporting Schedule]
  FROM (SELECT MAX(ID) AS CurrentDraftID
      , MetricID
      , UpdatePeriod
    FROM [dbo].[MetricUpdates]
    GROUP BY MetricID, UpdatePeriod) AS currentDraft LEFT OUTER JOIN
    dbo.MetricUpdates AS mu ON currentDraft.CurrentDraftID = mu.ID INNER JOIN
    dbo.Metrics AS m ON mu.MetricID = m.ID INNER JOIN
    dbo.Directorates AS d ON m.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON m.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON mu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON mu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.PreviousMetricUpdates AS pmu ON m.ID = pmu.MetricID AND mu.UpdatePeriod = pmu.NextMonth LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON m.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.MeasurementUnits AS measurements ON m.MeasurementUnitID = measurements.ID;
GO
/****** Object:  View [dbo].[ProjectReportingChartDataBenefits]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProjectReportingChartDataBenefits]
AS
SELECT   dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Projects.ID AS [Project ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
		,'Benefits/Metrics' AS [Indicator]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,BenefitRAG.ReportName AS [Rating]
		,BenefitRAG.Score AS [Rating Score]
		,dbo.PreviousProjectUpdates.PreviousBenefitsRAG AS [Previous Rating]
		,dbo.PreviousProjectUpdates.PreviousBenefitsRAGScore AS [Previous Rating Score]
		,BenefitRAG.Score - dbo.PreviousProjectUpdates.PreviousBenefitsRAGScore AS [RAG Change]
FROM  dbo.SignOffs INNER JOIN
        dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID INNER JOIN
        dbo.ProjectUpdates ON dbo.SignOffs.ID = dbo.ProjectUpdates.SignOffID LEFT OUTER JOIN
		dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
        dbo.RagOptions AS BenefitRAG ON dbo.ProjectUpdates.BenefitsRagOptionID = BenefitRAG.ID LEFT OUTER JOIN
		dbo.PreviousProjectUpdates ON dbo.PreviousProjectUpdates.ProjectID = dbo.SignOffs.ProjectID AND dbo.PreviousProjectUpdates.NextMonth = dbo.SignOffs.ReportMonth
WHERE   (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  Table [History].[PartnerOrganisations]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[PartnerOrganisations](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[DirectorateID] [int] NULL,
	[LeadPolicySponsorUserID] [int] NULL,
	[ReportAuthorUserID] [int] NULL,
	[Objectives] [nvarchar](max) NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[ModifiedByUserID] [int] NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[CreatedDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartnerOrganisations]    Script Date: 08/11/2022 15:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartnerOrganisations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[DirectorateID] [int] NULL,
	[LeadPolicySponsorUserID] [int] NULL,
	[ReportAuthorUserID] [int] NULL,
	[Objectives] [nvarchar](max) NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[ModifiedByUserID] [int] NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[CreatedDate] [datetime2](0) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_PartnerOrganisations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[PartnerOrganisations] )
)
GO
/****** Object:  View [drafts].[PartnerOrganisationMilestoneUpdates]    Script Date: 08/11/2022 15:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[PartnerOrganisationMilestoneUpdates]
AS
  SELECT mu.ID AS [Milestone Update ID]
			, mu.UpdatePeriod AS [Report Month]
      , po.Title AS [Partner Organisation]
			, m.ID AS [Milestone ID]
			, m.MilestoneCode AS [Milestone ID (User)]
			, m.Title AS [Milestone]
			, mu.Comment AS [Progress Update]
			, m.Description AS [Milestone Description]
			, CAST(m.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
			, CAST(mu.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
			, CAST(mu.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
			, pmu.PreviousRAG AS [Previous RAG]
			, pmu.PreviousRAGScore AS [Previous RAG Score]
			, dbo.RagOptions.ReportName AS [Current RAG]
			, dbo.RagOptions.ID AS [Current RAG Score]
			, dbo.RagOptions.ID - pmu.PreviousRAGScore AS [RAG Change]
			, LeadUser.Title AS [Lead]
			, UpdateAuthor.Title AS [Author]
			, CAST(mu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			, CASE mu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Milestone Closed]
			, CASE WHEN SdpMilestones.ID IS NOT NULL THEN 'Yes' ELSE NULL END AS [SDP]
			, SdpMilestones.AttributeValue AS [SDP Value]
			, CAST(m.StartDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Start Date] 
			, es.Title AS [Status]
  FROM dbo.Milestones AS m LEFT OUTER JOIN
    dbo.PartnerOrganisations AS po ON m.PartnerOrganisationID = po.ID LEFT OUTER JOIN
    dbo.MilestoneUpdates AS mu ON m.ID = mu.MilestoneID INNER JOIN
    (SELECT MAX(mu.ID) AS CurrentDraftID
      , MilestoneID
      , UpdatePeriod
    FROM [dbo].[MilestoneUpdates] AS mu INNER JOIN [dbo].[Milestones] AS m ON mu.MilestoneID = m.ID
    WHERE m.PartnerOrganisationID IS NOT NULL
    GROUP BY MilestoneID, UpdatePeriod) AS currentDraft ON currentDraft.CurrentDraftID = mu.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON m.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON mu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON mu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.PreviousMilestoneUpdates AS pmu ON m.ID = pmu.MilestoneID AND mu.UpdatePeriod = pmu.NextMonth LEFT OUTER JOIN
    dbo.Attributes AS SdpMilestones ON m.ID = SdpMilestones.MilestoneID AND SdpMilestones.AttributeTypeID = 2 LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON m.EntityStatusID = es.ID
GO
/****** Object:  View [dbo].[ProjectReportingChartDataDeliveryConfidence]    Script Date: 08/11/2022 15:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProjectReportingChartDataDeliveryConfidence]
AS
SELECT   dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Projects.ID AS [Project ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
		,'Delivery Confidence' AS [Indicator]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,OverallRAG.ReportName AS [Rating]
		,OverallRAG.Score AS [Rating Score]
		,dbo.PreviousProjectUpdates.PreviousDeliveryConfidenceRAG AS [Previous Rating]
		,dbo.PreviousProjectUpdates.PreviousDeliveryConfidenceRAGScore AS [Previous Rating Score]
		,OverallRAG.Score - dbo.PreviousProjectUpdates.PreviousDeliveryConfidenceRAGScore AS [RAG Change]
FROM  dbo.SignOffs INNER JOIN
        dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID INNER JOIN
        dbo.ProjectUpdates ON dbo.SignOffs.ID = dbo.ProjectUpdates.SignOffID LEFT OUTER JOIN
		dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
        dbo.RagOptions AS OverallRAG ON dbo.ProjectUpdates.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
		dbo.PreviousProjectUpdates ON dbo.PreviousProjectUpdates.ProjectID = dbo.SignOffs.ProjectID AND dbo.PreviousProjectUpdates.NextMonth = dbo.SignOffs.ReportMonth
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  Table [dbo].[PartnerOrganisationRiskMitigationActionUpdates]    Script Date: 08/11/2022 15:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NULL,
	[PartnerOrganisationRiskMitigationActionID] [int] NULL,
	[UpdateDate] [datetime2](7) NULL,
	[UpdateUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[Comment] [nvarchar](500) NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
	[SignOffID] [int] NULL,
 CONSTRAINT [PK_PartnerOrganisationRiskMitigationActionUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [History].[PartnerOrganisationRiskRiskTypes]    Script Date: 08/11/2022 15:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[PartnerOrganisationRiskRiskTypes](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[PartnerOrganisationRiskID] [int] NOT NULL,
	[RiskTypeID] [int] NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_PartnerOrganisationRiskRiskTypes]    Script Date: 08/11/2022 15:27:05 ******/
CREATE CLUSTERED INDEX [ix_PartnerOrganisationRiskRiskTypes] ON [History].[PartnerOrganisationRiskRiskTypes]
(
	[SysEndTime] ASC,
	[SysStartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartnerOrganisationRiskRiskTypes]    Script Date: 08/11/2022 15:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartnerOrganisationRiskRiskTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[PartnerOrganisationRiskID] [int] NOT NULL,
	[RiskTypeID] [int] NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PK_PartnerOrganisationRiskRiskTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[PartnerOrganisationRiskRiskTypes] )
)
GO
/****** Object:  Table [dbo].[PartnerOrganisationRiskUpdates]    Script Date: 08/11/2022 15:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartnerOrganisationRiskUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Comment] [nvarchar](500) NULL,
	[RagOptionID] [int] NULL,
	[BeisRagOptionID] [int] NULL,
	[PartnerOrganisationRiskID] [int] NULL,
	[UpdateUserID] [int] NULL,
	[UpdateDate] [datetime2](7) NULL,
	[RiskProbabilityID] [int] NULL,
	[RiskImpactLevelID] [int] NULL,
	[BeisRiskProbabilityID] [int] NULL,
	[BeisRiskImpactLevelID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
	[IsCurrent] [bit] NULL,
	[RiskProximity] [date] NULL,
	[RiskIsOngoing] [bit] NULL,
	[SignOffID] [int] NULL,
 CONSTRAINT [PK_PartnerOrganisationRiskUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RiskTypes]    Script Date: 08/11/2022 15:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[ThresholdID] [int] NULL,
 CONSTRAINT [PK_RiskImpactTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [History].[PartnerOrganisationRiskMitigationActions]    Script Date: 08/11/2022 15:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[PartnerOrganisationRiskMitigationActions](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](200) NULL,
	[Description] [nvarchar](500) NULL,
	[PartnerOrganisationRiskID] [int] NULL,
	[RiskMitigationActionCode] [int] NULL,
	[BaselineDate] [date] NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
	[OwnerUserID] [int] NULL,
	[ActionIsOngoing] [bit] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[LeadUserID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_PartnerOrganisationRiskMitigationActions]    Script Date: 08/11/2022 15:27:05 ******/
CREATE CLUSTERED INDEX [ix_PartnerOrganisationRiskMitigationActions] ON [History].[PartnerOrganisationRiskMitigationActions]
(
	[SysEndTime] ASC,
	[SysStartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartnerOrganisationRiskMitigationActions]    Script Date: 08/11/2022 15:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartnerOrganisationRiskMitigationActions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NULL,
	[Description] [nvarchar](500) NULL,
	[PartnerOrganisationRiskID] [int] NULL,
	[RiskMitigationActionCode] [int] NULL,
	[BaselineDate] [date] NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
	[OwnerUserID] [int] NULL,
	[ActionIsOngoing] [bit] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[LeadUserID] [int] NULL,
 CONSTRAINT [PK_PartnerOrganisationRiskMitigatingActions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[PartnerOrganisationRiskMitigationActions] )
)
GO
/****** Object:  Table [History].[PartnerOrganisationRisks]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[PartnerOrganisationRisks](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[RiskCode] [nvarchar](50) NULL,
	[PartnerOrganisationID] [int] NOT NULL,
	[RiskOwnerUserID] [int] NULL,
	[BeisRiskOwnerUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[RiskEventDescription] [nvarchar](600) NULL,
	[RiskCauseDescription] [nvarchar](600) NULL,
	[RiskImpactDescription] [nvarchar](600) NULL,
	[UnmitigatedRiskProbabilityID] [int] NULL,
	[UnmitigatedRiskImpactLevelID] [int] NULL,
	[TargetRiskProbabilityID] [int] NULL,
	[TargetRiskImpactLevelID] [int] NULL,
	[BEISUnmitigatedRiskProbabilityID] [int] NULL,
	[BEISUnmitigatedRiskImpactLevelID] [int] NULL,
	[BEISTargetRiskProbabilityID] [int] NULL,
	[BEISTargetRiskImpactLevelID] [int] NULL,
	[RiskAppetiteID] [int] NULL,
	[BeisRiskAppetiteID] [int] NULL,
	[DepartmentalObjectiveID] [int] NULL,
	[RiskProximity] [date] NULL,
	[RiskIsOngoing] [bit] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[ModifiedByUserID] [int] NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[LeadUserID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_PartnerOrganisationRisks]    Script Date: 08/11/2022 15:27:06 ******/
CREATE CLUSTERED INDEX [ix_PartnerOrganisationRisks] ON [History].[PartnerOrganisationRisks]
(
	[SysEndTime] ASC,
	[SysStartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartnerOrganisationRisks]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartnerOrganisationRisks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[RiskCode] [nvarchar](50) NULL,
	[PartnerOrganisationID] [int] NOT NULL,
	[RiskOwnerUserID] [int] NULL,
	[BeisRiskOwnerUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[RiskEventDescription] [nvarchar](600) NULL,
	[RiskCauseDescription] [nvarchar](600) NULL,
	[RiskImpactDescription] [nvarchar](600) NULL,
	[UnmitigatedRiskProbabilityID] [int] NULL,
	[UnmitigatedRiskImpactLevelID] [int] NULL,
	[TargetRiskProbabilityID] [int] NULL,
	[TargetRiskImpactLevelID] [int] NULL,
	[BEISUnmitigatedRiskProbabilityID] [int] NULL,
	[BEISUnmitigatedRiskImpactLevelID] [int] NULL,
	[BEISTargetRiskProbabilityID] [int] NULL,
	[BEISTargetRiskImpactLevelID] [int] NULL,
	[RiskAppetiteID] [int] NULL,
	[BeisRiskAppetiteID] [int] NULL,
	[DepartmentalObjectiveID] [int] NULL,
	[RiskProximity] [date] NULL,
	[RiskIsOngoing] [bit] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[ModifiedByUserID] [int] NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[Description] [nvarchar](500) NULL,
	[LeadUserID] [int] NULL,
 CONSTRAINT [PK_PartnerOrganisationRisks] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[PartnerOrganisationRisks] )
)
GO
/****** Object:  View [drafts].[PartnerOrganisationRiskMitigationActionUpdates]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[PartnerOrganisationRiskMitigationActionUpdates]
AS
  WITH
    RiskTypesForRisk
    AS
    (
      SELECT por.ID AS PartnerOrganisationRiskID, STRING_AGG(rt.Title, ',') WITHIN GROUP (ORDER BY rt.Title) AS RiskTypes
      FROM dbo.PartnerOrganisationRisks por
        JOIN dbo.PartnerOrganisationRiskRiskTypes porrt ON porrt.PartnerOrganisationRiskID = por.ID
        JOIN dbo.RiskTypes rt ON rt.ID = porrt.RiskTypeID
      GROUP BY por.ID
    )
  SELECT rmau.ID AS [Risk Mitigation Action Update ID]
	, po.Title AS [Partner Organisation]
	, d.Title AS [Directorate] 
	, g.Title AS [Group] 
	, r.ID AS [Risk ID]
	, rma.ID AS [Risk Mitigation Action ID]
	, r.Title AS [Risk Name]
	, poRiskTypes.RiskTypes AS [Risk Type] 
	, rma.Title AS [Mitigation Action]
	, rma.Description AS [Description]
	, ISNULL(rma.ActualDate, rma.ForecastDate) AS [Delivery Date]
	, CASE
		WHEN rma.ActionIsOngoing = 'true' THEN 'Yes'
		ELSE 'No'
	 END AS [Is ongoing]
	, rmao.Title AS [Action Owner]
	, rmau.UpdatePeriod AS [Report Month]
	, ro.ReportName AS [RAG Status]
	, ro.Score AS [RAG Score]
	, PartnerOrganisationRiskMitigationActionsLastMonth.[RAG Status] AS [Previous RAG Status]
	, PartnerOrganisationRiskMitigationActionsLastMonth.[RAG Score] AS [Previous RAG Score] 
	, (ro.Score - PartnerOrganisationRiskMitigationActionsLastMonth.[RAG Score]) AS [RAG Change] 
	, rmau.Comment AS [Progress]
	, rmauu.Title AS [Last Updated by]
	, es.Title AS [Status]
	, CAST(ru.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]

  FROM dbo.PartnerOrganisationRiskMitigationActionUpdates AS rmau LEFT OUTER JOIN
    dbo.PartnerOrganisationRiskMitigationActions AS rma ON rmau.PartnerOrganisationRiskMitigationActionID = rma.ID LEFT OUTER JOIN
    dbo.PartnerOrganisationRiskUpdates AS ru ON rma.PartnerOrganisationRiskID = ru.PartnerOrganisationRiskID LEFT OUTER JOIN
    dbo.PartnerOrganisationRisks AS r ON r.ID = rma.PartnerOrganisationRiskID LEFT OUTER JOIN
    dbo.PartnerOrganisations AS po ON r.PartnerOrganisationID = po.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON po.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users rmao ON rmao.ID = rma.OwnerUserID LEFT OUTER JOIN
    dbo.Users rmauu ON rmauu.ID = rmau.UpdateUserID LEFT OUTER JOIN
    dbo.EntityStatuses es ON es.ID = rma.EntityStatusID LEFT OUTER JOIN
    dbo.RagOptions ro ON ro.ID = rmau.RagOptionID LEFT OUTER JOIN
    RiskTypesForRisk AS poRiskTypes ON r.ID = poRiskTypes.PartnerOrganisationRiskID LEFT OUTER JOIN
    (SELECT rmau.PartnerOrganisationRiskMitigationActionID AS [PartnerOrganisationRiskMitigationActionID]
		, EOMONTH(DATEADD(MONTH, 1, rmau.UpdatePeriod)) AS [NextMonth]
		, ro.ReportName AS [RAG status]
		, ro.Score AS [RAG Score]
    FROM dbo.PartnerOrganisationRiskMitigationActionUpdates AS rmau LEFT OUTER JOIN
      dbo.PartnerOrganisationRiskUpdates AS ru ON ru.SignOffID = rmau.SignOffID LEFT OUTER JOIN
      dbo.PartnerOrganisationRiskMitigationActions AS rma ON rma.ID = rmau.PartnerOrganisationRiskMitigationActionID LEFT OUTER JOIN
      dbo.RagOptions ro ON ro.ID = rmau.RagOptionID
    WHERE ru.IsCurrent = 1) AS PartnerOrganisationRiskMitigationActionsLastMonth ON rmau.PartnerOrganisationRiskMitigationActionID = PartnerOrganisationRiskMitigationActionsLastMonth.PartnerOrganisationRiskMitigationActionID
      AND rmau.UpdatePeriod = PartnerOrganisationRiskMitigationActionsLastMonth.NextMonth
  WHERE	ru.IsCurrent = 1
GO
/****** Object:  View [dbo].[ProjectReportingChartDataFinance]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProjectReportingChartDataFinance]
AS
SELECT  dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Projects.ID AS [Project ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
		,'Finance' AS [Indicator]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,FinanceRAG.ReportName AS [Rating]
		,FinanceRAG.Score AS [Rating Score]
		,dbo.PreviousProjectUpdates.PreviousFinanceRAG AS [Previous Rating]
		,dbo.PreviousProjectUpdates.PreviousFinanceRAGScore AS [Previous Rating Score]
		,FinanceRAG.Score - dbo.PreviousProjectUpdates.PreviousFinanceRAGScore AS [RAG Change]
FROM     dbo.SignOffs INNER JOIN
            dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID INNER JOIN
            dbo.ProjectUpdates ON dbo.SignOffs.ID = dbo.ProjectUpdates.SignOffID LEFT OUTER JOIN
			dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
            dbo.RagOptions AS FinanceRAG ON dbo.ProjectUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
			dbo.PreviousProjectUpdates ON dbo.PreviousProjectUpdates.ProjectID = dbo.SignOffs.ProjectID AND dbo.PreviousProjectUpdates.NextMonth = dbo.SignOffs.ReportMonth
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  Table [dbo].[RiskImpactLevels]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskImpactLevels](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[StartUpdatePeriod] [date] NULL,
	[EndUpdatePeriod] [date] NULL,
 CONSTRAINT [PK_RiskImpactLevels] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RiskProbabilities]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskProbabilities](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[StartUpdatePeriod] [date] NULL,
	[EndUpdatePeriod] [date] NULL,
 CONSTRAINT [PK_RiskProbabilities] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [drafts].[PartnerOrganisationRiskUpdates]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[PartnerOrganisationRiskUpdates]
AS
  WITH
    RiskTypesForRisk
    AS
    (
      SELECT por.ID AS PartnerOrganisationRiskID, STRING_AGG(rt.Title, ',') WITHIN GROUP (ORDER BY rt.Title) AS RiskTypes
      FROM dbo.PartnerOrganisationRisks por
        JOIN dbo.PartnerOrganisationRiskRiskTypes porrt ON porrt.PartnerOrganisationRiskID = por.ID
        JOIN dbo.RiskTypes rt ON rt.ID = porrt.RiskTypeID
      GROUP BY por.ID
    )
  SELECT u.Title AS [Author]
		, d.Title AS [Directorate] 
		, g.Title AS [Group]
	  , CAST(poru.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
	  , CASE poru.ToBeClosed WHEN 1 THEN poru.Comment ELSE NULL END AS [Closure Comment]

	  , beisRil.Title AS [BEIS Impact level]
	  , poRil.Title AS [Partner Organisation Impact Level]
	
	  , beisRp.Title AS [BEIS Probability]
	  , poRp.Title AS [Partner Organisation Probability] 
	  , OverallBeisRp.RAGReportName AS [BEIS RAG]
	  , OverallBeisRp.RAGScore AS [BEIS RAG Score]
	
	  , OverallRp.RAGReportName AS [Partner Organisation RAG]
	  , OverallRp.RAGScore AS [Partner Organisation RAG Score] 
	   
  	, poru.UpdatePeriod AS [Report Month]

	  , poru.PartnerOrganisationRiskID AS [Risk ID]
	  , por.RiskCode AS [Risk ID (user)]
	  , poru.Title AS [Risk Name]
	  , poRiskTypes.RiskTypes AS [Risk Type]
	  , poru.ID AS [Risk Update ID]
		
	  , beisTIL.Title AS [BEIS Target Impact]
	  , poTIL.Title AS [Partner Organisation Target Impact]
		
	  , beisTrp.Title AS [BEIS Target Probability]
	  , poTrp.Title AS [Partner Organisation Target Probability]
	
	  , OverallBeisTrp.RAGReportName AS [BEIS Target RAG]
	  , OverallTrp.RAGReportName AS [Partner Organisation Target RAG]

    , RisksLastMonth.ProbabilityBEIS AS [BEIS Previous Probability]
	  , RisksLastMonth.[Impact levelBEIS] AS [BEIS Previous Impact Level]
    , RisksLastMonth.RAGBEIS AS [BEIS Previous RAG]
  	, RisksLastMonth.BeisRagScore AS [BEIS Previous RAG Score]
  	, (OverallBEISRp.RAGScore- RisksLastMonth.BeisRagScore) AS [BEIS RAG Change]

	  , RisksLastMonth.ProbabilityPO AS [Partner Organisation Previous Probability]
	  , RisksLastMonth.[Impact levelPO] AS [Partner Organisation Previous Impact Level]
    , RisksLastMonth.RAGPO AS [Partner Organisation Previous RAG]
	  , RisksLastMonth.RAGScore AS [Partner Organisation Previous RAG Score]
	  , (OverallRp.RAGScore- RisksLastMonth.RAGScore) AS [Partner Organisation RAG Change]

	  , CASE poru.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be closed]

	  , CAST(poru.RiskProximity AS DATE) AS [Risk Proximity]
	  , es.Title AS [Status]

  FROM dbo.PartnerOrganisationRiskUpdates AS poru LEFT OUTER JOIN
    dbo.PartnerOrganisationRisks AS por ON poru.PartnerOrganisationRiskID = por.ID LEFT OUTER JOIN
    dbo.Users AS u ON poru.UpdateUserID = u.ID LEFT OUTER JOIN
    dbo.PartnerOrganisations AS po ON por.PartnerOrganisationID = po.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON po.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON por.EntityStatusID = es.ID LEFT OUTER JOIN
    RiskTypesForRisk AS poRiskTypes ON por.ID = poRiskTypes.PartnerOrganisationRiskID LEFT OUTER JOIN

    dbo.RiskImpactLevels AS beisRil ON poru.BeisRiskImpactLevelID = beisRil.ID LEFT OUTER JOIN
    dbo.RiskImpactLevels AS poRil ON poru.RiskImpactLevelID = poRil.ID LEFT OUTER JOIN

    dbo.RiskProbabilities AS beisRp ON poru.BeisRiskProbabilityID = beisRp.ID LEFT OUTER JOIN
    dbo.RiskProbabilities AS poRp ON poru.RiskProbabilityID = poRp.ID LEFT OUTER JOIN

    dbo.RiskImpactLevels AS beisTil ON por.BEISTargetRiskImpactLevelID = beisTil.ID LEFT OUTER JOIN
    dbo.RiskImpactLevels AS poTil ON por.TargetRiskImpactLevelID = poTil.ID LEFT OUTER JOIN

    dbo.RiskProbabilities AS beisTrp ON por.BEISTargetRiskProbabilityID = beisTrp.ID LEFT OUTER JOIN
    dbo.RiskProbabilities AS poTrp ON por.TargetRiskProbabilityID = poTrp.ID LEFT OUTER JOIN

    reports.RagFromRILandRP AS OverallBeisRp ON poru.BeisRiskProbabilityID = OverallBeisRp.RPID and poru.BeisRiskImpactLevelID = OverallBeisRp.RILID LEFT OUTER JOIN
    reports.RagFromRILandRP AS OverallBeisTrp ON por.BEISTargetRiskProbabilityID = OverallBeisTrp.RPID and por.BEISTargetRiskImpactLevelID = OverallBeisTrp.RILID LEFT OUTER JOIN

    reports.RagFromRILandRP AS OverallRp ON poru.RiskProbabilityID = OverallRp.RPID and poru.RiskImpactLevelID = OverallRp.RILID LEFT OUTER JOIN
    reports.RagFromRILandRP AS OverallTrp ON por.TargetRiskProbabilityID = OverallTrp.RPID and por.TargetRiskImpactLevelID = OverallTrp.RILID LEFT OUTER JOIN

    (SELECT poru2.PartnerOrganisationRiskID AS [RiskID]
			, EOMONTH(DATEADD(month, 1, poru2.UpdatePeriod)) AS [NextMonth]
			, roBEIS.RAGReportName AS [RAGBEIS]
			, rpBEIS.Title AS [ProbabilityBEIS]
			, rilBEIS.Title AS [Impact levelBEIS]
			, roBEIS.RAGScore AS [BeisRagScore] 
			, roPO.RAGReportName AS [RAGPO]
			, roPO.RAGScore AS [RAGScore]
			, rpPO.Title AS [ProbabilityPO]
			, rilPO.Title AS [Impact levelPO]
    FROM dbo.PartnerOrganisationRiskUpdates AS poru2 LEFT OUTER JOIN
      reports.RagFromRILandRP AS roBEIS ON roBEIS.RILID = poru2.BeisRiskImpactLevelID AND roBEIS.RPID = poru2.BeisRiskProbabilityID LEFT OUTER JOIN
      dbo.RiskProbabilities AS rpBEIS ON poru2.BeisRiskProbabilityID = rpBEIS.ID LEFT OUTER JOIN
      dbo.RiskImpactLevels AS rilBEIS ON poru2.BeisRiskImpactLevelID = rilBEIS.ID LEFT OUTER JOIN

      reports.RagFromRILandRP AS roPO ON roPO.RILID = poru2.RiskImpactLevelID AND roPO.RPID = poru2.RiskProbabilityID LEFT OUTER JOIN
      dbo.RiskProbabilities AS rpPO ON poru2.RiskProbabilityID = rpPO.ID LEFT OUTER JOIN
      dbo.RiskImpactLevels AS rilPO ON poru2.RiskImpactLevelID = rilPO.ID
    WHERE poru2.IsCurrent = 1) AS RisksLastMonth ON poru.PartnerOrganisationRiskID = RisksLastMonth.RiskID AND poru.UpdatePeriod = RisksLastMonth.NextMonth
  WHERE poru.IsCurrent = 1
GO
/****** Object:  View [dbo].[ProjectReportingChartDataMilestones]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProjectReportingChartDataMilestones]
AS
SELECT  dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Projects.ID AS [Project ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
		,'Milestones' AS [Indicator]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,MilestonesRAG.ReportName AS [Rating]
		,MilestonesRAG.Score AS [Rating Score]
		,dbo.PreviousProjectUpdates.PreviousMilestonesRAG AS [Previous Rating]
		,dbo.PreviousProjectUpdates.PreviousMilestonesRAGScore AS [Previous Rating Score]
		,MilestonesRAG.Score - dbo.PreviousProjectUpdates.PreviousMilestonesRAGScore AS [RAG Change]
FROM  dbo.SignOffs INNER JOIN
        dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID INNER JOIN
        dbo.ProjectUpdates ON dbo.SignOffs.ID = dbo.ProjectUpdates.SignOffID LEFT OUTER JOIN
		dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
        dbo.RagOptions AS MilestonesRAG ON dbo.ProjectUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.PreviousProjectUpdates ON dbo.PreviousProjectUpdates.ProjectID = dbo.SignOffs.ProjectID AND dbo.PreviousProjectUpdates.NextMonth = dbo.SignOffs.ReportMonth
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  Table [dbo].[ProjectBusinessCaseTypes]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectBusinessCaseTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_ProjectBusinessCaseTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectPhases]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectPhases](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_ProjectPhases] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [drafts].[ProjectUpdates]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[ProjectUpdates]
AS
  SELECT g.Title AS [Group]
		, d.Title AS [Directorate]
		, p.Title AS [Project]
		, p.ID AS [ID]
		, Months.UpdatePeriod AS [Report Month]
		, SROUser.Title AS [SRO]
		, ProjectManagerUser.Title AS [Project Manager]
		, UpdateAuthor.Title AS [Author]
		, CAST(pu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, p.Objectives AS [Objectives]
		, pu.ProgressUpdate AS [Delivery Confidence Update]
		, pu.FutureActions AS [Future Actions Update]
		, pu.Escalations AS [Escalations Update]
		, dbo.ProjectPhases.Title AS [Current Phase]
		, dbo.ProjectBusinessCaseTypes.Title AS [Latest approved business case type]
		, CAST(pu.BusinessCaseDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Business Case Approval Date]
		, pu.WholeLifeCost AS [Whole Life Cost £m]
		, pu.WholeLifeBenefit AS [Whole Life Benefit £m]
		, pu.NetPresentValue AS [Net Present Value £m]
		, es.Title AS [Status] 

		, ppu.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, ppu.PreviousFinanceRAG AS [Previous Finance RAG]
		, ppu.PreviousMilestonesRAG AS [Previous Milestones RAG]
		, ppu.PreviousBenefitsRAG AS [Previous Benefits RAG]
		, ppu.PreviousPeopleRAG AS [Previous People RAG]
	
		, ppu.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score]
		, ppu.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, ppu.PreviousMilestonesRAGScore AS [Previous Milestones RAG Score]
		, ppu.PreviousBenefitsRAGScore AS [Previous Benefits RAG Score]
		, ppu.PreviousPeopleRAGScore AS [Previous People RAG Score]

		, OverallRAG.ReportName AS [Delivery Confidence RAG]
		, FinanceRAG.ReportName AS [Finance RAG]
		, MilestonesRAG.ReportName AS [Milestones RAG]
		, BenefitsRAG.ReportName AS [Benefits RAG]
		, PeopleRAG.ReportName AS [People RAG]
	
		, OverallRAG.Score AS [Delivery Confidence RAG Score]
		, FinanceRAG.Score AS [Finance RAG Score]
		, MilestonesRAG.Score AS [Milestones RAG Score]
		, BenefitsRAG.Score AS [Benefits RAG Score]
		, PeopleRAG.Score AS [People RAG Score]

		, pu.FinanceComment AS [Finance Update]
		, pu.MilestonesComment AS [Milestones Update]
		, pu.BenefitsComment AS [Benefits Update]
		, pu.PeopleComment AS [People Update]

		, (OverallRAG.Score - ppu.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (FinanceRAG.Score - ppu.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (MilestonesRAG.Score - ppu.PreviousMilestonesRAGScore) AS [Milestones RAG Change]
		, (BenefitsRAG.Score - ppu.PreviousBenefitsRAGScore) AS [Benefits RAG Change]
		, (PeopleRAG.Score - ppu.PreviousPeopleRAGScore) AS [People RAG Change]

  FROM dbo.Projects AS p CROSS JOIN
           (SELECT DISTINCT UpdatePeriod
    FROM [dbo].[ProjectUpdates]
    WHERE UpdatePeriod IS NOT NULL) AS Months LEFT OUTER JOIN
    dbo.ProjectUpdates AS pu ON p.ID = pu.ProjectID AND Months.UpdatePeriod = pu.UpdatePeriod AND pu.ID IN
	(SELECT MAX([ID]) AS CurrentDraftID
    FROM [dbo].[ProjectUpdates]
    GROUP BY ProjectID, UpdatePeriod) LEFT OUTER JOIN
    dbo.Directorates AS d ON p.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON p.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.RagOptions AS OverallRAG ON pu.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
    dbo.RagOptions AS FinanceRAG ON pu.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
    dbo.RagOptions AS PeopleRAG ON pu.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
    dbo.RagOptions AS MilestonesRAG ON pu.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
    dbo.RagOptions AS BenefitsRAG ON pu.BenefitsRagOptionID = BenefitsRAG.ID LEFT OUTER JOIN
    dbo.Users AS SROUser ON p.SeniorResponsibleOwnerUserID = SROUser.ID LEFT OUTER JOIN
    dbo.Users AS ProjectManagerUser ON p.ProjectManagerUserID = ProjectManagerUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON pu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.ProjectPhases ON pu.ProjectPhaseID = dbo.ProjectPhases.ID LEFT OUTER JOIN
    dbo.ProjectBusinessCaseTypes ON pu.BusinessCaseTypeID = dbo.ProjectBusinessCaseTypes.ID LEFT OUTER JOIN
    dbo.PreviousProjectUpdates AS ppu ON p.ID = ppu.ProjectID AND Months.UpdatePeriod = ppu.NextMonth;
GO
/****** Object:  Table [dbo].[PartnerOrganisationUpdates]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartnerOrganisationUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Comment] [nvarchar](50) NULL,
	[RagOptionID] [int] NULL,
	[PartnerOrganisationID] [int] NULL,
	[UpdateDate] [datetime2](7) NULL,
	[OverallRagOptionID] [int] NULL,
	[FinanceRagOptionID] [int] NULL,
	[FinanceComment] [nvarchar](500) NULL,
	[PeopleRagOptionID] [int] NULL,
	[PeopleComment] [nvarchar](500) NULL,
	[MilestonesRagOptionID] [int] NULL,
	[MilestonesComment] [nvarchar](500) NULL,
	[KPIRagOptionID] [int] NULL,
	[KPIComment] [nvarchar](500) NULL,
	[ProgressUpdate] [nvarchar](1000) NULL,
	[FutureActions] [nvarchar](1000) NULL,
	[Escalations] [nvarchar](1000) NULL,
	[UpdateUserID] [int] NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
 CONSTRAINT [PK_PartnerOrganisationUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PreviousPartnerOrganisationUpdates]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PreviousPartnerOrganisationUpdates]
AS
	SELECT so.PartnerOrganisationID 
			, nextso.ReportMonth AS [NextMonth]
			, DeliveryConfidenceRAG.ReportName AS [PreviousDeliveryConfidenceRAG]
			, DeliveryConfidenceRAG.Score AS [PreviousDeliveryConfidenceRAGScore]
			, FinanceRAG.ReportName AS [PreviousFinanceRAG]
			, FinanceRAG.Score AS [PreviousFinanceRAGScore]
			, MilestonesRAG.ReportName AS [PreviousMilestonesRAG]
			, MilestonesRAG.Score AS [PreviousMilestonesRAGScore]
			, KeyPerformanceIndicatorsRAG.ReportName AS [PreviousKeyPerformanceIndicatorRAG]
			, KeyPerformanceIndicatorsRAG.Score AS [PreviousKeyPerformanceIndicatorScore] 
			, PeopleRAG.ReportName AS [PreviousPeopleRAG]
			, PeopleRAG.Score AS [PreviousPeopleRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.PartnerOrganisationUpdates AS pou ON so.ID = pou.SignOffID LEFT OUTER JOIN
		dbo.RagOptions AS DeliveryConfidenceRAG ON pou.OverallRagOptionID = DeliveryConfidenceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON pou.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON pou.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS KeyPerformanceIndicatorsRAG ON pou.KPIRagOptionID = KeyPerformanceIndicatorsRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON pou.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND so.PartnerOrganisationID = nextso.PartnerOrganisationID AND nextso.ReportMonth = 
			(SELECT MIN(ReportMonth)
			FROM SignOffs
			WHERE PartnerOrganisationID = so.PartnerOrganisationID AND ReportMonth > so.ReportMonth AND IsCurrent = 1)
	WHERE so.IsCurrent = 1;
GO
/****** Object:  View [dbo].[ProjectReportingChartDataPeople]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProjectReportingChartDataPeople]
AS
SELECT  dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Projects.ID AS [Project ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
		,'People' AS [Indicator]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,PeopleRAG.ReportName AS [Rating]
		,PeopleRAG.Score AS [Rating Score]
		,dbo.PreviousProjectUpdates.PreviousPeopleRAG AS [Previous Rating]
		,dbo.PreviousProjectUpdates.PreviousPeopleRAGScore AS [Previous Rating Score]
		,PeopleRAG.Score - dbo.PreviousProjectUpdates.PreviousPeopleRAGScore AS [RAG Change]
FROM    dbo.SignOffs INNER JOIN
            dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID INNER JOIN
            dbo.ProjectUpdates ON dbo.SignOffs.ID = dbo.ProjectUpdates.SignOffID LEFT OUTER JOIN
			dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
            dbo.RagOptions AS PeopleRAG ON dbo.ProjectUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
			dbo.PreviousProjectUpdates ON dbo.PreviousProjectUpdates.ProjectID = dbo.SignOffs.ProjectID AND dbo.PreviousProjectUpdates.NextMonth = dbo.SignOffs.ReportMonth
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  Table [dbo].[ReportingEntityUpdates]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportingEntityUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ReportingEntityID] [int] NOT NULL,
	[UpdateDate] [datetime2](7) NULL,
	[RagOptionID] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[CurrentPerformance] [decimal](18, 4) NULL,
	[ForecastDate] [datetime2](7) NULL,
	[ActualDate] [datetime2](7) NULL,
	[UpdateUserID] [int] NULL,
	[SignOffID] [int] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
 CONSTRAINT [PK_ReportingEntityUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [History].[ReportingEntityTypes]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[ReportingEntityTypes](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[CreatedDate] [datetime2](0) NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportTypeID] [int] NOT NULL,
	[InheritReportSchedule] [bit] NULL,
	[IsHeadlineSection] [bit] NULL,
	[UpdateHasRag] [bit] NULL,
	[UpdateRagIsRequired] [bit] NULL,
	[UpdateHasNarrative] [bit] NULL,
	[UpdateNarrativeIsRequired] [bit] NULL,
	[UpdateNarrativeMaxChars] [int] NULL,
	[UpdateHasDeliveryDates] [bit] NULL,
	[UpdateDeliveryDatesIsRequired] [bit] NULL,
	[HasUpperAndLowerTargets] [bit] NULL,
	[UpdateHasMeasurement] [bit] NULL,
	[UpdateMeasurementIsRequired] [bit] NULL,
	[CustomFields] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportingEntityTypes]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportingEntityTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[CreatedDate] [datetime2](0) NULL,
	[ModifiedByUserID] [int] NULL,
	[ReportTypeID] [int] NOT NULL,
	[InheritReportSchedule] [bit] NULL,
	[IsHeadlineSection] [bit] NULL,
	[UpdateHasRag] [bit] NULL,
	[UpdateRagIsRequired] [bit] NULL,
	[UpdateHasNarrative] [bit] NULL,
	[UpdateNarrativeIsRequired] [bit] NULL,
	[UpdateNarrativeMaxChars] [int] NULL,
	[UpdateHasDeliveryDates] [bit] NULL,
	[UpdateDeliveryDatesIsRequired] [bit] NULL,
	[HasUpperAndLowerTargets] [bit] NULL,
	[UpdateHasMeasurement] [bit] NULL,
	[UpdateMeasurementIsRequired] [bit] NULL,
	[CustomFields] [nvarchar](max) NULL,
 CONSTRAINT [PK_ReportingEntityTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[ReportingEntityTypes] )
)
GO
/****** Object:  View [drafts].[ReportingEntityUpdates]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[ReportingEntityUpdates]
AS
  SELECT
    g.Title AS [Group]
    , d.Title AS [Directorate]
    , p.Title AS [Project]
    , po.Title AS [Partner organisation]
    , ru.UpdatePeriod AS [Report period]
    , rt.Title AS [Reporting entity type]
    , r.ID AS [Reporting entity ID]
    , r.Title AS [Reporting entity]
    , ru.Comment AS [Progress update]
    , rag.ReportName AS [Current RAG]
    , rag.Score AS [Current RAG score]
    , ru.CurrentPerformance AS [Current performance]
    , CAST(ru.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast delivery date]
    , CAST(ru.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual delivery date]
    , LeadUser.Title AS [Lead]
    , UpdateAuthor.Title AS [Update author]
    , CAST(ru.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last edited date]
    , CASE ru.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Reporting entity closed]
    , es.Title AS [Status]
  FROM (SELECT MAX(ID) AS CurrentDraftID
      , ReportingEntityID
      , UpdatePeriod
    FROM [dbo].[ReportingEntityUpdates]
    GROUP BY ReportingEntityID, UpdatePeriod) AS currentDraft INNER JOIN
    dbo.ReportingEntityUpdates AS ru ON currentDraft.CurrentDraftID = ru.ID LEFT OUTER JOIN
    dbo.ReportingEntities AS r ON ru.ReportingEntityID = r.ID LEFT OUTER JOIN
    dbo.ReportingEntityTypes AS rt ON r.ReportingEntityTypeID = rt.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON r.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Projects AS p ON r.ProjectID = p.ID LEFT OUTER JOIN
    dbo.PartnerOrganisations AS po ON r.PartnerOrganisationID = po.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON r.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON ru.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions AS rag ON ru.RagOptionID = rag.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON r.EntityStatusID = es.ID;
GO
/****** Object:  Table [dbo].[RiskAppetites]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskAppetites](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
 CONSTRAINT [PK_RiskAppetities] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RiskRegisters]    Script Date: 08/11/2022 15:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskRegisters](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[RiskCodePrefix] [nvarchar](50) NULL,
 CONSTRAINT [PK_RiskRegisters] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RiskRiskTypes]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskRiskTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[RiskID] [int] NOT NULL,
	[RiskTypeID] [int] NOT NULL,
 CONSTRAINT [PK_RiskRiskTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [History].[Risks]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Risks](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[RiskCode] [nvarchar](50) NULL,
	[DirectorateID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[RiskOwnerUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[RiskRegisterID] [int] NULL,
	[RiskEventDescription] [nvarchar](750) NULL,
	[RiskCauseDescription] [nvarchar](750) NULL,
	[RiskImpactDescription] [nvarchar](750) NULL,
	[UnmitigatedRiskProbabilityID] [int] NULL,
	[UnmitigatedRiskImpactLevelID] [int] NULL,
	[TargetRiskProbabilityID] [int] NULL,
	[TargetRiskImpactLevelID] [int] NULL,
	[RiskAppetiteID] [int] NULL,
	[DepartmentalObjectiveID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[IsProjectRisk] [bit] NULL,
	[ProjectID] [int] NULL,
	[RiskProximity] [date] NULL,
	[RiskIsOngoing] [bit] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[LinkedRiskID] [int] NULL,
	[ReportApproverUserID] [int] NULL,
	[CreatedDate] [datetime2](0) NULL,
	[RiskRegisteredDate] [datetime2](0) NULL,
	[StaffNonStaffSpend] [nvarchar](50) NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[FundingClassification] [nvarchar](max) NULL,
	[EconomicRingfence] [nvarchar](max) NULL,
	[PolicyRingfence] [nvarchar](max) NULL,
	[UniformChartOfAccountsID] [nvarchar](max) NULL,
	[GroupID] [int] NULL,
	[OwnedByDgOffice] [bit] NULL,
	[OwnedByMultipleGroups] [bit] NULL,
	[Description] [nvarchar](500) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Risks]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Risks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[RiskCode] [nvarchar](50) NULL,
	[DirectorateID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[RiskOwnerUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[RiskRegisterID] [int] NULL,
	[RiskEventDescription] [nvarchar](750) NULL,
	[RiskCauseDescription] [nvarchar](750) NULL,
	[RiskImpactDescription] [nvarchar](750) NULL,
	[UnmitigatedRiskProbabilityID] [int] NULL,
	[UnmitigatedRiskImpactLevelID] [int] NULL,
	[TargetRiskProbabilityID] [int] NULL,
	[TargetRiskImpactLevelID] [int] NULL,
	[RiskAppetiteID] [int] NULL,
	[DepartmentalObjectiveID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[IsProjectRisk] [bit] NULL,
	[ProjectID] [int] NULL,
	[RiskProximity] [date] NULL,
	[RiskIsOngoing] [bit] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingStartMonth] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[LinkedRiskID] [int] NULL,
	[ReportApproverUserID] [int] NULL,
	[CreatedDate] [datetime2](0) NULL,
	[RiskRegisteredDate] [datetime2](0) NULL,
	[StaffNonStaffSpend] [nvarchar](50) NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[FundingClassification] [nvarchar](max) NULL,
	[EconomicRingfence] [nvarchar](max) NULL,
	[PolicyRingfence] [nvarchar](max) NULL,
	[UniformChartOfAccountsID] [nvarchar](max) NULL,
	[GroupID] [int] NULL,
	[OwnedByDgOffice] [bit] NULL,
	[OwnedByMultipleGroups] [bit] NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Risks] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Risks] )
)
GO
/****** Object:  Table [dbo].[DepartmentalObjectives]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentalObjectives](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
 CONSTRAINT [PK_DepartmentalObjectives] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [reports].[Risks]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[Risks]
AS
	WITH
		RiskTypesForRisk
		AS
		(
			SELECT r.ID AS RiskID, STRING_AGG(rt.Title, ',') AS RiskTypes
			FROM dbo.Risks r
				JOIN dbo.RiskRiskTypes rrt ON rrt.RiskID = r.ID
				JOIN dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID
			GROUP BY r.ID
		)
	SELECT r.ID AS [Risk ID]
	, r.Title AS [Risk Name]
	, r.RiskCode AS [Risk ID (user)]
	, riskTypes.RiskTypes AS [Risk Type]
	, g.Title AS [Group]
	, d.Title AS [Directorate]
	, es.Title AS [Status]
	, u.Title AS [Risk Owner]
	, rr.Title AS [Risk Register]
	, r.RiskEventDescription AS [Risk Description (event)]
	, r.RiskCauseDescription AS [Risk Description (cause)]
	, r.RiskImpactDescription AS [Risk Description (impact)]
	, urp.Title AS [Unmitigated Probability]
	, uril.Title AS [Unmitigated Impact]
	, OverallUrp.[RAGReportName] AS [Unmitigated RAG]
	, OverallUrp.RAGScore AS [Unmitigated RAG Score] 
	, trp.Title AS [Target Probability]
	, tril.Title AS [Target Impact]
	, OverallTrp.[RAGReportName] AS [Target RAG]
	, OverallTrp.RAGScore AS [Target RAG Score] 
	, ra.Title AS [Risk Appetite]
	, do.Title AS [Departmental Objective]
	, lr.Title AS [Linked Risk]
	, r.RiskProximity AS [Risk Proximity]
	FROM dbo.Risks AS r LEFT OUTER JOIN
		dbo.Directorates AS d ON r.DirectorateID = d.ID LEFT OUTER JOIN
		dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON r.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.Users AS u ON r.RiskOwnerUserID = u.ID LEFT OUTER JOIN
		dbo.RiskRegisters AS rr ON r.RiskRegisterID = rr.ID LEFT OUTER JOIN
		dbo.RiskProbabilities AS urp ON r.UnmitigatedRiskProbabilityID = urp.ID LEFT OUTER JOIN
		dbo.RiskImpactLevels AS uril ON r.UnmitigatedRiskImpactLevelID = uril.ID LEFT OUTER JOIN
		dbo.RiskProbabilities AS trp ON r.TargetRiskProbabilityID = trp.ID LEFT OUTER JOIN
		dbo.RiskImpactLevels AS tril ON r.TargetRiskImpactLevelID = tril.ID LEFT OUTER JOIN
		dbo.RiskAppetites AS ra ON r.RiskAppetiteID = ra.ID LEFT OUTER JOIN
		dbo.DepartmentalObjectives AS do ON r.DepartmentalObjectiveID = do.ID LEFT OUTER JOIN
		dbo.Risks AS lr ON r.LinkedRiskID = lr.ID LEFT OUTER JOIN
		dbo.RiskRiskTypes AS riskrt ON r.ID = riskrt.RiskID LEFT OUTER JOIN
		RiskTypesForRisk AS riskTypes ON r.ID = riskTypes.RiskID LEFT OUTER JOIN
		reports.RagFromRILandRP OverallTrp ON r.TargetRiskProbabilityID = OverallTrp.RPID and r.TargetRiskImpactLevelID = OverallTrp.RILID LEFT OUTER JOIN
		reports.RagFromRILandRP OverallUrp ON r.UnmitigatedRiskProbabilityID = OverallUrp.RPID and r.UnmitigatedRiskImpactLevelID = OverallUrp.RILID
	WHERE r.Discriminator = 'CorporateRisk'
GO
/****** Object:  Table [History].[RiskMitigationActions]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[RiskMitigationActions](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Description] [nvarchar](750) NULL,
	[RiskID] [int] NULL,
	[RiskMitigationActionCode] [int] NULL,
	[BaselineDate] [date] NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
	[OwnerUserID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ActionIsOngoing] [bit] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[OngoingActionReviewFrequency] [tinyint] NULL,
	[OngoingActionReviewDueDay] [tinyint] NULL,
	[OngoingActionReviewStartDate] [datetime2](0) NULL,
	[LeadUserID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RiskMitigationActions]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskMitigationActions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Description] [nvarchar](750) NULL,
	[RiskID] [int] NULL,
	[RiskMitigationActionCode] [int] NULL,
	[BaselineDate] [date] NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
	[OwnerUserID] [int] NULL,
	[EntityStatusID] [int] NULL,
	[EntityStatusDate] [datetime2](7) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[ActionIsOngoing] [bit] NULL,
	[ReportingFrequency] [tinyint] NULL,
	[ReportingDueDay] [tinyint] NULL,
	[ReportingStartDate] [datetime2](0) NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[OngoingActionReviewFrequency] [tinyint] NULL,
	[OngoingActionReviewDueDay] [tinyint] NULL,
	[OngoingActionReviewStartDate] [datetime2](0) NULL,
	[LeadUserID] [int] NULL,
 CONSTRAINT [PK_RiskMitigatingActions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[RiskMitigationActions] )
)
GO
/****** Object:  Table [dbo].[RiskMitigationActionUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskMitigationActionUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NULL,
	[RiskMitigationActionID] [int] NULL,
	[UpdateDate] [datetime2](7) NULL,
	[UpdateUserID] [int] NULL,
	[RagOptionID] [int] NULL,
	[Comment] [nvarchar](1000) NULL,
	[ForecastDate] [date] NULL,
	[ActualDate] [date] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
	[RiskUpdateID] [int] NULL,
	[SignOffID] [int] NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_RiskMitigationActionUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [drafts].[RiskMitigationActionUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[RiskMitigationActionUpdates]
AS
  WITH
    RiskTypesForRisk
    AS
    (
      SELECT r.ID AS RiskID, STRING_AGG(rt.Title, ',') AS RiskTypes
      FROM dbo.Risks r
        JOIN dbo.RiskRiskTypes rrt ON rrt.RiskID = r.ID
        JOIN dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID
      GROUP BY r.ID
    )
  SELECT gr.Title AS [Group]
	, dir.Title AS [Directorate] 
	, rmau.ID AS [Risk Mitigation Action Update ID]
	, r.ID AS [Risk ID]
	, rma.ID AS [Risk Mitigation Action ID]
	, r.Title AS [Risk Name]
	, riskTypes.RiskTypes AS [Risk Type]
	, rma.Title AS [Mitigation Action]
	, rma.Description AS [Description]
	, rma.BaselineDate AS [Baseline Date]
	, ISNULL(rma.ActualDate, rma.ForecastDate) AS [Delivery Date]
	, CASE
		WHEN rma.ActionIsOngoing = 'true' THEN 'Yes'
		ELSE 'No'
	 END AS [Is Ongoing]
	, rmao.Title AS [Action Owner]
	, rmau.UpdatePeriod AS [Report Month]
	, ro.ReportName AS [RAG Status]
	, ro.Score AS [RAG Score] 
	, RiskMitigationActionsLastMonth.[RAG Status] AS [Previous RAG Status]
	, RiskMitigationActionsLastMonth.[RAG Score] AS [Previous RAG Score]
	, ro.Score - RiskMitigationActionsLastMonth.[RAG Score] AS [RAG Change] 
	, rmau.Comment AS [Progress]
	, rmauu.Title AS [Last Updated by]
	, es.Title AS [Status]
	, CAST(rmau.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
  FROM dbo.RiskMitigationActionUpdates AS rmau LEFT OUTER JOIN
    (SELECT MAX(ID) AS CurrentDraftID
      , RiskMitigationActionID
      , UpdatePeriod
    FROM [dbo].[RiskMitigationActionUpdates]
    GROUP BY RiskMitigationActionID, UpdatePeriod) AS currentDraft ON rmau.ID = currentDraft.CurrentDraftID LEFT OUTER JOIN
    dbo.RiskMitigationActions AS rma ON rmau.RiskMitigationActionID = rma.ID LEFT OUTER JOIN
    dbo.Risks AS r ON r.ID = rma.RiskID LEFT OUTER JOIN
    dbo.Directorates AS dir ON r.DirectorateID = dir.ID LEFT OUTER JOIN
    dbo.Groups AS gr ON dir.GroupID = gr.ID LEFT OUTER JOIN
    dbo.Users AS rmao ON rmao.ID = rma.OwnerUserID LEFT OUTER JOIN
    dbo.Users AS rmauu ON rmauu.ID = rmau.UpdateUserID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON es.ID = rma.EntityStatusID LEFT OUTER JOIN
    dbo.RagOptions AS ro ON ro.ID = rmau.RagOptionID LEFT OUTER JOIN
    RiskTypesForRisk AS riskTypes ON r.ID = riskTypes.RiskID LEFT OUTER JOIN
    (SELECT rmau.RiskMitigationActionID AS [RiskMitigationActionID]
		, EOMONTH(DATEADD(MONTH, 1, rmau.UpdatePeriod)) AS [NextMonth]
		, ro.ReportName AS [RAG status]
		, ro.Score AS [RAG Score]
    FROM dbo.RiskMitigationActionUpdates AS rmau LEFT OUTER JOIN
      dbo.SignOffs AS so ON rmau.SignOffID = so.ID LEFT OUTER JOIN
      dbo.RiskMitigationActions AS rma ON rma.ID = rmau.RiskMitigationActionID LEFT OUTER JOIN
      dbo.RagOptions ro ON ro.ID = rmau.RagOptionID
    WHERE so.IsCurrent = 1) AS RiskMitigationActionsLastMonth ON rmau.RiskMitigationActionID = RiskMitigationActionsLastMonth.RiskMitigationActionID
      AND rmau.UpdatePeriod = RiskMitigationActionsLastMonth.NextMonth
  WHERE
  r.Discriminator = 'CorporateRisk'
GO
/****** Object:  Table [History].[Contributors]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[Contributors](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[ContributorUserID] [int] NULL,
	[BenefitID] [int] NULL,
	[CommitmentID] [int] NULL,
	[DependencyID] [int] NULL,
	[KeyWorkAreaID] [int] NULL,
	[MetricID] [int] NULL,
	[MilestoneID] [int] NULL,
	[WorkStreamID] [int] NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[RiskID] [int] NULL,
	[RiskMitigationActionID] [int] NULL,
	[PartnerOrganisationRiskID] [int] NULL,
	[PartnerOrganisationRiskMitigationActionID] [int] NULL,
	[PartnerOrganisationID] [int] NULL,
	[IsReadOnly] [bit] NULL,
	[ReportingEntityID] [int] NULL,
	[DirectorateID] [int] NULL,
	[ProjectID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contributors]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contributors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[ContributorUserID] [int] NULL,
	[BenefitID] [int] NULL,
	[CommitmentID] [int] NULL,
	[DependencyID] [int] NULL,
	[KeyWorkAreaID] [int] NULL,
	[MetricID] [int] NULL,
	[MilestoneID] [int] NULL,
	[WorkStreamID] [int] NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[RiskID] [int] NULL,
	[RiskMitigationActionID] [int] NULL,
	[PartnerOrganisationRiskID] [int] NULL,
	[PartnerOrganisationRiskMitigationActionID] [int] NULL,
	[PartnerOrganisationID] [int] NULL,
	[IsReadOnly] [bit] NULL,
	[ReportingEntityID] [int] NULL,
	[DirectorateID] [int] NULL,
	[ProjectID] [int] NULL,
 CONSTRAINT [PK_Contributors] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[Contributors] )
)
GO
/****** Object:  View [reports].[DependencyUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[DependencyUpdates]
AS
	SELECT dbo.DependencyUpdates.ID AS [Dependency Update ID]
		, dbo.SignOffs.ID AS [SignOff ID]
		, dbo.Groups.Title AS [Group]
		, dbo.Directorates.Title AS [Directorate]
		, dbo.Projects.Title AS [Project]
		, dbo.SignOffs.ReportMonth AS [Report Month]
		, dbo.Dependencies.ThirdParty AS [Name of third party]
		, dbo.Dependencies.ID AS [Dependency ID]
		, dbo.Dependencies.Title AS [Dependency]
		, dbo.DependencyUpdates.Comment AS [Progress Update]
		, CAST(dbo.Dependencies.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
		, CAST(dbo.DependencyUpdates.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
		, CAST(dbo.DependencyUpdates.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
		, dbo.PreviousDependencyUpdates.PreviousRAG AS [Previous RAG]
		, dbo.PreviousDependencyUpdates.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - dbo.PreviousDependencyUpdates.PreviousRAGScore AS [RAG Change]
		, dbo.Users.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(dbo.DependencyUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE dbo.DependencyUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Dependency Closed]
		, es.Title AS [Status]
	FROM dbo.SignOffs LEFT OUTER JOIN
		dbo.DependencyUpdates ON dbo.SignOffs.ID = dbo.DependencyUpdates.SignOffID INNER JOIN
		dbo.Dependencies ON dbo.DependencyUpdates.DependencyID = dbo.Dependencies.ID INNER JOIN
		dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID AND dbo.Dependencies.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
		dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
		dbo.Users ON dbo.Dependencies.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON dbo.DependencyUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.DependencyUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON dbo.Dependencies.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.PreviousDependencyUpdates ON dbo.Dependencies.ID = dbo.PreviousDependencyUpdates.DependencyID AND dbo.SignOffs.ReportMonth = dbo.PreviousDependencyUpdates.NextMonth
	WHERE		(dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  Table [dbo].[ThresholdAppetites]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThresholdAppetites](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ThresholdID] [int] NOT NULL,
	[RiskImpactLevelID] [int] NOT NULL,
	[RiskProbabilityID] [int] NOT NULL,
	[Acceptable] [bit] NOT NULL,
 CONSTRAINT [PK_ThresholdAppetites] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Thresholds]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thresholds](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Priority] [int] NOT NULL,
 CONSTRAINT [PK_Thresholds] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RiskUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskUpdates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Comment] [nvarchar](500) NULL,
	[RagOptionID] [int] NULL,
	[RiskID] [int] NULL,
	[UpdateUserID] [int] NULL,
	[UpdateDate] [datetime2](7) NULL,
	[RiskProbabilityID] [int] NULL,
	[RiskImpactLevelID] [int] NULL,
	[Escalate] [bit] NULL,
	[EscalateToRiskRegisterID] [int] NULL,
	[DeEscalate] [bit] NULL,
	[ToBeClosed] [bit] NULL,
	[UpdatePeriod] [date] NULL,
	[RiskMitigationActionUpdates] [nvarchar](max) NULL,
	[IsCurrent] [bit] NULL,
	[SendNotifications] [bit] NULL,
	[RiskRegisterID] [int] NULL,
	[RiskProximity] [date] NULL,
	[RiskCode] [nvarchar](50) NULL,
	[RiskIsOngoing] [bit] NULL,
	[SignOffID] [int] NULL,
	[RiskAppetiteBreachAuthorised] [bit] NULL,
	[Narrative] [nvarchar](1000) NULL,
	[ClosureReason] [nvarchar](50) NULL,
	[Attachments] [nvarchar](max) NULL,
	[Measurements] [nvarchar](max) NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[ToBeDiscussed] [bit] NULL,
	[DiscussionForum] [nvarchar](max) NULL,
 CONSTRAINT [PK_RiskUpdates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [drafts].[RiskUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[RiskUpdates]
AS
  WITH
    RiskTypesForRisk
    AS
    (
      SELECT r.ID AS RiskID, STRING_AGG(rt.Title, ',') AS RiskTypes
      FROM dbo.Risks r
        JOIN dbo.RiskRiskTypes rrt ON rrt.RiskID = r.ID
        JOIN dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID
      GROUP BY r.ID
    )
  SELECT gr.Title AS [Group]
	, dir.Title AS [Directorate] 
	, ru.ID AS [Risk Update ID]
	, r.ID AS [Risk ID]
	, r.RiskCode AS [Risk ID (user)]
	, r.Title AS [Risk Name]
	, riskTypes.RiskTypes AS [Risk Type]
	, ru.Narrative AS [Narrative]
	, Months.UpdatePeriod AS [Report Month]
	, u.Title AS [Author]
	, proj.Title AS [Project] 
	, CAST(ru.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
	, rr.Title AS [Risk Register]
	, rp.Title AS [Probability]
	, RisksLastMonth.Probability AS [Previous Probability]
	, trp.Title AS [Target Probability]
	, ril.Title AS [Impact Level]
	, RisksLastMonth.[Impact Level] AS [Previous Impact Level] 
	, tril.Title AS [Target Impact Level]
	, CASE WHEN EXISTS (SELECT 1
    FROM dbo.RiskRiskTypes rrt INNER JOIN
      dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID INNER JOIN
      dbo.ThresholdAppetites ta ON ta.ThresholdID = rt.ThresholdID
    WHERE rrt.RiskID = r.ID
      AND ta.RiskImpactLevelID  = ru.RiskImpactLevelID
      AND ta.RiskProbabilityID = ru.RiskProbabilityID
      AND ta.Acceptable = 'false') THEN 'No' ELSE 'Yes' END AS [Falls within departmental risk appetite]
	, (SELECT STRING_AGG(x.title, ', ')
    FROM (SELECT DISTINCT thr.Title
      FROM RiskRiskTypes rrt
        INNER JOIN dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID
        INNER JOIN dbo.Thresholds AS thr ON thr.ID = rt.ThresholdID
      WHERE rrt.RiskID = r.ID) x) AS [Threshold Title]
	, OverallRp.RAGReportName AS [RAG]
	, RisksLastMonth.RAG AS [Previous RAG]
	, OverallTrp.RAGReportName AS [Target RAG]
	, OverallRp.RAGScore AS [RAG Score] 
	, RisksLastMonth.[RAG Score] AS [Previous RAG Score]  
	, OverallTrp.RAGScore AS [Target RAG Score]
	, (OverallRp.RAGScore - RisksLastMonth.[RAG Score]) AS [RAG Change]
	, CASE ru.Escalate WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be escalated]
	, CASE ru.Escalate WHEN 1 THEN ru.Comment ELSE NULL END AS [Escalation comment]
	, CASE ru.DeEscalate WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be de-escalated]
	, CASE ru.DeEscalate WHEN 1 THEN ru.Comment ELSE NULL END AS [De-escalation comment]
	, CASE ru.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be closed]
	, CASE ru.ToBeClosed WHEN 1 THEN ru.Comment ELSE NULL END AS [Closure comment]
	, es.Title AS [Status]
	, ru.RiskProximity AS [Risk proximity]
  FROM dbo.Risks AS r CROSS JOIN
    (SELECT DISTINCT UpdatePeriod
    FROM dbo.RiskUpdates
    WHERE UpdatePeriod IS NOT NULL) AS Months LEFT OUTER JOIN
    dbo.RiskUpdates AS ru ON ru.RiskID = r.ID AND ru.UpdatePeriod = Months.UpdatePeriod INNER JOIN
    (SELECT MAX(ID) AS CurrentDraftID
      , RiskID
      , UpdatePeriod
    FROM [dbo].[RiskUpdates]
    GROUP BY RiskID, UpdatePeriod) AS currentDraft ON ru.ID = currentDraft.CurrentDraftID LEFT OUTER JOIN
    dbo.Users AS u ON ru.UpdateUserID = u.ID LEFT OUTER JOIN
    dbo.RiskRegisters AS rr ON r.RiskRegisterID = rr.ID LEFT OUTER JOIN
    dbo.RiskProbabilities AS rp ON ru.RiskProbabilityID = rp.ID LEFT OUTER JOIN
    dbo.RiskProbabilities AS trp ON r.TargetRiskProbabilityID = trp.ID LEFT OUTER JOIN
    dbo.RiskImpactLevels AS ril ON ru.RiskImpactLevelID = ril.ID LEFT OUTER JOIN
    dbo.RiskImpactLevels AS tril ON r.TargetRiskImpactLevelID = tril.ID LEFT OUTER JOIN
    dbo.Projects AS proj ON r.ProjectID = proj.ID LEFT OUTER JOIN
    dbo.Directorates AS dir ON r.DirectorateID = dir.ID LEFT OUTER JOIN
    dbo.Groups AS gr ON dir.GroupID = gr.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON r.EntityStatusID = es.ID LEFT OUTER JOIN
    reports.RagFromRILandRP AS OverallRp ON ru.RiskProbabilityID = OverallRp.RPID AND ru.RiskImpactLevelID = OverallRp.RILID LEFT OUTER JOIN
    reports.RagFromRILandRP AS OverallTrp ON r.TargetRiskProbabilityID = OverallTrp.RPID AND r.TargetRiskImpactLevelID = OverallTrp.RILID LEFT OUTER JOIN
    RiskTypesForRisk AS riskTypes ON r.ID = riskTypes.RiskID LEFT OUTER JOIN
    (SELECT ru.RiskID AS [RiskID]
			, EOMONTH(DATEADD(month, 1, ru.UpdatePeriod)) AS [NextMonth]
			, OverallRp.RAGReportName AS [RAG]
			, OverallRp.RAGScore AS [RAG Score] 
			, rp.Title AS [Probability]
			, ril.Title AS [Impact level]
    FROM dbo.RiskUpdates AS ru INNER JOIN
      dbo.SignOffs AS so ON ru.SignOffID = so.ID LEFT OUTER JOIN
      dbo.RiskProbabilities AS rp ON ru.RiskProbabilityID = rp.ID LEFT OUTER JOIN
      dbo.RiskImpactLevels AS ril ON ru.RiskImpactLevelID = ril.ID LEFT OUTER JOIN
      reports.RagFromRILandRP OverallRp ON OverallRp.RILID = ru.RiskImpactLevelID AND OverallRp.RPID = ru.RiskProbabilityID
    WHERE so.IsCurrent = 1) AS RisksLastMonth ON r.ID = RisksLastMonth.RiskID AND Months.UpdatePeriod = RisksLastMonth.NextMonth
GO
/****** Object:  View [reports].[CommitmentUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[CommitmentUpdates]
AS
SELECT       dbo.CommitmentUpdates.ID AS [Commitment Update ID]
			,dbo.SignOffs.ID AS [SignOff ID]
			,dbo.Groups.Title AS [Group]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.SignOffs.ReportMonth AS [Report Month]
			,dbo.Commitments.ID AS [Commitment ID]
			,dbo.Commitments.Title AS [Commitment]
			,dbo.CommitmentUpdates.Comment AS [Progress Update]
			,dbo.Commitments.BaselineDate AS [Baseline]
			,dbo.CommitmentUpdates.ForecastDate AS [Forecast]
			,dbo.CommitmentUpdates.ActualDate AS [Actual]
			,dbo.PreviousCommitmentUpdates.PreviousRAG AS [Previous RAG]
			,dbo.PreviousCommitmentUpdates.PreviousRAGScore AS [Previous RAG Score]
			,dbo.RagOptions.ReportName AS [Current RAG]
			,dbo.RagOptions.Score AS [Current RAG Score]
			,dbo.RagOptions.Score - dbo.PreviousCommitmentUpdates.PreviousRAGScore AS [RAG Change]
			,LeadUser.Title AS [Lead]
			,UpdateAuthor.Title AS [Author]
			,CAST(dbo.CommitmentUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			,CASE dbo.CommitmentUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Commitment Closed]
			,es.Title AS [Status] 
FROM     dbo.Commitments LEFT OUTER JOIN
            dbo.CommitmentUpdates ON dbo.CommitmentUpdates.SignOffID IS NOT NULL AND dbo.Commitments.ID = dbo.CommitmentUpdates.CommitmentID INNER JOIN
            dbo.SignOffs ON dbo.CommitmentUpdates.SignOffID = dbo.SignOffs.ID LEFT OUTER JOIN
            dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
            dbo.Users AS LeadUser ON dbo.Commitments.LeadUserID = LeadUser.ID LEFT OUTER JOIN
			dbo.Users AS UpdateAuthor ON dbo.CommitmentUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
            dbo.RagOptions ON dbo.CommitmentUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
			dbo.EntityStatuses AS es ON dbo.Commitments.EntityStatusID = es.ID LEFT OUTER JOIN
            dbo.PreviousCommitmentUpdates ON dbo.Commitments.ID = dbo.PreviousCommitmentUpdates.CommitmentID AND dbo.SignOffs.ReportMonth = dbo.PreviousCommitmentUpdates.NextMonth
WHERE (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [drafts].[WorkStreamMilestoneUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[WorkStreamMilestoneUpdates]
AS
  SELECT mu.ID AS [Milestone Update ID]
			, mu.UpdatePeriod AS [Report Month]
			, g.Title AS [Group]
			, d.Title AS [Directorate]
			, p.Title AS [Project]
			, m.WorkStreamID AS [Work Stream ID]
			, w.Title AS [Work Stream]
			, m.ID AS [Milestone ID]
			, m.MilestoneCode AS [Milestone ID (User)]
			, m.Title AS [Milestone]
			, mu.Comment AS [Progress Update]
			, m.Description AS [Milestone Description]
			, CAST(m.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
			, CAST(mu.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
			, CAST(mu.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
			, pmu.PreviousRAG AS [Previous RAG]
			, pmu.PreviousRAGScore AS [Previous RAG Score]
			, dbo.RagOptions.ReportName AS [Current RAG]
			, dbo.RagOptions.ID AS [Current RAG Score]
			, dbo.RagOptions.ID - pmu.PreviousRAGScore AS [RAG Change]
			, LeadUser.Title AS [Lead]
			, UpdateAuthor.Title AS [Author]
			, CAST(mu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			, CASE mu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Milestone Closed]
			, CASE WHEN SdpMilestones.ID IS NOT NULL THEN 'Yes' ELSE NULL END AS [SDP]
			, SdpMilestones.AttributeValue AS [SDP Value]
			, CAST(m.StartDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Start Date] 
			, es.Title AS [Status]
  FROM dbo.Milestones AS m LEFT OUTER JOIN
    dbo.WorkStreams AS w ON m.WorkStreamID = w.ID LEFT OUTER JOIN
    dbo.MilestoneUpdates AS mu ON m.ID = mu.MilestoneID INNER JOIN
    (SELECT MAX(mu.ID) AS CurrentDraftID
    FROM [dbo].[MilestoneUpdates] AS mu INNER JOIN [dbo].[Milestones] AS m ON mu.MilestoneID = m.ID
    WHERE m.WorkStreamID IS NOT NULL
    GROUP BY MilestoneID, UpdatePeriod) AS currentDraft ON currentDraft.CurrentDraftID = mu.ID LEFT OUTER JOIN
    dbo.Projects AS p ON w.ProjectID = p.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON p.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON m.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON mu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON mu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.PreviousMilestoneUpdates AS pmu ON m.ID = pmu.MilestoneID AND mu.UpdatePeriod = pmu.NextMonth LEFT OUTER JOIN
    dbo.Attributes AS SdpMilestones ON m.ID = SdpMilestones.MilestoneID AND SdpMilestones.AttributeTypeID = 2 LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON m.EntityStatusID = es.ID
GO
/****** Object:  View [reports].[RiskUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[RiskUpdates]
AS
	WITH
		RiskTypesForRisk
		AS
		(
			SELECT r.ID AS RiskID, STRING_AGG(rt.Title, ',') AS RiskTypes
			FROM dbo.Risks r
				JOIN dbo.RiskRiskTypes rrt ON rrt.RiskID = r.ID
				JOIN dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID
			GROUP BY r.ID
		)
	SELECT gr.Title AS [Group]
	, dir.Title AS [Directorate] 
	, ru.ID AS [Risk Update ID]
	, r.ID AS [Risk ID]
	, r.RiskCode AS [Risk ID (user)]
	, ru.SignOffID AS [SignOff ID] 
	, r.Title AS [Risk Name]
	, riskTypes.RiskTypes AS [Risk Type]
	, ru.Narrative AS [Narrative]
	, Months.ReportMonth AS [Report Month]
	, u.Title AS [Author]
	, proj.Title AS [Project] 
	, CAST(ru.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
	, rr.Title AS [Risk Register]
	, rp.Title AS [Probability]
	, RisksLastMonth.Probability AS [Previous Probability]
	, trp.Title AS [Target Probability]
	, ril.Title AS [Impact Level]
	, RisksLastMonth.[Impact Level] AS [Previous Impact Level] 
	, tril.Title AS [Target Impact Level]
	, CASE WHEN EXISTS (SELECT 1
		FROM dbo.RiskRiskTypes rrt INNER JOIN
			dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID INNER JOIN
			dbo.ThresholdAppetites ta ON ta.ThresholdID = rt.ThresholdID
		WHERE rrt.RiskID = r.ID
			AND ta.RiskImpactLevelID  = ru.RiskImpactLevelID
			AND ta.RiskProbabilityID = ru.RiskProbabilityID
			AND ta.Acceptable = 'false') THEN 'No' ELSE 'Yes' END AS [Falls within departmental risk appetite]
	, (SELECT STRING_AGG(x.title, ', ')
		FROM (SELECT DISTINCT thr.Title
			FROM RiskRiskTypes rrt
				INNER JOIN dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID
				INNER JOIN dbo.Thresholds AS thr ON thr.ID = rt.ThresholdID
			WHERE rrt.RiskID = r.ID) x) AS [Threshold Title]
	, OverallRp.RAGReportName AS [RAG]
	, RisksLastMonth.RAG AS [Previous RAG]
	, OverallTrp.RAGReportName AS [Target RAG]
	, OverallRp.RAGScore AS [RAG Score] 
	, RisksLastMonth.[RAG Score] AS [Previous RAG Score]  
	, OverallTrp.RAGScore AS [Target RAG Score]
	, (OverallRp.RAGScore - RisksLastMonth.[RAG Score]) AS [RAG Change]
	, CASE ru.Escalate WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be escalated]
	, CASE ru.Escalate WHEN 1 THEN ru.Comment ELSE NULL END AS [Escalation comment]
	, CASE ru.DeEscalate WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be de-escalated]
	, CASE ru.DeEscalate WHEN 1 THEN ru.Comment ELSE NULL END AS [De-escalation comment]
	, CASE ru.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be closed]
	, CASE ru.ToBeClosed WHEN 1 THEN ru.Comment ELSE NULL END AS [Closure comment]
	, es.Title AS [Status]
	, ru.RiskProximity AS [Risk proximity]
	FROM dbo.Risks r CROSS JOIN
    (SELECT DISTINCT dbo.SignOffs.ReportMonth
		FROM dbo.SignOffs
		WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months LEFT OUTER JOIN
		dbo.RiskUpdates AS ru ON ru.RiskID = r.ID AND ru.UpdatePeriod = Months.ReportMonth INNER JOIN
		dbo.SignOffs AS so ON ru.SignOffID = so.ID AND so.IsCurrent = 1 LEFT OUTER JOIN
		dbo.Users AS u ON ru.UpdateUserID = u.ID LEFT OUTER JOIN
		dbo.RiskRegisters AS rr ON r.RiskRegisterID = rr.ID LEFT OUTER JOIN
		dbo.RiskProbabilities AS rp ON ru.RiskProbabilityID = rp.ID LEFT OUTER JOIN
		dbo.RiskProbabilities AS trp ON r.TargetRiskProbabilityID = trp.ID LEFT OUTER JOIN
		dbo.RiskImpactLevels AS ril ON ru.RiskImpactLevelID = ril.ID LEFT OUTER JOIN
		dbo.RiskImpactLevels AS tril ON r.TargetRiskImpactLevelID = tril.ID LEFT OUTER JOIN
		dbo.Projects AS proj ON r.ProjectID = proj.ID LEFT OUTER JOIN
		dbo.Directorates AS dir ON r.DirectorateID = dir.ID LEFT OUTER JOIN
		dbo.Groups AS gr ON dir.GroupID = gr.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON r.EntityStatusID = es.ID LEFT OUTER JOIN
		reports.RagFromRILandRP OverallRp ON ru.RiskProbabilityID = OverallRp.RPID AND ru.RiskImpactLevelID = OverallRp.RILID LEFT OUTER JOIN
		reports.RagFromRILandRP OverallTrp ON r.TargetRiskProbabilityID = OverallTrp.RPID AND r.TargetRiskImpactLevelID = OverallTrp.RILID LEFT OUTER JOIN
		RiskTypesForRisk AS riskTypes ON r.ID = riskTypes.RiskID LEFT OUTER JOIN
		(SELECT ru.RiskID AS [RiskID]
			, EOMONTH(DATEADD(month, 1, ru.UpdatePeriod)) AS [NextMonth]
			, OverallRp.RAGReportName AS [RAG]
			, OverallRp.RAGScore AS [RAG Score] 
			, rp.Title AS [Probability]
			, ril.Title AS [Impact level]
		FROM dbo.RiskUpdates AS ru INNER JOIN
			dbo.SignOffs AS so ON ru.SignOffID = so.ID LEFT OUTER JOIN
			dbo.RiskProbabilities AS rp ON ru.RiskProbabilityID = rp.ID LEFT OUTER JOIN
			dbo.RiskImpactLevels AS ril ON ru.RiskImpactLevelID = ril.ID LEFT OUTER JOIN
			reports.RagFromRILandRP OverallRp ON OverallRp.RILID = ru.RiskImpactLevelID AND OverallRp.RPID = ru.RiskProbabilityID
		WHERE so.IsCurrent = 1) AS RisksLastMonth ON r.ID = RisksLastMonth.RiskID AND Months.ReportMonth = RisksLastMonth.NextMonth
GO
/****** Object:  View [drafts].[WorkStreamUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[WorkStreamUpdates]
AS
  SELECT wu.ID AS [Work Stream Update ID]
		, g.Title AS [Group]
		, d.Title AS [Directorate]
		, p.Title AS [Project]
		, wu.UpdatePeriod AS [Report Month]
		, w.ID AS [Work Stream ID]
		, w.Title AS [Work Stream]
		, wu.Comment AS [Progress Update]
		, pwu.PreviousRAG AS [Previous RAG]
		, pwu.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - pwu.PreviousRAGScore AS [RAG Change]
		, LeadUser.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(wu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE wu.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Work Stream Closed]
		, es.Title AS [Status]
  FROM (SELECT MAX(ID) AS CurrentDraftID
      , WorkStreamID
      , UpdatePeriod
    FROM [dbo].[WorkStreamUpdates]
    GROUP BY WorkStreamID, UpdatePeriod) AS currentDraft INNER JOIN
    dbo.WorkStreamUpdates AS wu ON currentDraft.CurrentDraftID = wu.ID INNER JOIN
    dbo.WorkStreams AS w ON wu.WorkStreamID = w.ID INNER JOIN
    dbo.Projects AS p ON w.ProjectID = p.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON p.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON w.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.Users AS LeadUser ON w.LeadUserID = LeadUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON wu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.RagOptions ON wu.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
    dbo.PreviousWorkStreamUpdates AS pwu ON w.ID = pwu.ID AND wu.UpdatePeriod = pwu.NextMonth;
GO
/****** Object:  View [reports].[MetricUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[MetricUpdates]
AS
    SELECT dbo.MetricUpdates.ID AS [Metric Update ID]
		, dbo.SignOffs.ID AS [SignOff ID]
		, dbo.Groups.Title AS [Group]
		, dbo.Directorates.Title AS [Directorate]
		, dbo.SignOffs.ReportMonth AS [Report Month]
		, dbo.Metrics.ID AS [Metric ID]
		, dbo.Metrics.MetricCode AS [Metric ID (User)]
		, dbo.Metrics.Title AS [Metric]
		, dbo.MetricUpdates.Comment AS [Progress Update]
		, CAST(dbo.PreviousMetricUpdates.PreviousPerformance AS float) AS [Previous Performance]
		, CAST(dbo.MetricUpdates.CurrentPerformance AS float) AS [Current Performance]
		, CAST(dbo.Metrics.TargetPerformanceLowerLimit AS float) AS [Target Performance Lower]
		, CAST(dbo.Metrics.TargetPerformanceUpperLimit AS float) AS [Target Performance Upper]
		, dbo.MeasurementUnits.Title AS [Performance Unit]
		, dbo.PreviousMetricUpdates.PreviousRAG AS [Previous RAG]
		, dbo.PreviousMetricUpdates.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - dbo.PreviousMetricUpdates.PreviousRAGScore AS [RAG Change]
		, dbo.Users.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(dbo.MetricUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE dbo.MetricUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Metric Closed]
		, es.Title AS [Status] 
		 , CASE dbo.Metrics.ReportingFrequency 
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
        , CASE dbo.Metrics.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(dbo.Metrics.ReportingStartDate)
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(dbo.Metrics.ReportingStartDate)
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(dbo.Metrics.ReportingStartDate)
                WHEN 1 THEN 'Jan' 
                WHEN 2 THEN 'Feb' 
                WHEN 3 THEN 'Mar' 
                WHEN 4 THEN 'Apr' 
                WHEN 5 THEN 'May' 
                WHEN 6 THEN 'Jun' 
                WHEN 7 THEN 'Jul' 
                WHEN 8 THEN 'Aug' 
                WHEN 9 THEN 'Sep' 
                WHEN 10 THEN 'Oct' 
                WHEN 11 THEN 'Nov' 
                WHEN 12 THEN 'Dec' 
                ELSE '' 
            END 
        END AS [Reporting Schedule]
    FROM dbo.SignOffs LEFT OUTER JOIN
        dbo.MetricUpdates ON dbo.SignOffs.ID = dbo.MetricUpdates.SignOffID INNER JOIN
        dbo.Metrics ON dbo.MetricUpdates.MetricID = dbo.Metrics.ID INNER JOIN
        dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID AND dbo.Metrics.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
        dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
        dbo.Users ON dbo.Metrics.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
        dbo.Users AS UpdateAuthor ON dbo.MetricUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
        dbo.RagOptions ON dbo.MetricUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
        dbo.PreviousMetricUpdates ON dbo.Metrics.ID = dbo.PreviousMetricUpdates.MetricID AND dbo.SignOffs.ReportMonth = dbo.PreviousMetricUpdates.NextMonth LEFT OUTER JOIN
        dbo.EntityStatuses As es ON dbo.Metrics.EntityStatusID = es.ID LEFT OUTER JOIN
        dbo.MeasurementUnits ON dbo.Metrics.MeasurementUnitID = dbo.MeasurementUnits.ID
    WHERE dbo.SignOffs.IsCurrent = 1;
GO
/****** Object:  View [reports].[KeyWorkAreaUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[KeyWorkAreaUpdates]
AS
SELECT       dbo.KeyWorkAreaUpdates.ID AS [Key Work Area Update ID]
			,dbo.KeyWorkAreaUpdates.SignOffID AS [SignOff ID]
			,dbo.Groups.Title AS [Group]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.SignOffs.ReportMonth AS [Report Month]
			,dbo.KeyWorkAreaUpdates.KeyWorkAreaID AS [Key Work Area ID]
			,dbo.KeyWorkAreas.Title AS [Key Work Area]
			,dbo.KeyWorkAreaUpdates.Comment AS [Progress Update]
			,dbo.PreviousKeyWorkAreaUpdates.PreviousRAG AS [Previous RAG]
			,dbo.PreviousKeyWorkAreaUpdates.PreviousRAGScore AS [Previous RAG Score]
			,dbo.RagOptions.ReportName AS [Current RAG]
			,dbo.RagOptions.Score AS [Current RAG Score]
			,dbo.RagOptions.Score - dbo.PreviousKeyWorkAreaUpdates.PreviousRAGScore AS [RAG Change]
			,LeadUser.Title AS [Lead]
			,UpdateAuthor.Title AS [Author]
			,CAST(dbo.KeyWorkAreaUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			,CASE dbo.KeyWorkAreaUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Key Work Area Closed]
			,es.Title AS [Status] 
FROM      dbo.SignOffs LEFT OUTER JOIN
            dbo.KeyWorkAreaUpdates ON dbo.SignOffs.ID = dbo.KeyWorkAreaUpdates.SignOffID INNER JOIN
            dbo.KeyWorkAreas ON dbo.KeyWorkAreaUpdates.KeyWorkAreaID = dbo.KeyWorkAreas.ID INNER JOIN
            dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID AND dbo.KeyWorkAreas.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
            dbo.Users AS LeadUser ON dbo.KeyWorkAreas.LeadUserID = LeadUser.ID LEFT OUTER JOIN
			dbo.Users AS UpdateAuthor ON dbo.KeyWorkAreaUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
            dbo.RagOptions ON dbo.KeyWorkAreaUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
			dbo.EntityStatuses AS es ON dbo.KeyWorkAreas.EntityStatusID = es.ID LEFT OUTER JOIN
            dbo.PreviousKeyWorkAreaUpdates ON dbo.KeyWorkAreas.ID = dbo.PreviousKeyWorkAreaUpdates.ID AND dbo.SignOffs.ReportMonth = dbo.PreviousKeyWorkAreaUpdates.NextMonth
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [reports].[BenefitUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[BenefitUpdates]
AS
    SELECT dbo.BenefitUpdates.ID AS [Benefit Update ID]
		, dbo.SignOffs.ID AS [SignOff ID]
		, dbo.Groups.Title AS [Group]
		, dbo.Directorates.Title AS [Directorate]
		, dbo.Projects.Title AS [Project]
		, dbo.SignOffs.ReportMonth AS [Report Month]
		, dbo.Benefits.ID AS [Benefit ID]
		, dbo.Benefits.Title AS [Benefit]
		, dbo.BenefitUpdates.Comment AS [Progress Update]
		, dbo.Benefits.Description AS [Benefit Description]
		, CAST(dbo.PreviousBenefitUpdates.PreviousPerformance AS float) AS [Previous Performance]
		, CAST(dbo.BenefitUpdates.CurrentPerformance AS float) AS [Current Performance]
		, CAST(dbo.Benefits.TargetPerformanceLowerLimit AS float) AS [Target Performance Lower]
		, CAST(dbo.Benefits.TargetPerformanceUpperLimit AS float) AS [Target Performance Upper]
		, dbo.MeasurementUnits.Title AS [Performance Unit]
		, dbo.PreviousBenefitUpdates.PreviousRAG AS [Previous RAG]
		, dbo.PreviousBenefitUpdates.PreviousRAGScore AS [Previous RAG Score]
		, dbo.RagOptions.ReportName AS [Current RAG]
		, dbo.RagOptions.Score AS [Current RAG Score]
		, dbo.RagOptions.Score - dbo.PreviousBenefitUpdates.PreviousRAGScore AS [RAG Change]
		, dbo.Users.Title AS [Lead]
		, UpdateAuthor.Title AS [Author]
		, CAST(dbo.BenefitUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, CASE dbo.BenefitUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Benefit Closed]
		, es.Title AS [Status] 
		, CASE dbo.Benefits.ReportingFrequency
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
        , CASE dbo.Benefits.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(dbo.Benefits.ReportingStartDate)  
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(dbo.Benefits.ReportingStartDate)  
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(dbo.Benefits.ReportingStartDate)  
                WHEN 1 THEN 'Jan' 
                WHEN 2 THEN 'Feb' 
                WHEN 3 THEN 'Mar' 
                WHEN 4 THEN 'Apr' 
                WHEN 5 THEN 'May' 
                WHEN 6 THEN 'Jun' 
                WHEN 7 THEN 'Jul' 
                WHEN 8 THEN 'Aug' 
                WHEN 9 THEN 'Sep' 
                WHEN 10 THEN 'Oct' 
                WHEN 11 THEN 'Nov' 
                WHEN 12 THEN 'Dec' 
                ELSE '' 
            END 
        END AS [Reporting Schedule]
    FROM dbo.SignOffs LEFT OUTER JOIN
        dbo.BenefitUpdates ON dbo.SignOffs.ID = dbo.BenefitUpdates.SignOffID INNER JOIN
        dbo.Benefits ON dbo.BenefitUpdates.BenefitID = dbo.Benefits.ID INNER JOIN
        dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID AND dbo.Benefits.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
        dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
        dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
        dbo.Users ON dbo.Benefits.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
        dbo.Users AS UpdateAuthor ON dbo.BenefitUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
        dbo.RagOptions ON dbo.BenefitUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
        dbo.PreviousBenefitUpdates ON dbo.Benefits.ID = dbo.PreviousBenefitUpdates.BenefitID AND dbo.SignOffs.ReportMonth = dbo.PreviousBenefitUpdates.NextMonth LEFT OUTER JOIN
        dbo.EntityStatuses AS es ON dbo.Benefits.EntityStatusID = es.ID LEFT OUTER JOIN
        dbo.MeasurementUnits ON dbo.Benefits.MeasurementUnitID = dbo.MeasurementUnits.ID
    WHERE dbo.SignOffs.IsCurrent = 1;
GO
/****** Object:  View [reports].[MilestoneUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[MilestoneUpdates]
AS
SELECT   dbo.MilestoneUpdates.ID AS [Milestone Update ID]
			,dbo.SignOffs.ID AS [Sign Off ID]
			,dbo.SignOffs.ReportMonth AS [Report Month]
			,ISNULL(dbo.Groups.Title, ProjectDirectorateGroups.Title) AS [Group]
			,ISNULL(dbo.Directorates.Title, ProjectDirectorates.Title) AS [Directorate]
			,dbo.Projects.Title AS [Project]
			,dbo.Milestones.KeyWorkAreaID AS [Key Work Area ID]
			,dbo.KeyWorkAreas.Title AS [Key Work Area]
			,dbo.Milestones.WorkStreamID AS [Work Stream ID]
			,dbo.WorkStreams.Title AS [Work Stream]
			,dbo.Milestones.ID AS [Milestone ID]
			,dbo.Milestones.MilestoneCode AS [Milestone ID (User)]
			,dbo.Milestones.Title AS [Milestone]
			,dbo.MilestoneUpdates.Comment AS [Progress Update]
			,dbo.Milestones.Description AS [Milestone Description]
			,CAST(dbo.Milestones.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
			,CAST(dbo.MilestoneUpdates.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
			,CAST(MilestoneUpdates.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
			,dbo.PreviousMilestoneUpdates.PreviousRAG AS [Previous RAG]
			,dbo.PreviousMilestoneUpdates.PreviousRAGScore AS [Previous RAG Score]
			,dbo.RagOptions.ReportName AS [Current RAG]
			,dbo.RagOptions.ID AS [Current RAG Score]
			,dbo.RagOptions.ID - dbo.PreviousMilestoneUpdates.PreviousRAGScore AS [RAG Change]
			,dbo.Users.Title AS [Lead]
			,UpdateAuthor.Title AS [Author]
			,CAST(dbo.MilestoneUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
			,CASE dbo.MilestoneUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Milestone Closed]
			,CASE WHEN SdpMilestones.ID IS NOT NULL THEN 'Yes' ELSE NULL END AS [SDP]
			,SdpMilestones.AttributeValue AS [SDP Value]
            ,dbo.PartnerOrganisations.Title AS [Partner Organisation]
			,CAST(dbo.Milestones.StartDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Start Date] 
			,dbo.EntityStatuses.Title AS [Status] 

FROM    dbo.Milestones LEFT OUTER JOIN
			dbo.KeyWorkAreas ON dbo.Milestones.KeyWorkAreaID = dbo.KeyWorkAreas.ID LEFT OUTER JOIN
			dbo.WorkStreams ON dbo.Milestones.WorkStreamID = dbo.WorkStreams.ID LEFT OUTER JOIN
            dbo.MilestoneUpdates ON dbo.MilestoneUpdates.SignOffID IS NOT NULL AND dbo.Milestones.ID = dbo.MilestoneUpdates.MilestoneID INNER JOIN
            dbo.SignOffs ON dbo.MilestoneUpdates.SignOffID = dbo.SignOffs.ID LEFT OUTER JOIN
            dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
            dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
            dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
            dbo.Directorates AS ProjectDirectorates ON dbo.Projects.DirectorateID = ProjectDirectorates.ID LEFT OUTER JOIN
            dbo.Groups AS ProjectDirectorateGroups ON ProjectDirectorates.GroupID = ProjectDirectorateGroups.ID LEFT OUTER JOIN
            dbo.Users ON dbo.Milestones.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
            dbo.Users AS UpdateAuthor ON dbo.MilestoneUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
            dbo.RagOptions ON dbo.MilestoneUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
            dbo.PreviousMilestoneUpdates ON dbo.Milestones.ID = dbo.PreviousMilestoneUpdates.MilestoneID AND dbo.SignOffs.ReportMonth = dbo.PreviousMilestoneUpdates.NextMonth LEFT OUTER JOIN
            dbo.Attributes AS SdpMilestones ON dbo.Milestones.ID = SdpMilestones.MilestoneID AND SdpMilestones.AttributeTypeID = 2 LEFT OUTER JOIN
            dbo.PartnerOrganisations ON dbo.Milestones.PartnerOrganisationID = dbo.PartnerOrganisations.ID LEFT OUTER JOIN 
			dbo.EntityStatuses ON dbo.Milestones.EntityStatusID = dbo.EntityStatuses.ID 
WHERE       (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [reports].[DirectorateUpdates]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[DirectorateUpdates]
AS
	SELECT dbo.Groups.Title AS [Group]
		, dbo.Directorates.Title AS [Directorate]
		, dbo.Directorates.ID AS [ID]
		, Months.ReportMonth AS [Report Month]
		, DirectorUser.Title AS [Director]
		, UpdateAuthor.Title AS [Author]
		, SignOffUser.Title AS [Signed-off by]
		, dbo.SignOffs.ID AS [SignOff ID]
		, es.Title AS [Status] 
		, CAST(dbo.SignOffs.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Date Signed-off]
		, CAST(dbo.DirectorateUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, dbo.Directorates.Objectives AS [Objectives]
		, dbo.DirectorateUpdates.ProgressUpdate AS [Delivery Confidence Update]
		, dbo.DirectorateUpdates.FutureActions AS [Future Actions Update]
		, dbo.DirectorateUpdates.Escalations AS [Escalations Update]

		, dbo.PreviousDirectorateUpdates.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, dbo.PreviousDirectorateUpdates.PreviousFinanceRAG AS [Previous Finance RAG]
		, dbo.PreviousDirectorateUpdates.PreviousMilestonesRAG AS [Previous Milestones RAG]
		, dbo.PreviousDirectorateUpdates.PreviousMetricsRAG AS [Previous Metrics RAG]
		, dbo.PreviousDirectorateUpdates.PreviousPeopleRAG AS [Previous People RAG]

		, dbo.PreviousDirectorateUpdates.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score]
		, dbo.PreviousDirectorateUpdates.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, dbo.PreviousDirectorateUpdates.PreviousMilestonesRAGScore AS [Previous Milestones RAG Score]
		, dbo.PreviousDirectorateUpdates.PreviousMetricsRAGScore AS [Previous Metrics RAG Score]
		, dbo.PreviousDirectorateUpdates.PreviousPeopleRAGScore AS [Previous People RAG Score]

		, OverallRAG.ReportName AS [Delivery Confidence RAG]
		, FinanceRAG.ReportName AS [Finance RAG]
		, MilestonesRAG.ReportName AS [Milestones RAG]
		, MetricsRAG.ReportName AS [Metrics RAG]
		, PeopleRAG.ReportName AS [People RAG]

		, OverallRAG.Score AS [Delivery Confidence RAG Score]
		, FinanceRAG.Score AS [Finance RAG Score]
		, MilestonesRAG.Score AS [Milestones RAG Score]
		, MetricsRAG.Score AS [Metrics RAG Score]
		, PeopleRAG.Score AS [People RAG Score]

		, dbo.DirectorateUpdates.FinanceComment AS [Finance Update]
		, dbo.DirectorateUpdates.MilestonesComment AS [Milestones Update]
		, dbo.DirectorateUpdates.MetricsComment AS [Metrics Update]
		, dbo.DirectorateUpdates.PeopleComment AS [People Update]

		, (OverallRAG.Score - dbo.PreviousDirectorateUpdates.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (FinanceRAG.Score - dbo.PreviousDirectorateUpdates.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (MilestonesRAG.Score - dbo.PreviousDirectorateUpdates.PreviousMilestonesRAGScore) AS [Milestones RAG Change]
		, (MetricsRAG.Score - dbo.PreviousDirectorateUpdates.PreviousMetricsRAGScore) AS [Metrics RAG Change]
		, (PeopleRAG.Score - dbo.PreviousDirectorateUpdates.PreviousPeopleRAGScore) AS [People RAG Change]

	FROM dbo.Directorates CROSS JOIN
           (SELECT DISTINCT dbo.SignOffs.ReportMonth
		FROM dbo.SignOffs
		WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months LEFT OUTER JOIN
		dbo.SignOffs ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID AND dbo.SignOffs.ReportMonth = Months.ReportMonth AND dbo.SignOffs.IsCurrent = 1 LEFT OUTER JOIN
		dbo.DirectorateUpdates ON dbo.DirectorateUpdates.DirectorateID = dbo.SignOffs.DirectorateID AND dbo.DirectorateUpdates.SignOffID = dbo.SignOffs.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON dbo.Directorates.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.RagOptions AS OverallRAG ON dbo.DirectorateUpdates.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON dbo.DirectorateUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON dbo.DirectorateUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON dbo.DirectorateUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MetricsRAG ON dbo.DirectorateUpdates.MetricsRagOptionID = MetricsRAG.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON dbo.DirectorateUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.Users AS DirectorUser ON dbo.Directorates.DirectorUserID = DirectorUser.ID LEFT OUTER JOIN
		dbo.Users AS SignOffUser ON dbo.SignOffs.SignOffUserID = SignOffUser.ID LEFT OUTER JOIN
		dbo.PreviousDirectorateUpdates ON dbo.Directorates.ID = dbo.PreviousDirectorateUpdates.DirectorateID AND Months.ReportMonth = dbo.PreviousDirectorateUpdates.NextMonth
GO
/****** Object:  Table [dbo].[AttributeTypes]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[Display] [bit] NULL,
 CONSTRAINT [PK_AttributeTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [reports].[Attributes]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[Attributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.BenefitID AS [Benefit ID]
		, dbo.Attributes.CommitmentID AS [Commitment ID]
		, dbo.Attributes.KeyWorkAreaID AS [Key Work Area ID]
		, dbo.Attributes.MetricID AS [Metric ID]
		, dbo.Attributes.MilestoneID AS [Milestone ID]
		, dbo.Attributes.WorkStreamID AS [Work Stream ID]
		, dbo.Attributes.RiskID AS [Risk ID]
		, dbo.Attributes.PartnerOrganisationRiskID AS [Partner Organisation Risk ID]
		, dbo.Attributes.DirectorateID AS [Directorate ID]
		, dbo.Attributes.ProjectID AS [Project ID]
		, dbo.Attributes.ReportingEntityID AS [Reporting Entity ID]
		, dbo.Attributes.DependencyID AS [Dependency ID]
		, dbo.Attributes.PartnerOrganisationID AS [Partner Organisation ID]
		, dbo.Attributes.PartnerOrganisationRiskMitigationActionID AS [Partner Organisation Risk Mitigating Action ID]
		, dbo.Attributes.RiskMitigationActionID AS [Risk Mitigating Action ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
GO
/****** Object:  View [reports].[Metrics]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[Metrics]
AS
SELECT    dbo.Metrics.ID AS [Metric ID]
			,dbo.Metrics.MetricCode AS [Metric ID (User)]
			,dbo.Metrics.Title AS [Metric]
			,dbo.Metrics.Description AS [Metric Description]
			,dbo.Groups.Title AS [Group]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.MeasurementUnits.Title AS [Performance Unit]
			,dbo.Metrics.TargetPerformanceLowerLimit AS [Target Performance Lower Limit]
			,dbo.Metrics.TargetPerformanceUpperLimit AS [Target Performance Upper Limit]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.Metrics.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
FROM     dbo.Metrics LEFT OUTER JOIN
			dbo.Directorates ON dbo.Metrics.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
			dbo.MeasurementUnits ON dbo.Metrics.MeasurementUnitID = dbo.MeasurementUnits.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Metrics.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Metrics.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[KeyWorkAreas]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[KeyWorkAreas]
AS
SELECT    dbo.KeyWorkAreas.ID AS [Key Work Area ID]
			,dbo.KeyWorkAreas.Title AS [Key Work Area]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.KeyWorkAreas.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
FROM     dbo.KeyWorkAreas LEFT OUTER JOIN
			dbo.Directorates ON dbo.KeyWorkAreas.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Users ON dbo.KeyWorkAreas.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.KeyWorkAreas.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  Table [dbo].[MilestoneTypes]    Script Date: 08/11/2022 15:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MilestoneTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_MilestoneTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [reports].[Milestones]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[Milestones]
AS
SELECT    dbo.Milestones.ID AS [Milestone ID]
			,dbo.Milestones.MilestoneCode AS [Milestone ID (User)]
			,dbo.Milestones.Title AS [Milestone]
			,dbo.Milestones.Description AS [Milestone Description]
			,CAST(dbo.Milestones.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
			,CAST(dbo.Milestones.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
			,CAST(dbo.Milestones.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
			,dbo.MilestoneTypes.Title AS [Milestone Type]
			,dbo.Directorates.Title AS [Directorate]
			,gr.Title AS [Group]
			,dbo.KeyWorkAreas.Title AS [Key Work Area]
			,dbo.Projects.Title AS [Project]
			,dbo.WorkStreams.Title AS [Work Stream]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.Milestones.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
            ,dbo.PartnerOrganisations.Title AS [Partner Organisation]
FROM     dbo.Milestones LEFT OUTER JOIN
			dbo.MilestoneTypes ON dbo.Milestones.MilestoneTypeID = dbo.MilestoneTypes.ID LEFT OUTER JOIN
			dbo.KeyWorkAreas ON dbo.Milestones.KeyWorkAreaID = dbo.KeyWorkAreas.ID LEFT OUTER JOIN
			dbo.Directorates ON dbo.KeyWorkAreas.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.WorkStreams ON dbo.Milestones.WorkStreamID = dbo.WorkStreams.ID LEFT OUTER JOIN
			dbo.Projects ON dbo.WorkStreams.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Milestones.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Milestones.EntityStatusID = dbo.EntityStatuses.ID LEFT OUTER JOIN
			dbo.Groups AS gr ON dbo.Directorates.GroupID = gr.ID LEFT OUTER JOIN
            dbo.PartnerOrganisations On dbo.Milestones.PartnerOrganisationID = dbo.PartnerOrganisations.ID
GO
/****** Object:  View [reports].[CSScorecardActivityProgress]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[CSScorecardActivityProgress]
AS

SELECT  'Key Work Area' AS [Report Element Type]
		,ku.[Key Work Area] AS [Report Element Name]
		,ku.[Group]
		,ku.[Directorate]
		,NULL AS [Project]
		,ku.[Progress Update]
		,ku.[Lead]
		,ku.[Author]
		,ku.[Report Month]
		,k.[Status]
		,ku.[Current RAG] AS [RAG]
		,NULL AS [Baseline Date]
		,NULL AS [Forecast Date]
		,NULL AS [Actual Date]
		,CASE Attr.[Attribute] WHEN 'CS Scorecard' THEN 'Yes' ELSE 'No' END AS [CS Scorecard]
		,Attr.[Attribute Value] AS [CS Scorecard Value]
FROM [reports].[KeyWorkAreaUpdates] AS ku INNER JOIN
		[reports].[KeyWorkAreas] AS k ON ku.[Key Work Area ID] = k.[Key Work Area ID] INNER JOIN
		[reports].[Attributes] AS Attr ON ku.[Key Work Area ID] = Attr.[Key Work Area ID] AND Attr.Attribute = 'CS Scorecard' INNER JOIN
		(SELECT [Key Work Area ID], MAX([Report Month]) AS LatestUpdateMonth
		  FROM [reports].[KeyWorkAreaUpdates]
		  GROUP BY [Key Work Area ID]) AS LatestKeyWorkAreaUpdateMonth ON ku.[Key Work Area ID] = LatestKeyWorkAreaUpdateMonth.[Key Work Area ID] AND ku.[Report Month] = LatestKeyWorkAreaUpdateMonth.LatestUpdateMonth

UNION

SELECT  'Metric' AS [Report Element Type]
		,mu.Metric AS [Report Element Name]
		,mu.[Group]
		,mu.[Directorate]
		,NULL AS [Project]
		,mu.[Progress Update]
		,mu.[Lead]
		,mu.[Author]
		,mu.[Report Month]
		,m.[Status]
		,mu.[Current RAG] AS [RAG]
		,NULL AS [Baseline Date]
		,NULL AS [Forecast Date]
		,NULL AS [Actual Date]
		,CASE Attr.[Attribute] WHEN 'CS Scorecard' THEN 'Yes' ELSE 'No' END AS [CS Scorecard]
		,Attr.[Attribute Value] AS [CS Scorecard Value]
FROM [reports].[MetricUpdates] AS mu INNER JOIN
		[reports].[Metrics] AS m ON mu.[Metric ID] = m.[Metric ID] INNER JOIN
		[reports].[Attributes] AS Attr ON mu.[Metric ID] = Attr.[Metric ID] AND Attr.Attribute = 'CS Scorecard' INNER JOIN
		(SELECT [Metric ID], MAX([Report Month]) AS LatestUpdateMonth
		  FROM [reports].[MetricUpdates]
		  GROUP BY [Metric ID]) AS LatestMetricUpdateMonth ON mu.[Metric ID] = LatestMetricUpdateMonth.[Metric ID] AND mu.[Report Month] = LatestMetricUpdateMonth.LatestUpdateMonth


UNION

SELECT  'Milestone' AS [Report Element Type]
		,mu.Milestone AS [Report Element Name]
		,mu.[Group]
		,mu.[Directorate]
		,mu.[Project]
		,mu.[Progress Update]
		,mu.[Lead]
		,mu.[Author]
		,mu.[Report Month]
		,m.[Status]
		,mu.[Current RAG] AS [RAG]
		,m.Baseline AS [Baseline Date]
		,m.Forecast AS [Forecast Date]
		,m.Actual AS [Actual Date]
		,CASE Attr.[Attribute] WHEN 'CS Scorecard' THEN 'Yes' ELSE 'No' END AS [CS Scorecard]
		,Attr.[Attribute Value] AS [CS Scorecard Value]
FROM [reports].[MilestoneUpdates] AS mu INNER JOIN
		[reports].[Milestones] AS m ON mu.[Milestone ID]=m.[Milestone ID] INNER JOIN
		[reports].[Attributes] AS Attr ON mu.[Milestone ID] = Attr.[Milestone ID] AND Attr.Attribute = 'CS Scorecard' INNER JOIN
		(SELECT [Milestone ID], MAX([Report Month]) AS LatestUpdateMonth
		  FROM [reports].[MilestoneUpdates]
		  GROUP BY [Milestone ID]) AS LatestMilestoneUpdateMonth ON mu.[Milestone ID] = LatestMilestoneUpdateMonth.[Milestone ID] AND mu.[Report Month] = LatestMilestoneUpdateMonth.LatestUpdateMonth
GO
/****** Object:  View [reports].[ProjectReportingChartData]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [reports].[ProjectReportingChartData]
AS
SELECT        *
FROM            dbo.ProjectReportingChartDataBenefits
UNION
SELECT        *
FROM            dbo.ProjectReportingChartDataDeliveryConfidence
UNION
SELECT        *
FROM            dbo.ProjectReportingChartDataFinance
UNION
SELECT        *
FROM            dbo.ProjectReportingChartDataMilestones
UNION
SELECT        *
FROM            dbo.ProjectReportingChartDataPeople
GO
/****** Object:  View [reports].[WorkStreamUpdates]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[WorkStreamUpdates]
AS
SELECT   dbo.WorkStreamUpdates.ID AS [Work Stream Update ID]
		,dbo.WorkStreamUpdates.SignOffID AS [SignOff ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,dbo.WorkStreams.ID AS [Work Stream ID]
		,dbo.WorkStreams.Title AS [Work Stream]
		,dbo.WorkStreamUpdates.Comment AS [Progress Update]
		,dbo.PreviousWorkStreamUpdates.PreviousRAG AS [Previous RAG]
		,dbo.PreviousWorkStreamUpdates.PreviousRAGScore AS [Previous RAG Score]
		,dbo.RagOptions.ReportName AS [Current RAG]
		,dbo.RagOptions.Score AS [Current RAG Score]
		,dbo.RagOptions.Score - dbo.PreviousWorkStreamUpdates.PreviousRAGScore AS [RAG Change]
		,LeadUser.Title AS [Lead]
		,UpdateAuthor.Title AS [Author]
		,CAST(dbo.WorkStreamUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		,CASE dbo.WorkStreamUpdates.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Work Stream Closed]
		,es.Title AS [Status] 
FROM  dbo.SignOffs LEFT OUTER JOIN
        dbo.WorkStreamUpdates ON dbo.SignOffs.ID = dbo.WorkStreamUpdates.SignOffID INNER JOIN
        dbo.WorkStreams ON dbo.WorkStreamUpdates.WorkStreamID = dbo.WorkStreams.ID INNER JOIN
        dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID AND dbo.WorkStreams.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
		dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON dbo.WorkStreams.EntityStatusID = es.ID LEFT OUTER JOIN
        dbo.Users AS LeadUser ON dbo.WorkStreams.LeadUserID = LeadUser.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON dbo.WorkStreamUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
        dbo.RagOptions ON dbo.WorkStreamUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
        dbo.PreviousWorkStreamUpdates ON dbo.WorkStreams.ID = dbo.PreviousWorkStreamUpdates.ID AND dbo.SignOffs.ReportMonth = dbo.PreviousWorkStreamUpdates.NextMonth
WHERE   (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[DirectorateReportingChartDataDeliveryConfidence]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DirectorateReportingChartDataDeliveryConfidence]
AS
SELECT  dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,'Delivery Confidence' AS [Indicator]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,dbo.RagOptions.ReportName AS [Rating]
		,dbo.RagOptions.Score AS [Rating Score]
		,dbo.PreviousDirectorateUpdates.PreviousDeliveryConfidenceRAG AS [Previous Rating]
		,dbo.PreviousDirectorateUpdates.PreviousDeliveryConfidenceRAGScore AS [Previous Rating Score]
		,dbo.RagOptions.Score - dbo.PreviousDirectorateUpdates.PreviousDeliveryConfidenceRAGScore AS [RAG Change]
FROM  dbo.SignOffs INNER JOIN
        dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID INNER JOIN
                dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID INNER JOIN
                dbo.DirectorateUpdates ON dbo.SignOffs.ID = dbo.DirectorateUpdates.SignOffID LEFT OUTER JOIN
                dbo.RagOptions ON dbo.DirectorateUpdates.OverallRagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
				dbo.PreviousDirectorateUpdates ON dbo.PreviousDirectorateUpdates.DirectorateID = dbo.SignOffs.DirectorateID AND dbo.PreviousDirectorateUpdates.NextMonth = dbo.SignOffs.ReportMonth
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[DirectorateReportingChartDataFinance]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DirectorateReportingChartDataFinance]
AS
SELECT   dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,'Finance' AS [Indicator]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,FinanceRAG.ReportName AS [Rating]
		,FinanceRAG.Score AS [Rating Score]
		,dbo.PreviousDirectorateUpdates.PreviousFinanceRAG AS [Previous Rating]
		,dbo.PreviousDirectorateUpdates.PreviousFinanceRAGScore AS [Previous Rating Score]
		,FinanceRAG.Score - dbo.PreviousDirectorateUpdates.PreviousFinanceRAGScore AS [RAG Change]
FROM     dbo.SignOffs INNER JOIN
            dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID INNER JOIN
            dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID INNER JOIN
            dbo.DirectorateUpdates ON dbo.SignOffs.ID = dbo.DirectorateUpdates.SignOffID LEFT OUTER JOIN
            dbo.RagOptions AS FinanceRAG ON dbo.DirectorateUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
			dbo.PreviousDirectorateUpdates ON dbo.PreviousDirectorateUpdates.DirectorateID = dbo.SignOffs.DirectorateID AND dbo.PreviousDirectorateUpdates.NextMonth = dbo.SignOffs.ReportMonth
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[DirectorateReportingChartDataMetrics]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DirectorateReportingChartDataMetrics]
AS
SELECT  dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,'Benefits/Metrics' AS [Indicator]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,dbo.RagOptions.ReportName AS [Rating]
		,dbo.RagOptions.Score AS [Rating Score]
		,dbo.PreviousDirectorateUpdates.PreviousMetricsRAG AS [Previous Rating]
		,dbo.PreviousDirectorateUpdates.PreviousMetricsRAGScore AS [Previous Rating Score]
		,dbo.RagOptions.Score - dbo.PreviousDirectorateUpdates.PreviousMetricsRAGScore AS [RAG Change]
FROM  dbo.SignOffs INNER JOIN
        dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID INNER JOIN
        dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID INNER JOIN
        dbo.DirectorateUpdates ON dbo.SignOffs.ID = dbo.DirectorateUpdates.SignOffID LEFT OUTER JOIN
        dbo.RagOptions ON dbo.DirectorateUpdates.MetricsRagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.PreviousDirectorateUpdates ON dbo.PreviousDirectorateUpdates.DirectorateID = dbo.SignOffs.DirectorateID AND dbo.PreviousDirectorateUpdates.NextMonth = dbo.SignOffs.ReportMonth
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[DirectorateReportingChartDataMilestones]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DirectorateReportingChartDataMilestones]
AS
SELECT   dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,'Milestones' AS [Indicator]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,dbo.RagOptions.ReportName AS [Rating]
		,dbo.RagOptions.Score AS [Rating Score]
		,dbo.PreviousDirectorateUpdates.PreviousMilestonesRAG AS [Previous Rating]
		,dbo.PreviousDirectorateUpdates.PreviousMilestonesRAGScore AS [Previous Rating Score]
		,dbo.RagOptions.Score - dbo.PreviousDirectorateUpdates.PreviousMilestonesRAGScore AS [RAG Change]
FROM   dbo.SignOffs INNER JOIN
            dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID INNER JOIN
            dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID INNER JOIN
            dbo.DirectorateUpdates ON dbo.SignOffs.ID = dbo.DirectorateUpdates.SignOffID LEFT OUTER JOIN
            dbo.RagOptions ON dbo.DirectorateUpdates.MilestonesRagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
			dbo.PreviousDirectorateUpdates ON dbo.PreviousDirectorateUpdates.DirectorateID = dbo.SignOffs.DirectorateID AND dbo.PreviousDirectorateUpdates.NextMonth = dbo.SignOffs.ReportMonth
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[DirectorateReportingChartDataPeople]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DirectorateReportingChartDataPeople]
AS
SELECT   dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,'People' AS [Indicator]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,dbo.RagOptions.ReportName AS [Rating]
		,dbo.RagOptions.Score AS [Rating Score]
		,dbo.PreviousDirectorateUpdates.PreviousPeopleRAG AS [Previous Rating]
		,dbo.PreviousDirectorateUpdates.PreviousPeopleRAGScore AS [Previous Rating Score]
		,dbo.RagOptions.Score - dbo.PreviousDirectorateUpdates.PreviousPeopleRAGScore AS [RAG Change]
FROM   dbo.SignOffs INNER JOIN
            dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID INNER JOIN
            dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID INNER JOIN
            dbo.DirectorateUpdates ON dbo.SignOffs.ID = dbo.DirectorateUpdates.SignOffID LEFT OUTER JOIN
            dbo.RagOptions ON dbo.DirectorateUpdates.PeopleRagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
			dbo.PreviousDirectorateUpdates ON dbo.PreviousDirectorateUpdates.DirectorateID = dbo.SignOffs.DirectorateID AND dbo.PreviousDirectorateUpdates.NextMonth = dbo.SignOffs.ReportMonth
WHERE    (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  Table [History].[ProjectAttributes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[ProjectAttributes](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ProjectAttributeTypeID] [int] NOT NULL,
	[ProjectID] [int] NOT NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectAttributes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectAttributes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ProjectAttributeTypeID] [int] NOT NULL,
	[ProjectID] [int] NOT NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
 CONSTRAINT [PK_ProjectAttributes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[ProjectAttributes] )
)
GO
/****** Object:  View [reports].[DirectorateReportingChartData]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [reports].[DirectorateReportingChartData]
AS
SELECT        *
FROM            dbo.DirectorateReportingChartDataMetrics
UNION
SELECT        *
FROM            dbo.DirectorateReportingChartDataDeliveryConfidence
UNION
SELECT        *
FROM            dbo.DirectorateReportingChartDataFinance
UNION
SELECT        *
FROM            dbo.DirectorateReportingChartDataMilestones
UNION
SELECT        *
FROM            dbo.DirectorateReportingChartDataPeople
GO
/****** Object:  View [reports].[WorkStreams]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[WorkStreams]
AS
SELECT    dbo.WorkStreams.ID AS [Work Stream ID]
			,dbo.WorkStreams.WorkStreamCode AS [Work Stream ID (User)]
			,dbo.WorkStreams.Title AS [Work Stream]
			,dbo.Projects.Title AS [Project]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.WorkStreams.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
FROM     dbo.WorkStreams LEFT OUTER JOIN
			dbo.Projects ON dbo.WorkStreams.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
			dbo.Users ON dbo.WorkStreams.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.WorkStreams.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  Table [dbo].[BenefitTypes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BenefitTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_BenefitTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [reports].[Benefits]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[Benefits]
AS
SELECT    dbo.Benefits.ID AS [Benefit ID]
			,dbo.Benefits.Title AS [Benefit]
			,dbo.Projects.Title AS [Project]
			,dbo.BenefitTypes.Title AS [Benefit Type]
			,dbo.Benefits.Description AS [Benefit Description]
			,dbo.MeasurementUnits.Title AS [Performance Unit]
			,dbo.Benefits.TargetPerformanceLowerLimit AS [Target Performance Lower Limit]
			,dbo.Benefits.TargetPerformanceUpperLimit AS [Target Performance Upper Limit]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.Benefits.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
FROM     dbo.Benefits LEFT OUTER JOIN
			dbo.Projects ON dbo.Benefits.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
			dbo.BenefitTypes ON dbo.Benefits.BenefitTypeID = dbo.BenefitTypes.ID LEFT OUTER JOIN
			dbo.MeasurementUnits ON dbo.Benefits.MeasurementUnitID = dbo.MeasurementUnits.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Benefits.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Benefits.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[SDPActivityProgress]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[SDPActivityProgress]
AS

SELECT  'Benefit' AS [Report Element Type]
		,bu.Benefit AS [Report Element Name]
		,bu.[Group]
		,bu.[Directorate]
		,bu.[Project]
		,bu.[Progress Update]
		,bu.[Lead]
		,bu.[Author]
		,bu.[Report Month]
		,b.[Status]
		,bu.[Current RAG] AS [RAG]
		,NULL AS [Baseline Date]
		,NULL AS [Forecast Date]
		,NULL AS [Actual Date]
		,CASE Attr.[Attribute] WHEN 'SDP' THEN 'Yes' ELSE 'No' END AS [SDP]
		,Attr.[Attribute Value] AS [SDP Value]
FROM [reports].[BenefitUpdates] AS bu INNER JOIN
		[reports].[Benefits] AS b ON bu.[Benefit ID] = b.[Benefit ID] INNER JOIN
		[reports].[Attributes] AS Attr ON bu.[Benefit ID] = Attr.[Benefit ID] AND Attr.Attribute = 'SDP' INNER JOIN
		(SELECT [Benefit ID], MAX([Report Month]) AS LatestUpdateMonth
		  FROM [reports].[BenefitUpdates]
		  GROUP BY [Benefit ID]) AS LatestBenefitUpdateMonth ON bu.[Benefit ID] = LatestBenefitUpdateMonth.[Benefit ID] AND bu.[Report Month] = LatestBenefitUpdateMonth.LatestUpdateMonth

UNION

SELECT  'Key Work Area' AS [Report Element Type]
		,ku.[Key Work Area] AS [Report Element Name]
		,ku.[Group]
		,ku.[Directorate]
		,NULL AS [Project]
		,ku.[Progress Update]
		,ku.[Lead]
		,ku.[Author]
		,ku.[Report Month]
		,k.[Status]
		,ku.[Current RAG] AS [RAG]
		,NULL AS [Baseline Date]
		,NULL AS [Forecast Date]
		,NULL AS [Actual Date]
		,CASE Attr.[Attribute] WHEN 'SDP' THEN 'Yes' ELSE 'No' END AS [SDP]
		,Attr.[Attribute Value] AS [SDP Value]
FROM [reports].[KeyWorkAreaUpdates] AS ku INNER JOIN
		[reports].[KeyWorkAreas] AS k ON ku.[Key Work Area ID] = k.[Key Work Area ID] INNER JOIN
		[reports].[Attributes] AS Attr ON ku.[Key Work Area ID] = Attr.[Key Work Area ID] AND Attr.Attribute = 'SDP' INNER JOIN
		(SELECT [Key Work Area ID], MAX([Report Month]) AS LatestUpdateMonth
		  FROM [reports].[KeyWorkAreaUpdates]
		  GROUP BY [Key Work Area ID]) AS LatestKeyWorkAreaUpdateMonth ON ku.[Key Work Area ID] = LatestKeyWorkAreaUpdateMonth.[Key Work Area ID] AND ku.[Report Month] = LatestKeyWorkAreaUpdateMonth.LatestUpdateMonth

UNION

SELECT  'Metric' AS [Report Element Type]
		,mu.Metric AS [Report Element Name]
		,mu.[Group]
		,mu.[Directorate]
		,NULL AS [Project]
		,mu.[Progress Update]
		,mu.[Lead]
		,mu.[Author]
		,mu.[Report Month]
		,m.[Status]
		,mu.[Current RAG] AS [RAG]
		,NULL AS [Baseline Date]
		,NULL AS [Forecast Date]
		,NULL AS [Actual Date]
		,CASE Attr.[Attribute] WHEN 'SDP' THEN 'Yes' ELSE 'No' END AS [SDP]
		,Attr.[Attribute Value] AS [SDP Value]
FROM [reports].[MetricUpdates] AS mu INNER JOIN
		[reports].[Metrics] AS m ON mu.[Metric ID] = m.[Metric ID] INNER JOIN
		[reports].[Attributes] AS Attr ON mu.[Metric ID] = Attr.[Metric ID] AND Attr.Attribute = 'SDP' INNER JOIN
		(SELECT [Metric ID], MAX([Report Month]) AS LatestUpdateMonth
		  FROM [reports].[MetricUpdates]
		  GROUP BY [Metric ID]) AS LatestMetricUpdateMonth ON mu.[Metric ID] = LatestMetricUpdateMonth.[Metric ID] AND mu.[Report Month] = LatestMetricUpdateMonth.LatestUpdateMonth


UNION

SELECT  'Milestone' AS [Report Element Type]
		,mu.Milestone AS [Report Element Name]
		,mu.[Group]
		,mu.[Directorate]
		,mu.[Project]
		,mu.[Progress Update]
		,mu.[Lead]
		,mu.[Author]
		,mu.[Report Month]
		,m.[Status]
		,mu.[Current RAG] AS [RAG]
		,m.Baseline AS [Baseline Date]
		,m.Forecast AS [Forecast Date]
		,m.Actual AS [Actual Date]
		,CASE Attr.[Attribute] WHEN 'SDP' THEN 'Yes' ELSE 'No' END AS [SDP]
		,Attr.[Attribute Value] AS [SDP Value]
FROM [reports].[MilestoneUpdates] AS mu INNER JOIN
		[reports].[Milestones] AS m ON mu.[Milestone ID]=m.[Milestone ID] INNER JOIN
		[reports].[Attributes] AS Attr ON mu.[Milestone ID] = Attr.[Milestone ID] AND Attr.Attribute = 'SDP' INNER JOIN
		(SELECT [Milestone ID], MAX([Report Month]) AS LatestUpdateMonth
		  FROM [reports].[MilestoneUpdates]
		  GROUP BY [Milestone ID]) AS LatestMilestoneUpdateMonth ON mu.[Milestone ID] = LatestMilestoneUpdateMonth.[Milestone ID] AND mu.[Report Month] = LatestMilestoneUpdateMonth.LatestUpdateMonth

UNION

SELECT  'Work Stream' AS [Report Element Type]
		,wu.[Work Stream] AS [Report Element Name]
		,wu.[Group]
		,wu.[Directorate]
		,wu.[Project]
		,wu.[Progress Update]
		,wu.[Lead]
		,wu.[Author]
		,wu.[Report Month]
		,w.[Status]
		,wu.[Current RAG] AS [RAG]
		,NULL AS [Baseline Date]
		,NULL AS [Forecast Date]
		,NULL AS [Actual Date]
		,CASE Attr.[Attribute] WHEN 'SDP' THEN 'Yes' ELSE 'No' END AS [SDP]
		,Attr.[Attribute Value] AS [SDP Value]
FROM [reports].[WorkStreamUpdates] AS wu INNER JOIN
		[reports].[WorkStreams] AS w ON wu.[Work Stream ID] = w.[Work Stream ID] INNER JOIN
		[reports].[Attributes] AS Attr ON wu.[Work Stream ID] = Attr.[Work Stream ID] AND Attr.Attribute = 'SDP' INNER JOIN
		(SELECT [Work Stream ID], MAX([Report Month]) AS LatestUpdateMonth
		  FROM [reports].[WorkStreamUpdates]
		  GROUP BY [Work Stream ID]) AS LatestWorkStreamUpdateMonth ON wu.[Work Stream ID] = LatestWorkStreamUpdateMonth.[Work Stream ID] AND wu.[Report Month] = LatestWorkStreamUpdateMonth.LatestUpdateMonth
GO
/****** Object:  View [reports].[PartnerOrganisations]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[PartnerOrganisations]
AS
    SELECT po.ID AS [Partner Organisation ID]
		, po.Title AS [Partner Organisation]
        , dr.Title AS [Directorate]
		, gr.Title AS [Group]
        , lps.Title AS [Lead Policy Sponsor]
        , ra.Title AS [Report Author]
        , po.Objectives AS [Objectives]
        , CASE po.ReportingFrequency 
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
        , CASE po.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(po.ReportingStartDate)
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(po.ReportingStartDate)
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(po.ReportingStartDate)  
                WHEN 1 THEN 'Jan' 
                WHEN 2 THEN 'Feb' 
                WHEN 3 THEN 'Mar' 
                WHEN 4 THEN 'Apr' 
                WHEN 5 THEN 'May' 
                WHEN 6 THEN 'Jun' 
                WHEN 7 THEN 'Jul' 
                WHEN 8 THEN 'Aug' 
                WHEN 9 THEN 'Sep' 
                WHEN 10 THEN 'Oct' 
                WHEN 11 THEN 'Nov' 
                WHEN 12 THEN 'Dec' 
                ELSE '' 
            END 
			ELSE '' 
        END AS [Reporting Schedule]
    FROM dbo.PartnerOrganisations po LEFT OUTER JOIN
        dbo.Directorates dr ON po.DirectorateID = dr.ID LEFT OUTER JOIN
        dbo.Groups gr ON dr.GroupID = gr.ID LEFT OUTER JOIN
        dbo.Users lps ON po.LeadPolicySponsorUserID = lps.ID LEFT OUTER JOIN
        dbo.Users ra ON po.ReportAuthorUserID = ra.ID;
GO
/****** Object:  View [reports].[CSFPActivityProgress]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[CSFPActivityProgress]
AS

SELECT  'Key Work Area' AS [Report Element Type]
		,ku.[Key Work Area] AS [Report Element Name]
		,ku.[Group]
		,ku.[Directorate]
		,NULL AS [Project]
		,ku.[Progress Update]
		,ku.[Lead]
		,ku.[Author]
		,ku.[Report Month]
		,k.[Status]
		,ku.[Current RAG] AS [RAG]
		,NULL AS [Baseline Date]
		,NULL AS [Forecast Date]
		,NULL AS [Actual Date]
		,CASE Attr.[Attribute] WHEN 'CSFP' THEN 'Yes' ELSE 'No' END AS [CSFP]
		,Attr.[Attribute Value] AS [CSFP Value]
FROM [reports].[KeyWorkAreaUpdates] AS ku INNER JOIN
		[reports].[KeyWorkAreas] AS k ON ku.[Key Work Area ID] = k.[Key Work Area ID] INNER JOIN
		[reports].[Attributes] AS Attr ON ku.[Key Work Area ID] = Attr.[Key Work Area ID] AND Attr.Attribute = 'CSFP' INNER JOIN
		(SELECT [Key Work Area ID], MAX([Report Month]) AS LatestUpdateMonth
		  FROM [reports].[KeyWorkAreaUpdates]
		  GROUP BY [Key Work Area ID]) AS LatestKeyWorkAreaUpdateMonth ON ku.[Key Work Area ID] = LatestKeyWorkAreaUpdateMonth.[Key Work Area ID] AND ku.[Report Month] = LatestKeyWorkAreaUpdateMonth.LatestUpdateMonth

UNION

SELECT  'Metric' AS [Report Element Type]
		,mu.Metric AS [Report Element Name]
		,mu.[Group]
		,mu.[Directorate]
		,NULL AS [Project]
		,mu.[Progress Update]
		,mu.[Lead]
		,mu.[Author]
		,mu.[Report Month]
		,m.[Status]
		,mu.[Current RAG] AS [RAG]
		,NULL AS [Baseline Date]
		,NULL AS [Forecast Date]
		,NULL AS [Actual Date]
		,CASE Attr.[Attribute] WHEN 'CSFP' THEN 'Yes' ELSE 'No' END AS [CSFP]
		,Attr.[Attribute Value] AS [CSFP Value]
FROM [reports].[MetricUpdates] AS mu INNER JOIN
		[reports].[Metrics] AS m ON mu.[Metric ID] = m.[Metric ID] INNER JOIN
		[reports].[Attributes] AS Attr ON mu.[Metric ID] = Attr.[Metric ID] AND Attr.Attribute = 'CSFP' INNER JOIN
		(SELECT [Metric ID], MAX([Report Month]) AS LatestUpdateMonth
		  FROM [reports].[MetricUpdates]
		  GROUP BY [Metric ID]) AS LatestMetricUpdateMonth ON mu.[Metric ID] = LatestMetricUpdateMonth.[Metric ID] AND mu.[Report Month] = LatestMetricUpdateMonth.LatestUpdateMonth


UNION

SELECT  'Milestone' AS [Report Element Type]
		,mu.Milestone AS [Report Element Name]
		,mu.[Group]
		,mu.[Directorate]
		,mu.[Project]
		,mu.[Progress Update]
		,mu.[Lead]
		,mu.[Author]
		,mu.[Report Month]
		,m.[Status]
		,mu.[Current RAG] AS [RAG]
		,m.Baseline AS [Baseline Date]
		,m.Forecast AS [Forecast Date]
		,m.Actual AS [Actual Date]
		,CASE Attr.[Attribute] WHEN 'CSFP' THEN 'Yes' ELSE 'No' END AS [CSFP]
		,Attr.[Attribute Value] AS [CSFP Value]
FROM [reports].[MilestoneUpdates] AS mu INNER JOIN
		[reports].[Milestones] AS m ON mu.[Milestone ID]=m.[Milestone ID] INNER JOIN
		[reports].[Attributes] AS Attr ON mu.[Milestone ID] = Attr.[Milestone ID] AND Attr.Attribute = 'CSFP' INNER JOIN
		(SELECT [Milestone ID], MAX([Report Month]) AS LatestUpdateMonth
		  FROM [reports].[MilestoneUpdates]
		  GROUP BY [Milestone ID]) AS LatestMilestoneUpdateMonth ON mu.[Milestone ID] = LatestMilestoneUpdateMonth.[Milestone ID] AND mu.[Report Month] = LatestMilestoneUpdateMonth.LatestUpdateMonth
GO
/****** Object:  Table [History].[UserGroups]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[UserGroups](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UserID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
	[IsRiskAdmin] [bit] NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[Discriminator] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGroups]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGroups](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UserID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
	[IsRiskAdmin] [bit] NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[Discriminator] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_UserGroups] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_UserGroups] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[GroupID] ASC,
	[Discriminator] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[UserGroups] )
)
GO
/****** Object:  View [reports].[FinancialRiskReports]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[FinancialRiskReports]
AS
WITH RiskFundingClassifications AS
(SELECT r.[ID] AS [RiskID], STRING_AGG(fcs.value, ', ') AS [FundingClassifications]
FROM [dbo].[Risks] AS r
CROSS APPLY OPENJSON(r.[FundingClassification]) AS fcs
GROUP BY r.ID),
RiskEconomicRingfences AS
(SELECT r.[ID] AS [RiskID], STRING_AGG(erf.value, ', ') AS [EconomicRingfences]
FROM [dbo].[Risks] AS r
CROSS APPLY OPENJSON(r.[EconomicRingfence]) AS erf
GROUP BY r.ID),
RiskPolicyRingfences AS
(SELECT r.[ID] AS [RiskID], STRING_AGG(prf.value, ', ') AS [PolicyRingfences]
FROM [dbo].[Risks] AS r
CROSS APPLY OPENJSON(r.[PolicyRingfence]) AS prf
GROUP BY r.ID)
  SELECT
    so.[ReportMonth] AS [Report Period]
    , CASE WHEN report.[OwnedByMultipleGroups] = 'true' THEN 'Central' 
        ELSE report.[Group] END AS [Group]
    , CASE WHEN report.[OwnedByMultipleGroups] = 'true' THEN 'Central'
        WHEN report.[OwnedByDgOffice] = 'true' THEN 'DG Office' 
        ELSE report.[Directorate] END AS [Directorate]
    , report.[RiskTitle] AS [Risk Name]
    , report.[RiskRegisteredDate] AS [Date Raised]
    , report.[StaffNonStaffSpend] AS [Staff/Non-staff spend]
    , RiskFundingClassifications.[FundingClassifications] AS [Funding Classifications]
    , RiskEconomicRingfences.[EconomicRingfences] AS [Economic Ringfences]
    , RiskPolicyRingfences.[PolicyRingfences] AS [Policy Ringfences]
    , report.[UniformChartOfAccountsID] AS [UCOA]
    , report.[FY0] AS [FY0]
    , report.[FY1] AS [FY1]
    , report.[FY2] AS [FY2]
    , report.[FY3] AS [FY3]
    , report.[FY4] AS [FY4]
    , report.[RiskEventDescription] AS [Risk Event Description]
    , report.[RiskCauseDescription] AS [Risk Cause Description]
    , report.[RiskImpactDescription] AS [Risk Impact Description]
    , report.[ImpactLevel] AS [Impact Level]
    , report.[Probability] AS [Probability]
    , report.[RAG] AS [RAG]
    , RiskActions.[ActionID] AS [Action ID]
    , RiskActions.[ActionTitle] AS [Action Title]
    , RiskActions.[ActionOwner] AS [Action Owner]
    , RiskActions.[ActionRag] AS [Action RAG]
    , RiskActions.[ActionComment] AS [Action Comment]
FROM
    [dbo].[SignOffs] AS so INNER JOIN
    [dbo].[Risks] AS r ON so.[RiskID] = r.[ID] LEFT OUTER JOIN
    RiskFundingClassifications ON so.[RiskID] = RiskFundingClassifications.[RiskID] LEFT OUTER JOIN
    RiskEconomicRingfences ON so.[RiskID] = RiskEconomicRingfences.[RiskID] LEFT OUTER JOIN
    RiskPolicyRingfences ON so.[RiskID] = RiskPolicyRingfences.[RiskID]
 CROSS APPLY OPENJSON(so.[ReportJson]) 
  WITH (
    [Group] NVARCHAR(MAX) '$.Risk.Group.Title',
    [OwnedByMultipleGroups] BIT '$.Risk.OwnedByMultipleGroups',
    [Directorate] NVARCHAR(MAX) '$.Risk.Directorate.Title',
    [OwnedByDgOffice] BIT '$.Risk.OwnedByDgOffice',
    [RiskTitle] NVARCHAR(MAX) '$.Risk.Title',
    [RiskRegisteredDate] DATETIME2(0) '$.Risk.RiskRegisteredDate',
    [StaffNonStaffSpend] NVARCHAR(MAX) '$.Risk.StaffNonStaffSpend',
    [UniformChartOfAccountsID] NVARCHAR(MAX) '$.Risk.UniformChartOfAccountsID',
    [FY0] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].Measurements.SpendProfile.FinancialYear0',
    [FY1] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].Measurements.SpendProfile.FinancialYear1',
    [FY2] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].Measurements.SpendProfile.FinancialYear2',
    [FY3] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].Measurements.SpendProfile.FinancialYear3',
    [FY4] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].Measurements.SpendProfile.FinancialYear4',
    [RiskEventDescription] NVARCHAR(MAX) '$.Risk.RiskEventDescription',
    [RiskCauseDescription] NVARCHAR(MAX) '$.Risk.RiskCauseDescription',
    [RiskImpactDescription] NVARCHAR(MAX) '$.Risk.RiskImpactDescription',
    [ImpactLevel] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].RiskImpactLevel.Title',
    [Probability] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].RiskProbability.Title',
    [RAG] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].RagOptionID',
    [Actions] NVARCHAR(MAX) '$.RiskMitigationActions' AS JSON
    ) AS report
    CROSS APPLY OPENJSON(report.Actions)
        WITH (
            [ActionID] int '$.ID',
            [ActionTitle] nvarchar(255) '$.Title',
            [ActionOwner] nvarchar(255) '$.OwnerUser.Title',
            [ActionRag] int '$.RiskMitigationActionUpdates[0].RagOptionID',
            [ActionComment] nvarchar(500) '$.RiskMitigationActionUpdates[0].Comment'
        ) AS RiskActions 
WHERE r.[Discriminator] = 'FinancialRisk' AND so.[IsCurrent] = 'true';
GO
/****** Object:  View [reports].[FinancialRisks]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[FinancialRisks]
AS
WITH RiskFundingClassifications AS
(SELECT r.[ID] AS [RiskID], STRING_AGG(fcs.value, ', ') AS [FundingClassifications]
FROM [dbo].[Risks] AS r
CROSS APPLY OPENJSON(r.[FundingClassification]) AS fcs
GROUP BY r.ID),
RiskEconomicRingfences AS
(SELECT r.[ID] AS [RiskID], STRING_AGG(erf.value, ', ') AS [EconomicRingfences]
FROM [dbo].[Risks] AS r
CROSS APPLY OPENJSON(r.[EconomicRingfence]) AS erf
GROUP BY r.ID),
RiskPolicyRingfences AS
(SELECT r.[ID] AS [RiskID], STRING_AGG(prf.value, ', ') AS [PolicyRingfences]
FROM [dbo].[Risks] AS r
CROSS APPLY OPENJSON(r.[PolicyRingfence]) AS prf
GROUP BY r.ID)
  SELECT
    CASE WHEN r.[OwnedByMultipleGroups] = 'true' THEN 'Central' 
        ELSE g.[Title] END AS [Group]
    , CASE WHEN r.[OwnedByMultipleGroups] = 'true' THEN 'Central'
        WHEN r.[OwnedByDgOffice] = 'true' THEN 'DG Office' 
        ELSE d.[Title] END AS [Directorate]
    , r.[Title] AS [Risk Name]
    , r.[RiskRegisteredDate] AS [Date Raised]
    , r.[StaffNonStaffSpend] AS [Staff/Non-staff spend]
    , RiskFundingClassifications.[FundingClassifications] AS [Funding Classifications]
    , RiskEconomicRingfences.[EconomicRingfences] AS [Economic Ringfences]
    , RiskPolicyRingfences.[PolicyRingfences] AS [Policy Ringfences]
    , r.[UniformChartOfAccountsID] AS [UCOA]
    , r.[RiskEventDescription] AS [Risk Event Description]
    , r.[RiskCauseDescription] AS [Risk Cause Description]
    , r.[RiskImpactDescription] AS [Risk Impact Description]
    , es.[Title] AS [Status]
FROM [dbo].[Risks] AS r LEFT OUTER JOIN
    [dbo].[Groups] AS g ON r.[GroupID] = g.[ID] LEFT OUTER JOIN
    [dbo].[Directorates] AS d ON r.[DirectorateID] = d.[ID] LEFT OUTER JOIN
    [dbo].[EntityStatuses] AS es ON r.[EntityStatusID] = es.[ID] LEFT OUTER JOIN
    RiskFundingClassifications ON r.[ID] = RiskFundingClassifications.[RiskID] LEFT OUTER JOIN
    RiskEconomicRingfences ON r.[ID] = RiskEconomicRingfences.[RiskID] LEFT OUTER JOIN
    RiskPolicyRingfences ON r.[ID] = RiskPolicyRingfences.[RiskID]
WHERE r.[Discriminator] = 'FinancialRisk' AND r.[EntityStatusID] = 1;
GO
/****** Object:  View [reports].[BenefitAttributes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[BenefitAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.BenefitID AS [Benefit ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.BenefitID IS NOT NULL
GO
/****** Object:  View [reports].[CommitmentAttributes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[CommitmentAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.CommitmentID AS [Commitment ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.CommitmentID IS NOT NULL
GO
/****** Object:  View [reports].[DirectorateAttributes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[DirectorateAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.DirectorateID AS [Directorate ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.DirectorateID IS NOT NULL
GO
/****** Object:  View [reports].[KeyWorkAreaAttributes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[KeyWorkAreaAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.KeyWorkAreaID AS [Key Work Area ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.KeyWorkAreaID IS NOT NULL
GO
/****** Object:  View [reports].[MetricAttributes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[MetricAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.MetricID AS [Metric ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.MetricID IS NOT NULL
GO
/****** Object:  View [reports].[MilestoneAttributes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[MilestoneAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.MilestoneID AS [Milestone ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.MilestoneID IS NOT NULL
GO
/****** Object:  View [reports].[PartnerOrganisationRiskAttributes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[PartnerOrganisationRiskAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.PartnerOrganisationRiskID AS [Partner Organisation Risk ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.PartnerOrganisationRiskID IS NOT NULL
GO
/****** Object:  Table [History].[RiskRiskMitigationActions]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[RiskRiskMitigationActions](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[RiskID] [int] NOT NULL,
	[RiskMitigationActionID] [int] NOT NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[Discriminator] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RiskRiskMitigationActions]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskRiskMitigationActions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[RiskID] [int] NOT NULL,
	[RiskMitigationActionID] [int] NOT NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_RiskRiskMitigationActions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[RiskRiskMitigationActions] )
)
GO
/****** Object:  View [reports].[RiskAttributes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[RiskAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.RiskID AS [Risk ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.RiskID IS NOT NULL
GO
/****** Object:  View [reports].[WorkStreamAttributes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[WorkStreamAttributes]
AS
	SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.WorkStreamID AS [Work Stream ID]
	FROM dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
	WHERE dbo.Attributes.WorkStreamID IS NOT NULL
GO
/****** Object:  View [reports].[DirectoratesWithNoUpdates]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[DirectoratesWithNoUpdates]
AS
SELECT    dbo.Directorates.ID AS [Directorate ID]
			,dbo.Groups.Title AS [Group]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.SignOffs.ReportMonth AS [Report Month]
			,OverallRAG.ID AS [Delivery Confidence RAG Score]
			,FinanceRAG.ID AS [Finance RAG Score]
			,PeopleRAG.ID AS [People RAG Score]
			,MilestonesRAG.ID AS [Milestones RAG Score]
			,MetricsRAG.ID AS [Metrics RAG Score]
			,CASE  
				WHEN OverALlRAG.ID = 1 OR FinanceRAG.ID = 1 OR PeopleRAG.ID = 1 OR MilestonesRAG.ID = 1 OR MetricsRAG.ID = 1 THEN 'Yes'
				WHEN OverALlRAG.ID = 2 OR FinanceRAG.ID = 2 OR PeopleRAG.ID = 2 OR MilestonesRAG.ID = 2 OR MetricsRAG.ID = 2 THEN 'Yes'
				WHEN OverALlRAG.ID = 3 OR FinanceRAG.ID = 3 OR PeopleRAG.ID = 3 OR MilestonesRAG.ID = 3 OR MetricsRAG.ID = 3 THEN 'Yes'
				WHEN OverALlRAG.ID = 4 OR FinanceRAG.ID = 4 OR PeopleRAG.ID = 4 OR MilestonesRAG.ID = 4 OR MetricsRAG.ID = 4 THEN 'Yes'
				WHEN OverALlRAG.ID = 5 OR FinanceRAG.ID = 5 OR PeopleRAG.ID = 5 OR MilestonesRAG.ID = 5 OR MetricsRAG.ID = 5 THEN 'Yes'
				ELSE 'No'
			END AS [Has Updates]
			
FROM     dbo.SignOffs INNER JOIN
			dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.DirectorateUpdates ON dbo.SignOffs.ID = dbo.DirectorateUpdates.SignOffID LEFT OUTER JOIN
            dbo.Groups ON Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
			dbo.RagOptions AS OverallRAG ON dbo.DirectorateUpdates.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
			dbo.RagOptions AS FinanceRAG ON dbo.DirectorateUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS PeopleRAG ON dbo.DirectorateUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS MilestonesRAG ON dbo.DirectorateUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS MetricsRAG ON dbo.DirectorateUpdates.MetricsRagOptionID = MetricsRAG.ID 

WHERE (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [reports].[ProjectHasUpdates]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ProjectHasUpdates]
AS
SELECT		dbo.Projects.ID AS [Project ID]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.SignOffs.ReportMonth AS [Report Month]
			,OverallRAG.ID AS [Delivery Confidence RAG Score]
			,FinanceRAG.ID AS [Finance RAG Score]
			,PeopleRAG.ID AS [People RAG Score]
			,MilestonesRAG.ID AS [Milestones RAG Score]
			,BenefitsRAG.ID AS [Benefits RAG Score]
			,CASE  
				WHEN OverALlRAG.ID = 1 OR FinanceRAG.ID = 1 OR PeopleRAG.ID = 1 OR MilestonesRAG.ID = 1 OR BenefitsRAG.ID = 1 THEN 'Yes'
				WHEN OverALlRAG.ID = 2 OR FinanceRAG.ID = 2 OR PeopleRAG.ID = 2 OR MilestonesRAG.ID = 2 OR BenefitsRAG.ID = 2 THEN 'Yes'
				WHEN OverALlRAG.ID = 3 OR FinanceRAG.ID = 3 OR PeopleRAG.ID = 3 OR MilestonesRAG.ID = 3 OR BenefitsRAG.ID = 3 THEN 'Yes'
				WHEN OverALlRAG.ID = 4 OR FinanceRAG.ID = 4 OR PeopleRAG.ID = 4 OR MilestonesRAG.ID = 4 OR BenefitsRAG.ID = 4 THEN 'Yes'
				WHEN OverALlRAG.ID = 5 OR FinanceRAG.ID = 5 OR PeopleRAG.ID = 5 OR MilestonesRAG.ID = 5 OR BenefitsRAG.ID = 5 THEN 'Yes'
				ELSE 'No'
			END AS [Has Updates]
			
FROM     dbo.SignOffs INNER JOIN
			dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
			dbo.ProjectUpdates ON dbo.SignOffs.ID = dbo.ProjectUpdates.SignOffID LEFT OUTER JOIN
            dbo.Directorates ON Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.RagOptions AS OverallRAG ON dbo.ProjectUpdates.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
			dbo.RagOptions AS FinanceRAG ON dbo.ProjectUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS PeopleRAG ON dbo.ProjectUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS MilestonesRAG ON dbo.ProjectUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS BenefitsRAG ON dbo.ProjectUpdates.BenefitsRagOptionID = BenefitsRAG.ID 

WHERE (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[DirectorateReports]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DirectorateReports]
AS
    SELECT
        g.Title AS [Group]
        , report.DirectorateName AS [Directorate]
        , so.DirectorateID AS [DirectorateID]
        , so.ReportMonth AS [ReportMonth]
        , DirectorUser.Title AS [Director]
        , report.UpdateUser AS [DirectorateUpdateAuthor]
        , so.ID AS [SignOffID]
        , es.Title AS [DirectorateStatus] 
		, so.SignOffDate AS [SignOffDate]
		, report.UpdateDate AS [DirectorateUpdateDate]
		, report.Objectives AS [Objectives]
		, report.ProgressUpdate AS [ProgressUpdate]
		, report.FutureActions AS [FutureActions]
		, report.Escalations AS [Escalations]

		, OverallRAG.ReportName AS [OverallRAG]
		, FinanceRAG.ReportName AS [FinanceRAG]
		, MilestonesRAG.ReportName AS [MilestonesRAG]
		, MetricsRAG.ReportName AS [MetricsRAG]
		, PeopleRAG.ReportName AS [PeopleRAG]

		, OverallRAG.Score AS [OverallRAGScore]
		, FinanceRAG.Score AS [FinanceRAGScore]
		, MilestonesRAG.Score AS [MilestonesRAGScore]
		, MetricsRAG.Score AS [MetricsRAGScore]
		, PeopleRAG.Score AS [PeopleRAGScore]

		, report.FinanceComment AS [FinanceComment]
		, report.MilestonesComment AS [MilestonesComment]
		, report.MetricsComment AS [MetricsComment]
		, report.PeopleComment AS [PeopleComment]

    FROM dbo.SignOffs AS so 
    CROSS APPLY OPENJSON(so.ReportJson, 'lax $.Directorate') 
    WITH (
        DirectorateName NVARCHAR(255) '$.Title',
        GroupID INT '$.GroupID',
        DirectorUserID INT '$.DirectorUserID',
        Objectives NVARCHAR(MAX) '$.Objectives',
        EntityStatusID INT '$.EntityStatusID',
        ProgressUpdate NVARCHAR(1000) '$.DirectorateUpdates[0].ProgressUpdate',
        FutureActions NVARCHAR(1000) '$.DirectorateUpdates[0].FutureActions',
        Escalations NVARCHAR(1000) '$.DirectorateUpdates[0].Escalations',
        UpdateUser NVARCHAR(255) '$.DirectorateUpdates[0].UpdateUser.Title',
        UpdateDate DATETIME2(7) '$.DirectorateUpdates[0].UpdateDate',
        OverallRagOptionID INT '$.DirectorateUpdates[0].OverallRagOptionID',
        FinanceRagOptionID INT '$.DirectorateUpdates[0].FinanceRagOptionID',
        FinanceComment NVARCHAR(1000) '$.DirectorateUpdates[0].FinanceComment',
        PeopleRagOptionID INT '$.DirectorateUpdates[0].PeopleRagOptionID',
        PeopleComment NVARCHAR(1000) '$.DirectorateUpdates[0].PeopleComment',
        MilestonesRagOptionID INT '$.DirectorateUpdates[0].MilestonesRagOptionID',
        MilestonesComment NVARCHAR(1000) '$.DirectorateUpdates[0].MilestonesComment',
        MetricsRagOptionID INT '$.DirectorateUpdates[0].MetricsRagOptionID',
        MetricsComment NVARCHAR(1000) '$.DirectorateUpdates[0].MetricsComment'
    ) AS report LEFT OUTER JOIN
        dbo.Groups AS g ON report.GroupID = g.ID LEFT OUTER JOIN
        dbo.EntityStatuses AS es ON report.EntityStatusID = es.ID LEFT OUTER JOIN
        dbo.Users AS DirectorUser ON report.DirectorUserID = directoruser.ID LEFT OUTER JOIN
        dbo.RagOptions AS OverallRAG ON report.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
        dbo.RagOptions AS FinanceRAG ON report.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
        dbo.RagOptions AS PeopleRAG ON report.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
        dbo.RagOptions AS MilestonesRAG ON report.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
        dbo.RagOptions AS MetricsRAG ON report.MetricsRagOptionID = MetricsRAG.ID
    WHERE so.IsCurrent = 1
GO
/****** Object:  View [reports].[DirectorateUpdates2]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[DirectorateUpdates2]
AS
	SELECT
		reports.[Group] AS [Group]
		, d.Title AS [Directorate]
		, d.ID AS [ID]
		, Months.ReportMonth AS [Report Month]
		, reports.Director AS [Director]
		, reports.DirectorateUpdateAuthor AS [Author]
		, SignOffUser.Title AS [Signed-off by]
		, so.ID AS [SignOff ID]
		, reports.DirectorateStatus AS [Status] 
		, CAST(so.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Date Signed-off]
		, CAST(reports.DirectorateUpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, reports.Objectives AS [Objectives]
		, reports.ProgressUpdate AS [Delivery Confidence Update]
		, reports.FutureActions AS [Future Actions Update]
		, reports.Escalations AS [Escalations Update]

		, reports.OverallRAG AS [Delivery Confidence RAG]
		, reports.FinanceRAG AS [Finance RAG]
		, reports.MilestonesRAG AS [Milestones RAG]
		, reports.MetricsRAG AS [Metrics RAG]
		, reports.PeopleRAG AS [People RAG]

		, reports.OverallRAGScore AS [Delivery Confidence RAG Score]
		, reports.FinanceRAGScore AS [Finance RAG Score]
		, reports.MilestonesRAGScore AS [Milestones RAG Score]
		, reports.MetricsRAGScore AS [Metrics RAG Score]
		, reports.PeopleRAGScore AS [People RAG Score]

		, reports.FinanceComment AS [Finance Update]
		, reports.MilestonesComment AS [Milestones Update]
		, reports.MetricsComment AS [Metrics Update]
		, reports.PeopleComment AS [People Update]

		, (reports.OverallRAGScore - pdu.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (reports.FinanceRAGScore - pdu.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (reports.MilestonesRAGScore - pdu.PreviousMilestonesRAGScore) AS [Milestones RAG Change]
		, (reports.MetricsRAGScore - pdu.PreviousMetricsRAGScore) AS [Metrics RAG Change]
		, (reports.PeopleRAGScore - pdu.PreviousPeopleRAGScore) AS [People RAG Change]
	FROM dbo.Directorates AS d CROSS JOIN
        (SELECT DISTINCT dbo.SignOffs.ReportMonth
		FROM dbo.SignOffs
		WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months LEFT OUTER JOIN
		dbo.SignOffs AS so ON so.DirectorateID = d.ID AND so.ReportMonth = Months.ReportMonth AND so.IsCurrent = 1 LEFT OUTER JOIN
		dbo.DirectorateReports AS reports ON reports.SignOffID = so.ID LEFT OUTER JOIN
		dbo.PreviousDirectorateUpdates AS pdu ON reports.DirectorateID = pdu.DirectorateID AND Months.ReportMonth = pdu.NextMonth LEFT OUTER JOIN
		dbo.Users AS SignOffUser ON so.SignOffUserID = SignOffUser.ID
GO
/****** Object:  View [dbo].[ReportingEntityReports]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReportingEntityReports]
AS
  SELECT so.ID AS [Report ID]
, g.Title AS [Group]
, d.Title AS [Directorate]
, p.Title AS [Project]
, po.Title AS [Partner organisation]
, so.ReportMonth AS [Report period]
, reportEntityTypes.TypeName AS [Reporting entity type]
, reportEntities.ReportingEntityName AS [Reporting entity]
, reportEntities.Comment AS [Progress update]
, reportEntities.Rag AS [Current RAG]
, reportEntities.RagScore AS [Current RAG score]
, reportEntities.CurrentPerformance AS [Current performance]
, CAST(reportEntities.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast delivery date]
, CAST(reportEntities.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual delivery date]
, reportEntities.LeadUser AS [Lead]
, reportEntities.UpdateAuthor AS [Update author]
, CAST(reportEntities.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last edited date]
, CASE reportEntities.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Reporting entity closed]
, reportEntities.EntityStatus AS [Status]
  FROM dbo.SignOffs AS so 
    CROSS APPLY OPENJSON(so.ReportJson, 'lax $.ReportingEntityTypes') 
    WITH (
      TypeName NVARCHAR(255) '$.Title',
      ReportingEntities NVARCHAR(MAX) '$.ReportingEntities' AS JSON
    ) AS reportEntityTypes 
    CROSS APPLY OPENJSON(reportEntityTypes.ReportingEntities,'$')
    WITH (
      ReportingEntityName NVARCHAR(255) '$.Title',
      LeadUser NVARCHAR(255) '$.LeadUser.Title',
      EntityStatus NVARCHAR(50) '$.EntityStatus.Title',
      UpdateAuthor NVARCHAR(255) '$.ReportingEntityUpdates[0].UpdateUser.Title',
      UpdateDate DATETIME2(7) '$.ReportingEntityUpdates[0].UpdateDate',
      Rag NVARCHAR(2) '$.ReportingEntityUpdates[0].RagOption.ReportName',
      RagScore INT '$.ReportingEntityUpdates[0].RagOption.Score',
      Comment NVARCHAR(1000) '$.ReportingEntityUpdates[0].Comment',
      CurrentPerformance DECIMAL(18, 4) '$.ReportingEntityUpdates[0].CurrentPerformance',
      ForecastDate DATETIME2(7) '$.ReportingEntityUpdates[0].ForecastDate',
      ActualDate DATETIME2(7) '$.ReportingEntityUpdates[0].ActualDate',
      ToBeClosed BIT '$.ReportingEntityUpdates[0].ToBeClosed'
    ) AS reportEntities LEFT OUTER JOIN
    dbo.Directorates AS d ON so.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.Projects AS p ON so.ProjectID = p.ID LEFT OUTER JOIN
    dbo.PartnerOrganisations AS po ON so.PartnerOrganisationID = po.ID
  WHERE so.IsCurrent = 1
GO
/****** Object:  Table [History].[UserDirectorates]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[UserDirectorates](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UserID] [int] NOT NULL,
	[DirectorateID] [int] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[IsRiskAdmin] [bit] NOT NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDirectorates]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDirectorates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UserID] [int] NOT NULL,
	[DirectorateID] [int] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[IsRiskAdmin] [bit] NOT NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
 CONSTRAINT [PK_UserDirectorates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_UserDirectorates] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[DirectorateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[UserDirectorates] )
)
GO
/****** Object:  Table [History].[ReportTypes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[ReportTypes](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[CreatedDate] [datetime2](0) NULL,
	[ModifiedByUserID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportTypes]    Script Date: 08/11/2022 15:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[CreatedDate] [datetime2](0) NULL,
	[ModifiedByUserID] [int] NULL,
 CONSTRAINT [PK_ReportTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[ReportTypes] )
)
GO
/****** Object:  View [reports].[ReportingEntities]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ReportingEntities]
AS
  SELECT re.ID AS [Reporting entity ID]
    , rt.Title AS [Report type]
    , ret.Title AS [Reporting entity type]
		, re.Title AS [Reporting entity]
    , d.Title AS [Directorate]
		, p.Title AS [Project]
    , po.Title AS [Partner organisation]
		, re.Description AS [Reporting entity description]
		, mu.Title AS [Performance unit]
		, re.TargetPerformanceLowerLimit AS [Target performance lower limit]
		, re.TargetPerformanceUpperLimit AS [Target performance upper limit]
    , CAST(re.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline delivery date]
		, CAST(re.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast delivery date]
		, CAST(re.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual delivery date]
		, leadUser.Title AS [Lead]
		, e.Title AS [Status]
		, CAST(re.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status last changed]
  FROM dbo.ReportingEntities AS re INNER JOIN
    dbo.ReportingEntityTypes AS ret ON re.ReportingEntityTypeID = ret.ID INNER JOIN
    dbo.ReportTypes AS rt ON ret.ReportTypeID = rt.ID LEFT OUTER JOIN
    dbo.Directorates AS d ON re.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Projects AS p ON re.ProjectID = p.ID LEFT OUTER JOIN
    dbo.PartnerOrganisations AS po ON re.PartnerOrganisationID = po.ID LEFT OUTER JOIN
    dbo.MeasurementUnits AS mu ON re.MeasurementUnitID = mu.ID LEFT OUTER JOIN
    dbo.Users AS leadUser ON re.LeadUserID = leadUser.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS e ON re.EntityStatusID = e.ID
GO
/****** Object:  View [reports].[DirectorateHasUpdates]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[DirectorateHasUpdates]
AS
SELECT    dbo.Directorates.ID AS [Directorate ID]
			,dbo.Groups.Title AS [Group]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.SignOffs.ReportMonth AS [Report Month]
			,ISNULL(OverallRAG.ID, 0) AS [Delivery Confidence RAG Score]
			,ISNULL(FinanceRAG.ID, 0) AS [Finance RAG Score]
			,ISNULL(PeopleRAG.ID, 0) AS [People RAG Score]
			,ISNULL(MilestonesRAG.ID, 0) AS [Milestones RAG Score]
			,ISNULL(MetricsRAG.ID, 0) AS [Metrics RAG Score]
			
FROM     dbo.Directorates INNER JOIN
			dbo.Groups ON Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
			dbo.DirectorateUpdates ON dbo.DirectorateUpdates.DirectorateID = dbo.Directorates.ID INNER JOIN
			dbo.SignOffs ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.DirectorateUpdates AS SignedOffDirectorateUpdates ON dbo.SignOffs.ID = dbo.DirectorateUpdates.SignOffID LEFT OUTER JOIN
			dbo.RagOptions AS OverallRAG ON dbo.DirectorateUpdates.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
			dbo.RagOptions AS FinanceRAG ON dbo.DirectorateUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS PeopleRAG ON dbo.DirectorateUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS MilestonesRAG ON dbo.DirectorateUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS MetricsRAG ON dbo.DirectorateUpdates.MetricsRagOptionID = MetricsRAG.ID 

WHERE (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  Table [History].[UserPartnerOrganisations]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[UserPartnerOrganisations](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UserID] [int] NOT NULL,
	[PartnerOrganisationID] [int] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[HideHeadlines] [bit] NULL,
	[HideMilestones] [bit] NULL,
	[HideCustomSections] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPartnerOrganisations]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPartnerOrganisations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UserID] [int] NOT NULL,
	[PartnerOrganisationID] [int] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[HideHeadlines] [bit] NULL,
	[HideMilestones] [bit] NULL,
	[HideCustomSections] [bit] NULL,
 CONSTRAINT [PK_UserPartnerOrganisations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_UserPartnerOrganisations] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[PartnerOrganisationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[UserPartnerOrganisations] )
)
GO
/****** Object:  View [dbo].[ReportingEntityTypeFields]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReportingEntityTypeFields]
AS
  SELECT ret.ID AS ReportingEntityTypeID, FieldName, FieldTitle, FieldType, fields.LookupList AS LookupListID, lookup.Title AS LookupList
  FROM [dbo].[ReportingEntityTypes] AS ret
  CROSS APPLY OPENJSON(CustomFields) WITH (
    FieldName NVARCHAR(255) '$.FieldName', 
    FieldTitle NVARCHAR(255) '$.Title', 
    FieldType INT '$.Type', 
    LookupList INT '$.LookupList'
    ) AS fields LEFT OUTER JOIN
    [dbo].[ReportingEntityTypes] AS lookup ON fields.LookupList = lookup.ID
GO
/****** Object:  View [dbo].[ReportingEntityProperties]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReportingEntityProperties]
AS
  SELECT re.ID AS ReportingEntityID, retf.FieldType, retf.LookupListID, retf.LookupList, retf.FieldTitle, props.value AS [Value]
  FROM [dbo].[ReportingEntities] AS re 
  CROSS APPLY OPENJSON(Properties) AS props INNER JOIN
    [dbo].[ReportingEntityTypeFields] AS retf ON re.ReportingEntityTypeID = retf.ReportingEntityTypeID AND props.[key] COLLATE Latin1_General_CI_AS = retf.FieldName
GO
/****** Object:  View [reports].[ReportingEntityChoiceProperties]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ReportingEntityChoiceProperties]
AS
  SELECT rep.ReportingEntityID, rep.FieldTitle, choices.value AS [Value]
  FROM [dbo].[ReportingEntityProperties] AS rep
  OUTER APPLY OPENJSON(rep.Value) AS choices
  WHERE rep.FieldType = 6
GO
/****** Object:  View [reports].[DirectorateUpdatesByReportMonth]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [reports].[DirectorateUpdatesByReportMonth]
AS
SELECT D.ID AS [Directorate ID]
	  ,D.Title AS [Directorate]
      ,G.Title AS [Group]
      ,Months.ReportMonth
	  ,OverallRAG.ReportName AS [Delivery Confidence RAG]
      ,ISNULL(OverallRAG.ID, 0) AS [Delivery Confidence RAG Score]
	  ,FinanceRAG.ReportName AS [Finance RAG]
	  ,ISNULL(FinanceRAG.ID, 0) AS [Finance RAG Score]
	  ,PeopleRAG.ReportName AS [People RAG]
	  ,ISNULL(PeopleRAG.ID, 0) AS [People RAG Score]
	  ,MilestonesRAG.ReportName AS [Milestones RAG]
	  ,ISNULL(MilestonesRAG.ID, 0) AS [Milestones RAG Score]
	  ,MetricsRAG.ReportName AS [Metrics RAG]
	  ,ISNULL(MetricsRAG.ID, 0) AS [Metrics RAG Score]
FROM   dbo.Directorates AS D
CROSS JOIN
	(SELECT DISTINCT
		dbo.SignOffs.ReportMonth
   FROM dbo.SignOffs WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months
LEFT OUTER JOIN
		dbo.SignOffs AS S ON S.DirectorateID = D.ID AND S.ReportMonth = Months.ReportMonth AND S.IsCurrent = 1
LEFT OUTER JOIN  
	    dbo.DirectorateUpdates AS DU ON DU.DirectorateID = S.DirectorateID AND DU.SignOffID = S.ID
LEFT OUTER JOIN
		dbo.Groups AS G ON D.GroupID = G.ID 
LEFT OUTER JOIN
		dbo.RagOptions AS OverallRAG ON DU.OverallRagOptionID = OverallRAG.ID 
LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON DU.FinanceRagOptionID = FinanceRAG.ID 
LEFT OUTER JOIN
        dbo.RagOptions AS PeopleRAG ON DU.PeopleRagOptionID = PeopleRAG.ID 
LEFT OUTER JOIN
        dbo.RagOptions AS MilestonesRAG ON DU.MilestonesRagOptionID = MilestonesRAG.ID 
LEFT OUTER JOIN
        dbo.RagOptions AS MetricsRAG ON DU.MetricsRagOptionID = MetricsRAG.ID
GO
/****** Object:  Table [History].[UserProjects]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[UserProjects](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UserID] [int] NOT NULL,
	[ProjectID] [int] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[IsRiskAdmin] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProjects]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProjects](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UserID] [int] NOT NULL,
	[ProjectID] [int] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
	[IsRiskAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_UserProjects] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_UserProjects] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[UserProjects] )
)
GO
/****** Object:  View [reports].[ProjectUpdatesByReportMonth]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ProjectUpdatesByReportMonth]
AS
SELECT P.ID AS [Project ID]
	  ,P.Title AS [Project]
      ,D.Title AS [Directorate]
	  ,G.Title AS [Group]
      ,Months.ReportMonth
	  ,OverallRAG.ReportName AS [Delivery Confidence RAG]
      ,ISNULL(OverallRAG.ID, 0) AS [Delivery Confidence RAG Score]
	  ,FinanceRAG.ReportName AS [Finance RAG]
	  ,ISNULL(FinanceRAG.ID, 0) AS [Finance RAG Score]
	  ,PeopleRAG.ReportName AS [People RAG]
	  ,ISNULL(PeopleRAG.ID, 0) AS [People RAG Score]
	  ,MilestonesRAG.ReportName AS [Milestones RAG]
	  ,ISNULL(MilestonesRAG.ID, 0) AS [Milestones RAG Score]
	  ,BenefitsRAG.ReportName AS [Benefits RAG]
	  ,ISNULL(BenefitsRAG.ID, 0) AS [Benefits RAG Score]
FROM     dbo.Projects AS P
CROSS JOIN
	(SELECT DISTINCT
		 dbo.SignOffs.ReportMonth            	
	FROM dbo.SignOffs WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months
LEFT OUTER JOIN
		 dbo.SignOffs AS S ON S.ProjectID = P.ID AND S.ReportMonth = Months.ReportMonth AND S.IsCurrent = 1
LEFT OUTER JOIN  
		 dbo.ProjectUpdates AS PU ON PU.ProjectID = S.ProjectID AND PU.SignOffID = S.ID
LEFT OUTER JOIN
		 dbo.Directorates AS D ON P.DirectorateID = D.ID 
LEFT OUTER JOIN
		 dbo.Groups AS G ON D.GroupID = G.ID 
LEFT OUTER JOIN
		 dbo.RagOptions AS OverallRAG ON PU.OverallRagOptionID = OverallRAG.ID 
LEFT OUTER JOIN
		 dbo.RagOptions AS FinanceRAG ON PU.FinanceRagOptionID = FinanceRAG.ID 
LEFT OUTER JOIN
         dbo.RagOptions AS PeopleRAG ON PU.PeopleRagOptionID = PeopleRAG.ID 
LEFT OUTER JOIN
         dbo.RagOptions AS MilestonesRAG ON PU.MilestonesRagOptionID = MilestonesRAG.ID 
LEFT OUTER JOIN
         dbo.RagOptions AS BenefitsRAG ON PU.BenefitsRagOptionID = BenefitsRAG.ID
GO
/****** Object:  View [reports].[RiskTargetRAGs]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[RiskTargetRAGs]
AS
SELECT r.ID AS [Risk ID]
	,CASE tril.Title + '/' + trp.Title 
		WHEN 'Crisis/Very likely' THEN 1 
		WHEN 'Crisis/Likely' THEN 1 
		WHEN 'Crisis/Possible' THEN 1 
		WHEN 'Critical/Very likely' THEN 1 
		WHEN 'Critical/Likely' THEN 1 
		WHEN 'Crisis/Unlikely' THEN 2 
		WHEN 'Crisis/Very Unlikely' THEN 2 
		WHEN 'Critical/Possible' THEN 2 
		WHEN 'Critical/Unlikely' THEN 2 
		WHEN 'Moderate/Very likely' THEN 2 
		WHEN 'Moderate/Likely' THEN 2 
		WHEN 'Moderate/Possible' THEN 2 
		WHEN 'Marginal/Very likely' THEN 4
		WHEN 'Marginal/Likely' THEN 4
		WHEN 'Marginal/Possible' THEN 4
		WHEN 'Moderate/Unlikely' THEN 4
		ELSE 5
	END AS [Target RAG]
FROM dbo.Risks AS r LEFT OUTER JOIN
dbo.RiskProbabilities AS trp ON r.TargetRiskProbabilityID = trp.ID LEFT OUTER JOIN
dbo.RiskImpactLevels AS tril ON r.TargetRiskImpactLevelID = tril.ID
GO
/****** Object:  Table [History].[UserRoles]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[UserRoles](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[ModifiedByUserID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[ModifiedByUserID] [int] NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_UserRoles] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [History].[UserRoles] )
)
GO
/****** Object:  View [reports].[ReportingEntityLookupProperties]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ReportingEntityLookupProperties]
AS
  SELECT rep.ReportingEntityID
  , rep.LookupList
  , rep.FieldTitle
  , CASE rep.LookupListID
  WHEN -1 THEN kwa.Title
  WHEN -2 THEN milestones.Title
  WHEN -3 THEN metrics.Title
  WHEN -4 THEN commitments.Title
  WHEN -5 THEN workStreams.Title
  WHEN -6 THEN milestones.Title
  WHEN -7 THEN benefits.Title
  WHEN -8 THEN dependencies.Title
  WHEN -9 THEN milestones.Title
  WHEN -10 THEN poRisks.Title
  WHEN -11 THEN poRMA.Title
  ELSE re.Title
  END AS [Value]
  FROM [dbo].[ReportingEntityProperties] AS rep LEFT OUTER JOIN
    [dbo].[KeyWorkAreas] AS kwa ON rep.LookupListID = -1 AND rep.[Value] = kwa.ID LEFT OUTER JOIN
    [dbo].[Milestones] AS milestones ON (rep.LookupListID = -2 OR rep.LookupListID = -6 OR rep.LookupListID = -9) AND rep.[Value] = milestones.ID LEFT OUTER JOIN
    [dbo].[Metrics] AS metrics ON rep.LookupListID = -3 AND rep.[Value] = metrics.ID LEFT OUTER JOIN
    [dbo].[Commitments] AS commitments ON rep.LookupListID = -4 AND rep.[Value] = commitments.ID LEFT OUTER JOIN
    [dbo].[WorkStreams] AS workStreams ON rep.LookupListID = -5 AND rep.[Value] = workStreams.ID LEFT OUTER JOIN
    [dbo].[Benefits] AS benefits ON rep.LookupListID = -7 AND rep.[Value] = benefits.ID LEFT OUTER JOIN
    [dbo].[Dependencies] AS dependencies ON rep.LookupListID = -8 AND rep.[Value] = dependencies.ID LEFT OUTER JOIN
    [dbo].[PartnerOrganisationRisks] AS poRisks ON rep.LookupListID = -10 AND rep.[Value] = poRisks.ID LEFT OUTER JOIN
    [dbo].[PartnerOrganisationRiskMitigationActions] AS poRMA ON rep.LookupListID = -11 AND rep.[Value] = poRMA.ID LEFT OUTER JOIN
    [dbo].[ReportingEntities] AS re ON rep.LookupListID = re.ReportingEntityTypeID AND rep.[Value] = re.ID
  WHERE rep.FieldType = 3
GO
/****** Object:  View [reports].[ReportingEntityNumberProperties]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ReportingEntityNumberProperties]
AS
  SELECT re.ID AS ReportingEntityID, retf.FieldType, retf.FieldTitle, props.value AS [Value]
  FROM [dbo].[ReportingEntities] AS re 
  CROSS APPLY OPENJSON(Properties) AS props INNER JOIN
    [dbo].[ReportingEntityTypeFields] AS retf ON re.ReportingEntityTypeID = retf.ReportingEntityTypeID AND props.[key] COLLATE Latin1_General_CI_AS = retf.FieldName
  WHERE retf.FieldType = 4
GO
/****** Object:  View [reports].[ReportingEntityTextProperties]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ReportingEntityTextProperties]
AS
  SELECT re.ID AS ReportingEntityID, retf.FieldType, retf.FieldTitle, props.value AS [Value]
  FROM [dbo].[ReportingEntities] AS re 
  CROSS APPLY OPENJSON(Properties) AS props INNER JOIN
    [dbo].[ReportingEntityTypeFields] AS retf ON re.ReportingEntityTypeID = retf.ReportingEntityTypeID AND props.[key] COLLATE Latin1_General_CI_AS = retf.FieldName
  WHERE retf.FieldType = 1 OR retf.FieldType = 2
GO
/****** Object:  View [reports].[ReportingEntityUpdates]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ReportingEntityUpdates]
AS
  SELECT so.ID AS [Report ID]
    , report.[Group] AS [Group]
    , report.Directorate AS [Directorate]
    , report.Project AS [Project]
    , report.PartnerOrganisation AS [Partner organisation]
    , so.ReportMonth AS [Report period]
    , reportEntityTypes.TypeName AS [Reporting entity type]
    , reportEntities.ReportingEntityID AS [Reporting entity ID]
    , reportEntities.ReportingEntityName AS [Reporting entity]
    , reportEntities.Comment AS [Progress update]
    , reportEntities.Rag AS [Current RAG]
    , reportEntities.RagScore AS [Current RAG score]
    , reportEntities.CurrentPerformance AS [Current performance]
    , CAST(reportEntities.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast delivery date]
    , CAST(reportEntities.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual delivery date]
    , reportEntities.LeadUser AS [Lead]
    , reportEntities.UpdateAuthor AS [Update author]
    , CAST(reportEntities.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last edited date]
    , CASE reportEntities.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Reporting entity closed]
    , reportEntities.EntityStatus AS [Status]
  FROM dbo.SignOffs AS so 
    CROSS APPLY OPENJSON(so.ReportJson, 'lax $')
    WITH (  
      [Group] NVARCHAR(255) '$.Directorate.Group.Title',
      Directorate NVARCHAR(255) '$.Directorate.Title',
      Project NVARCHAR(255) '$.Project.Title',
      PartnerOrganisation NVARCHAR(255) '$.PartnerOrganisation.Title',
      ReportingEntityTypes NVARCHAR(MAX) '$.ReportingEntityTypes' AS JSON
    ) AS report
    CROSS APPLY OPENJSON(report.ReportingEntityTypes) 
    WITH (
      TypeName NVARCHAR(255) '$.Title',
      ReportingEntities NVARCHAR(MAX) '$.ReportingEntities' AS JSON
    ) AS reportEntityTypes 
    CROSS APPLY OPENJSON(reportEntityTypes.ReportingEntities,'$')
    WITH (
      ReportingEntityID INT '$.ID',
      ReportingEntityName NVARCHAR(255) '$.Title',
      LeadUser NVARCHAR(255) '$.LeadUser.Title',
      EntityStatus NVARCHAR(50) '$.EntityStatus.Title',
      UpdateAuthor NVARCHAR(255) '$.ReportingEntityUpdates[0].UpdateUser.Title',
      UpdateDate DATETIME2(7) '$.ReportingEntityUpdates[0].UpdateDate',
      Rag NVARCHAR(2) '$.ReportingEntityUpdates[0].RagOption.ReportName',
      RagScore INT '$.ReportingEntityUpdates[0].RagOption.Score',
      Comment NVARCHAR(1000) '$.ReportingEntityUpdates[0].Comment',
      CurrentPerformance DECIMAL(18, 4) '$.ReportingEntityUpdates[0].CurrentPerformance',
      ForecastDate DATETIME2(7) '$.ReportingEntityUpdates[0].ForecastDate',
      ActualDate DATETIME2(7) '$.ReportingEntityUpdates[0].ActualDate',
      ToBeClosed BIT '$.ReportingEntityUpdates[0].ToBeClosed'
    ) AS reportEntities
  WHERE so.IsCurrent = 1
GO
/****** Object:  View [reports].[DependencyAttributes]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[DependencyAttributes]
AS
  SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.DependencyID AS [Dependency ID]
  FROM dbo.Attributes INNER JOIN
    dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
  WHERE dbo.Attributes.DependencyID IS NOT NULL
GO
/****** Object:  View [reports].[PartnerOrganisationAttributes]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[PartnerOrganisationAttributes]
AS
  SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.PartnerOrganisationID AS [Partner Organisation ID]
  FROM dbo.Attributes INNER JOIN
    dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
  WHERE dbo.Attributes.PartnerOrganisationID IS NOT NULL
GO
/****** Object:  View [reports].[PartnerOrganisationRiskMitigationActionAttributes]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[PartnerOrganisationRiskMitigationActionAttributes]
AS
  SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.PartnerOrganisationRiskMitigationActionID AS [Partner Organisation Risk Mitigating Action ID]
  FROM dbo.Attributes INNER JOIN
    dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
  WHERE dbo.Attributes.PartnerOrganisationRiskMitigationActionID IS NOT NULL
GO
/****** Object:  View [reports].[ReportingEntityAttributes]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ReportingEntityAttributes]
AS
  SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.ReportingEntityID AS [Reporting Entity ID]
  FROM dbo.Attributes INNER JOIN
    dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
  WHERE dbo.Attributes.ReportingEntityID IS NOT NULL
GO
/****** Object:  View [reports].[RiskMitigationActionAttributes]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[RiskMitigationActionAttributes]
AS
  SELECT dbo.Attributes.ID AS [Attribute ID]
		, dbo.AttributeTypes.Title AS [Attribute]
		, dbo.Attributes.AttributeValue AS [Attribute Value]
		, dbo.Attributes.RiskMitigationActionID AS [Risk Mitigating Action ID]
  FROM dbo.Attributes INNER JOIN
    dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
  WHERE dbo.Attributes.RiskMitigationActionID IS NOT NULL
GO
/****** Object:  View [reports].[PartnerOrganisationUpdates]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[PartnerOrganisationUpdates]
AS
    SELECT grp.Title AS [Group]
        , dr.Title AS [Directorate]
		, po.Title AS [Partner Organisation] 
		, po.ID AS [ID]
		, Months.ReportMonth AS [Report Month]
		, us.Title AS [Director]
        , lps.Title AS [Lead Policy Sponsor]
        , ra.Title AS [Author]
		, sou.Title AS [Signed-off by]
		, pou.SignOffID AS [SignOff ID]
		, CAST(sinof.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Date Signed-off]
		, CAST(pou.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, po.Objectives AS [Objectives]
		, pou.ProgressUpdate AS [Delivery Confidence Update]
		, pou.FutureActions AS [Future Actions Update]
		, pou.Escalations AS [Escalations Update]
		, es.Title AS [Status]
        , CASE po.ReportingFrequency 
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
        , CASE po.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(po.ReportingStartDate)
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(po.ReportingStartDate)
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(po.ReportingStartDate)
                WHEN 1 THEN 'Jan' 
                WHEN 2 THEN 'Feb' 
                WHEN 3 THEN 'Mar' 
                WHEN 4 THEN 'Apr' 
                WHEN 5 THEN 'May' 
                WHEN 6 THEN 'Jun' 
                WHEN 7 THEN 'Jul' 
                WHEN 8 THEN 'Aug' 
                WHEN 9 THEN 'Sep' 
                WHEN 10 THEN 'Oct' 
                WHEN 11 THEN 'Nov' 
                WHEN 12 THEN 'Dec' 
                ELSE '' 
            END 
        END AS [Reporting Schedule]
      
        /* RAGs */
		, PrevPOU.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, PrevPOU.PreviousFinanceRAG AS [Previous Finance RAG]
		, PrevPOU.PreviousKeyPerformanceIndicatorRAG AS [Previous Key Performance Indicators RAG]
		, PrevPOU.PreviousPeopleRAG AS [Previous Milestones RAG]
		, PrevPOU.PreviousMilestonesRAG AS [Previous People RAG]

		, PrevPOU.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score] 
		, PrevPOU.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, PrevPOU.PreviousKeyPerformanceIndicatorScore AS [Previous Key Performance Indicators RAG Score]
		, PrevPOU.PreviousPeopleRAGScore AS [Previous Milestones RAG Score]
		, PrevPOU.PreviousMilestonesRAGScore As [Previous People RAG Score]

		, dcRag.ReportName AS [Delivery Confidence RAG]
		, fiRag.ReportName AS [Finance RAG]
		, kpiRag.ReportName AS [Key Performance Indicators RAG]
		, mileRag.ReportName AS [Milestones RAG]
		, pplRag.ReportName AS [People RAG]

		, dcRag.Score AS [Delivery Confidence RAG Score] 
		, fiRag.Score AS [Finance RAG Score]
		, kpiRag.Score AS [Key Performance Indicators RAG Score]
		, mileRag.Score AS [Milestones RAG Score]
		, pplRag.Score As [People RAG Score]

		, pou.FinanceComment AS [Finance Update]
		, pou.KPIComment AS [Key Performance Indicators Update]
		, pou.MilestonesComment AS [Milestones Update]
		, pou.PeopleComment AS [People Update]
       
		, (dcRag.Score - PrevPOU.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (fiRag.Score - PrevPOU.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (kpiRag.Score - PrevPOU.PreviousKeyPerformanceIndicatorScore) AS [Key Performance Indicator RAG Change]
		, (pplRag.Score - PrevPOU.PreviousPeopleRAGScore) AS [People RAG Change]
		, (mileRag.Score - PrevPOU.PreviousMilestonesRAGScore) AS [Milestones RAG Change]

    FROM dbo.PartnerOrganisations po CROSS JOIN
    (SELECT DISTINCT dbo.SignOffs.ReportMonth
        FROM dbo.SignOffs
        WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months LEFT OUTER JOIN
        dbo.SignOffs sinof ON sinof.PartnerOrganisationID = po.ID AND sinof.ReportMonth = Months.ReportMonth AND sinof.IsCurrent = 1 LEFT OUTER JOIN
        dbo.PartnerOrganisationUpdates pou ON sinof.ID = pou.SignOffID INNER JOIN
        dbo.Directorates dr ON po.DirectorateID = dr.ID LEFT OUTER JOIN
        dbo.Groups grp ON dr.GroupID = grp.ID LEFT OUTER JOIN
        dbo.EntityStatuses AS es ON po.EntityStatusID = es.ID LEFT OUTER JOIN
        /* Users */
        dbo.Users lps ON po.LeadPolicySponsorUserID = lps.ID LEFT OUTER JOIN
        dbo.Users ra ON po.ReportAuthorUserID = ra.ID LEFT OUTER JOIN
        dbo.Users sou ON sinof.SignOffUserID = sou.ID LEFT OUTER JOIN
        dbo.Users us ON dr.DirectorUserID = us.ID LEFT OUTER JOIN
        /* RAGs */
        dbo.RagOptions AS dcRag ON pou.OverallRagOptionID = dcRag.ID LEFT OUTER JOIN
        dbo.RagOptions AS fiRag ON pou.FinanceRagOptionID = fiRag.ID LEFT OUTER JOIN
        dbo.RagOptions AS kpiRag ON pou.KPIRagOptionID = kpiRag.ID LEFT OUTER JOIN
        dbo.RagOptions AS mileRag ON pou.MilestonesRagOptionID = mileRag.ID LEFT OUTER JOIN
        dbo.RagOptions AS pplRag ON pou.PeopleRagOptionID = pplRag.ID LEFT OUTER JOIN
        dbo.PreviousPartnerOrganisationUpdates AS PrevPOU ON po.ID =PrevPOU.PartnerOrganisationID AND sinof.ReportMonth = PrevPOU.NextMonth;
GO
/****** Object:  View [reports].[PartnerOrganisationRisks]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[PartnerOrganisationRisks]
AS 
WITH RiskTypesForRisk AS
(SELECT por.ID AS PartnerOrganisationRiskID, STRING_AGG(rt.Title, ',') WITHIN GROUP (ORDER BY rt.Title) AS RiskTypes
FROM dbo.PartnerOrganisationRisks por
JOIN dbo.PartnerOrganisationRiskRiskTypes porrt ON porrt.PartnerOrganisationRiskID = por.ID
JOIN dbo.RiskTypes rt ON rt.ID = porrt.RiskTypeID
GROUP BY por.id
)
SELECT do.Title AS [Departmental Objective]
        ,po.Title AS [Partner Organisation]
        ,d.Title AS [Directorate]
        ,g.Title AS [Group]
        ,beisra.Title AS [BEIS Risk Appetite] 
        ,pora.Title AS [Partner Organisation Risk Appetite] 
        ,por.RiskCauseDescription AS [Risk Description (cause)]
        ,por.RiskEventDescription AS [Risk Description (event)]
        ,por.RiskImpactDescription AS [Risk Description (impact)]
        ,por.ID AS [Risk ID]
        ,por.RiskCode AS [Risk ID (user)]
        ,por.Title AS [Risk Name]
		,poRiskTypes.RiskTypes AS [Risk Type] 
        ,beisusr.Title AS [BEIS Risk Owner]
        ,pousr.Title AS [Partner Organisation Risk Owner]
        ,es.Title AS [Status]
        
        ,beisTIL.Title AS [BEIS Target Impact]
        ,poTIL.Title AS [Partner Organisation Target Impact]
        
        ,beisTrp.Title AS [BEIS Target Probability]
        ,poTrp.Title AS [Partner Organisation Target Probability]

		,OverallBeisTrp.RAGReportName AS [BEIS Target RAG]
		,OverallTrp.RAGReportName AS [Partner Organisation RAG] 
       	,OverallBeisTrp.RAGScore AS [BEIS Target RAG Score]
		,OverallTrp.RAGScore AS [Partner Organisation Target RAG Score]

        ,beisUril.Title AS [BEIS Unmitigated Impact]
        ,poUril.Title AS [Partner Organisation Unmitigated Impact]

        ,beisUrp.Title AS [BEIS Unmitigated Probability]
        ,poUrp.Title AS [Partner Organisation Unmitigated Probability]

		,OverallBeisUrp.RAGReportName AS [BEIS Unmitigated RAG]
		,OverallUrp.RAGReportName AS [Partner Organisation Unmitigated RAG]
		,OverallBeisUrp.RAGScore AS [BEIS Unmitigated RAG Score] 
		,OverallUrp.RAGScore AS [Partner Organisation Unmitigated RAG Score] 

		,CAST(por.RiskProximity AS DATE) AS [Risk Proximity]

FROM dbo.PartnerOrganisationRisks por LEFT OUTER JOIN
    dbo.PartnerOrganisations po On por.PartnerOrganisationID = po.ID LEFT OUTER JOIN
    dbo.Directorates d ON po.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.DepartmentalObjectives do ON por.DepartmentalObjectiveID = do.ID LEFT OUTER JOIN
    dbo.RiskAppetites beisra ON por.BEISRiskAppetiteID = beisra.ID LEFT OUTER JOIN
    dbo.RiskAppetites pora ON por.RiskAppetiteID = pora.ID LEFT OUTER JOIN
    dbo.Users beisusr ON por.BEISRiskOwnerUserID = beisusr.ID  LEFT OUTER JOIN
    dbo.Users pousr ON por.RiskOwnerUserID = pousr.ID LEFT OUTER JOIN
    dbo.EntityStatuses es ON por.EntityStatusID = es.ID LEFT OUTER JOIN
   
    dbo.RiskImpactLevels beisTil ON por.BEISTargetRiskImpactLevelID = beisTil.ID LEFT OUTER JOIN
    dbo.RiskImpactLevels poTil ON por.TargetRiskImpactLevelID = poTil.ID LEFT OUTER JOIN

	dbo.RiskProbabilities beisTrp ON por.BEISTargetRiskProbabilityID = beisTrp.ID LEFT OUTER JOIN
	dbo.RiskProbabilities poTrp ON por.TargetRiskProbabilityID = poTrp.ID LEFT OUTER JOIN

	dbo.RiskImpactLevels beisUril ON por.BEISUnmitigatedRiskImpactLevelID = beisUril.ID LEFT OUTER JOIN
	dbo.RiskImpactLevels poURil ON por.UnmitigatedRiskImpactLevelID = poUril.ID LEFT OUTER JOIN

	dbo.RiskProbabilities beisUrp ON por.BEISUnmitigatedRiskProbabilityID = beisUrp.ID LEFT OUTER JOIN
	dbo.RiskProbabilities poUrp ON por.UnmitigatedRiskProbabilityID = poUrp.ID LEFT OUTER JOIN

	reports.RagFromRILandRP OverallBeisUrp ON por.BEISUnmitigatedRiskProbabilityID = OverallBeisUrp.RPID and por.BEISUnmitigatedRiskImpactLevelID = OverallBeisUrp.RILID LEFT OUTER JOIN
	reports.RagFromRILandRP OverallBeisTrp ON por.BEISTargetRiskProbabilityID = OverallBeisTrp.RPID and por.BEISTargetRiskImpactLevelID = OverallBeisTrp.RILID LEFT OUTER JOIN

	reports.RagFromRILandRP OverallUrp ON por.UnmitigatedRiskProbabilityID = OverallUrp.RPID and por.UnmitigatedRiskImpactLevelID = OverallUrp.RILID LEFT OUTER JOIN
	reports.RagFromRILandRP OverallTrp ON por.TargetRiskProbabilityID = OverallTrp.RPID and por.TargetRiskImpactLevelID = OverallTrp.RILID LEFT OUTER JOIN
	dbo.PartnerOrganisationRiskRiskTypes AS riskrt ON por.ID = riskrt.PartnerOrganisationRiskID LEFT OUTER JOIN 
	RiskTypesForRisk AS poRiskTypes ON por.ID = poRiskTypes.PartnerOrganisationRiskID
GO
/****** Object:  View [reports].[PartnerOrganisationRisksMitigationActions]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[PartnerOrganisationRisksMitigationActions]
AS
WITH RiskTypesForRisk AS
(SELECT por.ID AS PartnerOrganisationRiskID, STRING_AGG(rt.Title, ',') WITHIN GROUP (ORDER BY rt.Title) AS RiskTypes
FROM dbo.PartnerOrganisationRisks por
JOIN dbo.PartnerOrganisationRiskRiskTypes porrt ON porrt.PartnerOrganisationRiskID = por.ID
JOIN dbo.RiskTypes rt ON rt.ID = porrt.RiskTypeID
GROUP BY por.id
)
SELECT 
    po.Title AS [Partner Organisation]	 
	,por.Title AS [Risk Name]
	,poRiskTypes.RiskTypes AS [Risk Type] 
    ,porma.Title AS [Risk Mitigation]
    ,porma.Description AS [Description]
    ,ownr.Title AS [Mitigating Action Owner]
    ,(SELECT STRING_AGG(cusr.Title, ', ') FROM dbo.Contributors c LEFT OUTER JOIN
    dbo.Users cusr ON cusr.ID = c.ContributorUserID
     WHERE PartnerOrganisationRiskMitigationActionID = porma.ID ) AS [Contributors]
	,ISNULL(porma.ActualDate, porma.ForecastDate) AS [Delivery date]
    ,CASE
		WHEN porma.ActionIsOngoing = 'true' THEN 'Yes'
		ELSE 'No'
	 END AS [Ongoing Action]
FROM dbo.PartnerOrganisationRiskMitigationActions porma LEFT OUTER JOIN
    dbo.PartnerOrganisationRisks por ON porma.PartnerOrganisationRiskID = por.ID LEFT OUTER JOIN
	dbo.PartnerOrganisations po ON po.ID = por.PartnerOrganisationID LEFT OUTER JOIN
    dbo.Users ownr ON porma.OwnerUserID = ownr.ID LEFT OUTER JOIN
    RiskTypesForRisk AS poRiskTypes ON por.ID = poRiskTypes.PartnerOrganisationRiskID
GO
/****** Object:  View [reports].[PartnerOrganisationRiskUpdates]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[PartnerOrganisationRiskUpdates]
AS
WITH RiskTypesForRisk AS
(SELECT por.ID AS PartnerOrganisationRiskID, STRING_AGG(rt.Title, ',') WITHIN GROUP (ORDER BY rt.Title) AS RiskTypes
FROM dbo.PartnerOrganisationRisks por
JOIN dbo.PartnerOrganisationRiskRiskTypes porrt ON porrt.PartnerOrganisationRiskID = por.ID
JOIN dbo.RiskTypes rt ON rt.ID = porrt.RiskTypeID
GROUP BY por.id
)
SELECT u.Title AS [Author]
		,dir.Title AS [Directorate] 
		,gr.Title AS [Group]
		,poru.SignOffID AS [SignOff ID]
	,CAST(poru.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
	,CASE poru.ToBeClosed WHEN 1 THEN poru.Comment ELSE NULL END AS [Closure Comment]

	,beisRil.Title AS [BEIS Impact level]
	,poRil.Title AS [Partner Organisation Impact Level]
	
	,beisRp.Title AS [BEIS Probability]
	,poRp.Title AS [Partner Organisation Probability] 
	,OverallBeisRp.RAGReportName AS [BEIS RAG]
	,OverallBeisRp.RAGScore AS [BEIS RAG Score]
	
	,OverallRp.RAGReportName AS [Partner Organisation RAG]
	,OverallRp.RAGScore AS [Partner Organisation RAG Score] 
	   
	,poru.UpdatePeriod AS [Report Month]

	,poru.PartnerOrganisationRiskID AS [Risk ID]
	,por.RiskCode AS [Risk ID (user)]
	,poru.Title AS [Risk Name]
	,poRiskTypes.RiskTypes AS [Risk Type]
	,poru.ID AS [Risk Update ID]
		
	,beisTIL.Title AS [BEIS Target Impact]
	,poTIL.Title AS [Partner Organisation Target Impact]
		
	,beisTrp.Title AS [BEIS Target Probability]
	,poTrp.Title AS [Partner Organisation Target Probability]
	
	,OverallBeisTrp.RAGReportName AS [BEIS Target RAG]
	,OverallTrp.RAGReportName AS [Partner Organisation Target RAG]

    ,RisksLastMonth.ProbabilityBEIS AS [BEIS Previous Probability]
	,RisksLastMonth.[Impact levelBEIS] AS [BEIS Previous Impact Level]
    ,RisksLastMonth.RAGBEIS AS [BEIS Previous RAG]
	,RisksLastMonth.BeisRagScore AS [BEIS Previous RAG Score]
	,(OverallBEISRp.RAGScore- RisksLastMonth.BeisRagScore) AS [BEIS RAG Change]

	,RisksLastMonth.ProbabilityPO AS [Partner Organisation Previous Probability]
	,RisksLastMonth.[Impact levelPO] AS [Partner Organisation Previous Impact Level]
    ,RisksLastMonth.RAGPO AS [Partner Organisation Previous RAG]
	,RisksLastMonth.RAGScore AS [Partner Organisation Previous RAG Score]
	,(OverallRp.RAGScore- RisksLastMonth.RAGScore) AS [Partner Organisation RAG Change]

	,CASE poru.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [To be closed]

	,CAST(poru.RiskProximity AS DATE) AS [Risk Proximity]
	,es.Title AS [Status] 

FROM dbo.PartnerOrganisationRiskUpdates poru  LEFT OUTER JOIN
	dbo.PartnerOrganisationRisks por ON poru.PartnerOrganisationRiskID = por.ID LEFT OUTER JOIN
	dbo.Users u ON poru.UpdateUserID = u.ID LEFT OUTER JOIN
	dbo.PartnerOrganisations AS po ON por.PartnerOrganisationID = po.ID LEFT OUTER JOIN
	dbo.Directorates AS dir ON po.DirectorateID = dir.ID LEFT OUTER JOIN
	dbo.Groups AS gr ON dir.GroupID = gr.ID LEFT OUTER JOIN
	dbo.EntityStatuses AS es ON por.EntityStatusID = es.ID LEFT OUTER JOIN
	RiskTypesForRisk AS poRiskTypes ON por.ID = poRiskTypes.PartnerOrganisationRiskID LEFT OUTER JOIN

	dbo.RiskImpactLevels beisRil ON poru.BeisRiskImpactLevelID = beisRil.ID LEFT OUTER JOIN
	dbo.RiskImpactLevels poRil ON poru.RiskImpactLevelID = poRil.ID LEFT OUTER JOIN
	
	dbo.RiskProbabilities beisRp ON poru.BeisRiskProbabilityID = beisRp.ID LEFT OUTER JOIN
	dbo.RiskProbabilities poRp ON poru.RiskProbabilityID = poRp.ID LEFT OUTER JOIN

	dbo.RiskImpactLevels beisTil ON por.BEISTargetRiskImpactLevelID = beisTil.ID LEFT OUTER JOIN
    dbo.RiskImpactLevels poTil ON por.TargetRiskImpactLevelID = poTil.ID LEFT OUTER JOIN

	dbo.RiskProbabilities beisTrp ON por.BEISTargetRiskProbabilityID = beisTrp.ID LEFT OUTER JOIN
	dbo.RiskProbabilities poTrp ON por.TargetRiskProbabilityID = poTrp.ID  LEFT OUTER JOIN

	reports.RagFromRILandRP OverallBeisRp ON poru.BeisRiskProbabilityID = OverallBeisRp.RPID and poru.BeisRiskImpactLevelID = OverallBeisRp.RILID LEFT OUTER JOIN
	reports.RagFromRILandRP OverallBeisTrp ON por.BEISTargetRiskProbabilityID = OverallBeisTrp.RPID and por.BEISTargetRiskImpactLevelID = OverallBeisTrp.RILID LEFT OUTER JOIN

	reports.RagFromRILandRP OverallRp ON poru.RiskProbabilityID = OverallRp.RPID and poru.RiskImpactLevelID = OverallRp.RILID LEFT OUTER JOIN
	reports.RagFromRILandRP OverallTrp ON por.TargetRiskProbabilityID = OverallTrp.RPID and por.TargetRiskImpactLevelID = OverallTrp.RILID  LEFT OUTER JOIN

	(SELECT	poru2.PartnerOrganisationRiskID AS [RiskID]
			,EOMONTH(DATEADD(month, 1, poru2.UpdatePeriod)) AS [NextMonth]
			,roBEIS.RAGReportName AS [RAGBEIS]
			,rpBEIS.Title AS [ProbabilityBEIS]
			,rilBEIS.Title AS [Impact levelBEIS]
			,roBEIS.RAGScore AS [BeisRagScore] 
			,roPO.RAGReportName AS [RAGPO]
			,roPO.RAGScore AS [RAGScore]
			,rpPO.Title AS [ProbabilityPO]
			,rilPO.Title AS [Impact levelPO]
	FROM    dbo.PartnerOrganisationRiskUpdates poru2 LEFT OUTER JOIN
			reports.RagFromRILandRP roBEIS ON roBEIS.RILID = poru2.BeisRiskImpactLevelID AND roBEIS.RPID = poru2.BeisRiskProbabilityID LEFT OUTER JOIN
			dbo.RiskProbabilities rpBEIS ON poru2.BEISRiskProbabilityID = rpBEIS.ID LEFT OUTER JOIN
			dbo.RiskImpactLevels rilBEIS ON poru2.BEISRiskImpactLevelID = rilBEIS.ID  LEFT OUTER JOIN

			reports.RagFromRILandRP roPO ON roPO.RILID = poru2.RiskImpactLevelID AND roPO.RPID = poru2.RiskProbabilityID LEFT OUTER JOIN
			dbo.RiskProbabilities rpPO ON poru2.RiskProbabilityID = rpPO.ID LEFT OUTER JOIN
			dbo.RiskImpactLevels rilPO ON poru2.RiskImpactLevelID = rilPO.ID
		WHERE poru2.IsCurrent = 1)  RisksLastMonth ON poru.PartnerOrganisationRiskID = RisksLastMonth.RiskID AND poru.UpdatePeriod = RisksLastMonth.NextMonth
WHERE
	poru.IsCurrent = 1
GO
/****** Object:  View [reports].[PartnerOrganisationRiskMitigationActionUpdates]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[PartnerOrganisationRiskMitigationActionUpdates]
AS
WITH RiskTypesForRisk AS
(SELECT por.ID AS PartnerOrganisationRiskID, STRING_AGG(rt.Title, ',') WITHIN GROUP (ORDER BY rt.Title) AS RiskTypes
FROM dbo.PartnerOrganisationRisks por
JOIN dbo.PartnerOrganisationRiskRiskTypes porrt ON porrt.PartnerOrganisationRiskID = por.ID
JOIN dbo.RiskTypes rt ON rt.ID = porrt.RiskTypeID
GROUP BY por.id
)
SELECT rmau.ID AS [Risk Mitigation Action Update ID]
	,po.Title AS [Partner Organisation]
	,dir.Title AS [Directorate] 
	,gr.Title AS [Group] 
	,r.ID AS [Risk ID]
	,rma.ID AS [Risk Mitigation Action ID]
	,r.Title AS [Risk Name]
	,poRiskTypes.RiskTypes AS [Risk Type] 
	,rma.Title AS [Mitigation Action]
	,rmau.SignOffID AS [SignOff ID] 
	,rma.Description AS [Description]
	,ISNULL(rma.ActualDate, rma.ForecastDate) AS [Delivery Date]
	,CASE
		WHEN rma.ActionIsOngoing = 'true' THEN 'Yes'
		ELSE 'No'
	 END AS [Is ongoing]
	,rmao.Title AS [Action Owner]
	,rmau.UpdatePeriod AS [Report Month]
	,ro.ReportName AS [RAG Status]
	,ro.Score AS [RAG Score]
	,PartnerOrganisationRiskMitigationActionsLastMonth.[RAG Status] AS [Previous RAG Status]
	,PartnerOrganisationRiskMitigationActionsLastMonth.[RAG Score] AS [Previous RAG Score] 
	,(ro.Score - PartnerOrganisationRiskMitigationActionsLastMonth.[RAG Score]) AS [RAG Change] 
	,rmau.Comment AS [Progress]
	,rmauu.Title AS [Last Updated by]
	,es.Title AS [Status]
	,CAST(ru.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date] 

FROM dbo.PartnerOrganisationRiskMitigationActionUpdates rmau LEFT OUTER JOIN
	dbo.PartnerOrganisationRiskUpdates AS ru ON ru.SignOffID = rmau.SignOffID LEFT OUTER JOIN
	dbo.PartnerOrganisationRiskMitigationActions rma ON rmau.PartnerOrganisationRiskMitigationActionID = rma.ID LEFT OUTER JOIN
	dbo.PartnerOrganisationRisks r ON r.ID = rma.PartnerOrganisationRiskID LEFT OUTER JOIN
	dbo.PartnerOrganisations po ON r.PartnerOrganisationID = po.ID LEFT OUTER JOIN
	dbo.Directorates AS dir ON po.DirectorateID = dir.ID LEFT OUTER JOIN
	dbo.Groups AS gr ON dir.GroupID = gr.ID LEFT OUTER JOIN
	dbo.Users rmao ON rmao.ID = rma.OwnerUserID LEFT OUTER JOIN
	dbo.Users rmauu ON rmauu.ID = rmau.UpdateUserID LEFT OUTER JOIN
	dbo.EntityStatuses es ON es.ID = rma.EntityStatusID LEFT OUTER JOIN
	dbo.RagOptions ro ON ro.ID = rmau.RagOptionID LEFT OUTER JOIN
	RiskTypesForRisk AS poRiskTypes ON r.ID = poRiskTypes.PartnerOrganisationRiskID LEFT OUTER JOIN
	(SELECT	rmau.PartnerOrganisationRiskMitigationActionID AS [PartnerOrganisationRiskMitigationActionID]
		,EOMONTH(DATEADD(MONTH, 1, rmau.UpdatePeriod)) AS [NextMonth]
		,ro.ReportName AS [RAG status]
		,ro.Score AS [RAG Score]
	FROM dbo.PartnerOrganisationRiskMitigationActionUpdates AS rmau LEFT OUTER JOIN
		dbo.PartnerOrganisationRiskUpdates AS ru ON ru.SignOffID = rmau.SignOffID LEFT OUTER JOIN
		dbo.PartnerOrganisationRiskMitigationActions AS rma ON rma.ID = rmau.PartnerOrganisationRiskMitigationActionID LEFT OUTER JOIN
		dbo.RagOptions ro ON ro.ID = rmau.RagOptionID
	WHERE ru.IsCurrent = 1) AS PartnerOrganisationRiskMitigationActionsLastMonth ON rmau.PartnerOrganisationRiskMitigationActionID = PartnerOrganisationRiskMitigationActionsLastMonth.PartnerOrganisationRiskMitigationActionID 
	AND rmau.UpdatePeriod = PartnerOrganisationRiskMitigationActionsLastMonth.NextMonth
WHERE
	ru.IsCurrent = 1
GO
/****** Object:  View [reports].[ReportingEntityUserProperties]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ReportingEntityUserProperties]
AS
  SELECT rep.ReportingEntityID, rep.FieldTitle, u.Title AS [User]
  FROM [dbo].[ReportingEntityProperties] AS rep
  OUTER APPLY OPENJSON(rep.Value) AS users INNER JOIN
    [dbo].[Users] AS u ON users.value = u.ID
  WHERE rep.FieldType = 5
GO
/****** Object:  View [reports].[ProjectUpdates]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ProjectUpdates]
AS
	SELECT dbo.Groups.Title AS [Group]
		, dbo.Directorates.Title AS [Directorate]
		, dbo.Projects.Title AS [Project]
		, dbo.Projects.ID AS [ID]
		, Months.ReportMonth AS [Report Month]
		, SROUser.Title AS [SRO]
		, ProjectManagerUser.Title AS [Project Manager]
		, UpdateAuthor.Title AS [Author]
		, SignOffUser.Title AS [Signed-off by]
		, dbo.SignOffs.ID AS [SignOff ID]
		, CAST(dbo.SignOffs.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Date Signed-off]
		, CAST(ProjectUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, dbo.Projects.Objectives AS [Objectives]
		, ProjectUpdates.ProgressUpdate AS [Delivery Confidence Update]
		, ProjectUpdates.FutureActions AS [Future Actions Update]
		, ProjectUpdates.Escalations AS [Escalations Update]
		, dbo.ProjectPhases.Title AS [Current Phase]
		, dbo.ProjectBusinessCaseTypes.Title AS [Latest approved business case type]
		, CAST(ProjectUpdates.BusinessCaseDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Business Case Approval Date]
		, ProjectUpdates.WholeLifeCost AS [Whole Life Cost £m]
		, ProjectUpdates.WholeLifeBenefit AS [Whole Life Benefit £m]
		, ProjectUpdates.NetPresentValue AS [Net Present Value £m]
		, es.Title AS [Status] 

		, PrevUpdate.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, PrevUpdate.PreviousFinanceRAG AS [Previous Finance RAG]
		, PrevUpdate.PreviousMilestonesRAG AS [Previous Milestones RAG]
		, PrevUpdate.PreviousBenefitsRAG AS [Previous Benefits RAG]
		, PrevUpdate.PreviousPeopleRAG AS [Previous People RAG]
	
		, PrevUpdate.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score]
		, PrevUpdate.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, PrevUpdate.PreviousMilestonesRAGScore AS [Previous Milestones RAG Score]
		, PrevUpdate.PreviousBenefitsRAGScore AS [Previous Benefits RAG Score]
		, PrevUpdate.PreviousPeopleRAGScore AS [Previous People RAG Score]

		, OverallRAG.ReportName AS [Delivery Confidence RAG]
		, FinanceRAG.ReportName AS [Finance RAG]
		, MilestonesRAG.ReportName AS [Milestones RAG]
		, BenefitsRAG.ReportName AS [Benefits RAG]
		, PeopleRAG.ReportName AS [People RAG]
	
		, OverallRAG.Score AS [Delivery Confidence RAG Score]
		, FinanceRAG.Score AS [Finance RAG Score]
		, MilestonesRAG.Score AS [Milestones RAG Score]
		, BenefitsRAG.Score AS [Benefits RAG Score]
		, PeopleRAG.Score AS [People RAG Score]

		, ProjectUpdates.FinanceComment AS [Finance Update]
		, ProjectUpdates.MilestonesComment AS [Milestones Update]
		, ProjectUpdates.BenefitsComment AS [Benefits Update]
		, ProjectUpdates.PeopleComment AS [People Update]

		, (OverallRAG.Score - PrevUpdate.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (FinanceRAG.Score - PrevUpdate.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (MilestonesRAG.Score - PrevUpdate.PreviousMilestonesRAGScore) AS [Milestones RAG Change]
		, (BenefitsRAG.Score - PrevUpdate.PreviousBenefitsRAGScore) AS [Benefits RAG Change]
		, (PeopleRAG.Score - PrevUpdate.PreviousPeopleRAGScore) AS [People RAG Change]

	FROM dbo.Projects CROSS JOIN
           (SELECT DISTINCT dbo.SignOffs.ReportMonth
		FROM dbo.SignOffs
		WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months LEFT OUTER JOIN
		dbo.SignOffs ON dbo.SignOffs.ProjectID = dbo.Projects.ID AND dbo.SignOffs.ReportMonth = Months.ReportMonth AND dbo.SignOffs.IsCurrent = 1 LEFT OUTER JOIN
		dbo.ProjectUpdates AS ProjectUpdates ON dbo.SignOffs.ID = ProjectUpdates.SignOffID LEFT OUTER JOIN
		dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON dbo.Projects.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.RagOptions AS OverallRAG ON ProjectUpdates.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON ProjectUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON ProjectUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON ProjectUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS BenefitsRAG ON ProjectUpdates.BenefitsRagOptionID = BenefitsRAG.ID LEFT OUTER JOIN
		dbo.Users AS SROUser ON dbo.Projects.SeniorResponsibleOwnerUserID = SROUser.ID LEFT OUTER JOIN
		dbo.Users AS ProjectManagerUser ON dbo.Projects.ProjectManagerUserID = ProjectManagerUser.ID LEFT OUTER JOIN
		dbo.Users AS SignOffUser ON dbo.SignOffs.SignOffUserID = SignOffUser.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON ProjectUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.ProjectPhases ON ProjectUpdates.ProjectPhaseID = dbo.ProjectPhases.ID LEFT OUTER JOIN
		dbo.ProjectBusinessCaseTypes ON ProjectUpdates.BusinessCaseTypeID = dbo.ProjectBusinessCaseTypes.ID LEFT OUTER JOIN
		dbo.PreviousProjectUpdates AS PrevUpdate ON dbo.Projects.ID = PrevUpdate.ProjectID AND Months.ReportMonth = PrevUpdate.NextMonth
GO
/****** Object:  View [reports].[SignedOffDirectorateReports]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[SignedOffDirectorateReports] AS
SELECT d.Title AS [Directorate]
		,CAST(s.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [This month]
		,u.Title AS [This month signed off by]
		,CAST(s1.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last month]
		,u1.Title AS [Last month signed off by]
		,CAST(s2.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [2 months ago]
		,u2.Title AS [2 months ago signed off by]
		,CAST(s3.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [3 months ago]
		,u3.Title AS [3 months ago signed off by]
FROM [dbo].[Directorates] AS d
	LEFT OUTER JOIN [dbo].[SignOffs] AS s ON d.ID = s.DirectorateID AND s.IsCurrent = 1 AND s.ReportMonth = EOMONTH(GETDATE())
	LEFT OUTER JOIN [dbo].[Users] AS u ON s.SignOffUserID = u.ID
	LEFT OUTER JOIN [dbo].[SignOffs] AS s1 ON d.ID = s1.DirectorateID AND s1.IsCurrent = 1 AND s1.ReportMonth = EOMONTH(DATEADD(m,-1,GETDATE()))
	LEFT OUTER JOIN [dbo].[Users] AS u1 ON s1.SignOffUserID = u1.ID
	LEFT OUTER JOIN [dbo].[SignOffs] AS s2 ON d.ID = s2.DirectorateID AND s2.IsCurrent = 1 AND s2.ReportMonth = EOMONTH(DATEADD(m,-2,GETDATE()))
	LEFT OUTER JOIN [dbo].[Users] AS u2 ON s2.SignOffUserID = u2.ID
	LEFT OUTER JOIN [dbo].[SignOffs] AS s3 ON d.ID = s3.DirectorateID AND s3.IsCurrent = 1 AND s3.ReportMonth = EOMONTH(DATEADD(m,-3,GETDATE()))
	LEFT OUTER JOIN [dbo].[Users] AS u3 ON s3.SignOffUserID = u3.ID
GO
/****** Object:  View [reports].[SignedOffProjectReports]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[SignedOffProjectReports] AS
SELECT p.Title AS [Project]
		,CAST(s.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [This month]
		,u.Title AS [This month signed off by]
		,CAST(s1.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last month]
		,u1.Title AS [Last month signed off by]
		,CAST(s2.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [2 months ago]
		,u2.Title AS [2 months ago signed off by]
		,CAST(s3.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [3 months ago]
		,u3.Title AS [3 months ago signed off by]
FROM [dbo].[Projects] AS p
	LEFT OUTER JOIN [dbo].[SignOffs] AS s ON p.ID = s.ProjectID AND s.IsCurrent = 1 AND s.ReportMonth = EOMONTH(GETDATE())
	LEFT OUTER JOIN [dbo].[Users] AS u ON s.SignOffUserID = u.ID
	LEFT OUTER JOIN [dbo].[SignOffs] AS s1 ON p.ID = s1.ProjectID AND s1.IsCurrent = 1 AND s1.ReportMonth = EOMONTH(DATEADD(m,-1,GETDATE()))
	LEFT OUTER JOIN [dbo].[Users] AS u1 ON s1.SignOffUserID = u1.ID
	LEFT OUTER JOIN [dbo].[SignOffs] AS s2 ON p.ID = s2.ProjectID AND s2.IsCurrent = 1 AND s2.ReportMonth = EOMONTH(DATEADD(m,-2,GETDATE()))
	LEFT OUTER JOIN [dbo].[Users] AS u2 ON s2.SignOffUserID = u2.ID
	LEFT OUTER JOIN [dbo].[SignOffs] AS s3 ON p.ID = s3.ProjectID AND s3.IsCurrent = 1 AND s3.ReportMonth = EOMONTH(DATEADD(m,-3,GETDATE()))
	LEFT OUTER JOIN [dbo].[Users] AS u3 ON s3.SignOffUserID = u3.ID
GO
/****** Object:  View [reports].[Dependencies]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[Dependencies]
AS
	SELECT dbo.Dependencies.ID AS [Dependency ID]
			, dbo.Dependencies.Title AS [Dependency]
			, dbo.Projects.Title AS [Project]
			, dbo.Users.Title AS [Lead]
			, dbo.EntityStatuses.Title AS [Status]
			, CAST(dbo.Dependencies.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
			, dbo.Dependencies.StartDate AS [Start date]
			, dbo.Dependencies.EndDate AS [End date]
			, CAST(dbo.Dependencies.BaselineDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Baseline]
			, CAST(dbo.Dependencies.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast]
			, CAST(dbo.Dependencies.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual]
	FROM dbo.Dependencies LEFT OUTER JOIN
		dbo.Projects ON dbo.Dependencies.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
		dbo.Users ON dbo.Dependencies.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
		dbo.EntityStatuses ON dbo.Dependencies.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[RiskMitigationActionUpdates]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[RiskMitigationActionUpdates]
AS
	WITH
		RiskTypesForRisk
		AS
		(
			SELECT r.ID AS RiskID, STRING_AGG(rt.Title, ',') AS RiskTypes
			FROM dbo.Risks r
				JOIN dbo.RiskRiskTypes rrt ON rrt.RiskID = r.ID
				JOIN dbo.RiskTypes rt ON rt.ID = rrt.RiskTypeID
			GROUP BY r.ID
		)
	SELECT gr.Title AS [Group]
	, dir.Title AS [Directorate] 
	, rmau.ID AS [Risk Mitigation Action Update ID]
	, r.ID AS [Risk ID]
	, rma.ID AS [Risk Mitigation Action ID]
	, rmau.SignOffID AS [SignOff ID] 
	, r.Title AS [Risk Name]
	, riskTypes.RiskTypes AS [Risk Type]
	, rma.Title AS [Mitigation Action]
	, rma.Description AS [Description]
	, rma.BaselineDate AS [Baseline Date]
	, ISNULL(rma.ActualDate, rma.ForecastDate) AS [Delivery Date]
	, CASE
		WHEN rma.ActionIsOngoing = 'true' THEN 'Yes'
		ELSE 'No'
	 END AS [Is Ongoing]
	, rmao.Title AS [Action Owner]
	, rmau.UpdatePeriod AS [Report Month]
	, ro.ReportName AS [RAG Status]
	, ro.Score AS [RAG Score] 
	, RiskMitigationActionsLastMonth.[RAG Status] AS [Previous RAG Status]
	, RiskMitigationActionsLastMonth.[RAG Score] AS [Previous RAG Score]
	, ro.Score - RiskMitigationActionsLastMonth.[RAG Score] AS [RAG Change] 
	, rmau.Comment AS [Progress]
	, rmauu.Title AS [Last Updated by]
	, es.Title AS [Status]
	, CAST(rmau.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
	FROM dbo.RiskMitigationActionUpdates rmau LEFT OUTER JOIN
		dbo.SignOffs AS so ON rmau.SignOffID = so.ID LEFT OUTER JOIN
		dbo.RiskMitigationActions rma ON rmau.RiskMitigationActionID = rma.ID LEFT OUTER JOIN
		dbo.Risks r ON r.ID = rma.RiskID LEFT OUTER JOIN
		dbo.Directorates AS dir ON r.DirectorateID = dir.ID LEFT OUTER JOIN
		dbo.Groups AS gr ON dir.GroupID = gr.ID LEFT OUTER JOIN
		dbo.Users rmao ON rmao.ID = rma.OwnerUserID LEFT OUTER JOIN
		dbo.Users rmauu ON rmauu.ID = rmau.UpdateUserID LEFT OUTER JOIN
		dbo.EntityStatuses es ON es.ID = rma.EntityStatusID LEFT OUTER JOIN
		dbo.RagOptions ro ON ro.ID = rmau.RagOptionID LEFT OUTER JOIN
		RiskTypesForRisk AS riskTypes ON r.ID = riskTypes.RiskID LEFT OUTER JOIN
		(SELECT rmau.RiskMitigationActionID AS [RiskMitigationActionID]
		, EOMONTH(DATEADD(MONTH, 1, rmau.UpdatePeriod)) AS [NextMonth]
		, ro.ReportName AS [RAG status]
		, ro.Score AS [RAG Score]
		FROM dbo.RiskMitigationActionUpdates AS rmau LEFT OUTER JOIN
			dbo.SignOffs AS so ON rmau.SignOffID = so.ID LEFT OUTER JOIN
			dbo.RiskMitigationActions AS rma ON rma.ID = rmau.RiskMitigationActionID LEFT OUTER JOIN
			dbo.RagOptions ro ON ro.ID = rmau.RagOptionID
		WHERE so.IsCurrent = 1) AS RiskMitigationActionsLastMonth ON rmau.RiskMitigationActionID = RiskMitigationActionsLastMonth.RiskMitigationActionID
			AND rmau.UpdatePeriod = RiskMitigationActionsLastMonth.NextMonth
	WHERE
	so.IsCurrent = 1 AND r.Discriminator = 'CorporateRisk'
GO
/****** Object:  View [reports].[Commitments]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[Commitments]
AS
SELECT    dbo.Commitments.ID AS [Commitment ID]
			,dbo.Commitments.Title AS [Commitment]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.Commitments.BaselineDate AS [Baseline]
			,dbo.Commitments.ForecastDate AS [Forecast]
			,dbo.Commitments.ActualDate AS [Actual]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(dbo.Commitments.EntityStatusDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Status Last Changed]
FROM     dbo.Commitments LEFT OUTER JOIN
			dbo.Directorates ON dbo.Commitments.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Commitments.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Commitments.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[UsersLastEdit]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[UsersLastEdit]
AS
SELECT u.Title AS [Name], u.Username, CAST(LastEditDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Update Date] FROM
(SELECT UpdateUserID, MAX(LastEditDate) AS LastEditDate FROM
(SELECT UpdateUserID, MAX(UpdateDate) AS LastEditDate FROM [dbo].[BenefitUpdates] GROUP BY UpdateUserID
UNION
SELECT UpdateUserID, MAX(UpdateDate) AS LastEditDate FROM [dbo].[CommitmentUpdates] GROUP BY UpdateUserID
UNION
SELECT UpdateUserID, MAX(UpdateDate) AS LastEditDate FROM [dbo].[DependencyUpdates] GROUP BY UpdateUserID
UNION
SELECT UpdateUserID, MAX(UpdateDate) AS LastEditDate FROM [dbo].[DirectorateUpdates] GROUP BY UpdateUserID
UNION
SELECT UpdateUserID, MAX(UpdateDate) AS LastEditDate FROM [dbo].[KeyWorkAreaUpdates] GROUP BY UpdateUserID
UNION
SELECT UpdateUserID, MAX(UpdateDate) AS LastEditDate FROM [dbo].[MetricUpdates] GROUP BY UpdateUserID
UNION
SELECT UpdateUserID, MAX(UpdateDate) AS LastEditDate FROM [dbo].[MilestoneUpdates] GROUP BY UpdateUserID
UNION
SELECT UpdateUserID, MAX(UpdateDate) AS LastEditDate FROM [dbo].[ProjectUpdates] GROUP BY UpdateUserID
UNION
SELECT SignOffUserID, MAX(SignOffDate) AS LastEditDate FROM [dbo].[SignOffs] GROUP BY SignOffUserID
UNION
SELECT UpdateUserID, MAX(UpdateDate) AS LastEditDate FROM [dbo].[WorkStreamUpdates] GROUP BY UpdateUserID) AS LastEdits
GROUP BY UpdateUserID)
AS LastEdits
INNER JOIN Users AS u ON LastEdits.UpdateUserID = u.ID
GO
/****** Object:  View [reports].[KeyWorkAreaChartData]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [reports].[KeyWorkAreaChartData]
AS
SELECT        dbo.KeyWorkAreas.ID, dbo.Groups.Title AS [Group], dbo.Directorates.Title AS [Directorate], dbo.KeyWorkAreas.Title AS [Key Work Area], dbo.SignOffs.ReportMonth AS [Report Month], dbo.RagOptions.ReportName AS [Rating]
FROM            dbo.SignOffs INNER JOIN
						 dbo.KeyWorkAreaUpdates ON dbo.SignOffs.ID = dbo.KeyWorkAreaUpdates.SignOffID INNER JOIN
						 dbo.KeyWorkAreas ON dbo.KeyWorkAreaUpdates.KeyWorkAreaID = dbo.KeyWorkAreas.ID INNER JOIN
                         dbo.Directorates ON dbo.KeyWorkAreas.DirectorateID = dbo.Directorates.ID INNER JOIN
						 dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
                         dbo.RagOptions ON dbo.KeyWorkAreaUpdates.RagOptionID = dbo.RagOptions.ID
WHERE        dbo.SignOffs.IsCurrent = 1
GO
/****** Object:  View [reports].[DirectoratesLastEdit]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[DirectoratesLastEdit]
AS
SELECT d.Title AS [Directorate], CAST(MAX(du.UpdateDate) AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Update Date]
FROM [dbo].[Directorates] AS d 
LEFT OUTER JOIN [dbo].[DirectorateUpdates] AS du ON d.ID = du.DirectorateID
GROUP BY d.Title
GO
/****** Object:  View [reports].[ProjectsLastEdit]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[ProjectsLastEdit]
AS
SELECT p.Title AS [Project], CAST(MAX(pu.UpdateDate) AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Update Date]
FROM [dbo].[Projects] AS p
LEFT OUTER JOIN [dbo].[ProjectUpdates] AS pu ON p.ID = pu.ProjectID
GROUP BY p.Title
GO
/****** Object:  View [reports].[UserAssociations]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[UserAssociations]
AS
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'User Group' AS [Thing Type]
		,g.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.UserGroups AS ug ON u.ID = ug.UserID
	INNER JOIN dbo.Groups AS g ON ug.GroupID = g.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'User Directorate' AS [Thing Type]
		,d.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.UserDirectorates AS ud ON u.ID = ud.UserID
	INNER JOIN dbo.Directorates AS d ON ud.DirectorateID = d.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'User Project' AS [Thing Type]
		,p.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.UserProjects AS up ON u.ID = up.UserID
	INNER JOIN dbo.Projects AS p ON up.ProjectID = p.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Group' AS [Thing Type]
		,g.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Groups AS g ON u.ID = g.BusinessPartnerUserID OR u.ID = g.DirectorGeneralUserID OR u.ID = g.RiskChampionDeputyDirectorUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Directorate' AS [Thing Type]
		,d.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Directorates AS d ON u.ID = d.DirectorUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Project' AS [Thing Type]
		,p.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Projects AS p ON u.ID = p.SeniorResponsibleOwnerUserID OR u.ID = p.ProjectManagerUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Key Work Area' AS [Thing Type]
		,k.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.KeyWorkAreas AS k ON u.ID = k.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Work Stream' AS [Thing Type]
		,w.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.WorkStreams AS w ON u.ID = w.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Milestone' AS [Thing Type]
		,m.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Milestones AS m ON u.ID = m.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Metric' AS [Thing Type]
		,m.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Metrics AS m ON u.ID = m.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Benefit' AS [Thing Type]
		,b.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Benefits AS b ON u.ID = b.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Commitment' AS [Thing Type]
		,c.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Commitments AS c ON u.ID = c.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Dependency' AS [Thing Type]
		,d.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Dependencies AS d ON u.ID = d.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Key Work Area Contributor' AS [Thing Type]
		,k.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.KeyWorkAreas AS k ON c.KeyWorkAreaID = k.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Work Stream Contributor' AS [Thing Type]
		,w.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.WorkStreams AS w ON c.WorkStreamID = w.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Milestone Contributor' AS [Thing Type]
		,m.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.Milestones AS m ON c.MilestoneID = m.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Metric Contributor' AS [Thing Type]
		,m.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.Metrics AS m ON c.MetricID = m.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Benefit Contributor' AS [Thing Type]
		,b.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.Benefits AS b ON c.BenefitID = b.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Commitment Contributor' AS [Thing Type]
		,com.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.Commitments AS com ON c.CommitmentID = com.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Dependency Contributor' AS [Thing Type]
		,d.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.Dependencies AS d ON c.DependencyID = d.ID
GO
/****** Object:  View [reports].[WorkStreamChartData]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [reports].[WorkStreamChartData]
AS
SELECT        dbo.WorkStreams.ID, dbo.Groups.Title AS [Group], dbo.Directorates.Title AS [Directorate], dbo.Projects.Title AS [Project], dbo.WorkStreams.Title AS [Work stream], dbo.SignOffs.ReportMonth AS [Report Month], dbo.RagOptions.ReportName AS [Rating]
FROM            dbo.SignOffs INNER JOIN
						 dbo.WorkStreamUpdates ON dbo.SignOffs.ID = dbo.WorkStreamUpdates.SignOffID INNER JOIN
						 dbo.WorkStreams ON dbo.WorkStreamUpdates.WorkStreamID = dbo.WorkStreams.ID INNER JOIN
                         dbo.Projects ON dbo.WorkStreams.ProjectID = dbo.Projects.ID INNER JOIN
						 dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID INNER JOIN
						 dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
                         dbo.RagOptions ON dbo.WorkStreamUpdates.RagOptionID = dbo.RagOptions.ID
WHERE        dbo.SignOffs.IsCurrent = 1
GO
/****** Object:  View [reports].[MilestonesLastEdit]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[MilestonesLastEdit]
AS
SELECT m.Title AS Milestone
	,kwa.Title AS [Key Work Area]
	,d.Title AS [Directorate]
	,ws.Title AS [Work Stream]
	,p.Title AS [Project]
	,CAST(MAX(mu.UpdateDate) AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Update Date]
FROM [dbo].[Milestones] AS m
LEFT OUTER JOIN [dbo].[MilestoneUpdates] AS mu ON m.ID = mu.MilestoneID
LEFT OUTER JOIN [dbo].[KeyWorkAreas] AS kwa ON m.KeyWorkAreaID = kwa.ID
LEFT OUTER JOIN [dbo].[Directorates] AS d ON kwa.DirectorateID = d.ID
LEFT OUTER JOIN [dbo].[WorkStreams] AS ws ON m.WorkStreamID = ws.ID
LEFT OUTER JOIN [dbo].[Projects] AS p ON ws.ProjectID = p.ID
GROUP BY m.Title, kwa.Title, d.Title, ws.Title, p.Title
GO
/****** Object:  View [reports].[Projects]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[Projects]
AS
SELECT    Projects.ID AS [Project ID]
			,dbo.Directorates.Title AS [Directorate]
			,Projects.Title AS [Project]
			,SroUser.Title AS [SRO]
			,Projects.Objectives AS [Objectives]
			,dbo.EntityStatuses.Title AS [Status]
			,CAST(Projects.StartDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Start Date]
			,CAST(Projects.EndDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [End Date]
			,Projects.CorporateProjectID AS [BEIS Project ID]
FROM     dbo.Projects AS Projects LEFT OUTER JOIN
            dbo.Directorates ON Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
            dbo.Users AS SroUser ON Projects.SeniorResponsibleOwnerUserID = SroUser.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON Projects.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[SignOffs]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[SignOffs]
AS
SELECT	dbo.SignOffs.ID AS [Sign Off ID]
		,CAST(dbo.SignOffs.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Sign Off Date]
		,dbo.Users.Title AS [Signed Off By]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
FROM   dbo.SignOffs LEFT OUTER JOIN
		dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
		dbo.Users ON dbo.SignOffs.SignOffUserID = dbo.Users.ID
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [reports].[ProjectAttributes]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  View [reports].[Directorates]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [reports].[Directorates]
AS
SELECT    Directorates.ID AS [Directorate ID]
			,dbo.Groups.Title AS [Group]
			,Directorates.Title AS [Directorate]
			,DirectorUser.Title AS [Director]
			,Directorates.Objectives AS [Objectives]
FROM     dbo.Directorates AS Directorates LEFT OUTER JOIN
            dbo.Groups ON Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
            dbo.Users AS DirectorUser ON Directorates.DirectorUserID = DirectorUser.ID
GO
/****** Object:  View [drafts].[DirectorateUpdates]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[DirectorateUpdates]
AS
	SELECT g.Title AS [Group]
		, d.Title AS [Directorate]
		, d.ID AS [Directorate ID]
		, Months.UpdatePeriod AS [Report Month]
		, DirectorUser.Title AS [Director]
		, UpdateAuthor.Title AS [Author]
		, es.Title AS [Status] 
		, CAST(du.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, d.Objectives AS [Objectives]
		, du.ProgressUpdate AS [Delivery Confidence Update]
		, du.FutureActions AS [Future Actions Update]
		, du.Escalations AS [Escalations Update]

		, pdu.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, pdu.PreviousFinanceRAG AS [Previous Finance RAG]
		, pdu.PreviousMilestonesRAG AS [Previous Milestones RAG]
		, pdu.PreviousMetricsRAG AS [Previous Metrics RAG]
		, pdu.PreviousPeopleRAG AS [Previous People RAG]

		, pdu.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score]
		, pdu.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, pdu.PreviousMilestonesRAGScore AS [Previous Milestones RAG Score]
		, pdu.PreviousMetricsRAGScore AS [Previous Metrics RAG Score]
		, pdu.PreviousPeopleRAGScore AS [Previous People RAG Score]

		, OverallRAG.ReportName AS [Delivery Confidence RAG]
		, FinanceRAG.ReportName AS [Finance RAG]
		, MilestonesRAG.ReportName AS [Milestones RAG]
		, MetricsRAG.ReportName AS [Metrics RAG]
		, PeopleRAG.ReportName AS [People RAG]

		, OverallRAG.Score AS [Delivery Confidence RAG Score]
		, FinanceRAG.Score AS [Finance RAG Score]
		, MilestonesRAG.Score AS [Milestones RAG Score]
		, MetricsRAG.Score AS [Metrics RAG Score]
		, PeopleRAG.Score AS [People RAG Score]

		, du.FinanceComment AS [Finance Update]
		, du.MilestonesComment AS [Milestones Update]
		, du.MetricsComment AS [Metrics Update]
		, du.PeopleComment AS [People Update]

		, (OverallRAG.Score - pdu.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (FinanceRAG.Score - pdu.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (MilestonesRAG.Score - pdu.PreviousMilestonesRAGScore) AS [Milestones RAG Change]
		, (MetricsRAG.Score - pdu.PreviousMetricsRAGScore) AS [Metrics RAG Change]
		, (PeopleRAG.Score - pdu.PreviousPeopleRAGScore) AS [People RAG Change]

	FROM dbo.Directorates AS d CROSS JOIN
    (SELECT DISTINCT UpdatePeriod
		FROM dbo.DirectorateUpdates
		WHERE UpdatePeriod IS NOT NULL) AS Months LEFT OUTER JOIN
		dbo.DirectorateUpdates AS du ON d.ID = du.DirectorateID AND Months.UpdatePeriod = du.UpdatePeriod AND du.ID IN
    	(SELECT MAX([ID])
			FROM [dbo].[DirectorateUpdates]
			GROUP BY DirectorateID, UpdatePeriod) LEFT OUTER JOIN
		dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON d.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.RagOptions AS OverallRAG ON du.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON du.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON du.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON du.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MetricsRAG ON du.MetricsRagOptionID = MetricsRAG.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON du.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.Users AS DirectorUser ON d.DirectorUserID = DirectorUser.ID LEFT OUTER JOIN
		dbo.PreviousDirectorateUpdates AS pdu ON d.ID = pdu.DirectorateID AND Months.UpdatePeriod = pdu.NextMonth;
GO
/****** Object:  View [drafts].[PartnerOrganisationUpdates]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [drafts].[PartnerOrganisationUpdates]
AS
  SELECT g.Title AS [Group]
    , d.Title AS [Directorate]
		, po.Title AS [Partner Organisation] 
		, po.ID AS [Partner Organisation ID]
		, Months.UpdatePeriod AS [Report Month]
		, DirectorUser.Title AS [Director]
    , LeadPolicySponsorUser.Title AS [Lead Policy Sponsor]
    , ReportAuthorUser.Title AS [Author]
		, CAST(pou.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, po.Objectives AS [Objectives]
		, pou.ProgressUpdate AS [Delivery Confidence Update]
		, pou.FutureActions AS [Future Actions Update]
		, pou.Escalations AS [Escalations Update]
		, es.Title AS [Status]
    , CASE po.ReportingFrequency 
            WHEN 1 THEN 'Monthly'
            WHEN 2 THEN 'Quarterly' 
            WHEN 3 THEN 'Biannually'
            WHEN 4 THEN 'Annually'
            ELSE '' 
        END AS [Reporting Frequency]
    , CASE po.ReportingFrequency
            WHEN 2 THEN 
                CASE MONTH(po.ReportingStartDate)
                WHEN 1 THEN 'Jan, Apr, Jul, Oct'
                WHEN 2 THEN 'Feb, May, Aug, Nov' 
                WHEN 3 THEN 'Mar, Jun, Sep, Dec'
                ELSE '' 
            END 
            WHEN 3 THEN 
                CASE MONTH(po.ReportingStartDate)
                WHEN 1 THEN 'Jan, Jul' 
                WHEN 2 THEN 'Feb, Aug' 
                WHEN 3 THEN 'Mar, Sep' 
                WHEN 4 THEN 'Apr, Oct' 
                WHEN 5 THEN 'May, Nov' 
                WHEN 6 THEN 'Jun, Dec' 
                ELSE '' 
            END 
            WHEN 4 THEN 
                CASE MONTH(po.ReportingStartDate)
                WHEN 1 THEN 'Jan' 
                WHEN 2 THEN 'Feb' 
                WHEN 3 THEN 'Mar' 
                WHEN 4 THEN 'Apr' 
                WHEN 5 THEN 'May' 
                WHEN 6 THEN 'Jun' 
                WHEN 7 THEN 'Jul' 
                WHEN 8 THEN 'Aug' 
                WHEN 9 THEN 'Sep' 
                WHEN 10 THEN 'Oct' 
                WHEN 11 THEN 'Nov' 
                WHEN 12 THEN 'Dec' 
                ELSE '' 
            END 
        END AS [Reporting Schedule]
      
        /* RAGs */
		, ppou.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, ppou.PreviousFinanceRAG AS [Previous Finance RAG]
		, ppou.PreviousKeyPerformanceIndicatorRAG AS [Previous Key Performance Indicators RAG]
		, ppou.PreviousPeopleRAG AS [Previous Milestones RAG]
		, ppou.PreviousMilestonesRAG AS [Previous People RAG]

		, ppou.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score] 
		, ppou.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, ppou.PreviousKeyPerformanceIndicatorScore AS [Previous Key Performance Indicators RAG Score]
		, ppou.PreviousPeopleRAGScore AS [Previous Milestones RAG Score]
		, ppou.PreviousMilestonesRAGScore As [Previous People RAG Score]

		, dcRag.ReportName AS [Delivery Confidence RAG]
		, fiRag.ReportName AS [Finance RAG]
		, kpiRag.ReportName AS [Key Performance Indicators RAG]
		, mileRag.ReportName AS [Milestones RAG]
		, pplRag.ReportName AS [People RAG]

		, dcRag.Score AS [Delivery Confidence RAG Score] 
		, fiRag.Score AS [Finance RAG Score]
		, kpiRag.Score AS [Key Performance Indicators RAG Score]
		, mileRag.Score AS [Milestones RAG Score]
		, pplRag.Score As [People RAG Score]

		, pou.FinanceComment AS [Finance Update]
		, pou.KPIComment AS [Key Performance Indicators Update]
		, pou.MilestonesComment AS [Milestones Update]
		, pou.PeopleComment AS [People Update]
       
		, (dcRag.Score - ppou.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (fiRag.Score - ppou.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (kpiRag.Score - ppou.PreviousKeyPerformanceIndicatorScore) AS [Key Performance Indicator RAG Change]
		, (pplRag.Score - ppou.PreviousPeopleRAGScore) AS [People RAG Change]
		, (mileRag.Score - ppou.PreviousMilestonesRAGScore) AS [Milestones RAG Change]

  FROM dbo.PartnerOrganisations AS po CROSS JOIN
    (SELECT DISTINCT UpdatePeriod
    FROM dbo.PartnerOrganisationUpdates
    WHERE UpdatePeriod IS NOT NULL) AS Months LEFT OUTER JOIN
    dbo.PartnerOrganisationUpdates AS pou ON po.ID = pou.PartnerOrganisationID AND Months.UpdatePeriod = pou.UpdatePeriod AND pou.ID IN
    (SELECT MAX([ID])
    FROM [dbo].[PartnerOrganisationUpdates]
    GROUP BY PartnerOrganisationID, UpdatePeriod) LEFT OUTER JOIN
    dbo.Directorates AS d ON po.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON po.EntityStatusID = es.ID LEFT OUTER JOIN
    /* Users */
    dbo.Users AS LeadPolicySponsorUser ON po.LeadPolicySponsorUserID = LeadPolicySponsorUser.ID LEFT OUTER JOIN
    dbo.Users AS ReportAuthorUser ON po.ReportAuthorUserID = ReportAuthorUser.ID LEFT OUTER JOIN
    dbo.Users AS DirectorUser ON d.DirectorUserID = DirectorUser.ID LEFT OUTER JOIN
    /* RAGs */
    dbo.RagOptions AS dcRag ON pou.OverallRagOptionID = dcRag.ID LEFT OUTER JOIN
    dbo.RagOptions AS fiRag ON pou.FinanceRagOptionID = fiRag.ID LEFT OUTER JOIN
    dbo.RagOptions AS kpiRag ON pou.KPIRagOptionID = kpiRag.ID LEFT OUTER JOIN
    dbo.RagOptions AS mileRag ON pou.MilestonesRagOptionID = mileRag.ID LEFT OUTER JOIN
    dbo.RagOptions AS pplRag ON pou.PeopleRagOptionID = pplRag.ID LEFT OUTER JOIN
    dbo.PreviousPartnerOrganisationUpdates AS ppou ON po.ID = ppou.PartnerOrganisationID AND pou.UpdatePeriod = ppou.NextMonth;
GO
/****** Object:  Table [dbo].[__RefactorLog]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__RefactorLog](
	[OperationKey] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OperationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProjectAttributeTypes]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectAttributeTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Display] [bit] NULL,
 CONSTRAINT [PK_ProjectAttributeTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportingFrequencies]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportingFrequencies](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[RemindAuthorsDaysBeforeDue] [int] NULL,
	[RemindApproverDaysBeforeDue] [int] NULL,
	[EarlyUpdateWarningDays] [int] NULL,
 CONSTRAINT [PK_ReportingFrequencies] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReportStaging]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportStaging](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ProjectID] [int] NOT NULL,
	[ReportJson] [nvarchar](max) NOT NULL,
	[SubmittedByUserID] [int] NOT NULL,
	[SubmittedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ReportStaging] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RiskDiscussionForums]    Script Date: 08/11/2022 15:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskDiscussionForums](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
 CONSTRAINT [PK_RiskDiscussionForums] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 08/11/2022 15:27:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF_Attributes_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF_Attributes_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Benefits] ADD  CONSTRAINT [DF_Benefits_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Benefits] ADD  CONSTRAINT [DF_Benefits_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Commitments] ADD  CONSTRAINT [DF_Commitments_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Commitments] ADD  CONSTRAINT [DF_Commitments_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Contributors] ADD  CONSTRAINT [DF_Contributors_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Contributors] ADD  CONSTRAINT [DF_Contributors_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Dependencies] ADD  CONSTRAINT [DF_Dependencies_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Dependencies] ADD  CONSTRAINT [DF_Dependencies_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Directorates] ADD  CONSTRAINT [DF_Directorates_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Directorates] ADD  CONSTRAINT [DF_Directorates_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Groups_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Groups_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[KeyWorkAreas] ADD  CONSTRAINT [DF_KeyWorkAreas_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[KeyWorkAreas] ADD  CONSTRAINT [DF_KeyWorkAreas_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Metrics] ADD  CONSTRAINT [DF_Metrics_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Metrics] ADD  CONSTRAINT [DF_Metrics_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Milestones] ADD  CONSTRAINT [DF_Milestones_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Milestones] ADD  CONSTRAINT [DF_Milestones_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] ADD  CONSTRAINT [DF_PartnerOrganisationRiskMitigationActions_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] ADD  CONSTRAINT [DF_PartnerOrganisationRiskMitigationActions_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes] ADD  CONSTRAINT [DF_PartnerOrganisationRiskRiskTypes_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes] ADD  CONSTRAINT [DF_PartnerOrganisationRiskRiskTypes_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] ADD  CONSTRAINT [DF_PartnerOrganisationRisks_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] ADD  CONSTRAINT [DF_PartnerOrganisationRisks_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[PartnerOrganisations] ADD  CONSTRAINT [DF_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[PartnerOrganisations] ADD  CONSTRAINT [DF_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[PartnerOrganisations] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ProjectAttributes] ADD  CONSTRAINT [DF_ProjectAttributes_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[ProjectAttributes] ADD  CONSTRAINT [DF_ProjectAttributes_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Projects] ADD  CONSTRAINT [DF_Projects_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Projects] ADD  CONSTRAINT [DF_Projects_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Projects] ADD  CONSTRAINT [DF_Projects_ShowOnDirectorateReport]  DEFAULT ('false') FOR [ShowOnDirectorateReport]
GO
ALTER TABLE [dbo].[ReportingEntities] ADD  CONSTRAINT [DF_ReportingEntities_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[ReportingEntities] ADD  CONSTRAINT [DF_ReportingEntities_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[ReportingEntities] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ReportingEntityTypes] ADD  CONSTRAINT [DF_ReportingEntityTypes_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[ReportingEntityTypes] ADD  CONSTRAINT [DF_ReportingEntityTypes_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[ReportingEntityTypes] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ReportTypes] ADD  CONSTRAINT [DF_ReportTypes_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[ReportTypes] ADD  CONSTRAINT [DF_ReportTypes_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[ReportTypes] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[RiskMitigationActions] ADD  CONSTRAINT [DF_RiskMitigationActions_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[RiskMitigationActions] ADD  CONSTRAINT [DF_RiskMitigationActions_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[RiskMitigationActions] ADD  DEFAULT (N'CorporateRiskMitigationAction') FOR [Discriminator]
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates] ADD  DEFAULT (N'CorporateRiskMitigationActionUpdate') FOR [Discriminator]
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions] ADD  CONSTRAINT [DF_RiskRiskMitigationActions_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions] ADD  CONSTRAINT [DF_RiskRiskMitigationActions_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions] ADD  DEFAULT (N'CorporateRiskRiskMitigationAction') FOR [Discriminator]
GO
ALTER TABLE [dbo].[Risks] ADD  CONSTRAINT [DF_Risks_SysStart]  DEFAULT (CONVERT([datetime2](0),'2018-01-01 00:00:00')) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Risks] ADD  CONSTRAINT [DF_Risks_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Risks] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Risks] ADD  DEFAULT (N'CorporateRisk') FOR [Discriminator]
GO
ALTER TABLE [dbo].[RiskUpdates] ADD  DEFAULT (N'CorporateRiskUpdate') FOR [Discriminator]
GO
ALTER TABLE [dbo].[SignOffs] ADD  CONSTRAINT [DF_SignOffs_IsCurrent]  DEFAULT ((0)) FOR [IsCurrent]
GO
ALTER TABLE [dbo].[UserDirectorates] ADD  CONSTRAINT [DF_UserDirectorates_IsAdmin]  DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[UserDirectorates] ADD  CONSTRAINT [DF_UserDirectorates_IsRiskAdmin]  DEFAULT ((0)) FOR [IsRiskAdmin]
GO
ALTER TABLE [dbo].[UserDirectorates] ADD  CONSTRAINT [DF_UserDirectorates_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[UserDirectorates] ADD  CONSTRAINT [DF_UserDirectorates_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[UserGroups] ADD  CONSTRAINT [DF_UserGroups_IsRiskAdmin]  DEFAULT ((0)) FOR [IsRiskAdmin]
GO
ALTER TABLE [dbo].[UserGroups] ADD  CONSTRAINT [DF_UserGroups_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[UserGroups] ADD  CONSTRAINT [DF_UserGroups_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[UserGroups] ADD  DEFAULT (N'UserGroup') FOR [Discriminator]
GO
ALTER TABLE [dbo].[UserPartnerOrganisations] ADD  CONSTRAINT [DF_UserPartnerOrganisations_IsAdmin]  DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[UserPartnerOrganisations] ADD  CONSTRAINT [DF_UserPartnerOrganisations_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[UserPartnerOrganisations] ADD  CONSTRAINT [DF_UserPartnerOrganisations_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[UserProjects] ADD  CONSTRAINT [DF_UserProjects_IsAdmin]  DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[UserProjects] ADD  CONSTRAINT [DF_UserProjects_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[UserProjects] ADD  CONSTRAINT [DF_UserProjects_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[UserProjects] ADD  CONSTRAINT [DF_UserProjects_IsRiskAdmin]  DEFAULT ((0)) FOR [IsRiskAdmin]
GO
ALTER TABLE [dbo].[UserRoles] ADD  CONSTRAINT [DF_UserRoles_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[UserRoles] ADD  CONSTRAINT [DF_UserRoles_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[WorkStreams] ADD  CONSTRAINT [DF_WorkStreams_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[WorkStreams] ADD  CONSTRAINT [DF_WorkStreams_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [History].[RiskMitigationActions] ADD  DEFAULT (N'CorporateRiskMitigationAction') FOR [Discriminator]
GO
ALTER TABLE [History].[Risks] ADD  DEFAULT (N'CorporateRisk') FOR [Discriminator]
GO
ALTER TABLE [History].[UserGroups] ADD  DEFAULT (N'UserGroup') FOR [Discriminator]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_AttributeTypes] FOREIGN KEY([AttributeTypeID])
REFERENCES [dbo].[AttributeTypes] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_AttributeTypes]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_Benefits] FOREIGN KEY([BenefitID])
REFERENCES [dbo].[Benefits] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Benefits]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_Commitments] FOREIGN KEY([CommitmentID])
REFERENCES [dbo].[Commitments] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Commitments]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_Dependencies] FOREIGN KEY([DependencyID])
REFERENCES [dbo].[Dependencies] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Dependencies]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Directorates]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_KeyWorkAreas] FOREIGN KEY([KeyWorkAreaID])
REFERENCES [dbo].[KeyWorkAreas] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_KeyWorkAreas]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_Metrics] FOREIGN KEY([MetricID])
REFERENCES [dbo].[Metrics] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Metrics]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_Milestones] FOREIGN KEY([MilestoneID])
REFERENCES [dbo].[Milestones] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Milestones]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_PartnerOrganisationRiskMitigationActions] FOREIGN KEY([PartnerOrganisationRiskMitigationActionID])
REFERENCES [dbo].[PartnerOrganisationRiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_PartnerOrganisationRiskMitigationActions]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_PartnerOrganisationRisks] FOREIGN KEY([PartnerOrganisationRiskID])
REFERENCES [dbo].[PartnerOrganisationRisks] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_PartnerOrganisationRisks]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_PartnerOrganisations]
GO
ALTER TABLE [dbo].[Attributes]  WITH NOCHECK ADD  CONSTRAINT [FK_Attributes_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Projects]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_ReportingEntities] FOREIGN KEY([ReportingEntityID])
REFERENCES [dbo].[ReportingEntities] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_ReportingEntities]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_RiskMitigationActions] FOREIGN KEY([RiskMitigationActionID])
REFERENCES [dbo].[RiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_RiskMitigationActions]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_Risks]
GO
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [FK_Attributes_WorkStreams] FOREIGN KEY([WorkStreamID])
REFERENCES [dbo].[WorkStreams] ([ID])
GO
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [FK_Attributes_WorkStreams]
GO
ALTER TABLE [dbo].[Benefits]  WITH CHECK ADD  CONSTRAINT [FK_Benefits_BenefitTypes] FOREIGN KEY([BenefitTypeID])
REFERENCES [dbo].[BenefitTypes] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_BenefitTypes]
GO
ALTER TABLE [dbo].[Benefits]  WITH CHECK ADD  CONSTRAINT [FK_Benefits_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_EntityStatuses]
GO
ALTER TABLE [dbo].[Benefits]  WITH CHECK ADD  CONSTRAINT [FK_Benefits_MeasurementUnits] FOREIGN KEY([MeasurementUnitID])
REFERENCES [dbo].[MeasurementUnits] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_MeasurementUnits]
GO
ALTER TABLE [dbo].[Benefits]  WITH CHECK ADD  CONSTRAINT [FK_Benefits_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Benefits]  WITH CHECK ADD  CONSTRAINT [FK_Benefits_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_Projects]
GO
ALTER TABLE [dbo].[Benefits]  WITH CHECK ADD  CONSTRAINT [FK_Benefits_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_RagOptions]
GO
ALTER TABLE [dbo].[Benefits]  WITH CHECK ADD  CONSTRAINT [FK_Benefits_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Benefits] CHECK CONSTRAINT [FK_Benefits_Users]
GO
ALTER TABLE [dbo].[BenefitUpdates]  WITH CHECK ADD  CONSTRAINT [FK_BenefitUpdates_Benefits] FOREIGN KEY([BenefitID])
REFERENCES [dbo].[Benefits] ([ID])
GO
ALTER TABLE [dbo].[BenefitUpdates] CHECK CONSTRAINT [FK_BenefitUpdates_Benefits]
GO
ALTER TABLE [dbo].[BenefitUpdates]  WITH CHECK ADD  CONSTRAINT [FK_BenefitUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[BenefitUpdates] CHECK CONSTRAINT [FK_BenefitUpdates_RagOptions]
GO
ALTER TABLE [dbo].[BenefitUpdates]  WITH CHECK ADD  CONSTRAINT [FK_BenefitUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[BenefitUpdates] CHECK CONSTRAINT [FK_BenefitUpdates_SignOffs]
GO
ALTER TABLE [dbo].[BenefitUpdates]  WITH CHECK ADD  CONSTRAINT [FK_BenefitUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[BenefitUpdates] CHECK CONSTRAINT [FK_BenefitUpdates_Users]
GO
ALTER TABLE [dbo].[Commitments]  WITH CHECK ADD  CONSTRAINT [FK_Commitments_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[Commitments] CHECK CONSTRAINT [FK_Commitments_Directorates]
GO
ALTER TABLE [dbo].[Commitments]  WITH CHECK ADD  CONSTRAINT [FK_Commitments_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Commitments] CHECK CONSTRAINT [FK_Commitments_EntityStatuses]
GO
ALTER TABLE [dbo].[Commitments]  WITH CHECK ADD  CONSTRAINT [FK_Commitments_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Commitments] CHECK CONSTRAINT [FK_Commitments_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Commitments]  WITH CHECK ADD  CONSTRAINT [FK_Commitments_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Commitments] CHECK CONSTRAINT [FK_Commitments_RagOptions]
GO
ALTER TABLE [dbo].[Commitments]  WITH CHECK ADD  CONSTRAINT [FK_Commitments_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Commitments] CHECK CONSTRAINT [FK_Commitments_Users]
GO
ALTER TABLE [dbo].[CommitmentUpdates]  WITH CHECK ADD  CONSTRAINT [FK_CommitmentUpdates_Commitments] FOREIGN KEY([CommitmentID])
REFERENCES [dbo].[Commitments] ([ID])
GO
ALTER TABLE [dbo].[CommitmentUpdates] CHECK CONSTRAINT [FK_CommitmentUpdates_Commitments]
GO
ALTER TABLE [dbo].[CommitmentUpdates]  WITH CHECK ADD  CONSTRAINT [FK_CommitmentUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[CommitmentUpdates] CHECK CONSTRAINT [FK_CommitmentUpdates_RagOptions]
GO
ALTER TABLE [dbo].[CommitmentUpdates]  WITH CHECK ADD  CONSTRAINT [FK_CommitmentUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[CommitmentUpdates] CHECK CONSTRAINT [FK_CommitmentUpdates_SignOffs]
GO
ALTER TABLE [dbo].[CommitmentUpdates]  WITH CHECK ADD  CONSTRAINT [FK_CommitmentUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[CommitmentUpdates] CHECK CONSTRAINT [FK_CommitmentUpdates_Users]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_Benefits] FOREIGN KEY([BenefitID])
REFERENCES [dbo].[Benefits] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Benefits]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_Commitments] FOREIGN KEY([CommitmentID])
REFERENCES [dbo].[Commitments] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Commitments]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_Dependencies] FOREIGN KEY([DependencyID])
REFERENCES [dbo].[Dependencies] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Dependencies]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_KeyWorkAreas] FOREIGN KEY([KeyWorkAreaID])
REFERENCES [dbo].[KeyWorkAreas] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_KeyWorkAreas]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_Metrics] FOREIGN KEY([MetricID])
REFERENCES [dbo].[Metrics] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Metrics]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_Milestones] FOREIGN KEY([MilestoneID])
REFERENCES [dbo].[Milestones] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Milestones]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_PartnerOrganisationRiskMitigationActions] FOREIGN KEY([PartnerOrganisationRiskMitigationActionID])
REFERENCES [dbo].[PartnerOrganisationRiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_PartnerOrganisationRiskMitigationActions]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_PartnerOrganisationRisks] FOREIGN KEY([PartnerOrganisationRiskID])
REFERENCES [dbo].[PartnerOrganisationRisks] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_PartnerOrganisationRisks]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_PartnerOrganisations]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_ReportingEntities] FOREIGN KEY([ReportingEntityID])
REFERENCES [dbo].[ReportingEntities] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_ReportingEntities]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_RiskMitigationActions] FOREIGN KEY([RiskMitigationActionID])
REFERENCES [dbo].[RiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_RiskMitigationActions]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Risks]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_Users] FOREIGN KEY([ContributorUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_Users]
GO
ALTER TABLE [dbo].[Contributors]  WITH CHECK ADD  CONSTRAINT [FK_Contributors_WorkStreams] FOREIGN KEY([WorkStreamID])
REFERENCES [dbo].[WorkStreams] ([ID])
GO
ALTER TABLE [dbo].[Contributors] CHECK CONSTRAINT [FK_Contributors_WorkStreams]
GO
ALTER TABLE [dbo].[Dependencies]  WITH CHECK ADD  CONSTRAINT [FK_Dependencies_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies_EntityStatuses]
GO
ALTER TABLE [dbo].[Dependencies]  WITH CHECK ADD  CONSTRAINT [FK_Dependencies_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Dependencies]  WITH CHECK ADD  CONSTRAINT [FK_Dependencies_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies_Projects]
GO
ALTER TABLE [dbo].[Dependencies]  WITH CHECK ADD  CONSTRAINT [FK_Dependencies_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies_RagOptions]
GO
ALTER TABLE [dbo].[Dependencies]  WITH CHECK ADD  CONSTRAINT [FK_Dependencies_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies_Users]
GO
ALTER TABLE [dbo].[DependencyUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DependencyUpdates_Dependencies] FOREIGN KEY([DependencyID])
REFERENCES [dbo].[Dependencies] ([ID])
GO
ALTER TABLE [dbo].[DependencyUpdates] CHECK CONSTRAINT [FK_DependencyUpdates_Dependencies]
GO
ALTER TABLE [dbo].[DependencyUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DependencyUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[DependencyUpdates] CHECK CONSTRAINT [FK_DependencyUpdates_RagOptions]
GO
ALTER TABLE [dbo].[DependencyUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DependencyUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[DependencyUpdates] CHECK CONSTRAINT [FK_DependencyUpdates_SignOffs]
GO
ALTER TABLE [dbo].[DependencyUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DependencyUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[DependencyUpdates] CHECK CONSTRAINT [FK_DependencyUpdates_Users]
GO
ALTER TABLE [dbo].[Directorates]  WITH CHECK ADD  CONSTRAINT [FK_Directorates_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_EntityStatuses]
GO
ALTER TABLE [dbo].[Directorates]  WITH CHECK ADD  CONSTRAINT [FK_Directorates_Groups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([ID])
GO
ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_Groups]
GO
ALTER TABLE [dbo].[Directorates]  WITH CHECK ADD  CONSTRAINT [FK_Directorates_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Directorates]  WITH CHECK ADD  CONSTRAINT [FK_Directorates_ReportApproverUsers] FOREIGN KEY([ReportApproverUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_ReportApproverUsers]
GO
ALTER TABLE [dbo].[Directorates]  WITH CHECK ADD  CONSTRAINT [FK_Directorates_ReportingLeadUsers] FOREIGN KEY([ReportingLeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_ReportingLeadUsers]
GO
ALTER TABLE [dbo].[Directorates]  WITH CHECK ADD  CONSTRAINT [FK_Directorates_Users] FOREIGN KEY([DirectorUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Directorates] CHECK CONSTRAINT [FK_Directorates_Users]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DirectorateUpdates_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_Directorates]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DirectorateUpdates_RagOptionFinance] FOREIGN KEY([FinanceRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_RagOptionFinance]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DirectorateUpdates_RagOptionMetric] FOREIGN KEY([MetricsRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_RagOptionMetric]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DirectorateUpdates_RagOptionMilestone] FOREIGN KEY([MilestonesRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_RagOptionMilestone]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DirectorateUpdates_RagOptionOverall] FOREIGN KEY([OverallRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_RagOptionOverall]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DirectorateUpdates_RagOptionPeople] FOREIGN KEY([PeopleRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_RagOptionPeople]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DirectorateUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_SignOffs]
GO
ALTER TABLE [dbo].[DirectorateUpdates]  WITH CHECK ADD  CONSTRAINT [FK_DirectorateUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[DirectorateUpdates] CHECK CONSTRAINT [FK_DirectorateUpdates_Users]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_BusinessPartnerUsers] FOREIGN KEY([BusinessPartnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_BusinessPartnerUsers]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_EntityStatuses]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_RiskChampionUsers] FOREIGN KEY([RiskChampionDeputyDirectorUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_RiskChampionUsers]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_Users] FOREIGN KEY([DirectorGeneralUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_Users]
GO
ALTER TABLE [dbo].[KeyWorkAreas]  WITH CHECK ADD  CONSTRAINT [FK_KeyWorkAreas_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[KeyWorkAreas] CHECK CONSTRAINT [FK_KeyWorkAreas_Directorates]
GO
ALTER TABLE [dbo].[KeyWorkAreas]  WITH CHECK ADD  CONSTRAINT [FK_KeyWorkAreas_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[KeyWorkAreas] CHECK CONSTRAINT [FK_KeyWorkAreas_EntityStatuses]
GO
ALTER TABLE [dbo].[KeyWorkAreas]  WITH CHECK ADD  CONSTRAINT [FK_KeyWorkAreas_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[KeyWorkAreas] CHECK CONSTRAINT [FK_KeyWorkAreas_ModifiedByUsers]
GO
ALTER TABLE [dbo].[KeyWorkAreas]  WITH CHECK ADD  CONSTRAINT [FK_KeyWorkAreas_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[KeyWorkAreas] CHECK CONSTRAINT [FK_KeyWorkAreas_RagOptions]
GO
ALTER TABLE [dbo].[KeyWorkAreas]  WITH CHECK ADD  CONSTRAINT [FK_KeyWorkAreas_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[KeyWorkAreas] CHECK CONSTRAINT [FK_KeyWorkAreas_Users]
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates]  WITH CHECK ADD  CONSTRAINT [FK_KeyWorkAreaUpdates_KeyWorkAreas] FOREIGN KEY([KeyWorkAreaID])
REFERENCES [dbo].[KeyWorkAreas] ([ID])
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates] CHECK CONSTRAINT [FK_KeyWorkAreaUpdates_KeyWorkAreas]
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates]  WITH CHECK ADD  CONSTRAINT [FK_KeyWorkAreaUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates] CHECK CONSTRAINT [FK_KeyWorkAreaUpdates_RagOptions]
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates]  WITH CHECK ADD  CONSTRAINT [FK_KeyWorkAreaUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates] CHECK CONSTRAINT [FK_KeyWorkAreaUpdates_SignOffs]
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates]  WITH CHECK ADD  CONSTRAINT [FK_KeyWorkAreaUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[KeyWorkAreaUpdates] CHECK CONSTRAINT [FK_KeyWorkAreaUpdates_Users]
GO
ALTER TABLE [dbo].[Metrics]  WITH CHECK ADD  CONSTRAINT [FK_Metrics_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_Directorates]
GO
ALTER TABLE [dbo].[Metrics]  WITH CHECK ADD  CONSTRAINT [FK_Metrics_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_EntityStatuses]
GO
ALTER TABLE [dbo].[Metrics]  WITH CHECK ADD  CONSTRAINT [FK_Metrics_MeasurementUnits] FOREIGN KEY([MeasurementUnitID])
REFERENCES [dbo].[MeasurementUnits] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_MeasurementUnits]
GO
ALTER TABLE [dbo].[Metrics]  WITH CHECK ADD  CONSTRAINT [FK_Metrics_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Metrics]  WITH CHECK ADD  CONSTRAINT [FK_Metrics_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_RagOptions]
GO
ALTER TABLE [dbo].[Metrics]  WITH CHECK ADD  CONSTRAINT [FK_Metrics_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Metrics] CHECK CONSTRAINT [FK_Metrics_Users]
GO
ALTER TABLE [dbo].[MetricUpdates]  WITH CHECK ADD  CONSTRAINT [FK_MetricUpdates_Metrics] FOREIGN KEY([MetricID])
REFERENCES [dbo].[Metrics] ([ID])
GO
ALTER TABLE [dbo].[MetricUpdates] CHECK CONSTRAINT [FK_MetricUpdates_Metrics]
GO
ALTER TABLE [dbo].[MetricUpdates]  WITH CHECK ADD  CONSTRAINT [FK_MetricUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[MetricUpdates] CHECK CONSTRAINT [FK_MetricUpdates_RagOptions]
GO
ALTER TABLE [dbo].[MetricUpdates]  WITH CHECK ADD  CONSTRAINT [FK_MetricUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[MetricUpdates] CHECK CONSTRAINT [FK_MetricUpdates_SignOffs]
GO
ALTER TABLE [dbo].[MetricUpdates]  WITH CHECK ADD  CONSTRAINT [FK_MetricUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[MetricUpdates] CHECK CONSTRAINT [FK_MetricUpdates_Users]
GO
ALTER TABLE [dbo].[Milestones]  WITH CHECK ADD  CONSTRAINT [FK_Milestones_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_EntityStatuses]
GO
ALTER TABLE [dbo].[Milestones]  WITH CHECK ADD  CONSTRAINT [FK_Milestones_KeyWorkAreas] FOREIGN KEY([KeyWorkAreaID])
REFERENCES [dbo].[KeyWorkAreas] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_KeyWorkAreas]
GO
ALTER TABLE [dbo].[Milestones]  WITH CHECK ADD  CONSTRAINT [FK_Milestones_MilestoneTypes] FOREIGN KEY([MilestoneTypeID])
REFERENCES [dbo].[MilestoneTypes] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_MilestoneTypes]
GO
ALTER TABLE [dbo].[Milestones]  WITH CHECK ADD  CONSTRAINT [FK_Milestones_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Milestones]  WITH CHECK ADD  CONSTRAINT [FK_Milestones_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_PartnerOrganisations]
GO
ALTER TABLE [dbo].[Milestones]  WITH CHECK ADD  CONSTRAINT [FK_Milestones_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_RagOptions]
GO
ALTER TABLE [dbo].[Milestones]  WITH CHECK ADD  CONSTRAINT [FK_Milestones_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_Users]
GO
ALTER TABLE [dbo].[Milestones]  WITH CHECK ADD  CONSTRAINT [FK_Milestones_WorkStreams] FOREIGN KEY([WorkStreamID])
REFERENCES [dbo].[WorkStreams] ([ID])
GO
ALTER TABLE [dbo].[Milestones] CHECK CONSTRAINT [FK_Milestones_WorkStreams]
GO
ALTER TABLE [dbo].[MilestoneUpdates]  WITH CHECK ADD  CONSTRAINT [FK_MilestoneUpdates_Milestones] FOREIGN KEY([MilestoneID])
REFERENCES [dbo].[Milestones] ([ID])
GO
ALTER TABLE [dbo].[MilestoneUpdates] CHECK CONSTRAINT [FK_MilestoneUpdates_Milestones]
GO
ALTER TABLE [dbo].[MilestoneUpdates]  WITH CHECK ADD  CONSTRAINT [FK_MilestoneUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[MilestoneUpdates] CHECK CONSTRAINT [FK_MilestoneUpdates_RagOptions]
GO
ALTER TABLE [dbo].[MilestoneUpdates]  WITH CHECK ADD  CONSTRAINT [FK_MilestoneUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[MilestoneUpdates] CHECK CONSTRAINT [FK_MilestoneUpdates_SignOffs]
GO
ALTER TABLE [dbo].[MilestoneUpdates]  WITH CHECK ADD  CONSTRAINT [FK_MilestoneUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[MilestoneUpdates] CHECK CONSTRAINT [FK_MilestoneUpdates_Users]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_EntityStatuses]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_LeadUsers] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_LeadUsers]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_ModifiedByUsers]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_PartnerOrganisationRisks] FOREIGN KEY([PartnerOrganisationRiskID])
REFERENCES [dbo].[PartnerOrganisationRisks] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_PartnerOrganisationRisks]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_Users] FOREIGN KEY([OwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActions] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActions_Users]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_PartnerOrganisationRiskMitigationActions] FOREIGN KEY([PartnerOrganisationRiskMitigationActionID])
REFERENCES [dbo].[PartnerOrganisationRiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_PartnerOrganisationRiskMitigationActions]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_RagOptions]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_SignOffs]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskMitigationActionUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskMitigationActionUpdates_Users]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_PartnerOrganisationRisks] FOREIGN KEY([PartnerOrganisationRiskID])
REFERENCES [dbo].[PartnerOrganisationRisks] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes] CHECK CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_PartnerOrganisationRisks]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_RiskTypes] FOREIGN KEY([RiskTypeID])
REFERENCES [dbo].[RiskTypes] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes] CHECK CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_RiskTypes]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_Users] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskRiskTypes] CHECK CONSTRAINT [FK_PartnerOrganisationRiskRiskTypes_Users]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_BeisRiskAppetites] FOREIGN KEY([BeisRiskAppetiteID])
REFERENCES [dbo].[RiskAppetites] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_BeisRiskAppetites]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_BEISTargetRiskImpactLevels] FOREIGN KEY([BEISTargetRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_BEISTargetRiskImpactLevels]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_BEISTargetRiskProbabilities] FOREIGN KEY([BEISTargetRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_BEISTargetRiskProbabilities]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_BEISUnmitigatedRiskImpactLevels] FOREIGN KEY([BEISUnmitigatedRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_BEISUnmitigatedRiskImpactLevels]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_BEISUnmitigatedRiskProbabilities] FOREIGN KEY([BEISUnmitigatedRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_BEISUnmitigatedRiskProbabilities]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_BeisUsers] FOREIGN KEY([BeisRiskOwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_BeisUsers]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_DepartmentalObjectives] FOREIGN KEY([DepartmentalObjectiveID])
REFERENCES [dbo].[DepartmentalObjectives] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_DepartmentalObjectives]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_EntityStatuses]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_LeadUsers] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_LeadUsers]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_ModifiedByUsers]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_PartnerOrganisations]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_RagOptions]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_RiskAppetites] FOREIGN KEY([RiskAppetiteID])
REFERENCES [dbo].[RiskAppetites] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_RiskAppetites]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_TargetRiskImpactLevels] FOREIGN KEY([TargetRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_TargetRiskImpactLevels]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_TargetRiskProbabilities] FOREIGN KEY([TargetRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_TargetRiskProbabilities]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_UnmitigatedRiskImpactLevels] FOREIGN KEY([UnmitigatedRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_UnmitigatedRiskImpactLevels]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_UnmitigatedRiskProbabilities] FOREIGN KEY([UnmitigatedRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_UnmitigatedRiskProbabilities]
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRisks_Users] FOREIGN KEY([RiskOwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRisks] CHECK CONSTRAINT [FK_PartnerOrganisationRisks_Users]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRagOptions] FOREIGN KEY([BeisRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRagOptions]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRiskImpactLevels] FOREIGN KEY([BeisRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRiskImpactLevels]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRiskProbabilities] FOREIGN KEY([BeisRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_BeisRiskProbabilities]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_PartnerOrganisationRisks] FOREIGN KEY([PartnerOrganisationRiskID])
REFERENCES [dbo].[PartnerOrganisationRisks] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_PartnerOrganisationRisks]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RagOptions]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RiskImpactLevels] FOREIGN KEY([RiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RiskImpactLevels]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RiskProbabilities] FOREIGN KEY([RiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_RiskProbabilities]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_SignOffs]
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationRiskUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationRiskUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationRiskUpdates_Users]
GO
ALTER TABLE [dbo].[PartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisations_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_Directorates]
GO
ALTER TABLE [dbo].[PartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisations_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_EntityStatuses]
GO
ALTER TABLE [dbo].[PartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisations_LeadPolicySponsorUsers] FOREIGN KEY([LeadPolicySponsorUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_LeadPolicySponsorUsers]
GO
ALTER TABLE [dbo].[PartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisations_ReportAuthorUsers] FOREIGN KEY([ReportAuthorUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_ReportAuthorUsers]
GO
ALTER TABLE [dbo].[PartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisations_Users] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisations] CHECK CONSTRAINT [FK_PartnerOrganisations_Users]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_PartnerOrganisations]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionFinance] FOREIGN KEY([FinanceRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionFinance]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionKPI] FOREIGN KEY([KPIRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionKPI]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionMilestone] FOREIGN KEY([MilestonesRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionMilestone]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionOverall] FOREIGN KEY([OverallRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionOverall]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionPeople] FOREIGN KEY([PeopleRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_RagOptionPeople]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_SignOffs]
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates]  WITH CHECK ADD  CONSTRAINT [FK_PartnerOrganisationUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[PartnerOrganisationUpdates] CHECK CONSTRAINT [FK_PartnerOrganisationUpdates_Users]
GO
ALTER TABLE [dbo].[ProjectAttributes]  WITH CHECK ADD  CONSTRAINT [FK_ProjectAttributes_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ProjectAttributes] CHECK CONSTRAINT [FK_ProjectAttributes_ModifiedByUsers]
GO
ALTER TABLE [dbo].[ProjectAttributes]  WITH CHECK ADD  CONSTRAINT [FK_ProjectAttributes_ProjectAttributeTypes] FOREIGN KEY([ProjectAttributeTypeID])
REFERENCES [dbo].[ProjectAttributeTypes] ([ID])
GO
ALTER TABLE [dbo].[ProjectAttributes] CHECK CONSTRAINT [FK_ProjectAttributes_ProjectAttributeTypes]
GO
ALTER TABLE [dbo].[ProjectAttributes]  WITH CHECK ADD  CONSTRAINT [FK_ProjectAttributes_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[ProjectAttributes] CHECK CONSTRAINT [FK_ProjectAttributes_Projects]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_Directorates]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_EntityStatuses]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_ParentProject] FOREIGN KEY([ParentProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ParentProject]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_ProjectManager] FOREIGN KEY([ProjectManagerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ProjectManager]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_ReportApproverUsers] FOREIGN KEY([ReportApproverUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ReportApproverUsers]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_ReportingLeadUsers] FOREIGN KEY([ReportingLeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ReportingLeadUsers]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_SeniorResponsibleOwner] FOREIGN KEY([SeniorResponsibleOwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_SeniorResponsibleOwner]
GO
ALTER TABLE [dbo].[ProjectUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUpdates_ProjectBusinessCaseTypes] FOREIGN KEY([BusinessCaseTypeID])
REFERENCES [dbo].[ProjectBusinessCaseTypes] ([ID])
GO
ALTER TABLE [dbo].[ProjectUpdates] CHECK CONSTRAINT [FK_ProjectUpdates_ProjectBusinessCaseTypes]
GO
ALTER TABLE [dbo].[ProjectUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUpdates_ProjectPhases] FOREIGN KEY([ProjectPhaseID])
REFERENCES [dbo].[ProjectPhases] ([ID])
GO
ALTER TABLE [dbo].[ProjectUpdates] CHECK CONSTRAINT [FK_ProjectUpdates_ProjectPhases]
GO
ALTER TABLE [dbo].[ProjectUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUpdates_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[ProjectUpdates] CHECK CONSTRAINT [FK_ProjectUpdates_Projects]
GO
ALTER TABLE [dbo].[ProjectUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUpdates_RagOptionBenefit] FOREIGN KEY([BenefitsRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[ProjectUpdates] CHECK CONSTRAINT [FK_ProjectUpdates_RagOptionBenefit]
GO
ALTER TABLE [dbo].[ProjectUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUpdates_RagOptionFinance] FOREIGN KEY([FinanceRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[ProjectUpdates] CHECK CONSTRAINT [FK_ProjectUpdates_RagOptionFinance]
GO
ALTER TABLE [dbo].[ProjectUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUpdates_RagOptionMilestone] FOREIGN KEY([MilestonesRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[ProjectUpdates] CHECK CONSTRAINT [FK_ProjectUpdates_RagOptionMilestone]
GO
ALTER TABLE [dbo].[ProjectUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUpdates_RagOptionOverall] FOREIGN KEY([OverallRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[ProjectUpdates] CHECK CONSTRAINT [FK_ProjectUpdates_RagOptionOverall]
GO
ALTER TABLE [dbo].[ProjectUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUpdates_RagOptionPeople] FOREIGN KEY([PeopleRagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[ProjectUpdates] CHECK CONSTRAINT [FK_ProjectUpdates_RagOptionPeople]
GO
ALTER TABLE [dbo].[ProjectUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[ProjectUpdates] CHECK CONSTRAINT [FK_ProjectUpdates_SignOffs]
GO
ALTER TABLE [dbo].[ProjectUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ProjectUpdates_UpdateUser] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ProjectUpdates] CHECK CONSTRAINT [FK_ProjectUpdates_UpdateUser]
GO
ALTER TABLE [dbo].[RagOptionsMapping]  WITH CHECK ADD  CONSTRAINT [FK_RagOptionsMapping_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[RagOptionsMapping] CHECK CONSTRAINT [FK_RagOptionsMapping_RagOptions]
GO
ALTER TABLE [dbo].[RagOptionsMapping]  WITH CHECK ADD  CONSTRAINT [FK_RagOptionsMapping_RiskImpactLevels] FOREIGN KEY([RiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[RagOptionsMapping] CHECK CONSTRAINT [FK_RagOptionsMapping_RiskImpactLevels]
GO
ALTER TABLE [dbo].[RagOptionsMapping]  WITH CHECK ADD  CONSTRAINT [FK_RagOptionsMapping_RiskProbabilities] FOREIGN KEY([RiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[RagOptionsMapping] CHECK CONSTRAINT [FK_RagOptionsMapping_RiskProbabilities]
GO
ALTER TABLE [dbo].[ReportingEntities]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntities_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_Directorates]
GO
ALTER TABLE [dbo].[ReportingEntities]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntities_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_EntityStatuses]
GO
ALTER TABLE [dbo].[ReportingEntities]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntities_LeadUsers] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_LeadUsers]
GO
ALTER TABLE [dbo].[ReportingEntities]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntities_MeasurementUnits] FOREIGN KEY([MeasurementUnitID])
REFERENCES [dbo].[MeasurementUnits] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_MeasurementUnits]
GO
ALTER TABLE [dbo].[ReportingEntities]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntities_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_ModifiedByUsers]
GO
ALTER TABLE [dbo].[ReportingEntities]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntities_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_PartnerOrganisations]
GO
ALTER TABLE [dbo].[ReportingEntities]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntities_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_Projects]
GO
ALTER TABLE [dbo].[ReportingEntities]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntities_ReportingEntityTypes] FOREIGN KEY([ReportingEntityTypeID])
REFERENCES [dbo].[ReportingEntityTypes] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntities] CHECK CONSTRAINT [FK_ReportingEntities_ReportingEntityTypes]
GO
ALTER TABLE [dbo].[ReportingEntityTypes]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntityTypes_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityTypes] CHECK CONSTRAINT [FK_ReportingEntityTypes_ModifiedByUsers]
GO
ALTER TABLE [dbo].[ReportingEntityTypes]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntityTypes_ReportTypes] FOREIGN KEY([ReportTypeID])
REFERENCES [dbo].[ReportTypes] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityTypes] CHECK CONSTRAINT [FK_ReportingEntityTypes_ReportTypes]
GO
ALTER TABLE [dbo].[ReportingEntityUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntityUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityUpdates] CHECK CONSTRAINT [FK_ReportingEntityUpdates_RagOptions]
GO
ALTER TABLE [dbo].[ReportingEntityUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntityUpdates_ReportingEntities] FOREIGN KEY([ReportingEntityID])
REFERENCES [dbo].[ReportingEntities] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityUpdates] CHECK CONSTRAINT [FK_ReportingEntityUpdates_ReportingEntities]
GO
ALTER TABLE [dbo].[ReportingEntityUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntityUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityUpdates] CHECK CONSTRAINT [FK_ReportingEntityUpdates_SignOffs]
GO
ALTER TABLE [dbo].[ReportingEntityUpdates]  WITH CHECK ADD  CONSTRAINT [FK_ReportingEntityUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ReportingEntityUpdates] CHECK CONSTRAINT [FK_ReportingEntityUpdates_Users]
GO
ALTER TABLE [dbo].[ReportStaging]  WITH CHECK ADD  CONSTRAINT [FK_ReportStaging_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[ReportStaging] CHECK CONSTRAINT [FK_ReportStaging_Projects]
GO
ALTER TABLE [dbo].[ReportStaging]  WITH CHECK ADD  CONSTRAINT [FK_ReportStaging_Users] FOREIGN KEY([SubmittedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ReportStaging] CHECK CONSTRAINT [FK_ReportStaging_Users]
GO
ALTER TABLE [dbo].[ReportTypes]  WITH CHECK ADD  CONSTRAINT [FK_ReportTypes_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ReportTypes] CHECK CONSTRAINT [FK_ReportTypes_ModifiedByUsers]
GO
ALTER TABLE [dbo].[RiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActions_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_EntityStatuses]
GO
ALTER TABLE [dbo].[RiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActions_LeadUsers] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_LeadUsers]
GO
ALTER TABLE [dbo].[RiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActions_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_ModifiedByUsers]
GO
ALTER TABLE [dbo].[RiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActions_RiskMitigationActions] FOREIGN KEY([ID])
REFERENCES [dbo].[RiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_RiskMitigationActions]
GO
ALTER TABLE [dbo].[RiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActions_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_Risks]
GO
ALTER TABLE [dbo].[RiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActions_Users] FOREIGN KEY([OwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActions] CHECK CONSTRAINT [FK_RiskMitigationActions_Users]
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActionUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates] CHECK CONSTRAINT [FK_RiskMitigationActionUpdates_RagOptions]
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActionUpdates_RiskMitigationActions] FOREIGN KEY([RiskMitigationActionID])
REFERENCES [dbo].[RiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates] CHECK CONSTRAINT [FK_RiskMitigationActionUpdates_RiskMitigationActions]
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActionUpdates_RiskUpdates] FOREIGN KEY([RiskUpdateID])
REFERENCES [dbo].[RiskUpdates] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates] CHECK CONSTRAINT [FK_RiskMitigationActionUpdates_RiskUpdates]
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActionUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates] CHECK CONSTRAINT [FK_RiskMitigationActionUpdates_SignOffs]
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskMitigationActionUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskMitigationActionUpdates] CHECK CONSTRAINT [FK_RiskMitigationActionUpdates_Users]
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_RiskRiskMitigationActions_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions] CHECK CONSTRAINT [FK_RiskRiskMitigationActions_ModifiedByUsers]
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_RiskRiskMitigationActions_RiskMitigationActions] FOREIGN KEY([RiskMitigationActionID])
REFERENCES [dbo].[RiskMitigationActions] ([ID])
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions] CHECK CONSTRAINT [FK_RiskRiskMitigationActions_RiskMitigationActions]
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions]  WITH CHECK ADD  CONSTRAINT [FK_RiskRiskMitigationActions_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[RiskRiskMitigationActions] CHECK CONSTRAINT [FK_RiskRiskMitigationActions_Risks]
GO
ALTER TABLE [dbo].[RiskRiskTypes]  WITH CHECK ADD  CONSTRAINT [FK_RiskRiskTypes_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[RiskRiskTypes] CHECK CONSTRAINT [FK_RiskRiskTypes_Risks]
GO
ALTER TABLE [dbo].[RiskRiskTypes]  WITH CHECK ADD  CONSTRAINT [FK_RiskRiskTypes_RiskTypes] FOREIGN KEY([RiskTypeID])
REFERENCES [dbo].[RiskTypes] ([ID])
GO
ALTER TABLE [dbo].[RiskRiskTypes] CHECK CONSTRAINT [FK_RiskRiskTypes_RiskTypes]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_DepartmentalObjectives] FOREIGN KEY([DepartmentalObjectiveID])
REFERENCES [dbo].[DepartmentalObjectives] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_DepartmentalObjectives]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_Directorates]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_EntityStatuses]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_Groups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_Groups]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_ModifiedByUsers]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_Projects]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_RagOptions]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_ReportApproverUsers] FOREIGN KEY([ReportApproverUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_ReportApproverUsers]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_RiskAppetites] FOREIGN KEY([RiskAppetiteID])
REFERENCES [dbo].[RiskAppetites] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_RiskAppetites]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_RiskRegisters] FOREIGN KEY([RiskRegisterID])
REFERENCES [dbo].[RiskRegisters] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_RiskRegisters]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_Risks] FOREIGN KEY([LinkedRiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_Risks]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_TargetRiskImpactLevels] FOREIGN KEY([TargetRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_TargetRiskImpactLevels]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_TargetRiskProbabilities] FOREIGN KEY([TargetRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_TargetRiskProbabilities]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_UnmitigatedRiskImpactLevels] FOREIGN KEY([UnmitigatedRiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_UnmitigatedRiskImpactLevels]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_UnmitigatedRiskProbabilities] FOREIGN KEY([UnmitigatedRiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_UnmitigatedRiskProbabilities]
GO
ALTER TABLE [dbo].[Risks]  WITH CHECK ADD  CONSTRAINT [FK_Risks_Users] FOREIGN KEY([RiskOwnerUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Risks] CHECK CONSTRAINT [FK_Risks_Users]
GO
ALTER TABLE [dbo].[RiskTypes]  WITH CHECK ADD  CONSTRAINT [FK_RiskTypes_Thresholds] FOREIGN KEY([ThresholdID])
REFERENCES [dbo].[Thresholds] ([ID])
GO
ALTER TABLE [dbo].[RiskTypes] CHECK CONSTRAINT [FK_RiskTypes_Thresholds]
GO
ALTER TABLE [dbo].[RiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskUpdates_EscalateToRiskRegisters] FOREIGN KEY([EscalateToRiskRegisterID])
REFERENCES [dbo].[RiskRegisters] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_EscalateToRiskRegisters]
GO
ALTER TABLE [dbo].[RiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_RagOptions]
GO
ALTER TABLE [dbo].[RiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskUpdates_RiskImpactLevels] FOREIGN KEY([RiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_RiskImpactLevels]
GO
ALTER TABLE [dbo].[RiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskUpdates_RiskProbabilities] FOREIGN KEY([RiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_RiskProbabilities]
GO
ALTER TABLE [dbo].[RiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskUpdates_RiskRegisters] FOREIGN KEY([RiskRegisterID])
REFERENCES [dbo].[RiskRegisters] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_RiskRegisters]
GO
ALTER TABLE [dbo].[RiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskUpdates_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_Risks]
GO
ALTER TABLE [dbo].[RiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_SignOffs]
GO
ALTER TABLE [dbo].[RiskUpdates]  WITH CHECK ADD  CONSTRAINT [FK_RiskUpdates_Users] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[RiskUpdates] CHECK CONSTRAINT [FK_RiskUpdates_Users]
GO
ALTER TABLE [dbo].[SignOffs]  WITH CHECK ADD  CONSTRAINT [FK_SignOffs_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_Directorates]
GO
ALTER TABLE [dbo].[SignOffs]  WITH CHECK ADD  CONSTRAINT [FK_SignOffs_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_PartnerOrganisations]
GO
ALTER TABLE [dbo].[SignOffs]  WITH CHECK ADD  CONSTRAINT [FK_SignOffs_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_Projects]
GO
ALTER TABLE [dbo].[SignOffs]  WITH CHECK ADD  CONSTRAINT [FK_SignOffs_Risks] FOREIGN KEY([RiskID])
REFERENCES [dbo].[Risks] ([ID])
GO
ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_Risks]
GO
ALTER TABLE [dbo].[SignOffs]  WITH CHECK ADD  CONSTRAINT [FK_SignOffs_Users] FOREIGN KEY([SignOffUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[SignOffs] CHECK CONSTRAINT [FK_SignOffs_Users]
GO
ALTER TABLE [dbo].[ThresholdAppetites]  WITH CHECK ADD  CONSTRAINT [FK_ThresholdAppetites_RiskImpactLevels] FOREIGN KEY([RiskImpactLevelID])
REFERENCES [dbo].[RiskImpactLevels] ([ID])
GO
ALTER TABLE [dbo].[ThresholdAppetites] CHECK CONSTRAINT [FK_ThresholdAppetites_RiskImpactLevels]
GO
ALTER TABLE [dbo].[ThresholdAppetites]  WITH CHECK ADD  CONSTRAINT [FK_ThresholdAppetites_RiskProbabilities] FOREIGN KEY([RiskProbabilityID])
REFERENCES [dbo].[RiskProbabilities] ([ID])
GO
ALTER TABLE [dbo].[ThresholdAppetites] CHECK CONSTRAINT [FK_ThresholdAppetites_RiskProbabilities]
GO
ALTER TABLE [dbo].[ThresholdAppetites]  WITH CHECK ADD  CONSTRAINT [FK_ThresholdAppetites_Thresholds] FOREIGN KEY([ThresholdID])
REFERENCES [dbo].[Thresholds] ([ID])
GO
ALTER TABLE [dbo].[ThresholdAppetites] CHECK CONSTRAINT [FK_ThresholdAppetites_Thresholds]
GO
ALTER TABLE [dbo].[UserDirectorates]  WITH CHECK ADD  CONSTRAINT [FK_UserDirectorates_Directorates] FOREIGN KEY([DirectorateID])
REFERENCES [dbo].[Directorates] ([ID])
GO
ALTER TABLE [dbo].[UserDirectorates] CHECK CONSTRAINT [FK_UserDirectorates_Directorates]
GO
ALTER TABLE [dbo].[UserDirectorates]  WITH CHECK ADD  CONSTRAINT [FK_UserDirectorates_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserDirectorates] CHECK CONSTRAINT [FK_UserDirectorates_ModifiedByUsers]
GO
ALTER TABLE [dbo].[UserDirectorates]  WITH CHECK ADD  CONSTRAINT [FK_UserDirectorates_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserDirectorates] CHECK CONSTRAINT [FK_UserDirectorates_Users]
GO
ALTER TABLE [dbo].[UserGroups]  WITH CHECK ADD  CONSTRAINT [FK_UserGroups_Groups] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([ID])
GO
ALTER TABLE [dbo].[UserGroups] CHECK CONSTRAINT [FK_UserGroups_Groups]
GO
ALTER TABLE [dbo].[UserGroups]  WITH CHECK ADD  CONSTRAINT [FK_UserGroups_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserGroups] CHECK CONSTRAINT [FK_UserGroups_ModifiedByUsers]
GO
ALTER TABLE [dbo].[UserGroups]  WITH CHECK ADD  CONSTRAINT [FK_UserGroups_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserGroups] CHECK CONSTRAINT [FK_UserGroups_Users]
GO
ALTER TABLE [dbo].[UserPartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_UserPartnerOrganisations_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserPartnerOrganisations] CHECK CONSTRAINT [FK_UserPartnerOrganisations_ModifiedByUsers]
GO
ALTER TABLE [dbo].[UserPartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_UserPartnerOrganisations_PartnerOrganisations] FOREIGN KEY([PartnerOrganisationID])
REFERENCES [dbo].[PartnerOrganisations] ([ID])
GO
ALTER TABLE [dbo].[UserPartnerOrganisations] CHECK CONSTRAINT [FK_UserPartnerOrganisations_PartnerOrganisations]
GO
ALTER TABLE [dbo].[UserPartnerOrganisations]  WITH CHECK ADD  CONSTRAINT [FK_UserPartnerOrganisations_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserPartnerOrganisations] CHECK CONSTRAINT [FK_UserPartnerOrganisations_Users]
GO
ALTER TABLE [dbo].[UserProjects]  WITH CHECK ADD  CONSTRAINT [FK_UserProjects_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserProjects] CHECK CONSTRAINT [FK_UserProjects_ModifiedByUsers]
GO
ALTER TABLE [dbo].[UserProjects]  WITH CHECK ADD  CONSTRAINT [FK_UserProjects_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[UserProjects] CHECK CONSTRAINT [FK_UserProjects_Projects]
GO
ALTER TABLE [dbo].[UserProjects]  WITH CHECK ADD  CONSTRAINT [FK_UserProjects_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserProjects] CHECK CONSTRAINT [FK_UserProjects_Users]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_ModifiedByUsers]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([ID])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_EntityStatuses]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_ModifiedByUsers]
GO
ALTER TABLE [dbo].[WorkStreams]  WITH CHECK ADD  CONSTRAINT [FK_WorkStreams_EntityStatuses] FOREIGN KEY([EntityStatusID])
REFERENCES [dbo].[EntityStatuses] ([ID])
GO
ALTER TABLE [dbo].[WorkStreams] CHECK CONSTRAINT [FK_WorkStreams_EntityStatuses]
GO
ALTER TABLE [dbo].[WorkStreams]  WITH CHECK ADD  CONSTRAINT [FK_WorkStreams_ModifiedByUsers] FOREIGN KEY([ModifiedByUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[WorkStreams] CHECK CONSTRAINT [FK_WorkStreams_ModifiedByUsers]
GO
ALTER TABLE [dbo].[WorkStreams]  WITH CHECK ADD  CONSTRAINT [FK_WorkStreams_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ID])
GO
ALTER TABLE [dbo].[WorkStreams] CHECK CONSTRAINT [FK_WorkStreams_Projects]
GO
ALTER TABLE [dbo].[WorkStreams]  WITH CHECK ADD  CONSTRAINT [FK_WorkStreams_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[WorkStreams] CHECK CONSTRAINT [FK_WorkStreams_RagOptions]
GO
ALTER TABLE [dbo].[WorkStreams]  WITH CHECK ADD  CONSTRAINT [FK_WorkStreams_Users] FOREIGN KEY([LeadUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[WorkStreams] CHECK CONSTRAINT [FK_WorkStreams_Users]
GO
ALTER TABLE [dbo].[WorkStreamUpdates]  WITH CHECK ADD  CONSTRAINT [FK_WorkStreamUpdates_RagOptions] FOREIGN KEY([RagOptionID])
REFERENCES [dbo].[RagOptions] ([ID])
GO
ALTER TABLE [dbo].[WorkStreamUpdates] CHECK CONSTRAINT [FK_WorkStreamUpdates_RagOptions]
GO
ALTER TABLE [dbo].[WorkStreamUpdates]  WITH CHECK ADD  CONSTRAINT [FK_WorkStreamUpdates_SignOffs] FOREIGN KEY([SignOffID])
REFERENCES [dbo].[SignOffs] ([ID])
GO
ALTER TABLE [dbo].[WorkStreamUpdates] CHECK CONSTRAINT [FK_WorkStreamUpdates_SignOffs]
GO
ALTER TABLE [dbo].[WorkStreamUpdates]  WITH CHECK ADD  CONSTRAINT [FK_WorkStreamUpdates_UpdateUser] FOREIGN KEY([UpdateUserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[WorkStreamUpdates] CHECK CONSTRAINT [FK_WorkStreamUpdates_UpdateUser]
GO
ALTER TABLE [dbo].[WorkStreamUpdates]  WITH CHECK ADD  CONSTRAINT [FK_WorkStreamUpdates_WorkStreams] FOREIGN KEY([WorkStreamID])
REFERENCES [dbo].[WorkStreams] ([ID])
GO
ALTER TABLE [dbo].[WorkStreamUpdates] CHECK CONSTRAINT [FK_WorkStreamUpdates_WorkStreams]
GO
/****** Object:  StoredProcedure [reports].[spReportingEntityChoiceProperties]    Script Date: 08/11/2022 15:27:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [reports].[spReportingEntityChoiceProperties]
AS
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON

-- Source: https://stackoverflow.com/a/14789896

DECLARE @PivotQuery AS NVARCHAR(MAX);
DECLARE @ColumnNames AS NVARCHAR(MAX);

--Get distinct values of the PIVOT Column 
SELECT @ColumnNames = ISNULL(@ColumnNames + ',','') + QUOTENAME([FieldTitle])
FROM (SELECT DISTINCT [FieldTitle]
  FROM [reports].[ReportingEntityChoiceProperties]) AS [Field];

SET @PivotQuery = 
	  N'
      SELECT *
      FROM
      (
        SELECT [ReportingEntityID], [FieldTitle], STRING_AGG([Value],'', '') AS [Values]
        FROM [reports].[ReportingEntityChoiceProperties]
        GROUP BY [ReportingEntityID], [FieldTitle]
      ) src
      PIVOT
      (
        MAX([Values])
        FOR [FieldTitle] IN (' + @ColumnNames + ')
      ) piv';

EXEC sp_executesql @PivotQuery;
GO
/****** Object:  StoredProcedure [reports].[spReportingEntityLookupProperties]    Script Date: 08/11/2022 15:27:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [reports].[spReportingEntityLookupProperties]
AS
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON

-- Source: https://stackoverflow.com/a/14789896

DECLARE @PivotQuery AS NVARCHAR(MAX);
DECLARE @ColumnNames AS NVARCHAR(MAX);

--Get distinct values of the PIVOT Column 
SELECT @ColumnNames = ISNULL(@ColumnNames + ',','') + QUOTENAME([FieldTitle])
FROM (SELECT DISTINCT [FieldTitle]
  FROM [reports].[ReportingEntityLookupProperties]) AS [Field];

SET @PivotQuery = 
	  N'
      SELECT *
      FROM
      (
        SELECT [ReportingEntityID], [FieldTitle], STRING_AGG([Value],'', '') AS [Values]
        FROM [reports].[ReportingEntityLookupProperties]
        GROUP BY [ReportingEntityID], [FieldTitle]
      ) src
      PIVOT
      (
      MAX([Values])
      FOR [FieldTitle] IN (' + @ColumnNames + ')
      ) piv';

EXEC sp_executesql @PivotQuery;
GO
/****** Object:  StoredProcedure [reports].[spReportingEntityNumberProperties]    Script Date: 08/11/2022 15:27:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [reports].[spReportingEntityNumberProperties]
AS
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON

-- Source: https://stackoverflow.com/a/14789896

DECLARE @PivotQuery AS NVARCHAR(MAX);
DECLARE @ColumnNames AS NVARCHAR(MAX);

--Get distinct values of the PIVOT Column 
SELECT @ColumnNames = ISNULL(@ColumnNames + ',','') + QUOTENAME([FieldTitle])
FROM (SELECT DISTINCT [FieldTitle]
  FROM [reports].[ReportingEntityNumberProperties]) AS [Field];

SET @PivotQuery = 
	  N'
      SELECT *
      FROM
      (
        SELECT [ReportingEntityID], [FieldTitle], STRING_AGG([Value],'', '') AS [Values]
        FROM [reports].[ReportingEntityNumberProperties]
        GROUP BY [ReportingEntityID], [FieldTitle]
      ) src
      PIVOT
      (
        MAX([Values])
        FOR [FieldTitle] IN (' + @ColumnNames + ')
      ) piv';

EXEC sp_executesql @PivotQuery;
GO
/****** Object:  StoredProcedure [reports].[spReportingEntityTextProperties]    Script Date: 08/11/2022 15:27:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [reports].[spReportingEntityTextProperties]
AS
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON

-- Source: https://stackoverflow.com/a/14789896

DECLARE @PivotQuery AS NVARCHAR(MAX);
DECLARE @ColumnNames AS NVARCHAR(MAX);

--Get distinct values of the PIVOT Column 
SELECT @ColumnNames = ISNULL(@ColumnNames + ',','') + QUOTENAME([FieldTitle])
FROM (SELECT DISTINCT [FieldTitle]
  FROM [reports].[ReportingEntityTextProperties]) AS [Field];

SET @PivotQuery = 
	  N'
      SELECT *
      FROM
      (
        SELECT [ReportingEntityID], [FieldTitle], STRING_AGG([Value],'', '') AS [Values]
        FROM [reports].[ReportingEntityTextProperties]
        GROUP BY [ReportingEntityID], [FieldTitle]
      ) src
      PIVOT
      (
        MAX([Values])
        FOR [FieldTitle] IN (' + @ColumnNames + ')
      ) piv';

EXEC sp_executesql @PivotQuery;
GO
/****** Object:  StoredProcedure [reports].[spReportingEntityUserProperties]    Script Date: 08/11/2022 15:27:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [reports].[spReportingEntityUserProperties]
AS
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON

-- Source: https://stackoverflow.com/a/14789896

DECLARE @PivotQuery AS NVARCHAR(MAX);
DECLARE @ColumnNames AS NVARCHAR(MAX);

--Get distinct values of the PIVOT Column 
SELECT @ColumnNames = ISNULL(@ColumnNames + ',','') + QUOTENAME([FieldTitle])
FROM (SELECT DISTINCT [FieldTitle]
  FROM [reports].[ReportingEntityUserProperties]) AS [Field];

SET @PivotQuery = 
	N'
    SELECT *
    FROM
    (
      SELECT [ReportingEntityID], [FieldTitle], STRING_AGG([User],'', '') AS [Users]
      FROM [reports].[ReportingEntityUserProperties]
      GROUP BY [ReportingEntityID], [FieldTitle]
    ) src
    PIVOT
    (
      MAX([Users])
      FOR [FieldTitle] IN (' + @ColumnNames + ')
    ) piv';

EXEC sp_executesql @PivotQuery;
GO
EXEC sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value=N'refactoring log' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'__RefactorLog'
GO
USE [master]
GO
ALTER DATABASE [dev-corp-reporting-db] SET  READ_WRITE 
GO
