
SET QUOTED_IDENTIFIER OFF;
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO
IF SCHEMA_ID(N'reports') IS NULL EXECUTE(N'CREATE SCHEMA [reports]');
GO

-- --------------------------------------------------
-- Dropping existing views
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[PreviousCommitmentUpdates]', 'V') IS NOT NULL DROP VIEW [dbo].[PreviousCommitmentUpdates]; 
GO
IF OBJECT_ID(N'[dbo].[PreviousKeyWorkAreaUpdates]', 'V') IS NOT NULL DROP VIEW [dbo].[PreviousKeyWorkAreaUpdates]; 
GO
IF OBJECT_ID(N'[dbo].[PreviousMetricUpdates]', 'V') IS NOT NULL DROP VIEW [dbo].[PreviousMetricUpdates]; 
GO
IF OBJECT_ID(N'[dbo].[PreviousMilestoneUpdates]', 'V') IS NOT NULL DROP VIEW [dbo].[PreviousMilestoneUpdates]; 
GO
IF OBJECT_ID(N'[dbo].[PreviousWorkStreamUpdates]', 'V') IS NOT NULL DROP VIEW [dbo].[PreviousWorkStreamUpdates]; 
GO
IF OBJECT_ID(N'[dbo].[PreviousBenefitUpdates]', 'V') IS NOT NULL DROP VIEW [dbo].[PreviousBenefitUpdates]; 
GO
IF OBJECT_ID(N'[dbo].[DirectorateReportingChartDataFinance]', 'V') IS NOT NULL DROP VIEW [dbo].[DirectorateReportingChartDataFinance]; 
GO
IF OBJECT_ID(N'[dbo].[DirectorateReportingChartDataPeople]', 'V') IS NOT NULL DROP VIEW [dbo].[DirectorateReportingChartDataPeople]; 
GO
IF OBJECT_ID(N'[dbo].[DirectorateReportingChartDataMilestones]', 'V') IS NOT NULL DROP VIEW [dbo].[DirectorateReportingChartDataMilestones]; 
GO
IF OBJECT_ID(N'[dbo].[DirectorateReportingChartDataMetrics]', 'V') IS NOT NULL DROP VIEW [dbo].[DirectorateReportingChartDataMetrics]; 
GO
IF OBJECT_ID(N'[dbo].[DirectorateReportingChartDataDeliveryConfidence]', 'V') IS NOT NULL DROP VIEW [dbo].[DirectorateReportingChartDataDeliveryConfidence]; 
GO
IF OBJECT_ID(N'[dbo].[ProjectReportingChartDataPeople]', 'V') IS NOT NULL DROP VIEW [dbo].[ProjectReportingChartDataPeople]; 
GO
IF OBJECT_ID(N'[dbo].[ProjectReportingChartDataMilestones]', 'V') IS NOT NULL DROP VIEW [dbo].[ProjectReportingChartDataMilestones]; 
GO
IF OBJECT_ID(N'[dbo].[ProjectReportingChartDataFinance]', 'V') IS NOT NULL DROP VIEW [dbo].[ProjectReportingChartDataFinance]; 
GO
IF OBJECT_ID(N'[dbo].[ProjectReportingChartDataDeliveryConfidence]', 'V') IS NOT NULL DROP VIEW [dbo].[ProjectReportingChartDataDeliveryConfidence]; 
GO
IF OBJECT_ID(N'[dbo].[ProjectReportingChartDataBenefits]', 'V') IS NOT NULL DROP VIEW [dbo].[ProjectReportingChartDataBenefits]; 
GO
IF OBJECT_ID(N'[dbo].[PreviousDependencyUpdates]', 'V') IS NOT NULL DROP VIEW [dbo].[PreviousDependencyUpdates]; 
GO
IF OBJECT_ID(N'[reports].[DependencyUpdates]', 'V') IS NOT NULL DROP VIEW [reports].[DependencyUpdates]; 
GO
IF OBJECT_ID(N'[reports].[ProjectReportingChartData]', 'V') IS NOT NULL DROP VIEW [reports].[ProjectReportingChartData]; 
GO
IF OBJECT_ID(N'[reports].[DirectorateUpdates]', 'V') IS NOT NULL DROP VIEW [reports].[DirectorateUpdates]; 
GO
IF OBJECT_ID(N'[reports].[ProjectUpdates]', 'V') IS NOT NULL DROP VIEW [reports].[ProjectUpdates]; 
GO
IF OBJECT_ID(N'[reports].[DirectorateReportingChartData]', 'V') IS NOT NULL DROP VIEW [reports].[DirectorateReportingChartData]; 
GO
IF OBJECT_ID(N'[reports].[BenefitUpdates]', 'V') IS NOT NULL DROP VIEW [reports].[BenefitUpdates]; 
GO
IF OBJECT_ID(N'[reports].[WorkStreamUpdates]', 'V') IS NOT NULL DROP VIEW [reports].[WorkStreamUpdates]; 
GO
IF OBJECT_ID(N'[reports].[MilestoneUpdates]', 'V') IS NOT NULL DROP VIEW [reports].[MilestoneUpdates]; 
GO
IF OBJECT_ID(N'[reports].[MetricUpdates]', 'V') IS NOT NULL DROP VIEW [reports].[MetricUpdates]; 
GO
IF OBJECT_ID(N'[reports].[KeyWorkAreaUpdates]', 'V') IS NOT NULL DROP VIEW [reports].[KeyWorkAreaUpdates]; 
GO
IF OBJECT_ID(N'[reports].[CommitmentUpdates]', 'V') IS NOT NULL DROP VIEW [reports].[CommitmentUpdates]; 
GO
IF OBJECT_ID(N'[reports].[KeyWorkAreaChartData]', 'V') IS NOT NULL DROP VIEW [reports].[KeyWorkAreaChartData]; 
GO
IF OBJECT_ID(N'[reports].[WorkStreamChartData]', 'V') IS NOT NULL DROP VIEW [reports].[WorkStreamChartData]; 
GO


