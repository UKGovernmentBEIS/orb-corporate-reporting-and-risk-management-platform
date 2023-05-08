
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 07/18/2018 17:56:28
-- Generated from EDMX file: A:\Source\CorporateReporting\CorporateReportingAPI\Models\CorporateReporting.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [corporate-reporting-dev];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Benefits_BenefitTypes]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Benefits] DROP CONSTRAINT [FK_Benefits_BenefitTypes];
GO
IF OBJECT_ID(N'[dbo].[FK_Benefits_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Benefits] DROP CONSTRAINT [FK_Benefits_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_Benefits_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Benefits] DROP CONSTRAINT [FK_Benefits_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_BenefitUpdates_Benefits]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BenefitUpdates] DROP CONSTRAINT [FK_BenefitUpdates_Benefits];
GO
IF OBJECT_ID(N'[dbo].[FK_BenefitUpdates_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BenefitUpdates] DROP CONSTRAINT [FK_BenefitUpdates_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_BenefitUpdates_SignOffs]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BenefitUpdates] DROP CONSTRAINT [FK_BenefitUpdates_SignOffs];
GO
IF OBJECT_ID(N'[dbo].[FK_BenefitUpdates_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BenefitUpdates] DROP CONSTRAINT [FK_BenefitUpdates_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_Directorates_Groups]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Directorates] DROP CONSTRAINT [FK_Directorates_Groups];
GO
IF OBJECT_ID(N'[dbo].[FK_Directorates_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Directorates] DROP CONSTRAINT [FK_Directorates_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_DirectorateUpdates_Directorates]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DirectorateUpdates] DROP CONSTRAINT [FK_DirectorateUpdates_Directorates];
GO
IF OBJECT_ID(N'[dbo].[FK_KeyWorkAreas_Directorates]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[KeyWorkAreas] DROP CONSTRAINT [FK_KeyWorkAreas_Directorates];
GO
IF OBJECT_ID(N'[dbo].[FK_UserDirectorates_Directorates]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserDirectorates] DROP CONSTRAINT [FK_UserDirectorates_Directorates];
GO
IF OBJECT_ID(N'[dbo].[FK_DirectorateUpdates_RagOptionFinance]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DirectorateUpdates] DROP CONSTRAINT [FK_DirectorateUpdates_RagOptionFinance];
GO
IF OBJECT_ID(N'[dbo].[FK_DirectorateUpdates_RagOptionMilestone]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DirectorateUpdates] DROP CONSTRAINT [FK_DirectorateUpdates_RagOptionMilestone];
GO
IF OBJECT_ID(N'[dbo].[FK_DirectorateUpdates_RagOptionOverall]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DirectorateUpdates] DROP CONSTRAINT [FK_DirectorateUpdates_RagOptionOverall];
GO
IF OBJECT_ID(N'[dbo].[FK_DirectorateUpdates_RagOptionPeople]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DirectorateUpdates] DROP CONSTRAINT [FK_DirectorateUpdates_RagOptionPeople];
GO
IF OBJECT_ID(N'[dbo].[FK_DirectorateUpdates_SignOffs]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DirectorateUpdates] DROP CONSTRAINT [FK_DirectorateUpdates_SignOffs];
GO
IF OBJECT_ID(N'[dbo].[FK_DirectorateUpdates_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DirectorateUpdates] DROP CONSTRAINT [FK_DirectorateUpdates_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_KeyWorkAreas_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[KeyWorkAreas] DROP CONSTRAINT [FK_KeyWorkAreas_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_KeyWorkAreas_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[KeyWorkAreas] DROP CONSTRAINT [FK_KeyWorkAreas_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_KeyWorkAreaUpdates_KeyWorkAreas]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[KeyWorkAreaUpdates] DROP CONSTRAINT [FK_KeyWorkAreaUpdates_KeyWorkAreas];
GO
IF OBJECT_ID(N'[dbo].[FK_Milestones_KeyWorkAreas]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Milestones] DROP CONSTRAINT [FK_Milestones_KeyWorkAreas];
GO
IF OBJECT_ID(N'[dbo].[FK_KeyWorkAreaUpdates_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[KeyWorkAreaUpdates] DROP CONSTRAINT [FK_KeyWorkAreaUpdates_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_KeyWorkAreaUpdates_SignOffs]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[KeyWorkAreaUpdates] DROP CONSTRAINT [FK_KeyWorkAreaUpdates_SignOffs];
GO
IF OBJECT_ID(N'[dbo].[FK_KeyWorkAreaUpdates_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[KeyWorkAreaUpdates] DROP CONSTRAINT [FK_KeyWorkAreaUpdates_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_Metrics_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Metrics] DROP CONSTRAINT [FK_Metrics_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_Metrics_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Metrics] DROP CONSTRAINT [FK_Metrics_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_MetricUpdates_Metrics]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MetricUpdates] DROP CONSTRAINT [FK_MetricUpdates_Metrics];
GO
IF OBJECT_ID(N'[dbo].[FK_MetricUpdates_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MetricUpdates] DROP CONSTRAINT [FK_MetricUpdates_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_MetricUpdates_SignOffs]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MetricUpdates] DROP CONSTRAINT [FK_MetricUpdates_SignOffs];
GO
IF OBJECT_ID(N'[dbo].[FK_MetricUpdates_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MetricUpdates] DROP CONSTRAINT [FK_MetricUpdates_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_MilestoneAttributes_MilestoneAttributeTypes]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MilestoneAttributes] DROP CONSTRAINT [FK_MilestoneAttributes_MilestoneAttributeTypes];
GO
IF OBJECT_ID(N'[dbo].[FK_MilestoneAttributes_Milestones]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MilestoneAttributes] DROP CONSTRAINT [FK_MilestoneAttributes_Milestones];
GO
IF OBJECT_ID(N'[dbo].[FK_Milestones_MilestoneTypes]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Milestones] DROP CONSTRAINT [FK_Milestones_MilestoneTypes];
GO
IF OBJECT_ID(N'[dbo].[FK_Milestones_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Milestones] DROP CONSTRAINT [FK_Milestones_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_Milestones_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Milestones] DROP CONSTRAINT [FK_Milestones_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_Milestones_WorkStreams]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Milestones] DROP CONSTRAINT [FK_Milestones_WorkStreams];
GO
IF OBJECT_ID(N'[dbo].[FK_MilestoneUpdates_Milestones]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MilestoneUpdates] DROP CONSTRAINT [FK_MilestoneUpdates_Milestones];
GO
IF OBJECT_ID(N'[dbo].[FK_MilestoneUpdates_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MilestoneUpdates] DROP CONSTRAINT [FK_MilestoneUpdates_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_MilestoneUpdates_SignOffs]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MilestoneUpdates] DROP CONSTRAINT [FK_MilestoneUpdates_SignOffs];
GO
IF OBJECT_ID(N'[dbo].[FK_MilestoneUpdates_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MilestoneUpdates] DROP CONSTRAINT [FK_MilestoneUpdates_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_Projects_ProjectManager]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Projects] DROP CONSTRAINT [FK_Projects_ProjectManager];
GO
IF OBJECT_ID(N'[dbo].[FK_Projects_SeniorResponsibleOwner]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Projects] DROP CONSTRAINT [FK_Projects_SeniorResponsibleOwner];
GO
IF OBJECT_ID(N'[dbo].[FK_ProjectUpdates_Projects]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectUpdates] DROP CONSTRAINT [FK_ProjectUpdates_Projects];
GO
IF OBJECT_ID(N'[dbo].[FK_UserProjects_Projects]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserProjects] DROP CONSTRAINT [FK_UserProjects_Projects];
GO
IF OBJECT_ID(N'[dbo].[FK_WorkStreams_Projects]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WorkStreams] DROP CONSTRAINT [FK_WorkStreams_Projects];
GO
IF OBJECT_ID(N'[dbo].[FK_ProjectUpdates_RagOptionFinance]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectUpdates] DROP CONSTRAINT [FK_ProjectUpdates_RagOptionFinance];
GO
IF OBJECT_ID(N'[dbo].[FK_ProjectUpdates_RagOptionMilestone]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectUpdates] DROP CONSTRAINT [FK_ProjectUpdates_RagOptionMilestone];
GO
IF OBJECT_ID(N'[dbo].[FK_ProjectUpdates_RagOptionOverall]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectUpdates] DROP CONSTRAINT [FK_ProjectUpdates_RagOptionOverall];
GO
IF OBJECT_ID(N'[dbo].[FK_ProjectUpdates_RagOptionPeople]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectUpdates] DROP CONSTRAINT [FK_ProjectUpdates_RagOptionPeople];
GO
IF OBJECT_ID(N'[dbo].[FK_ProjectUpdates_SignOffs]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectUpdates] DROP CONSTRAINT [FK_ProjectUpdates_SignOffs];
GO
IF OBJECT_ID(N'[dbo].[FK_ProjectUpdates_UpdateUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectUpdates] DROP CONSTRAINT [FK_ProjectUpdates_UpdateUser];
GO
IF OBJECT_ID(N'[dbo].[FK_WorkStreams_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WorkStreams] DROP CONSTRAINT [FK_WorkStreams_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_WorkStreamUpdates_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WorkStreamUpdates] DROP CONSTRAINT [FK_WorkStreamUpdates_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_UserRoles_Roles]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT [FK_UserRoles_Roles];
GO
IF OBJECT_ID(N'[dbo].[FK_SignOffs_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SignOffs] DROP CONSTRAINT [FK_SignOffs_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_WorkStreamUpdates_SignOffs]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WorkStreamUpdates] DROP CONSTRAINT [FK_WorkStreamUpdates_SignOffs];
GO
IF OBJECT_ID(N'[dbo].[FK_UserDirectorates_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserDirectorates] DROP CONSTRAINT [FK_UserDirectorates_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_UserProjects_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserProjects] DROP CONSTRAINT [FK_UserProjects_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_UserRoles_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT [FK_UserRoles_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_WorkStreams_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WorkStreams] DROP CONSTRAINT [FK_WorkStreams_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_WorkStreamUpdates_UpdateUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WorkStreamUpdates] DROP CONSTRAINT [FK_WorkStreamUpdates_UpdateUser];
GO
IF OBJECT_ID(N'[dbo].[FK_WorkStreamUpdates_WorkStreams]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WorkStreamUpdates] DROP CONSTRAINT [FK_WorkStreamUpdates_WorkStreams];
GO
IF OBJECT_ID(N'[dbo].[FK_ProjectUpdates_ProjectBusinessCaseTypes]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectUpdates] DROP CONSTRAINT [FK_ProjectUpdates_ProjectBusinessCaseTypes];
GO
IF OBJECT_ID(N'[dbo].[FK_ProjectUpdates_ProjectPhases]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectUpdates] DROP CONSTRAINT [FK_ProjectUpdates_ProjectPhases];
GO
IF OBJECT_ID(N'[dbo].[FK_SignOffs_Directorates]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SignOffs] DROP CONSTRAINT [FK_SignOffs_Directorates];
GO
IF OBJECT_ID(N'[dbo].[FK_SignOffs_Projects]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SignOffs] DROP CONSTRAINT [FK_SignOffs_Projects];
GO
IF OBJECT_ID(N'[dbo].[FK_Benefits_Projects]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Benefits] DROP CONSTRAINT [FK_Benefits_Projects];
GO
IF OBJECT_ID(N'[dbo].[FK_Metrics_Directorates]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Metrics] DROP CONSTRAINT [FK_Metrics_Directorates];
GO
IF OBJECT_ID(N'[dbo].[FK_Commitments_Directorates]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Commitments] DROP CONSTRAINT [FK_Commitments_Directorates];
GO
IF OBJECT_ID(N'[dbo].[FK_Commitments_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Commitments] DROP CONSTRAINT [FK_Commitments_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_Commitments_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Commitments] DROP CONSTRAINT [FK_Commitments_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_Dependencies_Projects]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Dependencies] DROP CONSTRAINT [FK_Dependencies_Projects];
GO
IF OBJECT_ID(N'[dbo].[FK_Dependencies_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Dependencies] DROP CONSTRAINT [FK_Dependencies_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_Dependencies_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Dependencies] DROP CONSTRAINT [FK_Dependencies_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_CommitmentUpdates_Commitments]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CommitmentUpdates] DROP CONSTRAINT [FK_CommitmentUpdates_Commitments];
GO
IF OBJECT_ID(N'[dbo].[FK_CommitmentUpdates_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CommitmentUpdates] DROP CONSTRAINT [FK_CommitmentUpdates_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_CommitmentUpdates_SignOffs]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CommitmentUpdates] DROP CONSTRAINT [FK_CommitmentUpdates_SignOffs];
GO
IF OBJECT_ID(N'[dbo].[FK_CommitmentUpdates_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CommitmentUpdates] DROP CONSTRAINT [FK_CommitmentUpdates_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_DependencyUpdates_Dependencies]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DependencyUpdates] DROP CONSTRAINT [FK_DependencyUpdates_Dependencies];
GO
IF OBJECT_ID(N'[dbo].[FK_DependencyUpdates_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DependencyUpdates] DROP CONSTRAINT [FK_DependencyUpdates_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_DependencyUpdates_SignOffs]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DependencyUpdates] DROP CONSTRAINT [FK_DependencyUpdates_SignOffs];
GO
IF OBJECT_ID(N'[dbo].[FK_DependencyUpdates_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DependencyUpdates] DROP CONSTRAINT [FK_DependencyUpdates_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_DirectorateUpdates_RagOptionMetric]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DirectorateUpdates] DROP CONSTRAINT [FK_DirectorateUpdates_RagOptionMetric];
GO
IF OBJECT_ID(N'[dbo].[FK_ProjectUpdates_RagOptionBenefit]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectUpdates] DROP CONSTRAINT [FK_ProjectUpdates_RagOptionBenefit];
GO
IF OBJECT_ID(N'[dbo].[FK_Groups_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Groups] DROP CONSTRAINT [FK_Groups_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_Projects_Directorates]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Projects] DROP CONSTRAINT [FK_Projects_Directorates];
GO
IF OBJECT_ID(N'[dbo].[FK_Risks_Directorates]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Risks] DROP CONSTRAINT [FK_Risks_Directorates];
GO
IF OBJECT_ID(N'[dbo].[FK_Risks_Groups]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Risks] DROP CONSTRAINT [FK_Risks_Groups];
GO
IF OBJECT_ID(N'[dbo].[FK_Risks_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Risks] DROP CONSTRAINT [FK_Risks_RagOptions];
GO
IF OBJECT_ID(N'[dbo].[FK_RiskMitigationActions_Risks]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RiskMitigationActions] DROP CONSTRAINT [FK_RiskMitigationActions_Risks];
GO
IF OBJECT_ID(N'[dbo].[FK_RiskMitigationActions_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RiskMitigationActions] DROP CONSTRAINT [FK_RiskMitigationActions_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_Risks_RiskRegisters]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Risks] DROP CONSTRAINT [FK_Risks_RiskRegisters];
GO
IF OBJECT_ID(N'[dbo].[FK_Risks_RiskStatuses]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Risks] DROP CONSTRAINT [FK_Risks_RiskStatuses];
GO
IF OBJECT_ID(N'[dbo].[FK_Risks_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Risks] DROP CONSTRAINT [FK_Risks_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_RiskUpdates_Risks]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RiskUpdates] DROP CONSTRAINT [FK_RiskUpdates_Risks];
GO
IF OBJECT_ID(N'[dbo].[FK_RiskUpdates_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RiskUpdates] DROP CONSTRAINT [FK_RiskUpdates_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_Risks_RiskImpactSpreads]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Risks] DROP CONSTRAINT [FK_Risks_RiskImpactSpreads];
GO
IF OBJECT_ID(N'[dbo].[FK_Risks_RiskImpactTypes]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Risks] DROP CONSTRAINT [FK_Risks_RiskImpactTypes];
GO
IF OBJECT_ID(N'[dbo].[FK_RiskUpdates_RiskImpactLevels]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RiskUpdates] DROP CONSTRAINT [FK_RiskUpdates_RiskImpactLevels];
GO
IF OBJECT_ID(N'[dbo].[FK_RiskUpdates_RiskProbabilities]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RiskUpdates] DROP CONSTRAINT [FK_RiskUpdates_RiskProbabilities];
GO
IF OBJECT_ID(N'[dbo].[FK_RiskMitigationActionUpdates_RiskMitigationActions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RiskMitigationActionUpdates] DROP CONSTRAINT [FK_RiskMitigationActionUpdates_RiskMitigationActions];
GO
IF OBJECT_ID(N'[dbo].[FK_RiskMitigationActionUpdates_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RiskMitigationActionUpdates] DROP CONSTRAINT [FK_RiskMitigationActionUpdates_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_RiskUpdates_RagOptions]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RiskUpdates] DROP CONSTRAINT [FK_RiskUpdates_RagOptions];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Benefits]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Benefits];
GO
IF OBJECT_ID(N'[dbo].[BenefitTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[BenefitTypes];
GO
IF OBJECT_ID(N'[dbo].[BenefitUpdates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[BenefitUpdates];
GO
IF OBJECT_ID(N'[dbo].[Directorates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Directorates];
GO
IF OBJECT_ID(N'[dbo].[DirectorateUpdates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DirectorateUpdates];
GO
IF OBJECT_ID(N'[dbo].[Groups]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Groups];
GO
IF OBJECT_ID(N'[dbo].[KeyWorkAreas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[KeyWorkAreas];
GO
IF OBJECT_ID(N'[dbo].[KeyWorkAreaUpdates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[KeyWorkAreaUpdates];
GO
IF OBJECT_ID(N'[dbo].[Metrics]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Metrics];
GO
IF OBJECT_ID(N'[dbo].[MetricUpdates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MetricUpdates];
GO
IF OBJECT_ID(N'[dbo].[MilestoneAttributes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MilestoneAttributes];
GO
IF OBJECT_ID(N'[dbo].[MilestoneAttributeTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MilestoneAttributeTypes];
GO
IF OBJECT_ID(N'[dbo].[Milestones]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Milestones];
GO
IF OBJECT_ID(N'[dbo].[MilestoneTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MilestoneTypes];
GO
IF OBJECT_ID(N'[dbo].[MilestoneUpdates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MilestoneUpdates];
GO
IF OBJECT_ID(N'[dbo].[Projects]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Projects];
GO
IF OBJECT_ID(N'[dbo].[ProjectUpdates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProjectUpdates];
GO
IF OBJECT_ID(N'[dbo].[RagOptions]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RagOptions];
GO
IF OBJECT_ID(N'[dbo].[Roles]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Roles];
GO
IF OBJECT_ID(N'[dbo].[SignOffs]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SignOffs];
GO
IF OBJECT_ID(N'[dbo].[UserDirectorates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserDirectorates];
GO
IF OBJECT_ID(N'[dbo].[UserProjects]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserProjects];
GO
IF OBJECT_ID(N'[dbo].[UserRoles]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserRoles];
GO
IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[WorkStreams]', 'U') IS NOT NULL
    DROP TABLE [dbo].[WorkStreams];
GO
IF OBJECT_ID(N'[dbo].[WorkStreamUpdates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[WorkStreamUpdates];
GO
IF OBJECT_ID(N'[dbo].[ProjectBusinessCaseTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProjectBusinessCaseTypes];
GO
IF OBJECT_ID(N'[dbo].[ProjectPhases]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProjectPhases];
GO
IF OBJECT_ID(N'[dbo].[Commitments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Commitments];
GO
IF OBJECT_ID(N'[dbo].[Dependencies]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Dependencies];
GO
IF OBJECT_ID(N'[dbo].[CommitmentUpdates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CommitmentUpdates];
GO
IF OBJECT_ID(N'[dbo].[DependencyUpdates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DependencyUpdates];
GO
IF OBJECT_ID(N'[dbo].[RiskImpactSpreads]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RiskImpactSpreads];
GO
IF OBJECT_ID(N'[dbo].[RiskImpactTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RiskImpactTypes];
GO
IF OBJECT_ID(N'[dbo].[RiskMitigationActions]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RiskMitigationActions];
GO
IF OBJECT_ID(N'[dbo].[RiskRegisters]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RiskRegisters];
GO
IF OBJECT_ID(N'[dbo].[Risks]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Risks];
GO
IF OBJECT_ID(N'[dbo].[RiskStatuses]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RiskStatuses];
GO
IF OBJECT_ID(N'[dbo].[RiskUpdates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RiskUpdates];
GO
IF OBJECT_ID(N'[dbo].[RiskImpactLevels]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RiskImpactLevels];
GO
IF OBJECT_ID(N'[dbo].[RiskProbabilities]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RiskProbabilities];
GO
IF OBJECT_ID(N'[dbo].[RiskMitigationActionUpdates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RiskMitigationActionUpdates];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Benefits'
CREATE TABLE [dbo].[Benefits] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL,
    [BenefitTypeID] int  NULL,
    [TargetPerformanceLowerLimit] nvarchar(255)  NULL,
    [TargetPerformanceUpperLimit] nvarchar(255)  NULL,
    [LeadUserID] int  NULL,
    [RagOptionID] int  NULL,
    [ProjectID] int  NOT NULL
);
GO

-- Creating table 'BenefitTypes'
CREATE TABLE [dbo].[BenefitTypes] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL
);
GO

-- Creating table 'BenefitUpdates'
CREATE TABLE [dbo].[BenefitUpdates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [BenefitID] int  NULL,
    [UpdateDate] datetime  NULL,
    [RagOptionID] int  NULL,
    [Comment] nvarchar(max)  NULL,
    [CurrentPerformance] decimal(18,4)  NULL,
    [UpdateUserID] int  NULL,
    [SignOffID] int  NULL
);
GO

-- Creating table 'Directorates'
CREATE TABLE [dbo].[Directorates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL,
    [GroupID] int  NULL,
    [DirectorUserID] int  NULL,
    [Objectives] nvarchar(max)  NULL
);
GO

-- Creating table 'DirectorateUpdates'
CREATE TABLE [dbo].[DirectorateUpdates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [DirectorateID] int  NULL,
    [UpdateDate] datetime  NULL,
    [OverallRagOptionID] int  NULL,
    [FinanceRagOptionID] int  NULL,
    [FinanceComment] nvarchar(200)  NULL,
    [PeopleRagOptionID] int  NULL,
    [PeopleComment] nvarchar(200)  NULL,
    [MilestonesRagOptionID] int  NULL,
    [MilestonesComment] nvarchar(200)  NULL,
    [ProgressUpdate] nvarchar(300)  NULL,
    [FutureActions] nvarchar(200)  NULL,
    [Escalations] nvarchar(100)  NULL,
    [UpdateUserID] int  NULL,
    [SignOffID] int  NULL,
    [MetricsRagOptionID] int  NULL,
    [MetricsComment] nvarchar(200)  NULL,
    [Comment] nvarchar(50)  NULL,
    [RagOptionID] int  NULL
);
GO

-- Creating table 'Groups'
CREATE TABLE [dbo].[Groups] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(50)  NULL,
    [DirectorGeneralUserID] int  NULL
);
GO

-- Creating table 'KeyWorkAreas'
CREATE TABLE [dbo].[KeyWorkAreas] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [DirectorateID] int  NOT NULL,
    [Title] nvarchar(255)  NOT NULL,
    [LeadUserID] int  NULL,
    [RagOptionID] int  NULL
);
GO

-- Creating table 'KeyWorkAreaUpdates'
CREATE TABLE [dbo].[KeyWorkAreaUpdates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [KeyWorkAreaID] int  NOT NULL,
    [UpdateDate] datetime  NOT NULL,
    [RagOptionID] int  NULL,
    [Comment] nvarchar(500)  NULL,
    [UpdateUserID] int  NULL,
    [SignOffID] int  NULL
);
GO

-- Creating table 'Metrics'
CREATE TABLE [dbo].[Metrics] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL,
    [MetricCode] nvarchar(255)  NULL,
    [Description] nvarchar(max)  NULL,
    [TargetPerformanceUpperLimit] nvarchar(255)  NULL,
    [TargetPerformanceLowerLimit] nvarchar(255)  NULL,
    [LeadUserID] int  NULL,
    [RagOptionID] int  NULL,
    [DirectorateID] int  NOT NULL
);
GO

-- Creating table 'MetricUpdates'
CREATE TABLE [dbo].[MetricUpdates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [MetricID] int  NOT NULL,
    [UpdateDate] datetime  NULL,
    [RagOptionID] int  NULL,
    [Comment] nvarchar(500)  NULL,
    [CurrentPerformance] decimal(18,4)  NULL,
    [UpdateUserID] int  NULL,
    [SignOffID] int  NULL
);
GO

-- Creating table 'MilestoneAttributes'
CREATE TABLE [dbo].[MilestoneAttributes] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [MilestoneID] int  NOT NULL,
    [MilestoneAttributeTypeID] int  NOT NULL,
    [AttributeValue] nvarchar(255)  NULL
);
GO

-- Creating table 'MilestoneAttributeTypes'
CREATE TABLE [dbo].[MilestoneAttributeTypes] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL
);
GO

-- Creating table 'Milestones'
CREATE TABLE [dbo].[Milestones] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL,
    [MilestoneCode] nvarchar(255)  NULL,
    [BaselineDate] datetime  NULL,
    [ForecastDate] datetime  NULL,
    [ActualDate] datetime  NULL,
    [MilestoneTypeID] int  NULL,
    [LeadUserID] int  NULL,
    [RagOptionID] int  NULL,
    [WorkStreamID] int  NULL,
    [KeyWorkAreaID] int  NULL
);
GO

-- Creating table 'MilestoneTypes'
CREATE TABLE [dbo].[MilestoneTypes] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL
);
GO

-- Creating table 'MilestoneUpdates'
CREATE TABLE [dbo].[MilestoneUpdates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [MilestoneID] int  NOT NULL,
    [UpdateDate] datetime  NULL,
    [RagOptionID] int  NULL,
    [Comment] nvarchar(255)  NULL,
    [ForecastDate] datetime  NULL,
    [ActualDate] datetime  NULL,
    [UpdateUserID] int  NULL,
    [SignOffID] int  NULL
);
GO

-- Creating table 'Projects'
CREATE TABLE [dbo].[Projects] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL,
    [SeniorResponsibleOwnerUserID] int  NULL,
    [ProjectManagerUserID] int  NULL,
    [Objectives] nvarchar(max)  NULL,
    [StartDate] datetime  NULL,
    [EndDate] datetime  NULL,
    [DirectorateID] int  NULL
);
GO

-- Creating table 'ProjectUpdates'
CREATE TABLE [dbo].[ProjectUpdates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [ProjectID] int  NOT NULL,
    [UpdateDate] datetime  NULL,
    [UpdateUserID] int  NULL,
    [OverallRagOptionID] int  NULL,
    [FinanceRagOptionID] int  NULL,
    [FinanceComment] nvarchar(200)  NULL,
    [PeopleRagOptionID] int  NULL,
    [PeopleComment] nvarchar(200)  NULL,
    [MilestonesRagOptionID] int  NULL,
    [MilestonesComment] nvarchar(200)  NULL,
    [ProgressUpdate] nvarchar(300)  NULL,
    [FutureActions] nvarchar(200)  NULL,
    [Escalations] nvarchar(100)  NULL,
    [ProjectPhaseID] int  NULL,
    [BusinessCaseTypeID] int  NULL,
    [BusinessCaseDate] datetime  NULL,
    [WholeLifeCost] decimal(18,4)  NULL,
    [WholeLifeBenefit] decimal(18,4)  NULL,
    [NetPresentValue] decimal(18,4)  NULL,
    [SignOffID] int  NULL,
    [BenefitsRagOptionID] int  NULL,
    [BenefitsComment] nvarchar(200)  NULL,
    [Comment] nvarchar(50)  NULL,
    [RagOptionID] int  NULL
);
GO

-- Creating table 'RagOptions'
CREATE TABLE [dbo].[RagOptions] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NULL,
    [ReportName] nvarchar(2)  NULL
);
GO

-- Creating table 'Roles'
CREATE TABLE [dbo].[Roles] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL
);
GO

-- Creating table 'SignOffs'
CREATE TABLE [dbo].[SignOffs] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [SignOffDate] datetime  NULL,
    [SignOffUserID] int  NULL,
    [ReportMonth] datetime  NULL,
    [DirectorateID] int  NULL,
    [ProjectID] int  NULL,
    [SignOffEntities] nvarchar(max)  NULL,
    [IsCurrent] bit  NULL
);
GO

-- Creating table 'UserDirectorates'
CREATE TABLE [dbo].[UserDirectorates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [UserID] int  NOT NULL,
    [DirectorateID] int  NOT NULL,
    [IsAdmin] bit  NOT NULL,
    [Title] nvarchar(50)  NULL
);
GO

-- Creating table 'UserProjects'
CREATE TABLE [dbo].[UserProjects] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [UserID] int  NOT NULL,
    [ProjectID] int  NOT NULL,
    [IsAdmin] bit  NOT NULL,
    [Title] nvarchar(50)  NULL
);
GO

-- Creating table 'UserRoles'
CREATE TABLE [dbo].[UserRoles] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [UserID] int  NOT NULL,
    [RoleID] int  NOT NULL,
    [Title] nvarchar(50)  NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Username] nvarchar(255)  NOT NULL,
    [Title] nvarchar(255)  NULL
);
GO

-- Creating table 'WorkStreams'
CREATE TABLE [dbo].[WorkStreams] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL,
    [WorkStreamCode] nvarchar(255)  NULL,
    [ProjectID] int  NOT NULL,
    [LeadUserID] int  NULL,
    [RagOptionID] int  NULL
);
GO

-- Creating table 'WorkStreamUpdates'
CREATE TABLE [dbo].[WorkStreamUpdates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [WorkStreamID] int  NOT NULL,
    [UpdateDate] datetime  NULL,
    [UpdateUserID] int  NULL,
    [RagOptionID] int  NULL,
    [Comment] nvarchar(500)  NULL,
    [SignOffID] int  NULL
);
GO

-- Creating table 'ProjectBusinessCaseTypes'
CREATE TABLE [dbo].[ProjectBusinessCaseTypes] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL
);
GO

-- Creating table 'ProjectPhases'
CREATE TABLE [dbo].[ProjectPhases] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NOT NULL
);
GO

-- Creating table 'Commitments'
CREATE TABLE [dbo].[Commitments] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [DirectorateID] int  NOT NULL,
    [BaselineDate] datetime  NULL,
    [RagOptionID] int  NULL,
    [LeadUserID] int  NULL,
    [ForecastDate] datetime  NULL,
    [ActualDate] datetime  NULL
);
GO

-- Creating table 'Dependencies'
CREATE TABLE [dbo].[Dependencies] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [ProjectID] int  NOT NULL,
    [ThirdParty] nvarchar(255)  NULL,
    [RagOptionID] int  NULL,
    [LeadUserID] int  NULL
);
GO

-- Creating table 'CommitmentUpdates'
CREATE TABLE [dbo].[CommitmentUpdates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [CommitmentID] int  NOT NULL,
    [UpdateDate] datetime  NULL,
    [UpdateUserID] int  NULL,
    [RagOptionID] int  NULL,
    [Comment] nvarchar(300)  NULL,
    [ForecastDate] datetime  NULL,
    [ActualDate] datetime  NULL,
    [SignOffID] int  NULL
);
GO

-- Creating table 'DependencyUpdates'
CREATE TABLE [dbo].[DependencyUpdates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [DependencyID] int  NOT NULL,
    [UpdateDate] datetime  NULL,
    [UpdateUserID] int  NULL,
    [RagOptionID] int  NULL,
    [Comment] nvarchar(300)  NULL,
    [SignOffID] int  NULL
);
GO

-- Creating table 'RiskImpactSpreads'
CREATE TABLE [dbo].[RiskImpactSpreads] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(50)  NULL
);
GO

-- Creating table 'RiskImpactTypes'
CREATE TABLE [dbo].[RiskImpactTypes] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(50)  NULL
);
GO

-- Creating table 'RiskMitigationActions'
CREATE TABLE [dbo].[RiskMitigationActions] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(200)  NULL,
    [RiskID] int  NULL,
    [TargetDate] datetime  NULL,
    [OwnerUserID] int  NULL,
    [RiskMitigationActionCode] nvarchar(50)  NULL,
    [Description] nvarchar(500)  NULL,
    [CompletionDate] datetime  NULL
);
GO

-- Creating table 'RiskRegisters'
CREATE TABLE [dbo].[RiskRegisters] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(50)  NULL
);
GO

-- Creating table 'Risks'
CREATE TABLE [dbo].[Risks] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255)  NULL,
    [RiskDescription] nvarchar(500)  NULL,
    [GroupID] int  NULL,
    [DirectorateID] int  NULL,
    [RiskStatusID] int  NULL,
    [RagOptionID] int  NULL,
    [RiskRegisterID] int  NULL,
    [RiskEventDescription] nvarchar(500)  NULL,
    [RiskCauseDescription] nvarchar(500)  NULL,
    [RiskImpactDescription] nvarchar(500)  NULL,
    [RiskImpactTypeID] int  NULL,
    [RiskImpactSpreadID] int  NULL,
    [Proximity] datetime  NULL,
    [RiskCode] nvarchar(50)  NULL,
    [RiskOwnerUserID] int  NULL
);
GO

-- Creating table 'RiskStatuses'
CREATE TABLE [dbo].[RiskStatuses] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(50)  NULL
);
GO

-- Creating table 'RiskUpdates'
CREATE TABLE [dbo].[RiskUpdates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(500)  NULL,
    [RiskID] int  NULL,
    [UpdateUserID] int  NULL,
    [UpdateDate] datetime  NULL,
    [RiskProbabilityID] int  NULL,
    [RiskImpactLevelID] int  NULL,
    [Comment] nvarchar(50)  NULL,
    [RagOptionID] int  NULL,
    [Escalate] bit  NULL,
    [DeEscalate] bit  NULL,
    [SignOffID] int  NULL
);
GO

-- Creating table 'RiskImpactLevels'
CREATE TABLE [dbo].[RiskImpactLevels] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(50)  NULL
);
GO

-- Creating table 'RiskProbabilities'
CREATE TABLE [dbo].[RiskProbabilities] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(50)  NULL
);
GO

-- Creating table 'RiskMitigationActionUpdates'
CREATE TABLE [dbo].[RiskMitigationActionUpdates] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(500)  NULL,
    [RiskMitigationActionID] int  NULL,
    [UpdateDate] datetime  NULL,
    [UpdateUserID] int  NULL,
    [CompletionDate] datetime  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ID] in table 'Benefits'
ALTER TABLE [dbo].[Benefits]
ADD CONSTRAINT [PK_Benefits]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'BenefitTypes'
ALTER TABLE [dbo].[BenefitTypes]
ADD CONSTRAINT [PK_BenefitTypes]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'BenefitUpdates'
ALTER TABLE [dbo].[BenefitUpdates]
ADD CONSTRAINT [PK_BenefitUpdates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Directorates'
ALTER TABLE [dbo].[Directorates]
ADD CONSTRAINT [PK_Directorates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'DirectorateUpdates'
ALTER TABLE [dbo].[DirectorateUpdates]
ADD CONSTRAINT [PK_DirectorateUpdates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Groups'
ALTER TABLE [dbo].[Groups]
ADD CONSTRAINT [PK_Groups]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'KeyWorkAreas'
ALTER TABLE [dbo].[KeyWorkAreas]
ADD CONSTRAINT [PK_KeyWorkAreas]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'KeyWorkAreaUpdates'
ALTER TABLE [dbo].[KeyWorkAreaUpdates]
ADD CONSTRAINT [PK_KeyWorkAreaUpdates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Metrics'
ALTER TABLE [dbo].[Metrics]
ADD CONSTRAINT [PK_Metrics]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'MetricUpdates'
ALTER TABLE [dbo].[MetricUpdates]
ADD CONSTRAINT [PK_MetricUpdates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'MilestoneAttributes'
ALTER TABLE [dbo].[MilestoneAttributes]
ADD CONSTRAINT [PK_MilestoneAttributes]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'MilestoneAttributeTypes'
ALTER TABLE [dbo].[MilestoneAttributeTypes]
ADD CONSTRAINT [PK_MilestoneAttributeTypes]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Milestones'
ALTER TABLE [dbo].[Milestones]
ADD CONSTRAINT [PK_Milestones]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'MilestoneTypes'
ALTER TABLE [dbo].[MilestoneTypes]
ADD CONSTRAINT [PK_MilestoneTypes]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'MilestoneUpdates'
ALTER TABLE [dbo].[MilestoneUpdates]
ADD CONSTRAINT [PK_MilestoneUpdates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Projects'
ALTER TABLE [dbo].[Projects]
ADD CONSTRAINT [PK_Projects]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'ProjectUpdates'
ALTER TABLE [dbo].[ProjectUpdates]
ADD CONSTRAINT [PK_ProjectUpdates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'RagOptions'
ALTER TABLE [dbo].[RagOptions]
ADD CONSTRAINT [PK_RagOptions]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Roles'
ALTER TABLE [dbo].[Roles]
ADD CONSTRAINT [PK_Roles]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'SignOffs'
ALTER TABLE [dbo].[SignOffs]
ADD CONSTRAINT [PK_SignOffs]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'UserDirectorates'
ALTER TABLE [dbo].[UserDirectorates]
ADD CONSTRAINT [PK_UserDirectorates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'UserProjects'
ALTER TABLE [dbo].[UserProjects]
ADD CONSTRAINT [PK_UserProjects]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'UserRoles'
ALTER TABLE [dbo].[UserRoles]
ADD CONSTRAINT [PK_UserRoles]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'WorkStreams'
ALTER TABLE [dbo].[WorkStreams]
ADD CONSTRAINT [PK_WorkStreams]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'WorkStreamUpdates'
ALTER TABLE [dbo].[WorkStreamUpdates]
ADD CONSTRAINT [PK_WorkStreamUpdates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'ProjectBusinessCaseTypes'
ALTER TABLE [dbo].[ProjectBusinessCaseTypes]
ADD CONSTRAINT [PK_ProjectBusinessCaseTypes]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'ProjectPhases'
ALTER TABLE [dbo].[ProjectPhases]
ADD CONSTRAINT [PK_ProjectPhases]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Commitments'
ALTER TABLE [dbo].[Commitments]
ADD CONSTRAINT [PK_Commitments]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Dependencies'
ALTER TABLE [dbo].[Dependencies]
ADD CONSTRAINT [PK_Dependencies]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'CommitmentUpdates'
ALTER TABLE [dbo].[CommitmentUpdates]
ADD CONSTRAINT [PK_CommitmentUpdates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'DependencyUpdates'
ALTER TABLE [dbo].[DependencyUpdates]
ADD CONSTRAINT [PK_DependencyUpdates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'RiskImpactSpreads'
ALTER TABLE [dbo].[RiskImpactSpreads]
ADD CONSTRAINT [PK_RiskImpactSpreads]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'RiskImpactTypes'
ALTER TABLE [dbo].[RiskImpactTypes]
ADD CONSTRAINT [PK_RiskImpactTypes]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'RiskMitigationActions'
ALTER TABLE [dbo].[RiskMitigationActions]
ADD CONSTRAINT [PK_RiskMitigationActions]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'RiskRegisters'
ALTER TABLE [dbo].[RiskRegisters]
ADD CONSTRAINT [PK_RiskRegisters]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Risks'
ALTER TABLE [dbo].[Risks]
ADD CONSTRAINT [PK_Risks]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'RiskStatuses'
ALTER TABLE [dbo].[RiskStatuses]
ADD CONSTRAINT [PK_RiskStatuses]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'RiskUpdates'
ALTER TABLE [dbo].[RiskUpdates]
ADD CONSTRAINT [PK_RiskUpdates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'RiskImpactLevels'
ALTER TABLE [dbo].[RiskImpactLevels]
ADD CONSTRAINT [PK_RiskImpactLevels]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'RiskProbabilities'
ALTER TABLE [dbo].[RiskProbabilities]
ADD CONSTRAINT [PK_RiskProbabilities]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'RiskMitigationActionUpdates'
ALTER TABLE [dbo].[RiskMitigationActionUpdates]
ADD CONSTRAINT [PK_RiskMitigationActionUpdates]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [BenefitTypeID] in table 'Benefits'
ALTER TABLE [dbo].[Benefits]
ADD CONSTRAINT [FK_Benefits_BenefitTypes]
    FOREIGN KEY ([BenefitTypeID])
    REFERENCES [dbo].[BenefitTypes]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Benefits_BenefitTypes'
CREATE INDEX [IX_FK_Benefits_BenefitTypes]
ON [dbo].[Benefits]
    ([BenefitTypeID]);
GO

-- Creating foreign key on [RagOptionID] in table 'Benefits'
ALTER TABLE [dbo].[Benefits]
ADD CONSTRAINT [FK_Benefits_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Benefits_RagOptions'
CREATE INDEX [IX_FK_Benefits_RagOptions]
ON [dbo].[Benefits]
    ([RagOptionID]);
GO

-- Creating foreign key on [LeadUserID] in table 'Benefits'
ALTER TABLE [dbo].[Benefits]
ADD CONSTRAINT [FK_Benefits_Users]
    FOREIGN KEY ([LeadUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Benefits_Users'
CREATE INDEX [IX_FK_Benefits_Users]
ON [dbo].[Benefits]
    ([LeadUserID]);
GO

-- Creating foreign key on [BenefitID] in table 'BenefitUpdates'
ALTER TABLE [dbo].[BenefitUpdates]
ADD CONSTRAINT [FK_BenefitUpdates_Benefits]
    FOREIGN KEY ([BenefitID])
    REFERENCES [dbo].[Benefits]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_BenefitUpdates_Benefits'
CREATE INDEX [IX_FK_BenefitUpdates_Benefits]
ON [dbo].[BenefitUpdates]
    ([BenefitID]);
GO

-- Creating foreign key on [RagOptionID] in table 'BenefitUpdates'
ALTER TABLE [dbo].[BenefitUpdates]
ADD CONSTRAINT [FK_BenefitUpdates_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_BenefitUpdates_RagOptions'
CREATE INDEX [IX_FK_BenefitUpdates_RagOptions]
ON [dbo].[BenefitUpdates]
    ([RagOptionID]);
GO

-- Creating foreign key on [SignOffID] in table 'BenefitUpdates'
ALTER TABLE [dbo].[BenefitUpdates]
ADD CONSTRAINT [FK_BenefitUpdates_SignOffs]
    FOREIGN KEY ([SignOffID])
    REFERENCES [dbo].[SignOffs]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_BenefitUpdates_SignOffs'
CREATE INDEX [IX_FK_BenefitUpdates_SignOffs]
ON [dbo].[BenefitUpdates]
    ([SignOffID]);
GO

-- Creating foreign key on [UpdateUserID] in table 'BenefitUpdates'
ALTER TABLE [dbo].[BenefitUpdates]
ADD CONSTRAINT [FK_BenefitUpdates_Users]
    FOREIGN KEY ([UpdateUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_BenefitUpdates_Users'
CREATE INDEX [IX_FK_BenefitUpdates_Users]
ON [dbo].[BenefitUpdates]
    ([UpdateUserID]);
GO

-- Creating foreign key on [GroupID] in table 'Directorates'
ALTER TABLE [dbo].[Directorates]
ADD CONSTRAINT [FK_Directorates_Groups]
    FOREIGN KEY ([GroupID])
    REFERENCES [dbo].[Groups]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Directorates_Groups'
CREATE INDEX [IX_FK_Directorates_Groups]
ON [dbo].[Directorates]
    ([GroupID]);
GO

-- Creating foreign key on [DirectorUserID] in table 'Directorates'
ALTER TABLE [dbo].[Directorates]
ADD CONSTRAINT [FK_Directorates_Users]
    FOREIGN KEY ([DirectorUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Directorates_Users'
CREATE INDEX [IX_FK_Directorates_Users]
ON [dbo].[Directorates]
    ([DirectorUserID]);
GO

-- Creating foreign key on [DirectorateID] in table 'DirectorateUpdates'
ALTER TABLE [dbo].[DirectorateUpdates]
ADD CONSTRAINT [FK_DirectorateUpdates_Directorates]
    FOREIGN KEY ([DirectorateID])
    REFERENCES [dbo].[Directorates]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DirectorateUpdates_Directorates'
CREATE INDEX [IX_FK_DirectorateUpdates_Directorates]
ON [dbo].[DirectorateUpdates]
    ([DirectorateID]);
GO

-- Creating foreign key on [DirectorateID] in table 'KeyWorkAreas'
ALTER TABLE [dbo].[KeyWorkAreas]
ADD CONSTRAINT [FK_KeyWorkAreas_Directorates]
    FOREIGN KEY ([DirectorateID])
    REFERENCES [dbo].[Directorates]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_KeyWorkAreas_Directorates'
CREATE INDEX [IX_FK_KeyWorkAreas_Directorates]
ON [dbo].[KeyWorkAreas]
    ([DirectorateID]);
GO

-- Creating foreign key on [DirectorateID] in table 'UserDirectorates'
ALTER TABLE [dbo].[UserDirectorates]
ADD CONSTRAINT [FK_UserDirectorates_Directorates]
    FOREIGN KEY ([DirectorateID])
    REFERENCES [dbo].[Directorates]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserDirectorates_Directorates'
CREATE INDEX [IX_FK_UserDirectorates_Directorates]
ON [dbo].[UserDirectorates]
    ([DirectorateID]);
GO

-- Creating foreign key on [FinanceRagOptionID] in table 'DirectorateUpdates'
ALTER TABLE [dbo].[DirectorateUpdates]
ADD CONSTRAINT [FK_DirectorateUpdates_RagOptionFinance]
    FOREIGN KEY ([FinanceRagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DirectorateUpdates_RagOptionFinance'
CREATE INDEX [IX_FK_DirectorateUpdates_RagOptionFinance]
ON [dbo].[DirectorateUpdates]
    ([FinanceRagOptionID]);
GO

-- Creating foreign key on [MilestonesRagOptionID] in table 'DirectorateUpdates'
ALTER TABLE [dbo].[DirectorateUpdates]
ADD CONSTRAINT [FK_DirectorateUpdates_RagOptionMilestone]
    FOREIGN KEY ([MilestonesRagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DirectorateUpdates_RagOptionMilestone'
CREATE INDEX [IX_FK_DirectorateUpdates_RagOptionMilestone]
ON [dbo].[DirectorateUpdates]
    ([MilestonesRagOptionID]);
GO

-- Creating foreign key on [OverallRagOptionID] in table 'DirectorateUpdates'
ALTER TABLE [dbo].[DirectorateUpdates]
ADD CONSTRAINT [FK_DirectorateUpdates_RagOptionOverall]
    FOREIGN KEY ([OverallRagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DirectorateUpdates_RagOptionOverall'
CREATE INDEX [IX_FK_DirectorateUpdates_RagOptionOverall]
ON [dbo].[DirectorateUpdates]
    ([OverallRagOptionID]);
GO

-- Creating foreign key on [PeopleRagOptionID] in table 'DirectorateUpdates'
ALTER TABLE [dbo].[DirectorateUpdates]
ADD CONSTRAINT [FK_DirectorateUpdates_RagOptionPeople]
    FOREIGN KEY ([PeopleRagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DirectorateUpdates_RagOptionPeople'
CREATE INDEX [IX_FK_DirectorateUpdates_RagOptionPeople]
ON [dbo].[DirectorateUpdates]
    ([PeopleRagOptionID]);
GO

-- Creating foreign key on [SignOffID] in table 'DirectorateUpdates'
ALTER TABLE [dbo].[DirectorateUpdates]
ADD CONSTRAINT [FK_DirectorateUpdates_SignOffs]
    FOREIGN KEY ([SignOffID])
    REFERENCES [dbo].[SignOffs]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DirectorateUpdates_SignOffs'
CREATE INDEX [IX_FK_DirectorateUpdates_SignOffs]
ON [dbo].[DirectorateUpdates]
    ([SignOffID]);
GO

-- Creating foreign key on [UpdateUserID] in table 'DirectorateUpdates'
ALTER TABLE [dbo].[DirectorateUpdates]
ADD CONSTRAINT [FK_DirectorateUpdates_Users]
    FOREIGN KEY ([UpdateUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DirectorateUpdates_Users'
CREATE INDEX [IX_FK_DirectorateUpdates_Users]
ON [dbo].[DirectorateUpdates]
    ([UpdateUserID]);
GO

-- Creating foreign key on [RagOptionID] in table 'KeyWorkAreas'
ALTER TABLE [dbo].[KeyWorkAreas]
ADD CONSTRAINT [FK_KeyWorkAreas_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_KeyWorkAreas_RagOptions'
CREATE INDEX [IX_FK_KeyWorkAreas_RagOptions]
ON [dbo].[KeyWorkAreas]
    ([RagOptionID]);
GO

-- Creating foreign key on [LeadUserID] in table 'KeyWorkAreas'
ALTER TABLE [dbo].[KeyWorkAreas]
ADD CONSTRAINT [FK_KeyWorkAreas_Users]
    FOREIGN KEY ([LeadUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_KeyWorkAreas_Users'
CREATE INDEX [IX_FK_KeyWorkAreas_Users]
ON [dbo].[KeyWorkAreas]
    ([LeadUserID]);
GO

-- Creating foreign key on [KeyWorkAreaID] in table 'KeyWorkAreaUpdates'
ALTER TABLE [dbo].[KeyWorkAreaUpdates]
ADD CONSTRAINT [FK_KeyWorkAreaUpdates_KeyWorkAreas]
    FOREIGN KEY ([KeyWorkAreaID])
    REFERENCES [dbo].[KeyWorkAreas]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_KeyWorkAreaUpdates_KeyWorkAreas'
CREATE INDEX [IX_FK_KeyWorkAreaUpdates_KeyWorkAreas]
ON [dbo].[KeyWorkAreaUpdates]
    ([KeyWorkAreaID]);
GO

-- Creating foreign key on [KeyWorkAreaID] in table 'Milestones'
ALTER TABLE [dbo].[Milestones]
ADD CONSTRAINT [FK_Milestones_KeyWorkAreas]
    FOREIGN KEY ([KeyWorkAreaID])
    REFERENCES [dbo].[KeyWorkAreas]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Milestones_KeyWorkAreas'
CREATE INDEX [IX_FK_Milestones_KeyWorkAreas]
ON [dbo].[Milestones]
    ([KeyWorkAreaID]);
GO

-- Creating foreign key on [RagOptionID] in table 'KeyWorkAreaUpdates'
ALTER TABLE [dbo].[KeyWorkAreaUpdates]
ADD CONSTRAINT [FK_KeyWorkAreaUpdates_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_KeyWorkAreaUpdates_RagOptions'
CREATE INDEX [IX_FK_KeyWorkAreaUpdates_RagOptions]
ON [dbo].[KeyWorkAreaUpdates]
    ([RagOptionID]);
GO

-- Creating foreign key on [SignOffID] in table 'KeyWorkAreaUpdates'
ALTER TABLE [dbo].[KeyWorkAreaUpdates]
ADD CONSTRAINT [FK_KeyWorkAreaUpdates_SignOffs]
    FOREIGN KEY ([SignOffID])
    REFERENCES [dbo].[SignOffs]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_KeyWorkAreaUpdates_SignOffs'
CREATE INDEX [IX_FK_KeyWorkAreaUpdates_SignOffs]
ON [dbo].[KeyWorkAreaUpdates]
    ([SignOffID]);
GO

-- Creating foreign key on [UpdateUserID] in table 'KeyWorkAreaUpdates'
ALTER TABLE [dbo].[KeyWorkAreaUpdates]
ADD CONSTRAINT [FK_KeyWorkAreaUpdates_Users]
    FOREIGN KEY ([UpdateUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_KeyWorkAreaUpdates_Users'
CREATE INDEX [IX_FK_KeyWorkAreaUpdates_Users]
ON [dbo].[KeyWorkAreaUpdates]
    ([UpdateUserID]);
GO

-- Creating foreign key on [RagOptionID] in table 'Metrics'
ALTER TABLE [dbo].[Metrics]
ADD CONSTRAINT [FK_Metrics_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Metrics_RagOptions'
CREATE INDEX [IX_FK_Metrics_RagOptions]
ON [dbo].[Metrics]
    ([RagOptionID]);
GO

-- Creating foreign key on [LeadUserID] in table 'Metrics'
ALTER TABLE [dbo].[Metrics]
ADD CONSTRAINT [FK_Metrics_Users]
    FOREIGN KEY ([LeadUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Metrics_Users'
CREATE INDEX [IX_FK_Metrics_Users]
ON [dbo].[Metrics]
    ([LeadUserID]);
GO

-- Creating foreign key on [MetricID] in table 'MetricUpdates'
ALTER TABLE [dbo].[MetricUpdates]
ADD CONSTRAINT [FK_MetricUpdates_Metrics]
    FOREIGN KEY ([MetricID])
    REFERENCES [dbo].[Metrics]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MetricUpdates_Metrics'
CREATE INDEX [IX_FK_MetricUpdates_Metrics]
ON [dbo].[MetricUpdates]
    ([MetricID]);
GO

-- Creating foreign key on [RagOptionID] in table 'MetricUpdates'
ALTER TABLE [dbo].[MetricUpdates]
ADD CONSTRAINT [FK_MetricUpdates_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MetricUpdates_RagOptions'
CREATE INDEX [IX_FK_MetricUpdates_RagOptions]
ON [dbo].[MetricUpdates]
    ([RagOptionID]);
GO

-- Creating foreign key on [SignOffID] in table 'MetricUpdates'
ALTER TABLE [dbo].[MetricUpdates]
ADD CONSTRAINT [FK_MetricUpdates_SignOffs]
    FOREIGN KEY ([SignOffID])
    REFERENCES [dbo].[SignOffs]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MetricUpdates_SignOffs'
CREATE INDEX [IX_FK_MetricUpdates_SignOffs]
ON [dbo].[MetricUpdates]
    ([SignOffID]);
GO

-- Creating foreign key on [UpdateUserID] in table 'MetricUpdates'
ALTER TABLE [dbo].[MetricUpdates]
ADD CONSTRAINT [FK_MetricUpdates_Users]
    FOREIGN KEY ([UpdateUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MetricUpdates_Users'
CREATE INDEX [IX_FK_MetricUpdates_Users]
ON [dbo].[MetricUpdates]
    ([UpdateUserID]);
GO

-- Creating foreign key on [MilestoneAttributeTypeID] in table 'MilestoneAttributes'
ALTER TABLE [dbo].[MilestoneAttributes]
ADD CONSTRAINT [FK_MilestoneAttributes_MilestoneAttributeTypes]
    FOREIGN KEY ([MilestoneAttributeTypeID])
    REFERENCES [dbo].[MilestoneAttributeTypes]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MilestoneAttributes_MilestoneAttributeTypes'
CREATE INDEX [IX_FK_MilestoneAttributes_MilestoneAttributeTypes]
ON [dbo].[MilestoneAttributes]
    ([MilestoneAttributeTypeID]);
GO

-- Creating foreign key on [MilestoneID] in table 'MilestoneAttributes'
ALTER TABLE [dbo].[MilestoneAttributes]
ADD CONSTRAINT [FK_MilestoneAttributes_Milestones]
    FOREIGN KEY ([MilestoneID])
    REFERENCES [dbo].[Milestones]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MilestoneAttributes_Milestones'
CREATE INDEX [IX_FK_MilestoneAttributes_Milestones]
ON [dbo].[MilestoneAttributes]
    ([MilestoneID]);
GO

-- Creating foreign key on [MilestoneTypeID] in table 'Milestones'
ALTER TABLE [dbo].[Milestones]
ADD CONSTRAINT [FK_Milestones_MilestoneTypes]
    FOREIGN KEY ([MilestoneTypeID])
    REFERENCES [dbo].[MilestoneTypes]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Milestones_MilestoneTypes'
CREATE INDEX [IX_FK_Milestones_MilestoneTypes]
ON [dbo].[Milestones]
    ([MilestoneTypeID]);
GO

-- Creating foreign key on [RagOptionID] in table 'Milestones'
ALTER TABLE [dbo].[Milestones]
ADD CONSTRAINT [FK_Milestones_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Milestones_RagOptions'
CREATE INDEX [IX_FK_Milestones_RagOptions]
ON [dbo].[Milestones]
    ([RagOptionID]);
GO

-- Creating foreign key on [LeadUserID] in table 'Milestones'
ALTER TABLE [dbo].[Milestones]
ADD CONSTRAINT [FK_Milestones_Users]
    FOREIGN KEY ([LeadUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Milestones_Users'
CREATE INDEX [IX_FK_Milestones_Users]
ON [dbo].[Milestones]
    ([LeadUserID]);
GO

-- Creating foreign key on [WorkStreamID] in table 'Milestones'
ALTER TABLE [dbo].[Milestones]
ADD CONSTRAINT [FK_Milestones_WorkStreams]
    FOREIGN KEY ([WorkStreamID])
    REFERENCES [dbo].[WorkStreams]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Milestones_WorkStreams'
CREATE INDEX [IX_FK_Milestones_WorkStreams]
ON [dbo].[Milestones]
    ([WorkStreamID]);
GO

-- Creating foreign key on [MilestoneID] in table 'MilestoneUpdates'
ALTER TABLE [dbo].[MilestoneUpdates]
ADD CONSTRAINT [FK_MilestoneUpdates_Milestones]
    FOREIGN KEY ([MilestoneID])
    REFERENCES [dbo].[Milestones]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MilestoneUpdates_Milestones'
CREATE INDEX [IX_FK_MilestoneUpdates_Milestones]
ON [dbo].[MilestoneUpdates]
    ([MilestoneID]);
GO

-- Creating foreign key on [RagOptionID] in table 'MilestoneUpdates'
ALTER TABLE [dbo].[MilestoneUpdates]
ADD CONSTRAINT [FK_MilestoneUpdates_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MilestoneUpdates_RagOptions'
CREATE INDEX [IX_FK_MilestoneUpdates_RagOptions]
ON [dbo].[MilestoneUpdates]
    ([RagOptionID]);
GO

-- Creating foreign key on [SignOffID] in table 'MilestoneUpdates'
ALTER TABLE [dbo].[MilestoneUpdates]
ADD CONSTRAINT [FK_MilestoneUpdates_SignOffs]
    FOREIGN KEY ([SignOffID])
    REFERENCES [dbo].[SignOffs]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MilestoneUpdates_SignOffs'
CREATE INDEX [IX_FK_MilestoneUpdates_SignOffs]
ON [dbo].[MilestoneUpdates]
    ([SignOffID]);
GO

-- Creating foreign key on [UpdateUserID] in table 'MilestoneUpdates'
ALTER TABLE [dbo].[MilestoneUpdates]
ADD CONSTRAINT [FK_MilestoneUpdates_Users]
    FOREIGN KEY ([UpdateUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MilestoneUpdates_Users'
CREATE INDEX [IX_FK_MilestoneUpdates_Users]
ON [dbo].[MilestoneUpdates]
    ([UpdateUserID]);
GO

-- Creating foreign key on [ProjectManagerUserID] in table 'Projects'
ALTER TABLE [dbo].[Projects]
ADD CONSTRAINT [FK_Projects_ProjectManager]
    FOREIGN KEY ([ProjectManagerUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Projects_ProjectManager'
CREATE INDEX [IX_FK_Projects_ProjectManager]
ON [dbo].[Projects]
    ([ProjectManagerUserID]);
GO

-- Creating foreign key on [SeniorResponsibleOwnerUserID] in table 'Projects'
ALTER TABLE [dbo].[Projects]
ADD CONSTRAINT [FK_Projects_SeniorResponsibleOwner]
    FOREIGN KEY ([SeniorResponsibleOwnerUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Projects_SeniorResponsibleOwner'
CREATE INDEX [IX_FK_Projects_SeniorResponsibleOwner]
ON [dbo].[Projects]
    ([SeniorResponsibleOwnerUserID]);
GO

-- Creating foreign key on [ProjectID] in table 'ProjectUpdates'
ALTER TABLE [dbo].[ProjectUpdates]
ADD CONSTRAINT [FK_ProjectUpdates_Projects]
    FOREIGN KEY ([ProjectID])
    REFERENCES [dbo].[Projects]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectUpdates_Projects'
CREATE INDEX [IX_FK_ProjectUpdates_Projects]
ON [dbo].[ProjectUpdates]
    ([ProjectID]);
GO

-- Creating foreign key on [ProjectID] in table 'UserProjects'
ALTER TABLE [dbo].[UserProjects]
ADD CONSTRAINT [FK_UserProjects_Projects]
    FOREIGN KEY ([ProjectID])
    REFERENCES [dbo].[Projects]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserProjects_Projects'
CREATE INDEX [IX_FK_UserProjects_Projects]
ON [dbo].[UserProjects]
    ([ProjectID]);
GO

-- Creating foreign key on [ProjectID] in table 'WorkStreams'
ALTER TABLE [dbo].[WorkStreams]
ADD CONSTRAINT [FK_WorkStreams_Projects]
    FOREIGN KEY ([ProjectID])
    REFERENCES [dbo].[Projects]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_WorkStreams_Projects'
CREATE INDEX [IX_FK_WorkStreams_Projects]
ON [dbo].[WorkStreams]
    ([ProjectID]);
GO

-- Creating foreign key on [FinanceRagOptionID] in table 'ProjectUpdates'
ALTER TABLE [dbo].[ProjectUpdates]
ADD CONSTRAINT [FK_ProjectUpdates_RagOptionFinance]
    FOREIGN KEY ([FinanceRagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectUpdates_RagOptionFinance'
CREATE INDEX [IX_FK_ProjectUpdates_RagOptionFinance]
ON [dbo].[ProjectUpdates]
    ([FinanceRagOptionID]);
GO

-- Creating foreign key on [MilestonesRagOptionID] in table 'ProjectUpdates'
ALTER TABLE [dbo].[ProjectUpdates]
ADD CONSTRAINT [FK_ProjectUpdates_RagOptionMilestone]
    FOREIGN KEY ([MilestonesRagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectUpdates_RagOptionMilestone'
CREATE INDEX [IX_FK_ProjectUpdates_RagOptionMilestone]
ON [dbo].[ProjectUpdates]
    ([MilestonesRagOptionID]);
GO

-- Creating foreign key on [OverallRagOptionID] in table 'ProjectUpdates'
ALTER TABLE [dbo].[ProjectUpdates]
ADD CONSTRAINT [FK_ProjectUpdates_RagOptionOverall]
    FOREIGN KEY ([OverallRagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectUpdates_RagOptionOverall'
CREATE INDEX [IX_FK_ProjectUpdates_RagOptionOverall]
ON [dbo].[ProjectUpdates]
    ([OverallRagOptionID]);
GO

-- Creating foreign key on [PeopleRagOptionID] in table 'ProjectUpdates'
ALTER TABLE [dbo].[ProjectUpdates]
ADD CONSTRAINT [FK_ProjectUpdates_RagOptionPeople]
    FOREIGN KEY ([PeopleRagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectUpdates_RagOptionPeople'
CREATE INDEX [IX_FK_ProjectUpdates_RagOptionPeople]
ON [dbo].[ProjectUpdates]
    ([PeopleRagOptionID]);
GO

-- Creating foreign key on [SignOffID] in table 'ProjectUpdates'
ALTER TABLE [dbo].[ProjectUpdates]
ADD CONSTRAINT [FK_ProjectUpdates_SignOffs]
    FOREIGN KEY ([SignOffID])
    REFERENCES [dbo].[SignOffs]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectUpdates_SignOffs'
CREATE INDEX [IX_FK_ProjectUpdates_SignOffs]
ON [dbo].[ProjectUpdates]
    ([SignOffID]);
GO

-- Creating foreign key on [UpdateUserID] in table 'ProjectUpdates'
ALTER TABLE [dbo].[ProjectUpdates]
ADD CONSTRAINT [FK_ProjectUpdates_UpdateUser]
    FOREIGN KEY ([UpdateUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectUpdates_UpdateUser'
CREATE INDEX [IX_FK_ProjectUpdates_UpdateUser]
ON [dbo].[ProjectUpdates]
    ([UpdateUserID]);
GO

-- Creating foreign key on [RagOptionID] in table 'WorkStreams'
ALTER TABLE [dbo].[WorkStreams]
ADD CONSTRAINT [FK_WorkStreams_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_WorkStreams_RagOptions'
CREATE INDEX [IX_FK_WorkStreams_RagOptions]
ON [dbo].[WorkStreams]
    ([RagOptionID]);
GO

-- Creating foreign key on [RagOptionID] in table 'WorkStreamUpdates'
ALTER TABLE [dbo].[WorkStreamUpdates]
ADD CONSTRAINT [FK_WorkStreamUpdates_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_WorkStreamUpdates_RagOptions'
CREATE INDEX [IX_FK_WorkStreamUpdates_RagOptions]
ON [dbo].[WorkStreamUpdates]
    ([RagOptionID]);
GO

-- Creating foreign key on [RoleID] in table 'UserRoles'
ALTER TABLE [dbo].[UserRoles]
ADD CONSTRAINT [FK_UserRoles_Roles]
    FOREIGN KEY ([RoleID])
    REFERENCES [dbo].[Roles]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserRoles_Roles'
CREATE INDEX [IX_FK_UserRoles_Roles]
ON [dbo].[UserRoles]
    ([RoleID]);
GO

-- Creating foreign key on [SignOffUserID] in table 'SignOffs'
ALTER TABLE [dbo].[SignOffs]
ADD CONSTRAINT [FK_SignOffs_Users]
    FOREIGN KEY ([SignOffUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_SignOffs_Users'
CREATE INDEX [IX_FK_SignOffs_Users]
ON [dbo].[SignOffs]
    ([SignOffUserID]);
GO

-- Creating foreign key on [SignOffID] in table 'WorkStreamUpdates'
ALTER TABLE [dbo].[WorkStreamUpdates]
ADD CONSTRAINT [FK_WorkStreamUpdates_SignOffs]
    FOREIGN KEY ([SignOffID])
    REFERENCES [dbo].[SignOffs]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_WorkStreamUpdates_SignOffs'
CREATE INDEX [IX_FK_WorkStreamUpdates_SignOffs]
ON [dbo].[WorkStreamUpdates]
    ([SignOffID]);
GO

-- Creating foreign key on [UserID] in table 'UserDirectorates'
ALTER TABLE [dbo].[UserDirectorates]
ADD CONSTRAINT [FK_UserDirectorates_Users]
    FOREIGN KEY ([UserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserDirectorates_Users'
CREATE INDEX [IX_FK_UserDirectorates_Users]
ON [dbo].[UserDirectorates]
    ([UserID]);
GO

-- Creating foreign key on [UserID] in table 'UserProjects'
ALTER TABLE [dbo].[UserProjects]
ADD CONSTRAINT [FK_UserProjects_Users]
    FOREIGN KEY ([UserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserProjects_Users'
CREATE INDEX [IX_FK_UserProjects_Users]
ON [dbo].[UserProjects]
    ([UserID]);
GO

-- Creating foreign key on [UserID] in table 'UserRoles'
ALTER TABLE [dbo].[UserRoles]
ADD CONSTRAINT [FK_UserRoles_Users]
    FOREIGN KEY ([UserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserRoles_Users'
CREATE INDEX [IX_FK_UserRoles_Users]
ON [dbo].[UserRoles]
    ([UserID]);
GO

-- Creating foreign key on [LeadUserID] in table 'WorkStreams'
ALTER TABLE [dbo].[WorkStreams]
ADD CONSTRAINT [FK_WorkStreams_Users]
    FOREIGN KEY ([LeadUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_WorkStreams_Users'
CREATE INDEX [IX_FK_WorkStreams_Users]
ON [dbo].[WorkStreams]
    ([LeadUserID]);
GO

-- Creating foreign key on [UpdateUserID] in table 'WorkStreamUpdates'
ALTER TABLE [dbo].[WorkStreamUpdates]
ADD CONSTRAINT [FK_WorkStreamUpdates_UpdateUser]
    FOREIGN KEY ([UpdateUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_WorkStreamUpdates_UpdateUser'
CREATE INDEX [IX_FK_WorkStreamUpdates_UpdateUser]
ON [dbo].[WorkStreamUpdates]
    ([UpdateUserID]);
GO

-- Creating foreign key on [WorkStreamID] in table 'WorkStreamUpdates'
ALTER TABLE [dbo].[WorkStreamUpdates]
ADD CONSTRAINT [FK_WorkStreamUpdates_WorkStreams]
    FOREIGN KEY ([WorkStreamID])
    REFERENCES [dbo].[WorkStreams]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_WorkStreamUpdates_WorkStreams'
CREATE INDEX [IX_FK_WorkStreamUpdates_WorkStreams]
ON [dbo].[WorkStreamUpdates]
    ([WorkStreamID]);
GO

-- Creating foreign key on [BusinessCaseTypeID] in table 'ProjectUpdates'
ALTER TABLE [dbo].[ProjectUpdates]
ADD CONSTRAINT [FK_ProjectUpdates_ProjectBusinessCaseTypes]
    FOREIGN KEY ([BusinessCaseTypeID])
    REFERENCES [dbo].[ProjectBusinessCaseTypes]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectUpdates_ProjectBusinessCaseTypes'
CREATE INDEX [IX_FK_ProjectUpdates_ProjectBusinessCaseTypes]
ON [dbo].[ProjectUpdates]
    ([BusinessCaseTypeID]);
GO

-- Creating foreign key on [ProjectPhaseID] in table 'ProjectUpdates'
ALTER TABLE [dbo].[ProjectUpdates]
ADD CONSTRAINT [FK_ProjectUpdates_ProjectPhases]
    FOREIGN KEY ([ProjectPhaseID])
    REFERENCES [dbo].[ProjectPhases]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectUpdates_ProjectPhases'
CREATE INDEX [IX_FK_ProjectUpdates_ProjectPhases]
ON [dbo].[ProjectUpdates]
    ([ProjectPhaseID]);
GO

-- Creating foreign key on [DirectorateID] in table 'SignOffs'
ALTER TABLE [dbo].[SignOffs]
ADD CONSTRAINT [FK_SignOffs_Directorates]
    FOREIGN KEY ([DirectorateID])
    REFERENCES [dbo].[Directorates]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_SignOffs_Directorates'
CREATE INDEX [IX_FK_SignOffs_Directorates]
ON [dbo].[SignOffs]
    ([DirectorateID]);
GO

-- Creating foreign key on [ProjectID] in table 'SignOffs'
ALTER TABLE [dbo].[SignOffs]
ADD CONSTRAINT [FK_SignOffs_Projects]
    FOREIGN KEY ([ProjectID])
    REFERENCES [dbo].[Projects]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_SignOffs_Projects'
CREATE INDEX [IX_FK_SignOffs_Projects]
ON [dbo].[SignOffs]
    ([ProjectID]);
GO

-- Creating foreign key on [ProjectID] in table 'Benefits'
ALTER TABLE [dbo].[Benefits]
ADD CONSTRAINT [FK_Benefits_Projects]
    FOREIGN KEY ([ProjectID])
    REFERENCES [dbo].[Projects]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Benefits_Projects'
CREATE INDEX [IX_FK_Benefits_Projects]
ON [dbo].[Benefits]
    ([ProjectID]);
GO

-- Creating foreign key on [DirectorateID] in table 'Metrics'
ALTER TABLE [dbo].[Metrics]
ADD CONSTRAINT [FK_Metrics_Directorates]
    FOREIGN KEY ([DirectorateID])
    REFERENCES [dbo].[Directorates]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Metrics_Directorates'
CREATE INDEX [IX_FK_Metrics_Directorates]
ON [dbo].[Metrics]
    ([DirectorateID]);
GO

-- Creating foreign key on [DirectorateID] in table 'Commitments'
ALTER TABLE [dbo].[Commitments]
ADD CONSTRAINT [FK_Commitments_Directorates]
    FOREIGN KEY ([DirectorateID])
    REFERENCES [dbo].[Directorates]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Commitments_Directorates'
CREATE INDEX [IX_FK_Commitments_Directorates]
ON [dbo].[Commitments]
    ([DirectorateID]);
GO

-- Creating foreign key on [RagOptionID] in table 'Commitments'
ALTER TABLE [dbo].[Commitments]
ADD CONSTRAINT [FK_Commitments_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Commitments_RagOptions'
CREATE INDEX [IX_FK_Commitments_RagOptions]
ON [dbo].[Commitments]
    ([RagOptionID]);
GO

-- Creating foreign key on [LeadUserID] in table 'Commitments'
ALTER TABLE [dbo].[Commitments]
ADD CONSTRAINT [FK_Commitments_Users]
    FOREIGN KEY ([LeadUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Commitments_Users'
CREATE INDEX [IX_FK_Commitments_Users]
ON [dbo].[Commitments]
    ([LeadUserID]);
GO

-- Creating foreign key on [ProjectID] in table 'Dependencies'
ALTER TABLE [dbo].[Dependencies]
ADD CONSTRAINT [FK_Dependencies_Projects]
    FOREIGN KEY ([ProjectID])
    REFERENCES [dbo].[Projects]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Dependencies_Projects'
CREATE INDEX [IX_FK_Dependencies_Projects]
ON [dbo].[Dependencies]
    ([ProjectID]);
GO

-- Creating foreign key on [RagOptionID] in table 'Dependencies'
ALTER TABLE [dbo].[Dependencies]
ADD CONSTRAINT [FK_Dependencies_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Dependencies_RagOptions'
CREATE INDEX [IX_FK_Dependencies_RagOptions]
ON [dbo].[Dependencies]
    ([RagOptionID]);
GO

-- Creating foreign key on [LeadUserID] in table 'Dependencies'
ALTER TABLE [dbo].[Dependencies]
ADD CONSTRAINT [FK_Dependencies_Users]
    FOREIGN KEY ([LeadUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Dependencies_Users'
CREATE INDEX [IX_FK_Dependencies_Users]
ON [dbo].[Dependencies]
    ([LeadUserID]);
GO

-- Creating foreign key on [CommitmentID] in table 'CommitmentUpdates'
ALTER TABLE [dbo].[CommitmentUpdates]
ADD CONSTRAINT [FK_CommitmentUpdates_Commitments]
    FOREIGN KEY ([CommitmentID])
    REFERENCES [dbo].[Commitments]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CommitmentUpdates_Commitments'
CREATE INDEX [IX_FK_CommitmentUpdates_Commitments]
ON [dbo].[CommitmentUpdates]
    ([CommitmentID]);
GO

-- Creating foreign key on [RagOptionID] in table 'CommitmentUpdates'
ALTER TABLE [dbo].[CommitmentUpdates]
ADD CONSTRAINT [FK_CommitmentUpdates_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CommitmentUpdates_RagOptions'
CREATE INDEX [IX_FK_CommitmentUpdates_RagOptions]
ON [dbo].[CommitmentUpdates]
    ([RagOptionID]);
GO

-- Creating foreign key on [SignOffID] in table 'CommitmentUpdates'
ALTER TABLE [dbo].[CommitmentUpdates]
ADD CONSTRAINT [FK_CommitmentUpdates_SignOffs]
    FOREIGN KEY ([SignOffID])
    REFERENCES [dbo].[SignOffs]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CommitmentUpdates_SignOffs'
CREATE INDEX [IX_FK_CommitmentUpdates_SignOffs]
ON [dbo].[CommitmentUpdates]
    ([SignOffID]);
GO

-- Creating foreign key on [UpdateUserID] in table 'CommitmentUpdates'
ALTER TABLE [dbo].[CommitmentUpdates]
ADD CONSTRAINT [FK_CommitmentUpdates_Users]
    FOREIGN KEY ([UpdateUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CommitmentUpdates_Users'
CREATE INDEX [IX_FK_CommitmentUpdates_Users]
ON [dbo].[CommitmentUpdates]
    ([UpdateUserID]);
GO

-- Creating foreign key on [DependencyID] in table 'DependencyUpdates'
ALTER TABLE [dbo].[DependencyUpdates]
ADD CONSTRAINT [FK_DependencyUpdates_Dependencies]
    FOREIGN KEY ([DependencyID])
    REFERENCES [dbo].[Dependencies]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DependencyUpdates_Dependencies'
CREATE INDEX [IX_FK_DependencyUpdates_Dependencies]
ON [dbo].[DependencyUpdates]
    ([DependencyID]);
GO

-- Creating foreign key on [RagOptionID] in table 'DependencyUpdates'
ALTER TABLE [dbo].[DependencyUpdates]
ADD CONSTRAINT [FK_DependencyUpdates_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DependencyUpdates_RagOptions'
CREATE INDEX [IX_FK_DependencyUpdates_RagOptions]
ON [dbo].[DependencyUpdates]
    ([RagOptionID]);
GO

-- Creating foreign key on [SignOffID] in table 'DependencyUpdates'
ALTER TABLE [dbo].[DependencyUpdates]
ADD CONSTRAINT [FK_DependencyUpdates_SignOffs]
    FOREIGN KEY ([SignOffID])
    REFERENCES [dbo].[SignOffs]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DependencyUpdates_SignOffs'
CREATE INDEX [IX_FK_DependencyUpdates_SignOffs]
ON [dbo].[DependencyUpdates]
    ([SignOffID]);
GO

-- Creating foreign key on [UpdateUserID] in table 'DependencyUpdates'
ALTER TABLE [dbo].[DependencyUpdates]
ADD CONSTRAINT [FK_DependencyUpdates_Users]
    FOREIGN KEY ([UpdateUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DependencyUpdates_Users'
CREATE INDEX [IX_FK_DependencyUpdates_Users]
ON [dbo].[DependencyUpdates]
    ([UpdateUserID]);
GO

-- Creating foreign key on [MetricsRagOptionID] in table 'DirectorateUpdates'
ALTER TABLE [dbo].[DirectorateUpdates]
ADD CONSTRAINT [FK_DirectorateUpdates_RagOptionMetric]
    FOREIGN KEY ([MetricsRagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DirectorateUpdates_RagOptionMetric'
CREATE INDEX [IX_FK_DirectorateUpdates_RagOptionMetric]
ON [dbo].[DirectorateUpdates]
    ([MetricsRagOptionID]);
GO

-- Creating foreign key on [BenefitsRagOptionID] in table 'ProjectUpdates'
ALTER TABLE [dbo].[ProjectUpdates]
ADD CONSTRAINT [FK_ProjectUpdates_RagOptionBenefit]
    FOREIGN KEY ([BenefitsRagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectUpdates_RagOptionBenefit'
CREATE INDEX [IX_FK_ProjectUpdates_RagOptionBenefit]
ON [dbo].[ProjectUpdates]
    ([BenefitsRagOptionID]);
GO

-- Creating foreign key on [DirectorGeneralUserID] in table 'Groups'
ALTER TABLE [dbo].[Groups]
ADD CONSTRAINT [FK_Groups_Users]
    FOREIGN KEY ([DirectorGeneralUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Groups_Users'
CREATE INDEX [IX_FK_Groups_Users]
ON [dbo].[Groups]
    ([DirectorGeneralUserID]);
GO

-- Creating foreign key on [DirectorateID] in table 'Projects'
ALTER TABLE [dbo].[Projects]
ADD CONSTRAINT [FK_Projects_Directorates]
    FOREIGN KEY ([DirectorateID])
    REFERENCES [dbo].[Directorates]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Projects_Directorates'
CREATE INDEX [IX_FK_Projects_Directorates]
ON [dbo].[Projects]
    ([DirectorateID]);
GO

-- Creating foreign key on [DirectorateID] in table 'Risks'
ALTER TABLE [dbo].[Risks]
ADD CONSTRAINT [FK_Risks_Directorates]
    FOREIGN KEY ([DirectorateID])
    REFERENCES [dbo].[Directorates]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Risks_Directorates'
CREATE INDEX [IX_FK_Risks_Directorates]
ON [dbo].[Risks]
    ([DirectorateID]);
GO

-- Creating foreign key on [GroupID] in table 'Risks'
ALTER TABLE [dbo].[Risks]
ADD CONSTRAINT [FK_Risks_Groups]
    FOREIGN KEY ([GroupID])
    REFERENCES [dbo].[Groups]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Risks_Groups'
CREATE INDEX [IX_FK_Risks_Groups]
ON [dbo].[Risks]
    ([GroupID]);
GO

-- Creating foreign key on [RagOptionID] in table 'Risks'
ALTER TABLE [dbo].[Risks]
ADD CONSTRAINT [FK_Risks_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Risks_RagOptions'
CREATE INDEX [IX_FK_Risks_RagOptions]
ON [dbo].[Risks]
    ([RagOptionID]);
GO

-- Creating foreign key on [RiskID] in table 'RiskMitigationActions'
ALTER TABLE [dbo].[RiskMitigationActions]
ADD CONSTRAINT [FK_RiskMitigationActions_Risks]
    FOREIGN KEY ([RiskID])
    REFERENCES [dbo].[Risks]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_RiskMitigationActions_Risks'
CREATE INDEX [IX_FK_RiskMitigationActions_Risks]
ON [dbo].[RiskMitigationActions]
    ([RiskID]);
GO

-- Creating foreign key on [OwnerUserID] in table 'RiskMitigationActions'
ALTER TABLE [dbo].[RiskMitigationActions]
ADD CONSTRAINT [FK_RiskMitigationActions_Users]
    FOREIGN KEY ([OwnerUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_RiskMitigationActions_Users'
CREATE INDEX [IX_FK_RiskMitigationActions_Users]
ON [dbo].[RiskMitigationActions]
    ([OwnerUserID]);
GO

-- Creating foreign key on [RiskRegisterID] in table 'Risks'
ALTER TABLE [dbo].[Risks]
ADD CONSTRAINT [FK_Risks_RiskRegisters]
    FOREIGN KEY ([RiskRegisterID])
    REFERENCES [dbo].[RiskRegisters]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Risks_RiskRegisters'
CREATE INDEX [IX_FK_Risks_RiskRegisters]
ON [dbo].[Risks]
    ([RiskRegisterID]);
GO

-- Creating foreign key on [RiskStatusID] in table 'Risks'
ALTER TABLE [dbo].[Risks]
ADD CONSTRAINT [FK_Risks_RiskStatuses]
    FOREIGN KEY ([RiskStatusID])
    REFERENCES [dbo].[RiskStatuses]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Risks_RiskStatuses'
CREATE INDEX [IX_FK_Risks_RiskStatuses]
ON [dbo].[Risks]
    ([RiskStatusID]);
GO

-- Creating foreign key on [RiskOwnerUserID] in table 'Risks'
ALTER TABLE [dbo].[Risks]
ADD CONSTRAINT [FK_Risks_Users]
    FOREIGN KEY ([RiskOwnerUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Risks_Users'
CREATE INDEX [IX_FK_Risks_Users]
ON [dbo].[Risks]
    ([RiskOwnerUserID]);
GO

-- Creating foreign key on [RiskID] in table 'RiskUpdates'
ALTER TABLE [dbo].[RiskUpdates]
ADD CONSTRAINT [FK_RiskUpdates_Risks]
    FOREIGN KEY ([RiskID])
    REFERENCES [dbo].[Risks]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_RiskUpdates_Risks'
CREATE INDEX [IX_FK_RiskUpdates_Risks]
ON [dbo].[RiskUpdates]
    ([RiskID]);
GO

-- Creating foreign key on [UpdateUserID] in table 'RiskUpdates'
ALTER TABLE [dbo].[RiskUpdates]
ADD CONSTRAINT [FK_RiskUpdates_Users]
    FOREIGN KEY ([UpdateUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_RiskUpdates_Users'
CREATE INDEX [IX_FK_RiskUpdates_Users]
ON [dbo].[RiskUpdates]
    ([UpdateUserID]);
GO

-- Creating foreign key on [RiskImpactSpreadID] in table 'Risks'
ALTER TABLE [dbo].[Risks]
ADD CONSTRAINT [FK_Risks_RiskImpactSpreads]
    FOREIGN KEY ([RiskImpactSpreadID])
    REFERENCES [dbo].[RiskImpactSpreads]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Risks_RiskImpactSpreads'
CREATE INDEX [IX_FK_Risks_RiskImpactSpreads]
ON [dbo].[Risks]
    ([RiskImpactSpreadID]);
GO

-- Creating foreign key on [RiskImpactTypeID] in table 'Risks'
ALTER TABLE [dbo].[Risks]
ADD CONSTRAINT [FK_Risks_RiskImpactTypes]
    FOREIGN KEY ([RiskImpactTypeID])
    REFERENCES [dbo].[RiskImpactTypes]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Risks_RiskImpactTypes'
CREATE INDEX [IX_FK_Risks_RiskImpactTypes]
ON [dbo].[Risks]
    ([RiskImpactTypeID]);
GO

-- Creating foreign key on [RiskImpactLevelID] in table 'RiskUpdates'
ALTER TABLE [dbo].[RiskUpdates]
ADD CONSTRAINT [FK_RiskUpdates_RiskImpactLevels]
    FOREIGN KEY ([RiskImpactLevelID])
    REFERENCES [dbo].[RiskImpactLevels]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_RiskUpdates_RiskImpactLevels'
CREATE INDEX [IX_FK_RiskUpdates_RiskImpactLevels]
ON [dbo].[RiskUpdates]
    ([RiskImpactLevelID]);
GO

-- Creating foreign key on [RiskProbabilityID] in table 'RiskUpdates'
ALTER TABLE [dbo].[RiskUpdates]
ADD CONSTRAINT [FK_RiskUpdates_RiskProbabilities]
    FOREIGN KEY ([RiskProbabilityID])
    REFERENCES [dbo].[RiskProbabilities]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_RiskUpdates_RiskProbabilities'
CREATE INDEX [IX_FK_RiskUpdates_RiskProbabilities]
ON [dbo].[RiskUpdates]
    ([RiskProbabilityID]);
GO

-- Creating foreign key on [RiskMitigationActionID] in table 'RiskMitigationActionUpdates'
ALTER TABLE [dbo].[RiskMitigationActionUpdates]
ADD CONSTRAINT [FK_RiskMitigationActionUpdates_RiskMitigationActions]
    FOREIGN KEY ([RiskMitigationActionID])
    REFERENCES [dbo].[RiskMitigationActions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_RiskMitigationActionUpdates_RiskMitigationActions'
CREATE INDEX [IX_FK_RiskMitigationActionUpdates_RiskMitigationActions]
ON [dbo].[RiskMitigationActionUpdates]
    ([RiskMitigationActionID]);
GO

-- Creating foreign key on [UpdateUserID] in table 'RiskMitigationActionUpdates'
ALTER TABLE [dbo].[RiskMitigationActionUpdates]
ADD CONSTRAINT [FK_RiskMitigationActionUpdates_Users]
    FOREIGN KEY ([UpdateUserID])
    REFERENCES [dbo].[Users]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_RiskMitigationActionUpdates_Users'
CREATE INDEX [IX_FK_RiskMitigationActionUpdates_Users]
ON [dbo].[RiskMitigationActionUpdates]
    ([UpdateUserID]);
GO

-- Creating foreign key on [RagOptionID] in table 'RiskUpdates'
ALTER TABLE [dbo].[RiskUpdates]
ADD CONSTRAINT [FK_RiskUpdates_RagOptions]
    FOREIGN KEY ([RagOptionID])
    REFERENCES [dbo].[RagOptions]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_RiskUpdates_RagOptions'
CREATE INDEX [IX_FK_RiskUpdates_RagOptions]
ON [dbo].[RiskUpdates]
    ([RagOptionID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------