-- --------------------------------------------------
-- Creating all views
-- --------------------------------------------------





CREATE VIEW [dbo].[PreviousCommitmentUpdates]
AS
SELECT   dbo.CommitmentUpdates.CommitmentID AS [CommitmentID]
			,EOMONTH(DATEADD(month, 1, dbo.SignOffs.ReportMonth)) AS [NextMonth]
			,dbo.RagOptions.ReportName AS [PreviousRAG]
			,dbo.RagOptions.Score AS [PreviousRAGScore]
FROM    dbo.SignOffs INNER JOIN
            dbo.CommitmentUpdates ON dbo.SignOffs.ID = dbo.CommitmentUpdates.SignOffID LEFT OUTER JOIN
            dbo.RagOptions ON dbo.CommitmentUpdates.RagOptionID = dbo.RagOptions.ID
WHERE dbo.SignOffs.IsCurrent = 1
GO
/****** Object:  View [reports].[CommitmentUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [reports].[CommitmentUpdates]
AS
SELECT       dbo.CommitmentUpdates.ID AS [Commitment Update ID]
			,dbo.SignOffs.ID AS [Sign Off ID]
			,dbo.Groups.Title AS [Group]
			,dbo.Directorates.Title AS [Directorate]
			,dbo.SignOffs.ReportMonth AS [Report Month]
			,dbo.CommitmentUpdates.UpdateDate AS [Authored Date]
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
FROM     dbo.Commitments LEFT OUTER JOIN
            dbo.CommitmentUpdates ON dbo.CommitmentUpdates.SignOffID IS NOT NULL AND dbo.Commitments.ID = dbo.CommitmentUpdates.CommitmentID INNER JOIN
            dbo.SignOffs ON dbo.CommitmentUpdates.SignOffID = dbo.SignOffs.ID LEFT OUTER JOIN
            dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
            dbo.Users AS LeadUser ON dbo.Commitments.LeadUserID = LeadUser.ID LEFT OUTER JOIN
			dbo.Users AS UpdateAuthor ON dbo.CommitmentUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
            dbo.RagOptions ON dbo.CommitmentUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
            dbo.PreviousCommitmentUpdates ON dbo.Commitments.ID = dbo.PreviousCommitmentUpdates.CommitmentID AND dbo.SignOffs.ReportMonth = dbo.PreviousCommitmentUpdates.NextMonth
WHERE (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[PreviousKeyWorkAreaUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[PreviousKeyWorkAreaUpdates]
AS
SELECT  dbo.KeyWorkAreas.ID
			,EOMONTH(DATEADD(month, 1, dbo.SignOffs.ReportMonth)) AS [NextMonth]
			,dbo.RagOptions.ReportName AS [PreviousRAG]
			,dbo.RagOptions.Score AS [PreviousRAGScore]
FROM  dbo.KeyWorkAreas INNER JOIN
			dbo.KeyWorkAreaUpdates ON dbo.KeyWorkAreas.ID = dbo.KeyWorkAreaUpdates.KeyWorkAreaID INNER JOIN
			dbo.SignOffs ON dbo.KeyWorkAreaUpdates.SignOffID = dbo.SignOffs.ID INNER JOIN
			dbo.RagOptions ON dbo.KeyWorkAreaUpdates.RagOptionID = dbo.RagOptions.ID
WHERE dbo.SignOffs.IsCurrent = 1
						 
GO
/****** Object:  View [reports].[KeyWorkAreaUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [reports].[KeyWorkAreaUpdates]
AS
SELECT       dbo.KeyWorkAreaUpdates.ID AS [Key Work Area Update ID]
			,dbo.KeyWorkAreaUpdates.SignOffID AS [Sign Off ID]
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
			,dbo.PreviousKeyWorkAreaUpdates.PreviousRAGScore - dbo.RagOptions.Score AS [RAG Change]
			,LeadUser.Title AS [Lead]
			,UpdateAuthor.Title AS [Author]
			,dbo.KeyWorkAreaUpdates.UpdateDate AS [Authored Date]
FROM      dbo.SignOffs LEFT OUTER JOIN
            dbo.KeyWorkAreaUpdates ON dbo.SignOffs.ID = dbo.KeyWorkAreaUpdates.SignOffID INNER JOIN
            dbo.KeyWorkAreas ON dbo.KeyWorkAreaUpdates.KeyWorkAreaID = dbo.KeyWorkAreas.ID INNER JOIN
            dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID AND dbo.KeyWorkAreas.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
            dbo.Users AS LeadUser ON dbo.KeyWorkAreas.LeadUserID = LeadUser.ID LEFT OUTER JOIN
			dbo.Users AS UpdateAuthor ON dbo.KeyWorkAreaUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
            dbo.RagOptions ON dbo.KeyWorkAreaUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
            dbo.PreviousKeyWorkAreaUpdates ON dbo.KeyWorkAreas.ID = dbo.PreviousKeyWorkAreaUpdates.ID AND dbo.SignOffs.ReportMonth = dbo.PreviousKeyWorkAreaUpdates.NextMonth
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[PreviousMetricUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[PreviousMetricUpdates]
AS
SELECT  dbo.MetricUpdates.MetricID AS [MetricID]
		,EOMONTH(DATEADD(month, 1, dbo.SignOffs.ReportMonth)) AS [NextMonth]
		,dbo.MetricUpdates.CurrentPerformance AS [PreviousPerformance]
		,dbo.RagOptions.ReportName AS [PreviousRAG]
		,dbo.RagOptions.Score AS [PreviousRAGScore]
FROM   dbo.SignOffs INNER JOIN
		dbo.MetricUpdates ON dbo.SignOffs.ID = dbo.MetricUpdates.SignOffID LEFT OUTER JOIN
        dbo.RagOptions ON dbo.MetricUpdates.RagOptionID = dbo.RagOptions.ID
WHERE (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [reports].[MetricUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [reports].[MetricUpdates]
AS
SELECT	dbo.MetricUpdates.ID AS [Metric Update ID]
		,dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,dbo.Metrics.ID AS [Metric ID]
		,dbo.Metrics.MetricCode AS [Metric ID (User)]
		,dbo.Metrics.Title AS [Metric]
		,dbo.MetricUpdates.Comment AS [Progress Update]
		,CAST(dbo.PreviousMetricUpdates.PreviousPerformance AS float) AS [Previous Performance]
		,CAST(dbo.MetricUpdates.CurrentPerformance AS float) AS [Current Performance]
		,CAST(dbo.Metrics.TargetPerformanceLowerLimit AS float) AS [Target Performance Lower]
		,CAST(dbo.Metrics.TargetPerformanceUpperLimit AS float) AS [Target Performance Upper]
		,dbo.MeasurementUnits.Title AS [Performance Unit]
		,dbo.PreviousMetricUpdates.PreviousRAG AS [Previous RAG]
		,dbo.PreviousMetricUpdates.PreviousRAGScore AS [Previous RAG Score]
		,dbo.RagOptions.ReportName AS [Current RAG]
		,dbo.RagOptions.Score AS [Current RAG Score]
		,dbo.PreviousMetricUpdates.PreviousRAGScore-dbo.RagOptions.Score AS [RAG Change]
		,dbo.Users.Title AS [Lead]
		,UpdateAuthor.Title AS [Author]
		,dbo.MetricUpdates.UpdateDate AS [Authored Date]
FROM    dbo.SignOffs LEFT OUTER JOIN
        dbo.MetricUpdates ON dbo.SignOffs.ID = dbo.MetricUpdates.SignOffID INNER JOIN
        dbo.Metrics ON dbo.MetricUpdates.MetricID = dbo.Metrics.ID INNER JOIN
        dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID AND dbo.Metrics.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
        dbo.Users ON dbo.Metrics.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON dbo.MetricUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.MetricUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
        dbo.PreviousMetricUpdates ON dbo.Metrics.ID = dbo.PreviousMetricUpdates.MetricID AND dbo.SignOffs.ReportMonth = dbo.PreviousMetricUpdates.NextMonth LEFT OUTER JOIN
		dbo.MeasurementUnits ON dbo.Metrics.MeasurementUnitID = dbo.MeasurementUnits.ID
WHERE   (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[PreviousMilestoneUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[PreviousMilestoneUpdates]
AS
SELECT    dbo.MilestoneUpdates.MilestoneID
			,EOMONTH(DATEADD(month, 1, dbo.SignOffs.ReportMonth)) AS [NextMonth]
			,dbo.RagOptions.ReportName AS [PreviousRAG]
			,dbo.RagOptions.Score AS [PreviousRAGScore]
FROM   dbo.SignOffs INNER JOIN
            dbo.MilestoneUpdates ON dbo.SignOffs.ID = dbo.MilestoneUpdates.SignOffID LEFT OUTER JOIN
            dbo.RagOptions ON dbo.MilestoneUpdates.RagOptionID = dbo.RagOptions.ID
WHERE dbo.SignOffs.IsCurrent = 1
GO
/****** Object:  View [reports].[MilestoneUpdates]    Script Date: 17/01/2019 09:38:31 ******/
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
			,dbo.Milestones.BaselineDate AS [Baseline]
			,dbo.MilestoneUpdates.ForecastDate AS [Forecast]
			,MilestoneUpdates.ActualDate AS [Actual]
			,dbo.PreviousMilestoneUpdates.PreviousRAG AS [Previous RAG]
			,dbo.PreviousMilestoneUpdates.PreviousRAGScore AS [Previous RAG Score]
			,dbo.RagOptions.ReportName AS [Current RAG]
			,dbo.RagOptions.ID AS [Current RAG Score]
			,dbo.PreviousMilestoneUpdates.PreviousRAGScore - dbo.RagOptions.ID AS [RAG Change]
			,dbo.Users.Title AS [Lead]
			,UpdateAuthor.Title AS [Author]
			,dbo.MilestoneUpdates.UpdateDate AS [Authored Date]
			,CASE WHEN SdpMilestones.ID IS NOT NULL THEN 'Yes' ELSE NULL END AS [SDP]
			,SdpMilestones.AttributeValue AS [SDP Value]
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
            dbo.Attributes AS SdpMilestones ON dbo.Milestones.ID = SdpMilestones.MilestoneID AND SdpMilestones.AttributeTypeID = 2
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[PreviousWorkStreamUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[PreviousWorkStreamUpdates]
AS
SELECT   dbo.WorkStreams.ID
			,EOMONTH(DATEADD(month, 1, dbo.SignOffs.ReportMonth)) AS [NextMonth]
			,dbo.RagOptions.ReportName AS [PreviousRAG]
			,dbo.RagOptions.Score AS [PreviousRAGScore]
FROM     dbo.SignOffs INNER JOIN
            dbo.WorkStreamUpdates ON dbo.SignOffs.ID = dbo.WorkStreamUpdates.SignOffID INNER JOIN
			dbo.WorkStreams ON dbo.WorkStreamUpdates.WorkStreamID = dbo.WorkStreams.ID LEFT OUTER JOIN
            dbo.RagOptions ON dbo.WorkStreamUpdates.RagOptionID = dbo.RagOptions.ID
WHERE dbo.SignOffs.IsCurrent = 1
GO
/****** Object:  View [reports].[WorkStreamUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [reports].[WorkStreamUpdates]
AS
SELECT   dbo.WorkStreamUpdates.ID AS [Work Stream Update ID]
		,dbo.WorkStreamUpdates.SignOffID AS [Sign Off ID]
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
		,dbo.PreviousWorkStreamUpdates.PreviousRAGScore - dbo.RagOptions.Score AS [RAG Change]
		,LeadUser.Title AS [Lead]
		,UpdateAuthor.Title AS [Author]
		,dbo.WorkStreamUpdates.UpdateDate AS [Authored Date]
FROM  dbo.SignOffs LEFT OUTER JOIN
        dbo.WorkStreamUpdates ON dbo.SignOffs.ID = dbo.WorkStreamUpdates.SignOffID INNER JOIN
        dbo.WorkStreams ON dbo.WorkStreamUpdates.WorkStreamID = dbo.WorkStreams.ID INNER JOIN
        dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID AND dbo.WorkStreams.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
		dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
        dbo.Users AS LeadUser ON dbo.WorkStreams.LeadUserID = LeadUser.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON dbo.WorkStreamUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
        dbo.RagOptions ON dbo.WorkStreamUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
        dbo.PreviousWorkStreamUpdates ON dbo.WorkStreams.ID = dbo.PreviousWorkStreamUpdates.ID AND dbo.SignOffs.ReportMonth = dbo.PreviousWorkStreamUpdates.NextMonth
WHERE   (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[PreviousBenefitUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[PreviousBenefitUpdates]
AS
SELECT	dbo.Benefits.ID AS [BenefitID]
			,EOMONTH(DATEADD(month, 1, dbo.SignOffs.ReportMonth)) AS [NextMonth]
			,dbo.BenefitUpdates.CurrentPerformance AS [PreviousPerformance]
			,dbo.RagOptions.ReportName AS [PreviousRAG]
			,dbo.RagOptions.Score AS [PreviousRAGScore]
FROM    dbo.SignOffs INNER JOIN
            dbo.BenefitUpdates ON dbo.SignOffs.ID = dbo.BenefitUpdates.SignOffID INNER JOIN
			dbo.Benefits ON dbo.BenefitUpdates.BenefitID = dbo.Benefits.ID LEFT OUTER JOIN
            dbo.RagOptions ON dbo.BenefitUpdates.RagOptionID = dbo.RagOptions.ID
WHERE dbo.SignOffs.IsCurrent = 1
GO
/****** Object:  View [reports].[BenefitUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [reports].[BenefitUpdates]
AS
SELECT	dbo.BenefitUpdates.ID AS [Benefit Update ID]
		,dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,dbo.Benefits.ID AS [Benefit ID]
		,dbo.Benefits.Title AS [Benefit]
		,dbo.BenefitUpdates.Comment AS [Progress Update]
		,CAST(dbo.PreviousBenefitUpdates.PreviousPerformance AS float) AS [Previous Performance]
		,CAST(dbo.BenefitUpdates.CurrentPerformance AS float) AS [Current Performance]
		,CAST(dbo.Benefits.TargetPerformanceLowerLimit AS float) AS [Target Performance Lower]
		,CAST(dbo.Benefits.TargetPerformanceUpperLimit AS float) AS [Target Performance Upper]
		,dbo.MeasurementUnits.Title AS [Performance Unit]
		,dbo.PreviousBenefitUpdates.PreviousRAG AS [Previous RAG]
		,dbo.PreviousBenefitUpdates.PreviousRAGScore AS [Previous RAG Score]
		,dbo.RagOptions.ReportName AS [Current RAG]
		,dbo.RagOptions.Score AS [Current RAG Score]
		,dbo.PreviousBenefitUpdates.PreviousRAGScore-dbo.RagOptions.Score AS [RAG Change]
		,dbo.Users.Title AS [Lead]
		,UpdateAuthor.Title AS [Author]
		,dbo.BenefitUpdates.UpdateDate AS [Authored Date]
FROM            dbo.SignOffs LEFT OUTER JOIN
                         dbo.BenefitUpdates ON dbo.SignOffs.ID = dbo.BenefitUpdates.SignOffID INNER JOIN
                         dbo.Benefits ON dbo.BenefitUpdates.BenefitID = dbo.Benefits.ID INNER JOIN
						 dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID AND dbo.Benefits.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
                         dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
						 dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
                         dbo.Users ON dbo.Benefits.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
						 dbo.Users AS UpdateAuthor ON dbo.BenefitUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
						 dbo.RagOptions ON dbo.BenefitUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
                         dbo.PreviousBenefitUpdates ON dbo.Benefits.ID = dbo.PreviousBenefitUpdates.BenefitID AND dbo.SignOffs.ReportMonth = dbo.PreviousBenefitUpdates.NextMonth LEFT OUTER JOIN
						 dbo.MeasurementUnits ON dbo.Benefits.MeasurementUnitID = dbo.MeasurementUnits.ID
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[PreviousDependencyUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[PreviousDependencyUpdates]
AS
SELECT  dbo.DependencyUpdates.DependencyID AS [DependencyID]
		,EOMONTH(DATEADD(month, 1, dbo.SignOffs.ReportMonth)) AS [NextMonth]
		,dbo.RagOptions.ReportName AS [PreviousRAG]
		,dbo.RagOptions.Score AS [PreviousRAGScore]
FROM            dbo.SignOffs INNER JOIN
                dbo.DependencyUpdates ON dbo.SignOffs.ID = dbo.DependencyUpdates.SignOffID LEFT OUTER JOIN
                dbo.RagOptions ON dbo.DependencyUpdates.RagOptionID = dbo.RagOptions.ID
WHERE dbo.SignOffs.IsCurrent = 1
GO
/****** Object:  View [reports].[DependencyUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [reports].[DependencyUpdates]
AS
SELECT  dbo.DependencyUpdates.ID AS [Dependency Update ID]
		,dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,dbo.Dependencies.ThirdParty AS [Name of third party]
		,dbo.Dependencies.ID AS [Dependency ID]
		,dbo.Dependencies.Title AS [Dependency]
		,dbo.DependencyUpdates.Comment AS [Progress Update]
		,dbo.PreviousDependencyUpdates.PreviousRAG AS [Previous RAG]
		,dbo.PreviousDependencyUpdates.PreviousRAGScore AS [Previous RAG Score]
		,dbo.RagOptions.ReportName AS [Current RAG]
		,dbo.RagOptions.Score AS [Current RAG Score]
		,dbo.RagOptions.Score - dbo.PreviousDependencyUpdates.PreviousRAGScore AS [RAG Change]
		,dbo.Users.Title AS [Lead]
		,UpdateAuthor.Title AS [Author]
		,dbo.DependencyUpdates.UpdateDate AS [Authored Date]
FROM        dbo.SignOffs LEFT OUTER JOIN
				dbo.DependencyUpdates ON dbo.SignOffs.ID = dbo.DependencyUpdates.SignOffID INNER JOIN
				dbo.Dependencies ON dbo.DependencyUpdates.DependencyID = dbo.Dependencies.ID INNER JOIN
				dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID AND dbo.Dependencies.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
				dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
				dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
                dbo.Users ON dbo.Dependencies.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
				dbo.Users AS UpdateAuthor ON dbo.DependencyUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
                dbo.RagOptions ON dbo.DependencyUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
                dbo.PreviousDependencyUpdates ON dbo.Dependencies.ID = dbo.PreviousDependencyUpdates.DependencyID AND dbo.SignOffs.ReportMonth = dbo.PreviousDependencyUpdates.NextMonth
WHERE		(dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [dbo].[PreviousDirectorateUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE VIEW [dbo].[PreviousDirectorateUpdates]
AS
SELECT   dbo.DirectorateUpdates.DirectorateID
			,EOMONTH(DATEADD(month, 1, dbo.SignOffs.ReportMonth)) AS [NextMonth]
			,DeliveryConfidenceRAG.ReportName AS [PreviousDeliveryConfidenceRAG]
			,DeliveryConfidenceRAG.Score AS [PreviousDeliveryConfidenceRAGScore]
			,FinanceRAG.ReportName AS [PreviousFinanceRAG]
			,FinanceRAG.Score AS [PreviousFinanceRAGScore]
			,MetricsRAG.ReportName AS [PreviousMetricsRAG]
			,MetricsRAG.Score AS [PreviousMetricsRAGScore]
			,MilestonesRAG.ReportName AS [PreviousMilestonesRAG]
			,MilestonesRAG.Score AS [PreviousMilestonesRAGScore]
			,PeopleRAG.ReportName AS [PreviousPeopleRAG]
			,PeopleRAG.Score AS [PreviousPeopleRAGScore]
FROM    dbo.SignOffs INNER JOIN
            dbo.DirectorateUpdates ON dbo.SignOffs.ID = dbo.DirectorateUpdates.SignOffID LEFT OUTER JOIN
			dbo.RagOptions AS DeliveryConfidenceRAG ON dbo.DirectorateUpdates.OverallRagOptionID = DeliveryConfidenceRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS FinanceRAG ON dbo.DirectorateUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
			dbo.RagOptions AS MetricsRAG ON dbo.DirectorateUpdates.MetricsRagOptionID = MetricsRAG.ID LEFT OUTER JOIN
			dbo.RagOptions AS MilestonesRAG ON dbo.DirectorateUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
			dbo.RagOptions AS PeopleRAG ON dbo.DirectorateUpdates.PeopleRagOptionID = PeopleRAG.ID 
GO
/****** Object:  View [dbo].[DirectorateReportingChartDataFinance]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [dbo].[DirectorateReportingChartDataPeople]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [dbo].[DirectorateReportingChartDataMilestones]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [dbo].[DirectorateReportingChartDataMetrics]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [dbo].[DirectorateReportingChartDataDeliveryConfidence]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [reports].[DirectorateReportingChartData]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [dbo].[PreviousProjectUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE VIEW [dbo].[PreviousProjectUpdates]
AS
SELECT   dbo.ProjectUpdates.ProjectID
			,EOMONTH(DATEADD(month, 1, dbo.SignOffs.ReportMonth)) AS [NextMonth]
			,DeliveryConfidenceRAG.ReportName AS [PreviousDeliveryConfidenceRAG]
			,DeliveryConfidenceRAG.Score AS [PreviousDeliveryConfidenceRAGScore]
			,FinanceRAG.ReportName AS [PreviousFinanceRAG]
			,FinanceRAG.Score AS [PreviousFinanceRAGScore]
			,BenefitsRAG.ReportName AS [PreviousBenefitsRAG]
			,BenefitsRAG.Score AS [PreviousBenefitsRAGScore]
			,MilestonesRAG.ReportName AS [PreviousMilestonesRAG]
			,MilestonesRAG.Score AS [PreviousMilestonesRAGScore]
			,PeopleRAG.ReportName AS [PreviousPeopleRAG]
			,PeopleRAG.Score AS [PreviousPeopleRAGScore]
FROM    dbo.SignOffs INNER JOIN
            dbo.ProjectUpdates ON dbo.SignOffs.ID = dbo.ProjectUpdates.SignOffID LEFT OUTER JOIN
			dbo.RagOptions AS DeliveryConfidenceRAG ON dbo.ProjectUpdates.OverallRagOptionID = DeliveryConfidenceRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS FinanceRAG ON dbo.ProjectUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
			dbo.RagOptions AS BenefitsRAG ON dbo.ProjectUpdates.BenefitsRagOptionID = BenefitsRAG.ID LEFT OUTER JOIN
			dbo.RagOptions AS MilestonesRAG ON dbo.ProjectUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
			dbo.RagOptions AS PeopleRAG ON dbo.ProjectUpdates.PeopleRagOptionID = PeopleRAG.ID 
WHERE dbo.SignOffs.IsCurrent = 1
GO
/****** Object:  View [dbo].[ProjectReportingChartDataPeople]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [dbo].[ProjectReportingChartDataMilestones]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [dbo].[ProjectReportingChartDataFinance]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [dbo].[ProjectReportingChartDataDeliveryConfidence]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [dbo].[ProjectReportingChartDataBenefits]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [reports].[ProjectReportingChartData]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [reports].[Attributes]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [reports].[Attributes]
AS
SELECT	dbo.Attributes.ID AS [Attribute ID]
		,dbo.AttributeTypes.Title AS [Attribute]
		,dbo.Attributes.AttributeValue AS [Attribute Value]
		,dbo.Attributes.BenefitID AS [Benefit ID]
		,dbo.Attributes.CommitmentID AS [Commitment ID]
		,dbo.Attributes.KeyWorkAreaID AS [Key Work Area ID]
		,dbo.Attributes.MetricID AS [Metric ID]
		,dbo.Attributes.MilestoneID AS [Milestone ID]
		,dbo.Attributes.WorkStreamID AS [Work Stream ID]
FROM	dbo.Attributes INNER JOIN
		dbo.AttributeTypes ON dbo.Attributes.AttributeTypeID = dbo.AttributeTypes.ID
GO
/****** Object:  View [reports].[Benefits]    Script Date: 17/01/2019 09:38:31 ******/
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
			,dbo.MeasurementUnits.Title AS [Performance Unit]
			,dbo.Benefits.TargetPerformanceLowerLimit AS [Target Performance Lower Limit]
			,dbo.Benefits.TargetPerformanceUpperLimit AS [Target Performance Upper Limit]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
FROM     dbo.Benefits LEFT OUTER JOIN
			dbo.Projects ON dbo.Benefits.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
			dbo.BenefitTypes ON dbo.Benefits.BenefitTypeID = dbo.BenefitTypes.ID LEFT OUTER JOIN
			dbo.MeasurementUnits ON dbo.Benefits.MeasurementUnitID = dbo.MeasurementUnits.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Benefits.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Benefits.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[KeyWorkAreas]    Script Date: 17/01/2019 09:38:31 ******/
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
FROM     dbo.KeyWorkAreas LEFT OUTER JOIN
			dbo.Directorates ON dbo.KeyWorkAreas.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Users ON dbo.KeyWorkAreas.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.KeyWorkAreas.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[Metrics]    Script Date: 17/01/2019 09:38:31 ******/
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
			,dbo.Directorates.Title AS [Directorate]
			,dbo.MeasurementUnits.Title AS [Performance Unit]
			,dbo.Metrics.TargetPerformanceLowerLimit AS [Target Performance Lower Limit]
			,dbo.Metrics.TargetPerformanceUpperLimit AS [Target Performance Upper Limit]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
FROM     dbo.Metrics LEFT OUTER JOIN
			dbo.Directorates ON dbo.Metrics.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.MeasurementUnits ON dbo.Metrics.MeasurementUnitID = dbo.MeasurementUnits.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Metrics.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Metrics.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[Milestones]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [reports].[Milestones]
AS
SELECT    dbo.Milestones.ID AS [Milestone ID]
			,dbo.Milestones.MilestoneCode AS [Milestone ID (User)]
			,dbo.Milestones.Title AS [Milestone]
			,dbo.Milestones.BaselineDate AS [Baseline]
			,dbo.Milestones.ForecastDate AS [Forecast]
			,dbo.Milestones.ActualDate AS [Actual]
			,dbo.MilestoneTypes.Title AS [Milestone Type]
			,dbo.KeyWorkAreas.Title AS [Key Work Area]
			,dbo.WorkStreams.Title AS [Work Stream]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
FROM     dbo.Milestones LEFT OUTER JOIN
			dbo.MilestoneTypes ON dbo.Milestones.MilestoneTypeID = dbo.MilestoneTypes.ID LEFT OUTER JOIN
			dbo.KeyWorkAreas ON dbo.Milestones.KeyWorkAreaID = dbo.KeyWorkAreas.ID LEFT OUTER JOIN
			dbo.WorkStreams ON dbo.Milestones.WorkStreamID = dbo.WorkStreams.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Milestones.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Milestones.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[WorkStreams]    Script Date: 17/01/2019 09:38:31 ******/
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
FROM     dbo.WorkStreams LEFT OUTER JOIN
			dbo.Projects ON dbo.WorkStreams.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
			dbo.Users ON dbo.WorkStreams.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.WorkStreams.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[SDPActivityProgress]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [reports].[Commitments]    Script Date: 17/01/2019 09:38:31 ******/
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
FROM     dbo.Commitments LEFT OUTER JOIN
			dbo.Directorates ON dbo.Commitments.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Commitments.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Commitments.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[Dependencies]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [reports].[Dependencies]
AS
SELECT    dbo.Dependencies.ID AS [Dependency ID]
			,dbo.Dependencies.Title AS [Dependency]
			,dbo.Projects.Title AS [Project]
			,dbo.Users.Title AS [Lead]
			,dbo.EntityStatuses.Title AS [Status]
FROM     dbo.Dependencies LEFT OUTER JOIN
			dbo.Projects ON dbo.Dependencies.ProjectID = dbo.Projects.ID LEFT OUTER JOIN
			dbo.Users ON dbo.Dependencies.LeadUserID = dbo.Users.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON dbo.Dependencies.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[Directorates]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [reports].[DirectoratesLastEdit]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [reports].[DirectoratesLastEdit]
AS
SELECT d.Title AS [Directorate], MAX(du.UpdateDate) AS [Last Update Date]
FROM [dbo].[Directorates] AS d 
LEFT OUTER JOIN [dbo].[DirectorateUpdates] AS du ON d.ID = du.DirectorateID
GROUP BY d.Title
GO
/****** Object:  View [reports].[DirectorateUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [reports].[DirectorateUpdates]
AS
SELECT   dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS Directorate
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,OverallRAG.ReportName AS [Delivery Confidence RAG]
		,dbo.DirectorateUpdates.ProgressUpdate AS [Progress Update]
		,dbo.DirectorateUpdates.FutureActions AS [Future Actions]
		,dbo.DirectorateUpdates.Escalations AS [Escalations]
		,FinanceRAG.ReportName AS [Finance RAG]
		,dbo.DirectorateUpdates.FinanceComment AS [Finance Comment]
		,PeopleRAG.ReportName AS [People RAG]
		,dbo.DirectorateUpdates.PeopleComment AS [People Comment]
		,MilestonesRAG.ReportName AS [Milestones RAG]
		,dbo.DirectorateUpdates.MilestonesComment AS [Milestones Comment]
		,MetricsRAG.ReportName AS [Metrics RAG]
		,dbo.DirectorateUpdates.MetricsComment AS [Metrics Comment]
		,DirectorUser.Title AS [Director]
		,UpdateAuthor.Title AS [Author]
		,dbo.DirectorateUpdates.UpdateDate AS [Authored Date]
		,SignOffUser.Title AS [Signed-off by]
		,dbo.SignOffs.SignOffDate AS [Date signed-off]
		,dbo.Directorates.Objectives AS [Objectives]
		,dbo.SignOffs.ID AS [Sign Off ID]
		,OverallRAG.ID AS [Delivery Confidence RAG Score]
		,FinanceRAG.ID AS [Finance RAG Score]
		,PeopleRAG.ID AS [People RAG Score]
		,MilestonesRAG.ID AS [Milestones RAG Score]
		,MetricsRAG.ID AS [Metrics RAG Score]
FROM   dbo.SignOffs INNER JOIN
            dbo.Directorates ON dbo.SignOffs.DirectorateID = dbo.Directorates.ID INNER JOIN
            dbo.DirectorateUpdates ON dbo.SignOffs.ID = dbo.DirectorateUpdates.SignOffID INNER JOIN
			dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
			dbo.RagOptions AS OverallRAG ON dbo.DirectorateUpdates.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS FinanceRAG ON dbo.DirectorateUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS PeopleRAG ON dbo.DirectorateUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS MilestonesRAG ON dbo.DirectorateUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
            dbo.RagOptions AS MetricsRAG ON dbo.DirectorateUpdates.MetricsRagOptionID = MetricsRAG.ID LEFT OUTER JOIN
			dbo.Users AS UpdateAuthor ON dbo.DirectorateUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
            dbo.Users AS DirectorUser ON dbo.Directorates.DirectorUserID = DirectorUser.ID LEFT OUTER JOIN
            dbo.Users AS SignOffUser ON dbo.SignOffs.SignOffUserID = SignOffUser.ID
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [reports].[KeyWorkAreaChartData]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [reports].[MilestonesLastEdit]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [reports].[MilestonesLastEdit]
AS
SELECT m.Title AS Milestone, kwa.Title AS [Key Work Area], d.Title AS [Directorate], ws.Title AS [Work Stream], p.Title AS [Project], MAX(mu.UpdateDate) AS [Last Update Date]
FROM [dbo].[Milestones] AS m
LEFT OUTER JOIN [dbo].[MilestoneUpdates] AS mu ON m.ID = mu.MilestoneID
LEFT OUTER JOIN [dbo].[KeyWorkAreas] AS kwa ON m.KeyWorkAreaID = kwa.ID
LEFT OUTER JOIN [dbo].[Directorates] AS d ON kwa.DirectorateID = d.ID
LEFT OUTER JOIN [dbo].[WorkStreams] AS ws ON m.WorkStreamID = ws.ID
LEFT OUTER JOIN [dbo].[Projects] AS p ON ws.ProjectID = p.ID
GROUP BY m.Title, kwa.Title, d.Title, ws.Title, p.Title
GO
/****** Object:  View [reports].[ProjectAttributes]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [reports].[ProjectAttributes]
AS
SELECT	dbo.ProjectAttributes.ID AS [Project Attribute ID]
		,dbo.ProjectAttributeTypes.Title AS [Project Attribute]
		,dbo.ProjectAttributes.ProjectID AS [Project ID]
FROM	dbo.ProjectAttributes INNER JOIN
		dbo.ProjectAttributeTypes ON dbo.ProjectAttributes.ProjectAttributeTypeID = dbo.ProjectAttributeTypes.ID
GO
/****** Object:  View [reports].[Projects]    Script Date: 17/01/2019 09:38:31 ******/
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
			,Projects.StartDate AS [Start Date]
			,Projects.EndDate AS [End Date]
FROM     dbo.Projects AS Projects LEFT OUTER JOIN
            dbo.Directorates ON Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
            dbo.Users AS SroUser ON Projects.SeniorResponsibleOwnerUserID = SroUser.ID LEFT OUTER JOIN
			dbo.EntityStatuses ON Projects.EntityStatusID = dbo.EntityStatuses.ID
GO
/****** Object:  View [reports].[ProjectsLastEdit]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [reports].[ProjectsLastEdit]
AS
SELECT p.Title AS [Project], MAX(pu.UpdateDate) AS [Last Update Date]
FROM [dbo].[Projects] AS p
LEFT OUTER JOIN [dbo].[ProjectUpdates] AS pu ON p.ID = pu.ProjectID
GROUP BY p.Title
GO
/****** Object:  View [reports].[ProjectUpdates]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [reports].[ProjectUpdates]
AS
SELECT   dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
		,dbo.SignOffs.ProjectID AS [Project ID]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,OverallRAG.ReportName AS [Delivery Confidence RAG]
		,SROUser.Title AS [SRO]
		,ProjectManagerUser.Title AS [Project Manager]
		,SignOffUser.Title AS [Signed-off by]
		,dbo.SignOffs.SignOffDate AS [Date signed-off]
		,dbo.Projects.Objectives AS [Objectives]
		,FinanceRAG.ReportName AS [Finance RAG]
		,ProjectUpdates.FinanceComment AS [Finance Comment]
		,PeopleRAG.ReportName AS [People RAG]
		,ProjectUpdates.PeopleComment AS [People Comment]
		,MilestonesRAG.ReportName AS [Milestones RAG]
		,ProjectUpdates.MilestonesComment AS [Milestones Comment]
		,BenefitsRAG.ReportName AS [Benefits RAG]
		,ProjectUpdates.BenefitsComment AS [Benefits Comment]
		,ProjectUpdates.ProgressUpdate AS [Progress Update]
		,ProjectUpdates.FutureActions AS [Future Actions]
		,ProjectUpdates.Escalations AS [Escalations]
		,UpdateAuthor.Title AS [Author]
		,ProjectUpdates.UpdateDate AS [Authored Date]
		,dbo.ProjectPhases.Title AS [Current phase]
		,dbo.ProjectBusinessCaseTypes.Title AS [Latest approved business case type]
		,ProjectUpdates.BusinessCaseDate AS [Business case approval date]
		,ProjectUpdates.WholeLifeCost AS [Whole life cost £m]
		,ProjectUpdates.WholeLifeBenefit AS [Whole life benefit £m]
		,ProjectUpdates.NetPresentValue AS [Net present value £m]
		,dbo.SignOffs.ID AS [Sign Off ID]
		,OverallRAG.ID AS [Delivery Confidence RAG Score]
		,FinanceRAG.ID AS [Finance RAG Score]
		,PeopleRAG.ID AS [People RAG Score]
		,MilestonesRAG.ID AS [Milestones RAG Score]
		,BenefitsRAG.ID AS [Benefits RAG Score]
FROM   dbo.SignOffs INNER JOIN
            dbo.Projects ON dbo.SignOffs.ProjectID = dbo.Projects.ID INNER JOIN
            dbo.ProjectUpdates AS ProjectUpdates ON dbo.SignOffs.ID = ProjectUpdates.SignOffID LEFT OUTER JOIN
            dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
            dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
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
			dbo.ProjectBusinessCaseTypes ON ProjectUpdates.BusinessCaseTypeID = dbo.ProjectBusinessCaseTypes.ID
WHERE        (dbo.SignOffs.IsCurrent = 1)
GO
/****** Object:  View [reports].[SignedOffDirectorateReports]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [reports].[SignedOffDirectorateReports] AS
SELECT d.Title AS [Directorate]
		,s.SignOffDate AS [This month]
		,u.Title AS [This month signed off by]
		,s1.SignOffDate AS [Last month]
		,u1.Title AS [Last month signed off by]
		,s2.SignOffDate AS [2 months ago]
		,u2.Title AS [2 months ago signed off by]
		,s3.SignOffDate AS [3 months ago]
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
/****** Object:  View [reports].[SignedOffProjectReports]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [reports].[SignedOffProjectReports] AS
SELECT p.Title AS [Project]
		,s.SignOffDate AS [This month]
		,u.Title AS [This month signed off by]
		,s1.SignOffDate AS [Last month]
		,u1.Title AS [Last month signed off by]
		,s2.SignOffDate AS [2 months ago]
		,u2.Title AS [2 months ago signed off by]
		,s3.SignOffDate AS [3 months ago]
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
/****** Object:  View [reports].[SignOffs]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [reports].[SignOffs]
AS
SELECT	dbo.SignOffs.ID AS [Sign Off ID]
		,dbo.SignOffs.SignOffDate AS [Sign Off Date]
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
/****** Object:  View [reports].[UserAssociations]    Script Date: 17/01/2019 09:38:31 ******/
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
/****** Object:  View [reports].[UsersLastEdit]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [reports].[UsersLastEdit]
AS
SELECT u.Title AS [Name], u.Username, LastEditDate AS [Last Update Date] FROM
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
/****** Object:  View [reports].[WorkStreamChartData]    Script Date: 17/01/2019 09:38:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [reports].[WorkStreamChartData]
AS
SELECT   dbo.WorkStreams.ID
		,dbo.Groups.Title AS [Group]
		,dbo.Directorates.Title AS [Directorate]
		,dbo.Projects.Title AS [Project]
		,dbo.WorkStreams.Title AS [Work Stream]
		,dbo.SignOffs.ReportMonth AS [Report Month]
		,dbo.RagOptions.ReportName AS [Rating]
FROM   dbo.SignOffs INNER JOIN
		dbo.WorkStreamUpdates ON dbo.SignOffs.ID = dbo.WorkStreamUpdates.SignOffID INNER JOIN
		dbo.WorkStreams ON dbo.WorkStreamUpdates.WorkStreamID = dbo.WorkStreams.ID INNER JOIN
        dbo.Projects ON dbo.WorkStreams.ProjectID = dbo.Projects.ID INNER JOIN
		dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID INNER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
        dbo.RagOptions ON dbo.WorkStreamUpdates.RagOptionID = dbo.RagOptions.ID
WHERE        dbo.SignOffs.IsCurrent = 1
GO
